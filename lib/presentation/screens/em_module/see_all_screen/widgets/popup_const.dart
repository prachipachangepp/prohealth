import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import 'dart:math';

import '../../../../../app/constants/app_config.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';


class CustomDialog extends StatefulWidget {
  final String title;
 // final String depTitle;
   //VoidCallback onSubmit;
  //final TextEditingController userIdController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
 // final TextEditingController roleController;
  final TextEditingController passwordController;
 // final TextEditingController companyIdController ;
  //Widget child;

  CustomDialog({
   // required this.child,
    required this.title,
   // required this.depTitle,
   // required this.onSubmit,
   // required this.userIdController,
    required this.lastNameController,
    required this.emailController,
    required this.firstNameController,
    //required this.roleController,
    required this.passwordController,
   // required this.companyIdController,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  @override
  void initState() {
    super.initState();
    _generatePassword(); // Generate password when dialog is initialized
  }

  void _generatePassword() {
    final random = Random();
    final characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@';
    String password = '';
    for (int i = 0; i < 8; i++) {
      password += characters[random.nextInt(characters.length)];
    }
    setState(() {
      widget.passwordController.text = password; // Update the controller text
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.passwordController.text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Copied to clipboard')),
      );
    });
  }
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _nameDocError;
  String? _emailDocError;
  String? _stateDocError;
  String? _PasswordDocError;
  bool isLoading = false;

  bool _isFormValid = true;
  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid = true;
      _nameDocError = _validateTextField(widget.firstNameController.text, 'First Name');
      _emailDocError = _validateTextField(widget.emailController.text, 'Email');
      _stateDocError = _validateTextField(widget.lastNameController.text, 'Last Name');
      _PasswordDocError =
          _validateTextField(widget.passwordController.text, 'Password');
     });
  }

  var deptId = 1;
  int? firstDeptId;
  String? selectedDeptName;
  int? selectedDeptId;

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(width: 410,
        height: AppSize.s540,
        title: "Create User",
        body: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FirstSMTextFConst(
                  controller: widget.firstNameController,
                  keyboardType: TextInputType.text,
                  text: "First Name",
                ),
                if (_nameDocError != null) // Display error if any
                  Text(
                    _nameDocError!,
                    style: CommonErrorMsg.customTextStyle(context),
                  ),
                SizedBox(height: 5,),
                ///
                FirstSMTextFConst(
                  controller: widget.lastNameController,
                  keyboardType: TextInputType.text,
                  text: 'Last Name',
                ),
                if (_stateDocError != null) // Display error if any
                  Text(
                    _stateDocError!,
                    style: CommonErrorMsg.customTextStyle(context),
                  ),
                SizedBox(height: 10,),
                Text(
                    'Select Department',
                    //  widget.depTitle,
                    style: AllPopupHeadings.customTextStyle(context)),
                SizedBox(height: 5,),
                FutureBuilder<List<HRHeadBar>>(
                  future: companyHRHeadApi(context, deptId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      List<String>dropDownServiceList =[];
                      return Container(
                          alignment: Alignment.center,
                          child:
                          HRUManageDropdown(
                            controller:
                            TextEditingController(
                                text: ''
                            ),
                            labelFontSize: 12,
                            items:  dropDownServiceList,
                          )
                      );
                    }
                    if (snapshot.hasData &&
                        snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          ErrorMessageString.noroleAdded,
                          style: AllNoDataAvailable.customTextStyle(context),
                        ),
                      );
                    }
                    if (snapshot.hasData) {

                      List<String> dropDownServiceList = snapshot
                          .data!
                          .map((dept) => dept.deptName!)
                          .toList();
                      String? firstDeptName =
                      snapshot.data!.isNotEmpty
                          ? snapshot.data![0].deptName
                          : null;
                      int? firstDeptId = snapshot.data!.isNotEmpty
                          ? snapshot.data![0].deptId
                          : null;

                      if (selectedDeptName == null &&
                          dropDownServiceList.isNotEmpty) {
                        selectedDeptName = firstDeptName;
                        selectedDeptId = firstDeptId;
                      }

                      return HRUManageDropdown(
                        controller: TextEditingController(
                            text: selectedDeptName ?? ''),
                        hintText: "Department",
                        labelFontSize: 12,
                        items: dropDownServiceList,
                        onChanged: (val) {
                          setState(() {
                            selectedDeptName = val;
                            // Find the corresponding department ID from the snapshot
                            selectedDeptId = snapshot.data!
                                .firstWhere(
                                    (dept) => dept.deptName == val)
                                .deptId;
                          });
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(height: 14,),
                SMTextFConst(controller: widget.emailController,
                    keyboardType: TextInputType.emailAddress,
                    text: 'Email'),
                if (_emailDocError != null) // Display error if any
                  Text(
                    _emailDocError!,
                    style: CommonErrorMsg.customTextStyle(context),
                  ),
                SizedBox(height: 14,),
                Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: Text("Password",
                      style: AllPopupHeadings.customTextStyle(context)),
                ),
                SizedBox(height: 5,),
                CustomTextFieldWithIcon(
                  controller: widget.passwordController,
                  // suffixIcon: Icon(Icons.copy, size: 14,color: Colors.black),
                  keyboardType: TextInputType.text,
                  text: "Password",
                  cursorHeight: 12,
                  // labelText: "Password",
                  hintText: "Password",
                  labelStyle: TextStyle(),
                  labelFontSize: 12,
                  errorText: 'Password is required',
                  onSuffixIconPressed: _copyToClipboard,
                ),
                if (_PasswordDocError != null)
                  Text(
                    _PasswordDocError!,
                    style: CommonErrorMsg.customTextStyle(context),
                  ),
              ],
            ),
          )

        ],
        bottomButtons:  isLoading == true
      ? CircularProgressIndicator(
          color: ColorManager.blueprime,
        )
            : CustomElevatedButton(
            height: 30,
            width: 120,
            text: 'Create',
            onPressed: () async {
              _validateForm();
              print('$selectedDeptId');
              print('${widget.firstNameController.text}');
              print('${widget.lastNameController.text}');
              print('${widget.emailController.text}');
              print('${widget.passwordController.text}');
              if (_isFormValid) {
                var response = await createUserPost(
                  context,
                  widget.firstNameController.text,
                  widget.lastNameController.text,
                  selectedDeptId!,
                  widget.emailController.text,
                  widget.passwordController.text,
                );
                widget.firstNameController.clear();
                widget.lastNameController.clear();
                widget.emailController.clear();
                selectedDeptId = AppConfig.AdministrationId;
                Navigator.pop(context);
                if(response.statusCode == 200 || response.statusCode == 201){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddSuccessPopup(
                        message: 'User Added Successfully',
                      );
                    },
                  );
                }
                // }
              }
            }
          //},
        ),
        );
  }
}

