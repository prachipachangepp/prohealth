import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
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

  CustomDialog({
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


  String _password = '';
  // Method for Generating Random Passwords
  void _generatePassword() {
    final random = Random();
    final characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@';
    String password = '';
    for (int i = 0; i < 8; i++) {
      password += characters[
      // Generate a random password
      random.nextInt(characters.length)];
    }
    setState(() {
      // Update the displayed password
      _password = password;
      widget.passwordController.text = password;
    });
  }



  @override
  initState() {
    super.initState();
    _generatePassword();
  }




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
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ColorManager.bluebottom,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p25),
                          child: Text(
                            widget.title,
                            style: GoogleFonts.firaSans(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8.0),
                //   child: HRManageTextField(
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
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: HRManageTextField(
                    controller: widget.firstNameController,
                    keyboardType: TextInputType.phone,
                    text: "First Name",
                    cursorHeight: 12,
                    labelText: "First Name",
                    labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
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
                    labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                    labelFontSize: 12,
                    errorText: 'Last Name is required',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: HRManageDropdown(
                    controller: widget.roleController,
                    labelText: 'Role',
                    labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                    labelFontSize: 12,
                    items: ['Admin', 'Sales', 'Clinician'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: HRManageTextFieldEmail(
                    controller: widget.emailController,
                    keyboardType: TextInputType.phone,
                    text: "Email",
                    cursorHeight: 12,
                    labelText: "Email",
                    labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                    labelFontSize: 12,
                    errorText: 'Email is required',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: HRManageTextFieldEmail(
                    controller: widget.passwordController,

                    keyboardType: TextInputType.text,
                    text: "Password",
                    cursorHeight: 12,
                    labelText: "Password",       //  _password,
                    labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                    labelFontSize: 12,
                    errorText: 'Password is required',
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8.0),
                //   child: HRManageTextField(
                //     readOnly: true,
                //     controller: widget.companyIdController,
                //     keyboardType: TextInputType.phone,
                //     text: "Company ID",
                //     cursorHeight: 12,
                //     labelText: "Company ID",
                //     labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                //     labelFontSize: 12,
                //     //errorText: 'Company ID is required',
                //   ),
                // ),
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







/// edit user
class EditUserPopUp extends StatefulWidget {
  final String title;
  final VoidCallback onSubmit;
  final TextEditingController userIdController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController firstNameController;
   TextEditingController? roleController;
  // final TextEditingController passwordController;
  final TextEditingController companyIdController ;


   EditUserPopUp({
    required this.title,
    required this.onSubmit,
    required this.userIdController,
    required this.lastNameController,
    required this.emailController,
    required this.firstNameController,
     this.roleController,
    required this.companyIdController});


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
              height: 500,
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
                        padding: EdgeInsets.all(5),
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
                              padding: const EdgeInsets.only(left: AppPadding.p25),
                              child: Text(
                                widget.title,
                                style: GoogleFonts.firaSans(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HRManageTextField(
                          controller: widget.userIdController,
                          keyboardType: TextInputType.phone,
                          text: "User ID",
                          cursorHeight: 12,
                          labelText: "User ID",
                          labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                          labelFontSize: 12,
                          errorText: 'User ID is required',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HRManageTextField(
                          controller: widget.firstNameController,
                          keyboardType: TextInputType.phone,
                          text: "First Name",
                          cursorHeight: 12,
                          labelText: "First Name",
                          labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
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
                          labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                          labelFontSize: 12,
                          errorText: 'Last Name is required',
                        ),
                      ),
                      HRManageDropdown(
                        controller: widget.roleController!,
                        labelText: 'Role',
                        labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                        labelFontSize: 12,
                        items: ['Admin', 'Staff', 'User'],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HRManageTextFieldEmail(
                          controller: widget.emailController,
                          keyboardType: TextInputType.phone,
                          text: "Email",
                          cursorHeight: 12,
                          labelText: "Email",
                          labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                          labelFontSize: 12,
                          errorText: 'Email is required',
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: HRManageTextField(
                      //     controller: widget.companyIdController,
                      //     keyboardType: TextInputType.phone,
                      //     text: "Company ID",
                      //     cursorHeight: 12,
                      //     labelText: "Company ID",
                      //     labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                      //     labelFontSize: 12,
                      //     errorText: 'Company ID is required',
                      //   ),
                      // ),
                      SizedBox(height: 24.0),
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
