import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

class AddReferencePopup extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController titlePositionController;
  final TextEditingController knowPersonController;
  final TextEditingController companyNameController;
  final TextEditingController associationLengthController;
  final TextEditingController mobileNumberController;
  final TextEditingController referredBy;
  final String title;
  VoidCallback onpressedClose;
  Future<void> Function() onpressedSave;
  AddReferencePopup(
      {super.key,
      required this.nameController,
      required this.emailController,
      required this.titlePositionController,
      required this.knowPersonController,
      required this.companyNameController,
      required this.associationLengthController,
      required this.mobileNumberController,
      required this.onpressedClose,
      required this.onpressedSave,
      required this.title,
      required this.referredBy});

  @override
  State<AddReferencePopup> createState() => _AddReferencePopupState();
}



class _AddReferencePopupState extends State<AddReferencePopup> {
  bool isLoading = false;

  // Error states
  Map<String, bool> errorStates = {
    'name': false,
    'email': false,
    'titlePosition': false,
    'knowPerson': false,
    'companyName': false,
    'associationLength': false,
    'mobileNumber': false,
    'referredBy': false,
  };

  // Email validation
  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.8 ,
        height: MediaQuery.of(context).size.height / 1.8,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: AppSize.s50,
              decoration: BoxDecoration(
                color: ColorManager.blueprime,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Text(
                      widget.title,
                      style: PopupHeadingStyle.customTextStyle(context)
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _clearControllers();
                    },
                    icon: Icon(
                        Icons.close,
                        color: IconColorManager.white
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  controller: widget.nameController,
                  labelText: "Name",
                  errorKey: 'name',
                  capitalIsSelect: true,
                ),
                _buildTextField(
                  controller: widget.emailController,
                  labelText: "Email",
                  errorKey: 'email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => !_isEmailValid(value)
                      ? 'Please enter a valid email'
                      : null,
                  capitalIsSelect: false,
                ),
                // _buildTextField(
                //   controller: widget.nameController,
                //   labelText: "Name",
                //   errorKey: 'name',
                //   keyboardType: TextInputType.name,
                //   validator: (value) => value.isEmpty ? 'Please enter your name' : null,
                //   capitalIsSelect: true, // Capitalize first letter for name
                // ),
                _buildTextField(
                  controller: widget.titlePositionController,
                  labelText: "Title/Position",
                  errorKey: 'titlePosition',
                  capitalIsSelect: true,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  controller: widget.knowPersonController,
                  labelText: "How do you know this person?",
                  errorKey: 'knowPerson',
                  capitalIsSelect: true,
                ),
                _buildTextField(
                  controller: widget.companyNameController,
                  labelText: "Company",
                  errorKey: 'companyName',
                  capitalIsSelect: true,
                ),
                _buildTextField(
                  controller: widget.associationLengthController,
                  labelText: "Length of Association",
                  errorKey: 'associationLength',
                  capitalIsSelect: true,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  controller: widget.mobileNumberController,
                  labelText: "Mobile Number",
                  errorKey: 'mobileNumber',
                  keyboardType: TextInputType.number,
                  capitalIsSelect: true,
                ),

                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 6,
                ),
                // _buildTextField(
                //   controller: widget.referredBy,
                //   labelText: "Referred By",
                //   errorKey: 'referredBy',
                //   capitalIsSelect: true,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButtonTransparent(text: AppString.cancel, onPressed: () {_clearControllers();}),
                  const SizedBox(
                    width: AppSize.s10,
                  ),
                  isLoading
                      ? SizedBox(
                      height: AppSize.s25,
                      width: AppSize.s25,
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ))
                      : CustomElevatedButton(
                    width: AppSize.s100,
                    text: AppString.save,
                    onPressed: _handleSave,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String errorKey,
    TextInputType? keyboardType,
    String? Function(String)? validator,
    bool capitalIsSelect = false, // Add this parameter with a default value
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldRegister(
          phoneNumberField:  errorKey == 'mobileNumber' ? true : false,
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
          labelText: labelText,
          keyboardType: keyboardType ?? TextInputType.text,
          padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
          capitalIsSelect: capitalIsSelect, // Pass the parameter here
          onChanged: (value) {
            setState(() {
              if (validator != null) {
                errorStates[errorKey] = validator(value) != null;
              } else {
                errorStates[errorKey] = value.isEmpty;
              }
              // if (errorKey == 'mobileNumber') {
              //   errorStates[errorKey] = value.length != 10;
              // }
            });
          },
        ),
        // if (errorStates[errorKey]!)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 5),
        //     child: Text(
        //       errorKey == 'mobileNumber'
        //           ? 'Please Enter a valid mobile number'
        //           : errorKey == 'email'
        //           ? 'Please Enter a valid email'
        //           : 'Please Enter $labelText',
        //       style: TextStyle(
        //         color: ColorManager.red,
        //         fontSize: FontSize.s10,
        //       ),
        //     ),
        //   ),
      ],
    );
  }
  void _handleSave() async {
    setState(() {
      errorStates['name'] = widget.nameController.text.isEmpty;
      errorStates['email'] = !_isEmailValid(widget.emailController.text);
      errorStates['titlePosition'] = widget.titlePositionController.text.isEmpty;
      errorStates['knowPerson'] = widget.knowPersonController.text.isEmpty;
      errorStates['companyName'] = widget.companyNameController.text.isEmpty;
      errorStates['associationLength'] = widget.associationLengthController.text.isEmpty;
      //errorStates['mobileNumber'] = widget.mobileNumberController.text.length != 10;
      errorStates['referredBy'] = widget.referredBy.text.isEmpty;
    });

    // if (!errorStates.values.contains(true)) {
      try {
        setState(() {
          isLoading = true;
        });
        await widget.onpressedSave();
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 3), () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            });
            return AddSuccessPopup(
              message: 'Added Successfully',
            );
          },
        );
        _clearControllers();
      }
    // }
  }

  void _clearControllers() {
    widget.nameController.clear();
    widget.emailController.clear();
    widget.companyNameController.clear();
    widget.titlePositionController.clear();
    widget.mobileNumberController.clear();
    widget.associationLengthController.clear();
    widget.knowPersonController.clear();
    widget.referredBy.clear();
  }
}