///
class CustomTextFieldWithIcon extends StatefulWidget {
  final TextEditingController controller;
  final Icon? suffixIcon;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final double cursorHeight;
  final String? labelText;
  final String? hintText;
  final TextStyle? labelStyle;
  final double labelFontSize;
  final FocusNode? focusNode;
  final String? errorText;
  final VoidCallback? onSuffixIconPressed;  // Callback for suffix icon

  const CustomTextFieldWithIcon({
    Key? key,
    required this.controller,
    this.suffixIcon,
    required this.keyboardType,
    required this.text,
    required this.cursorHeight,
     this.labelText,
    this.labelStyle,
    required this.labelFontSize,
    this.errorText,
    this.onSuffixIconPressed,  // Callback for suffix icon
    this.focusNode, this.hintText,
    this.textColor = const Color(0xff686464),
  }) : super(key: key);

  @override
  State<CustomTextFieldWithIcon> createState() => _CustomTextFieldWithIconState();
}

class _CustomTextFieldWithIconState extends State<CustomTextFieldWithIcon> {
   bool hasError = false;

   @override
   void initState() {
     super.initState();
     hasError = false;
   }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 354,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        textAlign: TextAlign.start,
        style:  DocumentTypeDataStyle.customTextStyle(context),
        textAlignVertical: TextAlignVertical.center,
        cursorColor: ColorManager.black,
        textInputAction: TextInputAction.next,
        // decoration: InputDecoration(
        //   suffixIcon: IconButton(
        //     icon: Padding(
        //       padding: const EdgeInsets.only(bottom: 22),
        //       child: widget.suffixIcon ?? Icon(Icons.copy,size:12, color: Colors.black),
        //     ),
        //     onPressed: widget.onSuffixIconPressed, // Use widget.onSuffixIconPressed
        //   ),
        //  // prefix: widget.prefixWidget,
        //   prefixStyle:AllHRTableData.customTextStyle(context),
        //   border: InputBorder.none,
        //   contentPadding: EdgeInsets.only(
        //       bottom: 22,
        //       left: AppPadding.p15),
        // ),
        ///
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              bottom: AppPadding.p3,
              top: AppPadding.p5,
              left: AppPadding.p12
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: widget.labelText,
          labelStyle: DocumentTypeDataStyle.customTextStyle(context),
           errorText: hasError ? widget.errorText : null,
          suffixIcon: IconButton(
            icon: widget.suffixIcon ?? Icon(Icons.copy, size: 14,color: Colors.black),
            onPressed: widget.onSuffixIconPressed, // Use widget.onSuffixIconPressed
          ),
        ),
        inputFormatters: [
          CapitalizeFirstLetterFormatter(),
        ],
      ),
    );
  }
}










