import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';


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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
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
              borderRadius: BorderRadius.circular(20.0),
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
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.firaSans(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
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
                SizedBox(height: 16.0),
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
                    items: ['Admin', 'Staff', 'User'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: HRManageTextField(
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
                  child: HRManageTextField(
                    controller: widget.passwordController,
                    keyboardType: TextInputType.phone,
                    text: "Password",
                    cursorHeight: 12,
                    labelText: "Password",
                    labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                    labelFontSize: 12,
                    errorText: 'Password is required',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: HRManageTextField(
                    controller: widget.companyIdController,
                    keyboardType: TextInputType.phone,
                    text: "Company ID",
                    cursorHeight: 12,
                    labelText: "Company ID",
                    labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                    labelFontSize: 12,
                    errorText: 'Company ID is required',
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
          borderRadius: BorderRadius.circular(20.0),
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
                borderRadius: BorderRadius.circular(20.0),
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
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: GoogleFonts.firaSans(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
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
                        child: HRManageTextField(
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
                        padding: const EdgeInsets.all(8.0),
                        child: HRManageTextField(
                          controller: widget.companyIdController,
                          keyboardType: TextInputType.phone,
                          text: "Company ID",
                          cursorHeight: 12,
                          labelText: "Company ID",
                          labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
                          labelFontSize: 12,
                          errorText: 'Company ID is required',
                        ),
                      ),
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


// // Function to show the custom dialog
// void showCustomDialog({
//   required BuildContext context,
//   required String title,
//   required VoidCallback onSubmit,
//   required TextEditingController userIdController,
//   required TextEditingController lastNameController,
//   required TextEditingController emailController,
//   required TextEditingController firstNameController,
//   required TextEditingController roleController,
//   required TextEditingController passwordController,
// }) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {


    ///
// class CustomDialog extends StatefulWidget {
//   final String title, description;
//   final VoidCallback onSubmit;
//
//   CustomDialog({
//     required this.title,
//     required this.description,
//     required this.onSubmit,
//   });
//
//   @override
//   State<CustomDialog> createState() => _CustomDialogState();
// }
//
// class _CustomDialogState extends State<CustomDialog> {
//   final StreamController<List<CompanyModel>> _controller =
//       StreamController<List<CompanyModel>>();
//
//   TextEditingController userIdController = TextEditingController();
//
//   TextEditingController lastNameController = TextEditingController();
//
//   TextEditingController emailController = TextEditingController();
//
//   TextEditingController firstNameController = TextEditingController();
//
//   TextEditingController roleController = TextEditingController();
//
//   TextEditingController companyIdController = TextEditingController();
//
//   TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }
//
//   Widget dialogContent(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           height: 500,
//           width: 440,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(20.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10.0,
//                 offset: const Offset(0.0, 10.0),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Container(
//                 height: 40,
//                 width: 440,
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12),
//                     )),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       widget.title,
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12.0,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(
//                         Icons.close,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: HRManageTextField(
//                   controller: lastNameController,
//                   keyboardType: TextInputType.phone,
//                   text: "User ID",
//                   cursorHeight: 12,
//                   labelText: "User ID",
//                   labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
//                   labelFontSize: 12,
//                   errorText: 'User ID is required',
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: HRManageTextField(
//                   controller: firstNameController,
//                   keyboardType: TextInputType.phone,
//                   text: "Last Name",
//                   cursorHeight: 12,
//                   labelText: "Last Name",
//                   labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
//                   labelFontSize: 12,
//                   errorText: 'Last Name is required',
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: HRManageTextField(
//                   controller: lastNameController,
//                   keyboardType: TextInputType.phone,
//                   text: "First Name",
//                   cursorHeight: 12,
//                   labelText: "First Name",
//                   labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
//                   labelFontSize: 12,
//                   errorText: 'First Name is required',
//                 ),
//               ),
//               HRManageDropdown(
//                 controller: roleController,
//                 labelText: 'Role',
//                 labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
//                 labelFontSize: 12,
//                 items: ['Admin', 'Staff', 'User'],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: HRManageTextField(
//                   controller: lastNameController,
//                   keyboardType: TextInputType.phone,
//                   text: "Email",
//                   cursorHeight: 12,
//                   labelText: "Email",
//                   labelStyle: GoogleFonts.firaSans(fontWeight: FontWeight.w500),
//                   labelFontSize: 12,
//                   errorText: 'Email is required',
//                 ),
//               ),
//               SizedBox(height: 24.0),
//               ReusableLoadingButton(
//                 text: 'Create',
//                 onPressed: () {},
//                 loadingDuration: 2,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

///
// class CustomDialog extends StatelessWidget {
//   final String title, description ;
//
//   CustomDialog({
//     required this.title,
//     required this.description,
//
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       child: dialogContent(context),
//     );
//   }
//
//   Widget dialogContent(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//          height: 500,
//           width: 440,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(20.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10.0,
//                 offset: const Offset(0.0, 10.0),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//              Container(
//                height: 40,
//                width: 440,
//                padding: EdgeInsets.all(5),
//                decoration: BoxDecoration(
//                  color: Colors.blue,
//                borderRadius: BorderRadius.only(
//                  topLeft: Radius.circular(12), topRight: Radius.circular(12)
//                )),
//                child:Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Text(
//                      title,
//                      style: GoogleFonts.firaSans(
//                        fontSize: 12.0,
//                        fontWeight: FontWeight.w700,
//                        color: Colors.white,
//                      ),
//                    ),
//                    IconButton(
//                        onPressed: (){
//                          Navigator.pop(context);
//                        },
//                        icon: Icon( Icons.close,
//                          color: Colors.white,))
//                  ],
//                )
//              ),
//               SizedBox(height: 16.0),
//               // Text(
//               //   description,
//               //   textAlign: TextAlign.center,
//               //   style: TextStyle(
//               //     fontSize: 12.0,
//               //   ),
//               // ),
//               SizedBox(height: 24.0),
//               // Align(
//               //   alignment: Alignment.bottomRight,
//               //   child: ElevatedButton(
//               //     onPressed: () {
//               //       Navigator.of(context).pop(); // To close the dialog
//               //     },
//               //     child: Text(buttonText),
//               //   ),
//
//             ],
//           ),
//         ),
//         // Positioned(
//         //   left: 16.0,
//         //   right: 16.0,
//         //   child: CircleAvatar(
//         //     backgroundColor: Colors.blueAccent,
//         //     radius: 66.0,
//         //     child: ClipRRect(
//         //       borderRadius: BorderRadius.all(Radius.circular(66.0)),
//         //       child: Icon(
//         //         Icons.info,
//         //         size: 20.0,
//         //         color: Colors.white,
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
// createUserPost(
// context,
// firstNameController.text,
// lastNameController.text,
// roleController.text,
// emailController.text,
// int.parse(
// companyIdController
//     .text),
// passwordController.text);
// getUser(context).then((data) {
// _companyUsersList.add(data);
// }).catchError((error) {
// // Handle error
// });
// Navigator.pop(context);
// firstNameController.clear();
// lastNameController.clear();
// roleController.clear();
// emailController.clear();
// companyIdController.clear();
// passwordController.clear();
// Future.delayed(
// Duration(
// seconds: 2),
// () {
// print(
// 'Submit action completed!');
// });
// print('Form validated and submitted!');