//////


//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
//
// class AddReferencePopup extends StatefulWidget {
//   final TextEditingController nameController;
//   final TextEditingController emailController;
//   final TextEditingController titlePositionController;
//   final TextEditingController knowPersonController;
//   final TextEditingController companyNameController;
//   final TextEditingController associationLengthController;
//   final TextEditingController mobileNumberController;
//   final String title;
//   final VoidCallback onpressedClose;
//   Future<void> Function() onpressedSave;
//
//   AddReferencePopup({
//     Key? key,
//     required this.nameController,
//     required this.emailController,
//     required this.titlePositionController,
//     required this.knowPersonController,
//     required this.companyNameController,
//     required this.associationLengthController,
//     required this.mobileNumberController,
//     required this.onpressedClose,
//     required this.onpressedSave,
//     required this.title,
//   }) : super(key: key);
//
//   @override
//   State<AddReferencePopup> createState() => _AddReferencePopupState();
// }
//
// class _AddReferencePopupState extends State<AddReferencePopup> {
//   bool isLoading = false;
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: MediaQuery.of(context).size.width / 1.5,
//         height: AppSize.s420,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Color(0xff50B5E5),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     topRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                       child: Text(
//                         widget.title,
//                         style: GoogleFonts.firaSans(
//                           fontSize: FontSize.s14,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.close, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width / 6,
//                     controller: widget.nameController,
//                     labelText: "Name",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//                     onChanged: (value) {},
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter Name';
//                       }
//                       if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
//                         return 'Please enter only alphabets';
//                       }
//                       return null;
//                     },
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width / 6,
//                     controller: widget.emailController,
//                     labelText: "Email",
//                     keyboardType: TextInputType.emailAddress,
//                     padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//                     onChanged: (value) {},
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter Email';
//                       }
//                       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                         return 'Please enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width / 6,
//                     controller: widget.titlePositionController,
//                     labelText: "Title/Position",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//                     onChanged: (value) {},
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter Title/Position';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width / 6,
//                     controller: widget.knowPersonController,
//                     labelText: "How do you know this person?",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//                     onChanged: (value) {},
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter how you know this person';
//                       }
//                       return null;
//                     },
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width / 6,
//                     controller: widget.companyNameController,
//                     labelText: "Company",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//                     onChanged: (value) {},
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter Company';
//                       }
//                       return null;
//                     },
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width / 6,
//                     controller: widget.associationLengthController,
//                     labelText: "Length of Association",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//                     onChanged: (value) {},
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter Length of Association';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width / 6,
//                     controller: widget.mobileNumberController,
//                     labelText: "Mobile Number",
//                     keyboardType: TextInputType.phone,
//                     padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//                     onChanged: (value) {},
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter Mobile Number';
//                       }
//                       if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                         return 'Please enter 10 digit number';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width / 6),
//                   SizedBox(width: MediaQuery.of(context).size.width / 6),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 15),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     CustomButtonTransparent(
//                       text: "Cancel",
//                       onPressed: () async {
//                         widget.onpressedClose();
//                       },
//                     ),
//                     const SizedBox(width: 10),
//                     isLoading
//                         ? SizedBox(
//                       height: 25,
//                       width: 25,
//                       child: CircularProgressIndicator(color: ColorManager.blueprime),
//                     )
//                         : CustomElevatedButton(
//                       text: "Save",
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           setState(() {
//                             isLoading = true;
//                           });
//                           try {
//                             await widget.onpressedSave();
//                           } finally {
//                             setState(() {
//                               isLoading = false;
//                             });
//                             Navigator.pop(context);
//                             widget.nameController.clear();
//                             widget.emailController.clear();
//                             widget.companyNameController.clear();
//                             widget.titlePositionController.clear();
//                             widget.mobileNumberController.clear();
//                             widget.associationLengthController.clear();
//                             widget.knowPersonController.clear();
//                           }
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
//
// class AddReferencePopup extends StatefulWidget {
//   final TextEditingController nameController;
//   final TextEditingController emailController;
//   final TextEditingController titlePositionController;
//   final TextEditingController knowPersonController;
//   final TextEditingController companyNameController;
//   final TextEditingController associationLengthController;
//   final TextEditingController mobileNumberController;
//   final String title;
//   final VoidCallback onpressedClose;
//   Future<void> Function() onpressedSave;
//
//   AddReferencePopup({
//     Key? key,
//     required this.nameController,
//     required this.emailController,
//     required this.titlePositionController,
//     required this.knowPersonController,
//     required this.companyNameController,
//     required this.associationLengthController,
//     required this.mobileNumberController,
//     required this.onpressedClose,
//     required this.onpressedSave,
//     required this.title,
//   }) : super(key: key);
//
//   @override
//   State<AddReferencePopup> createState() => _AddReferencePopupState();
// }
//
// class _AddReferencePopupState extends State<AddReferencePopup> {
//   bool isLoading = false;
//   final _formKey = GlobalKey<FormState>();
//
//   String? _nameError;
//   String? _emailError;
//   String? _titlePositionError;
//   String? _knowPersonError;
//   String? _companyNameError;
//   String? _associationLengthError;
//   String? _mobileNumberError;
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: MediaQuery.of(context).size.width / 1.5,
//         height: AppSize.s480,                                 // Increased height to accommodate error messages
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Color(0xff50B5E5),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     topRight: Radius.circular(12),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                       child: Text(
//                         widget.title,
//                         style: GoogleFonts.firaSans(
//                           // fontSize: FontSize.s14,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(
//                         Icons.close,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildTextFieldWithError(
//                     height: AppSize.s30,
//                     controller: widget.nameController,
//                     labelText: "Name",
//                     errorText: _nameError,
//                     onChanged: (value) => setState(() => _nameError = null),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         setState(() => _nameError = "Please enter Name");
//                         return '';
//                       }
//                       if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
//                         setState(() => _nameError = "Only alphabets are allowed");
//                         return '';
//                       }
//                       return null;
//                     },
//                   ),
//                   _buildTextFieldWithError(
//                     height: AppSize.s30,
//                     controller: widget.emailController,
//                     labelText: "Email",
//                     errorText: _emailError,
//                     keyboardType: TextInputType.emailAddress,
//                     onChanged: (value) => setState(() => _emailError = null),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         setState(() => _emailError = "Please enter Email");
//                         return '';
//                       }
//                       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                         setState(() => _emailError = "Please enter a valid email");
//                         return '';
//                       }
//                       return null;
//                     },
//                   ),
//                   _buildTextFieldWithError(
//                     height: AppSize.s30,
//                     controller: widget.titlePositionController,
//                     labelText: "Title/Position",
//                     errorText: _titlePositionError,
//                     onChanged: (value) => setState(() => _titlePositionError = null),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         setState(() => _titlePositionError = "Please enter Title/Position");
//                         return '';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildTextFieldWithError(
//                     height: AppSize.s30,
//                     controller: widget.knowPersonController,
//                     labelText: "How do you know this person ?",
//                     errorText: _knowPersonError,
//                     onChanged: (value) => setState(() => _knowPersonError = null),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         setState(() => _knowPersonError = "Please enter how you know this person");
//                         return '';
//                       }
//                       return null;
//                     },
//                   ),
//                   _buildTextFieldWithError(
//                     height: AppSize.s30,
//
//                     controller: widget.companyNameController,
//                     labelText: "Company",
//                     errorText: _companyNameError,
//                     onChanged: (value) => setState(() => _companyNameError = null),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         setState(() => _companyNameError = "Please enter Company");
//                         return '';
//                       }
//                       return null;
//                     },
//                   ),
//                   _buildTextFieldWithError(
//                     height: AppSize.s30,
//                     controller: widget.associationLengthController,
//                     labelText: "Length of Association",
//                     errorText: _associationLengthError,
//                     onChanged: (value) => setState(() => _associationLengthError = null),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         setState(() => _associationLengthError = "Please enter Length of Association");
//                         return '';
//                       }
//                       return null;
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildTextFieldWithError(
//                     height: AppSize.s30,
//                     controller: widget.mobileNumberController,
//                     labelText: "Mobile Number",
//                     errorText: _mobileNumberError,
//                     keyboardType: TextInputType.phone,
//                     onChanged: (value) => setState(() => _mobileNumberError = null),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         setState(() => _mobileNumberError = "Please enter Mobile Number");
//                         return '';
//                       }
//                       if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
//                         setState(() => _mobileNumberError = "Please enter a valid 10-digit mobile number");
//                         return '';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width / 6),
//                   SizedBox(width: MediaQuery.of(context).size.width / 6),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 15),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     CustomButtonTransparent(
//                       text: "Cancel",
//                       onPressed: widget.onpressedClose,
//                     ),
//                     const SizedBox(width: 10),
//                     isLoading
//                         ? SizedBox(
//                       height: 25,
//                       width: 25,
//                       child: CircularProgressIndicator(
//                         color: ColorManager.blueprime,
//                       ),
//                     )
//                         : CustomElevatedButton(
//                       text: "Save",
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           setState(() => isLoading = true);
//                           try {
//                             await widget.onpressedSave();
//                           } finally {
//                             setState(() => isLoading = false);
//                             Navigator.pop(context);
//                             _clearControllers();
//                           }
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextFieldWithError({
//     required TextEditingController controller,
//     required String labelText,
//     required String? errorText,
//     required double? height,
//
//     TextInputType keyboardType = TextInputType.text,
//     required Function(String) onChanged,
//     required String? Function(String?) validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomTextFieldRegister(
//           height: height,
//           width: MediaQuery.of(context).size.width / 6,
//           controller: controller,
//           labelText: labelText,
//           keyboardType: keyboardType,
//           padding:  EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
//           onChanged: onChanged,
//           validator: validator,
//         ),
//         if (errorText != null)
//           Container(
//             padding: const EdgeInsets.only(left: AppPadding.p20),
//             height: 15,
//             child: Text(
//               errorText,
//               style: TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }
//
//   void _clearControllers() {
//     widget.nameController.clear();
//     widget.emailController.clear();
//     widget.companyNameController.clear();
//     widget.titlePositionController.clear();
//     widget.mobileNumberController.clear();
//     widget.associationLengthController.clear();
//     widget.knowPersonController.clear();
//   }
// }
//
// class _AddReferencePopupState extends State<AddReferencePopup> {
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: MediaQuery.of(context).size.width / 1.5,
//         height: MediaQuery.of(context).size.height / 1.7,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Color(0xff50B5E5),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 15),
//                     child: Text(
//                       widget.title,
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s14,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(
//                       Icons.close,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width / 6,
//                   controller: widget.nameController,
//                   labelText: "Name",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(
//                       bottom: AppPadding.p5, left: AppPadding.p20),
//                   onChanged: (value) {},
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 CustomTextFieldForEmail(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width / 6,
//                   controller: widget.emailController,
//                   labelText: "Email",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(
//                       bottom: AppPadding.p5, left: AppPadding.p20),
//                   onChanged: (value) {},
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width / 6,
//                   controller: widget.titlePositionController,
//                   labelText: "Title/Position",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(
//                       bottom: AppPadding.p5, left: AppPadding.p20),
//                   onChanged: (value) {},
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width / 6,
//                   controller: widget.knowPersonController,
//                   labelText: "How do you know this person ?",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(
//                       bottom: AppPadding.p5, left: AppPadding.p20),
//                   onChanged: (value) {},
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width / 6,
//                   controller: widget.companyNameController,
//                   labelText: "Company",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(
//                       bottom: AppPadding.p5, left: AppPadding.p20),
//                   onChanged: (value) {},
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width / 6,
//                   controller: widget.associationLengthController,
//                   labelText: "Length of Association",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(
//                       bottom: AppPadding.p5, left: AppPadding.p20),
//                   onChanged: (value) {},
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width / 6,
//                   controller: widget.mobileNumberController,
//                   labelText: "Mobile Number",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(
//                       bottom: AppPadding.p5, left: AppPadding.p20),
//                   onChanged: (value) {},
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width / 6,
//                   controller: widget.referredBy,
//                   labelText: "Referred By",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(
//                       bottom: AppPadding.p5, left: AppPadding.p20),
//                   onChanged: (value) {},
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 6,
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 15),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   CustomButtonTransparent(text: "Cancel", onPressed: () {}),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   isLoading
//                       ? SizedBox(
//                           height: 25,
//                           width: 25,
//                           child: CircularProgressIndicator(
//                             color: ColorManager.blueprime,
//                           ))
//                       : CustomElevatedButton(
//                     width: 100,
//                           text: "Save",
//                           onPressed: () async {
//                             setState(() {
//                               isLoading = true;
//                             });
//                             try {
//                               await widget.onpressedSave();
//                             } finally {
//                               setState(() {
//                                 isLoading = false;
//                               });
//                               Navigator.pop(context);
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   Future.delayed(Duration(seconds: 3), () {
//                                     if (Navigator.of(context).canPop()) {
//                                       Navigator.of(context).pop();
//                                     }
//                                   });
//                                   return AddSuccessPopup(
//                                     message: 'Added Successfully',
//                                   );
//                                 },
//                               );
//                               widget.nameController.clear();
//                               widget.emailController.clear();
//                               widget.companyNameController.clear();
//                               widget.titlePositionController.clear();
//                               widget.mobileNumberController.clear();
//                               widget.associationLengthController.clear();
//                               widget.knowPersonController.clear();
//                               widget.referredBy.clear();
//                             }
//                           }),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }