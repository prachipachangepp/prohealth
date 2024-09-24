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
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import 'dart:math';

import '../../../../../app/resources/font_manager.dart';



class CustomDialog extends StatefulWidget {
  final String title;
  final String depTitle;
   VoidCallback onSubmit;
  final TextEditingController userIdController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController roleController;
  final TextEditingController passwordController;
  final TextEditingController companyIdController ;
  Widget child;

  CustomDialog({
    required this.child,
    required this.title,
    required this.depTitle,
    required this.onSubmit,
    required this.userIdController,
    required this.lastNameController,
    required this.emailController,
    required this.firstNameController,
    required this.roleController,
    required this.passwordController,
    required this.companyIdController,
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
  String? _pPhoneDocError;
  String? _sphoneDocError;
  String? _aphoneDocError;
  String? _countryDocError;

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
          _validateTextField(widget.passwordController.text, 'Password ');
      // _pPhoneDocError =
      //     _validateTextField(widget.mobNumController.text, 'Primary Phone');
      // _sphoneDocError =
      //     _validateTextField(widget.secNumController.text, 'Secondary Phone');
      // _aphoneDocError = _validateTextField(
      //     widget.OptionalController.text, 'Alternative Phone');
      // _countryDocError =
      //     _validateTextField(widget.countryController.text, 'Country');
    });
  }








  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            height: 500,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  width: 440,
                  //padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ColorManager.bluebottom,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          widget.title,
                          style: PopupBlueBarText.customTextStyle(context),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text("First Name" ,
                                style: TextStyle(
                                    fontSize: 10,
                                    color:  Color(0xff686464),
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            HRManageTextField(
                              controller: widget.firstNameController,
                              keyboardType: TextInputType.phone,
                              text: "First Name",
                              cursorHeight: 12,
                              // labelText: "First Name",
                              // labelStyle: TextStyle(),
                              labelFontSize: 10,
                              errorText: 'First Name is required',
                              hintText: 'First Name',
                            ),
                            if (_nameDocError != null) // Display error if any
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text(
                                  _nameDocError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: FontSize.s10,
                                  ),
                                ),
                              ),

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text("Last Name",
                                style: TextStyle(fontSize: 10,
                                    color:  Color(0xff686464),
                                    fontWeight: FontWeight.w700),
                              ),

                            ),
                            SizedBox(height: 8,),
                            HRManageTextField(
                              controller: widget.lastNameController,
                              keyboardType: TextInputType.phone,
                              text: "Last Name",
                              cursorHeight: 12,
                              // labelText: "Last Name",
                              // labelStyle: TextStyle(),
                              labelFontSize: 10,
                              errorText: 'Last Name is required',
                              hintText: 'Last Name',
                            ),

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 220 ),
                              child: Text(
                                 widget.depTitle,
                                style: TextStyle(fontSize: 10,
                                    color:  Color(0xff686464),
                                    fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(height: 8,),
                            widget.child,
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text("Email", style: TextStyle(fontSize: 10, color:  Color(0xff686464),fontWeight: FontWeight.w700),
                              ),

                            ),


                            SizedBox(height: 8,),
                            HRManageTextFieldEmail(

                              ///
                              controller:widget.emailController,
                              keyboardType: TextInputType.phone,
                              text: "Email",
                              cursorHeight: 12,
                              // labelText: "Last Name",
                              labelStyle: TextStyle(),
                              labelFontSize: 10,
                              errorText: 'Email is required',
                              hintText: 'Email',
                            ),
                            if (_emailDocError != null) // Display error if any
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text(
                                  _emailDocError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: FontSize.s10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 10),
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text("Password", style: TextStyle(fontSize: 10, color:  Color(0xff686464),fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(height: 8,),
                            CustomTextFieldWithIcon(
                              controller: widget.passwordController,
                              suffixIcon: Icon(Icons.copy, size: 14,color: Colors.black),
                              keyboardType: TextInputType.text,
                              text: "Password",
                              cursorHeight: 12,
                              // labelText: "Password",
                              hintText: "Password",
                              labelStyle: TextStyle(),
                              labelFontSize: 10,
                              errorText: 'Password is required',
                              onSuffixIconPressed: _copyToClipboard, // Pass the copy callback
                            ),
                            if (_PasswordDocError != null) // Display error if any
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text(
                                  _PasswordDocError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: FontSize.s10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.0),
                      ReusableLoadingButton(
                        height: 30,
                        width: 120,
                        text: 'Create',
                        onPressed: () async {
                          _validateForm();
                          if (_isFormValid) {
                            widget.onSubmit();
                          }

                        },
                        loadingDuration: 3,
                      ),

              ],
            ),
          ),
        ],
      )
    );
  }
}

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
      width: 320,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p5),
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          textAlign: TextAlign.start,
          style: TextStyle(color: ColorManager.mediumgrey, fontWeight: FontWeight.w700, fontSize: 12),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: ColorManager.black,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3,
                top: AppPadding.p5,
                left: AppPadding.p5
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle?.copyWith(
                fontSize: widget.labelFontSize,
                color: ColorManager.mediumgrey
            ),
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
      ),
    );
  }
}