/// edit user
class EditUserPopUp extends StatefulWidget {
  final String title;
  final String deptName;
 final int userId;
  Widget child;
  final String firstname;
  final String lastname;
  final String email;

  // final TextEditingController lastNameController;
  // final TextEditingController emailController;
  // final TextEditingController firstNameController;


  final bool? enable;

  EditUserPopUp(
      {required this.title,
        required this.child,
        required this.userId,


        // required this.lastNameController,
        // required this.emailController,
        // required this.firstNameController,
        //

        this.enable,
        required this.deptName, required this.firstname, required this.lastname, required this.email});

  @override
  State<EditUserPopUp> createState() => _EditUserPopUpState();
}

class _EditUserPopUpState extends State<EditUserPopUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var deptId = 1;
  int? firstDeptId;
  String? selectedDeptName;
  int? selectedDeptId;


  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();



  @override
  void initState() {
    super.initState();
    firstnameController.text = widget.firstname;
    lastnameController.text = widget.lastname;
    emailController.text = widget.email;


  }


  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      height: 440,
      width: 400,
      title: widget.title,
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              FirstSMTextFConst(
                controller: firstnameController,
                keyboardType: TextInputType.text,
                text: "First Name",
              ),
              // if (_nameDocError != null) // Display error if any
              //   Text(
              //     _nameDocError!,
              //     style: CommonErrorMsg.customTextStyle(context),
              //   ),
              SizedBox(height: 5,),
              ///
              FirstSMTextFConst(
                controller:lastnameController,
                keyboardType: TextInputType.text,
                text: 'Last Name',
              ),
              // if (_stateDocError != null) // Display error if any
              //   Text(
              //     _stateDocError!,
              //     style: CommonErrorMsg.customTextStyle(context),
              //   ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:0),
                    child: Text(
                        'Select Department',
                        //  widget.depTitle,

                        style: AllPopupHeadings.customTextStyle(context)),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              FutureBuilder<List<HRHeadBar>>(
                future: companyHRHeadApi(context, deptId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    List<String>dropDownServiceList =[];
                    return Container(
                        alignment: Alignment.center,
                        child:
                        HRUManageDropdown(
                          controller: TextEditingController(
                              text: ''),
                          labelFontSize: 12,
                          items:  dropDownServiceList,
                        )
                    );
                  }
                  if (snapshot.hasData &&
                      snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        ErrorMessageString.noroleAdded,
                        style: AllNoDataAvailable.customTextStyle(context),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    // Extract dropdown items from snapshot
                    List<String> dropDownServiceList = snapshot
                        .data!
                        .map((dept) => dept.deptName!)
                        .toList();
                    String? firstDeptName =
                    snapshot.data!.isNotEmpty
                        ? snapshot.data![0].deptName
                        : null;
                    int? firstDeptId = snapshot.data!.isNotEmpty
                        ? snapshot.data![0].deptId
                        : null;

                    if (selectedDeptName == null &&
                        dropDownServiceList.isNotEmpty) {
                      selectedDeptName = firstDeptName;
                      selectedDeptId = firstDeptId;
                    }

                    return HRUManageDropdown(
                      controller: TextEditingController(
                          text: selectedDeptName ?? ''),
                      hintText: "Department",
                      labelFontSize: 12,
                      items: dropDownServiceList,
                      onChanged: (val) {
                        setState(() {
                          selectedDeptName = val;
                          // Find the corresponding department ID from the snapshot
                          selectedDeptId = snapshot.data!
                              .firstWhere(
                                  (dept) => dept.deptName == val)
                              .deptId;
                        });
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 14,),
              SMTextFConst(controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  text: 'Email'),
              // if (_emailDocError != null) // Display error if any
              //   Text(
              //     _emailDocError!,
              //     style: CommonErrorMsg.customTextStyle(context),
              //   ),
            ],
          ),
        )
      ],
      bottomButtons: ReusableLoadingButton(
        height: 30,
        width: 120,
        text: 'Submit',
        onPressed: ()  async{

          String FName = firstnameController.text.isNotEmpty
              ? firstnameController.text
              : widget.firstname;

          String LDocName = lastnameController.text.isNotEmpty
              ? lastnameController.text
              : widget.lastname;

          String EDocName = emailController.text.isNotEmpty
              ? emailController.text
              : widget.email;

          var responce = await updateUserPatch(
          context:
          context,
          userId: widget.userId,
          firstName: FName,
          lastName:LDocName,

          deptId: selectedDeptId!,
              // ??
              // snapshotPrefill
              //     .data!
              //     .deptId,
          email:EDocName

          );
          // getUser(context)
          //     .then(
          //         (data) {
          //       _companyUsersList
          //           .add(
          //           data);
          //     }).catchError(
          //         (error) {
          //       // Handle error
          //     });
          Navigator.pop(
              context);
          if(responce.statusCode == 200 || responce.statusCode == 201){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddSuccessPopup(
                  message: 'User Edit Successfully',
                );
              },
            );
          }
          // firstNameController
          //     .clear();
          // lastNameController
          //     .clear();
          // roleController
          //     .clear();
          // emailController
          //     .clear();
          // companyIdController
          //     .clear();
        },
        loadingDuration: 2,
      ),
    );
  }
}






















//
// /// edit user
// class EditUserPopUp extends StatefulWidget {
//   final String title;
//   final String deptName;
//   final VoidCallback onSubmit;
//   Widget child;
//   final TextEditingController userIdController;
//   final TextEditingController lastNameController;
//   final TextEditingController emailController;
//   final TextEditingController firstNameController;
//    TextEditingController? roleController;
//    final TextEditingController? passwordController;
//   final TextEditingController companyIdController ;
//   final bool ? enable;
//
//
//    EditUserPopUp({
//     required this.title,
//     required this.child,
//     required this.onSubmit,
//     required this.userIdController,
//     required this.lastNameController,
//     required this.emailController,
//     required this.firstNameController,
//      this.roleController,
//     required this.companyIdController,  this.passwordController,
//    this.enable, required this.deptName});
//
//
//   @override
//   State<EditUserPopUp> createState() => _EditUserPopUpState();
// }
//
// class _EditUserPopUpState extends State<EditUserPopUp> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         child: Stack(
//           children: <Widget>[
//             Container(
//               height: 490,
//               width: 450,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10.0,
//                     offset: const Offset(0.0,10.0),
//                   ),
//                 ],
//               ),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Container(
//                         height: 40,
//                         width: 450,
//                         //padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                           color: ColorManager.bluebottom,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: AppPadding.p35),
//                               child: Text(
//                                 widget.title,
//                                 style: PopupBlueBarText.customTextStyle(context),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(bottom: 5.0),
//                               child: IconButton(
//                                 splashColor: Colors.transparent,
//                                 hoverColor: Colors.transparent,
//                                 highlightColor: Colors.transparent,
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 icon: Icon(
//                                   Icons.close,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10 ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 4),
//                               child: Text("First Name" ,
//                                 style: TextStyle(fontSize: 10, color:  Color(0xff686464),fontWeight: FontWeight.w700),),
//                             ),
//                             SizedBox(height: 8,),
//                             HRManageTextField(
//                               height: 38,
//                               width: 350,
//                               controller: widget.firstNameController,
//                               keyboardType: TextInputType.phone,
//                               text: "First Name",
//                               cursorHeight: 12,
//                               // labelText: "First Name",
//                               labelStyle: TextStyle(),
//                               labelFontSize: 10,
//                               errorText: 'First Name is required',
//                               hintText: 'First Name',
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10 ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 4),
//                               child: Text("Last Name", style: TextStyle(fontSize: 10, color:  Color(0xff686464),fontWeight: FontWeight.w700),),
//                             ),
//                             SizedBox(height: 8,),
//                             HRManageTextField(
//                               height: 38,
//                               width: 350,
//                               controller: widget.lastNameController,
//                               keyboardType: TextInputType.phone,
//                               text: "Last Name",
//                               cursorHeight: 12,
//                               // labelText: "Last Name",
//                               labelStyle: TextStyle(),
//                               labelFontSize: 10,
//                               errorText: 'Last Name is required', hintText: 'last Name',
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10 ),
//                         child: Column(
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(right: 250 ),
//                               child: Text(
//                                 widget.deptName,
//                                 style: TextStyle(
//                                     fontSize: 10,
//                                     color:  Color(0xff686464),
//                                     fontWeight: FontWeight.w700),),
//                             ),
//                             SizedBox(height: 8,),
//                             widget.child,
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10, bottom: 10 ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 4),
//                               child: Text("Email", style: TextStyle(fontSize: 10, color:  Color(0xff686464),fontWeight: FontWeight.w700),),
//                             ),
//                             SizedBox(height: 8,),
//                             HRManageTextFieldEmail(
//                               height: 38,
//                               width: 350,
//                               controller: widget.emailController,
//                               keyboardType: TextInputType.phone,
//                               text: "Email",
//                               cursorHeight: 12,
//                               // labelText: "Email",
//
//                               labelStyle: TextStyle(),
//                               hintText: "Email",
//                               labelFontSize: 10,
//                               errorText: 'Email is required',
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 35),
//                       ReusableLoadingButton(
//                         height: 30,
//                         width: 120,
//                         text: 'Submit',
//                         onPressed: (){
//                           widget.onSubmit();
//                         },
//                         loadingDuration: 2,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )
//     );
//   }
// }
