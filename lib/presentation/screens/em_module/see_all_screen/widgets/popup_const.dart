import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import 'dart:math';



class CustomDialog extends StatefulWidget {
  final String title;
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
            height: 420,
            width: 360,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
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
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: AppPadding.p23),
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
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: HRManageTextField(
                    controller: widget.firstNameController,
                    keyboardType: TextInputType.phone,
                    text: "First Name",
                    cursorHeight: 12,
                    labelText: "First Name",
                    labelStyle: TextStyle(),
                    labelFontSize: 12,
                    errorText: 'First Name is required',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: HRManageTextField(
                    controller: widget.lastNameController,

                    keyboardType: TextInputType.phone,
                    text: "Last Name",
                    cursorHeight: 12,
                    labelText: "Last Name",
                    labelStyle: TextStyle(),
                    labelFontSize: 12,
                    errorText: 'Last Name is required',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: widget.child,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: HRManageTextFieldEmail(
                    controller: widget.emailController,
                    keyboardType: TextInputType.phone,
                    text: "Email",
                    cursorHeight: 12,
                    labelText: "Email",
                    labelStyle: TextStyle(),
                    labelFontSize: 12,
                    errorText: 'Email is required',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomTextFieldWithIcon(
                    controller: widget.passwordController,
                    suffixIcon: Icon(Icons.copy, size: 14,color: Colors.black),
                    keyboardType: TextInputType.text,
                    text: "Password",
                    cursorHeight: 12,
                    labelText: "Password",
                    labelStyle: TextStyle(),
                    labelFontSize: 12,
                    errorText: 'Password is required',
                    onSuffixIconPressed: _copyToClipboard, // Pass the copy callback
                  ),
                ),

                SizedBox(height: 24.0),
                ReusableLoadingButton(
                  text: 'Create',
                  onPressed: (){
                    widget.onSubmit();
                  },
                  loadingDuration: 2,
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
  final double cursorHeight;
  final String labelText;
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
    required this.labelText,
    this.labelStyle,
    required this.labelFontSize,
    this.errorText,
    this.onSuffixIconPressed,  // Callback for suffix icon
    this.focusNode,
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
          style: TextStyle(color: ColorManager.mediumgrey, fontWeight: FontWeight.w600, fontSize: 12),
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
   this.enable});


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
              height: 420,
              width: 360,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
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
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: AppPadding.p23),
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
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: HRManageTextField(
                      //     readOnly: true,
                      //     enabled: false,
                      //     controller: widget.userIdController,
                      //     keyboardType: TextInputType.phone,
                      //     text: "User ID",
                      //     cursorHeight: 12,
                      //     labelText: "User ID",
                      //     labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                      //     labelFontSize: 12,
                      //     errorText: 'User ID is required',
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HRManageTextField(
                          controller: widget.firstNameController,
                          keyboardType: TextInputType.phone,
                          text: "First Name",
                          cursorHeight: 12,
                          labelText: "First Name",
                          labelStyle: TextStyle(),
                          labelFontSize: 12,
                          errorText: 'First Name is required',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HRManageTextField(
                          controller: widget.lastNameController,
                          keyboardType: TextInputType.phone,
                          text: "Last Name",
                          cursorHeight: 12,
                          labelText: "Last Name",
                          labelStyle: TextStyle(),
                          labelFontSize: 12,
                          errorText: 'Last Name is required',
                        ),
                      ),
                      widget.child,
                      // HRManageDropdown(
                      //   controller: widget.roleController!,
                      //   labelText: 'Role',
                      //   labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                      //   labelFontSize: 12,
                      //   items: ['Admin', 'Staff', 'User'],
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HRManageTextFieldEmail(
                          controller: widget.emailController,
                          keyboardType: TextInputType.phone,
                          text: "Email",
                          cursorHeight: 12,
                          labelText: "Email",
                          labelStyle: TextStyle(),
                          labelFontSize: 12,
                          errorText: 'Email is required',
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: HRManageTextField(
                      //     controller: widget.passwordController,
                      //     keyboardType: TextInputType.visiblePassword,
                      //     text: "Password",
                      //     cursorHeight: 12,
                      //     labelText: "Password",
                      //     labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                      //     labelFontSize: 12,
                      //     errorText: 'Password is required',
                      //   ),
                      // ),
                      SizedBox(height: 35),
                      ReusableLoadingButton(
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