/// edit user
class EditUserPopUp extends StatefulWidget {
  final String title;
  final String deptName;
  final VoidCallback onSubmit;
  Widget child;
  final TextEditingController userIdController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
   TextEditingController? roleController;
   final TextEditingController? passwordController;
  final TextEditingController companyIdController ;
  final bool ? enable;


   EditUserPopUp({
    required this.title,
    required this.child,
    required this.onSubmit,
    required this.userIdController,
    required this.lastNameController,
    required this.emailController,
    required this.firstNameController,
     this.roleController,
    required this.companyIdController,  this.passwordController,
   this.enable, required this.deptName});


  @override
  State<EditUserPopUp> createState() => _EditUserPopUpState();
}

class _EditUserPopUpState extends State<EditUserPopUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              height: 470,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0,10.0),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 440,
                        //padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ColorManager.bluebottom,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: AppPadding.p35),
                              child: Text(
                                widget.title,
                                style: PopupBlueBarText.customTextStyle(context),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),

                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10 ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text("First Name" , style: TextStyle(fontSize: 10, color:  Color(0xff686464),fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(height: 8,),
                            HRManageTextField(
                              controller: widget.firstNameController,
                              keyboardType: TextInputType.phone,
                              text: "First Name",
                              cursorHeight: 12,
                              // labelText: "First Name",
                              labelStyle: TextStyle(),
                              labelFontSize: 10,
                              errorText: 'First Name is required',
                              hintText: 'First Name',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10 ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text("Last Name", style: TextStyle(fontSize: 10, color:  Color(0xff686464),fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(height: 8,),
                            HRManageTextField(
                              controller: widget.lastNameController,
                              keyboardType: TextInputType.phone,
                              text: "Last Name",
                              cursorHeight: 12,
                              // labelText: "Last Name",
                              labelStyle: TextStyle(),
                              labelFontSize: 10,
                              errorText: 'Last Name is required', hintText: 'last Name',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10 ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 220 ),
                              child: Text(
                                widget.deptName,
                                style: TextStyle(
                                    fontSize: 10,
                                    color:  Color(0xff686464),
                                    fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(height: 8,),
                            widget.child,
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10 ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text("Email", style: TextStyle(fontSize: 10, color:  Color(0xff686464),fontWeight: FontWeight.w700),),
                            ),
                            SizedBox(height: 8,),
                            HRManageTextFieldEmail(
                              controller: widget.emailController,
                              keyboardType: TextInputType.phone,
                              text: "Email",
                              cursorHeight: 12,
                              // labelText: "Email",

                              labelStyle: TextStyle(),
                              hintText: "Email",
                              labelFontSize: 10,
                              errorText: 'Email is required',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      ReusableLoadingButton(
                        height: 30,
                        width: 120,
                        text: 'Submit',
                        onPressed: (){
                          widget.onSubmit();
                        },
                        loadingDuration: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
