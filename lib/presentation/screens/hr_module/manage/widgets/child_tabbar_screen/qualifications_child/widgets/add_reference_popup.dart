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
//    AddReferencePopup({super.key, required this.nameController, required this.emailController, required this.titlePositionController, required this.knowPersonController, required this.companyNameController, required this.associationLengthController, required this.mobileNumberController, required this.onpressedClose, required this.onpressedSave, required this.title});
//
//   @override
//   State<AddReferencePopup> createState() => _AddReferencePopupState();
// }
//
// class _AddReferencePopupState extends State<AddReferencePopup> {
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return  Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: MediaQuery.of(context).size.width/1.5,
//         height: AppSize.s420,
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
//                     padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
//                     child: Text(widget.title,style: GoogleFonts.firaSans(
//                       fontSize: FontSize.s14,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                       decoration: TextDecoration.none,
//                     ),),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.close,color: Colors.white,),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height:MediaQuery.of(context).size.height/20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width/6,
//                   controller: widget.nameController,
//                   labelText: "Name",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                   onChanged: (value) {
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width/6,
//                   controller: widget.emailController,
//                   labelText: "Email",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                   onChanged: (value) {
//
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width/6,
//                   controller: widget.titlePositionController,
//                   labelText: "Title/Position",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                   onChanged: (value) {
//
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//
//               ],
//             ),
//             SizedBox(height:MediaQuery.of(context).size.height/20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width/6,
//                   controller: widget.knowPersonController,
//                   labelText: "How do you know this person ?",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                   onChanged: (value) {
//
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width/6,
//                   controller: widget.companyNameController,
//                   labelText: "Company",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                   onChanged: (value) {
//
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width/6,
//                   controller: widget.associationLengthController,
//                   labelText: "Length of Association",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                   onChanged: (value) {
//
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//
//               ],
//             ),
//             SizedBox(height:MediaQuery.of(context).size.height/20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CustomTextFieldRegister(
//                   height: AppSize.s30,
//                   width: MediaQuery.of(context).size.width/6,
//                   controller: widget.mobileNumberController,
//                   labelText: "Mobile Number",
//                   keyboardType: TextInputType.text,
//                   padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                   onChanged: (value) {
//
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return AppString.enterText;
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(width: MediaQuery.of(context).size.width/6,),
//                 SizedBox(width: MediaQuery.of(context).size.width/6,),
//               ],
//             ),
//             SizedBox(height:MediaQuery.of(context).size.height/15),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   CustomButtonTransparent(text: "Cancel", onPressed: () async{
//                     widget.onpressedClose();
//                   }),
//                   const SizedBox(width: 10,),
//                  isLoading ? SizedBox(
//                    height: 25,
//                      width: 25,
//                      child: CircularProgressIndicator(color: ColorManager.blueprime,))
//                      : CustomElevatedButton(text: "Save",onPressed: () async{
//                    setState(() {
//                      isLoading = true;
//                    });
//                    try {
//                      await widget.onpressedSave();
//                    } finally {
//                      setState(() {
//                        isLoading = false;
//                      });
//                      Navigator.pop(context);
//                      widget.nameController.clear();
//                      widget.emailController.clear();
//                      widget.companyNameController.clear();
//                      widget.titlePositionController.clear();
//                      widget.mobileNumberController.clear();
//                      widget.associationLengthController.clear();
//                      widget.knowPersonController.clear();
//                    }
//
//                   }),
//
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
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
  final String title;
  final VoidCallback onpressedClose;
  Future<void> Function() onpressedSave;

  AddReferencePopup({
    Key? key,
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
  }) : super(key: key);

  @override
  State<AddReferencePopup> createState() => _AddReferencePopupState();
}

class _AddReferencePopupState extends State<AddReferencePopup> {
  bool isLoading = false;
  bool _nameError = false;
  bool _emailError = false;
  bool _titlePositionError = false;
  bool _knowPersonError = false;
  bool _companyNameError = false;
  bool _associationLengthError = false;
  bool _mobileNumberError = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: AppSize.s420,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
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
                  errorText: _nameError ? 'Please Enter Name' : null,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return 'Please Enter Only Alphabets';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: widget.emailController,
                  labelText: "Email",
                  errorText: _emailError ? 'Please Enter Valid Email' : null,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: widget.titlePositionController,
                  labelText: "Title/Position",
                  errorText: _titlePositionError ? 'Please Enter Title/Position' : null,
                  keyboardType: TextInputType.text,
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
                  errorText: _knowPersonError ? 'Please Enter How You Know This Person' : null,
                  keyboardType: TextInputType.text,
                ),
                _buildTextField(
                  controller: widget.companyNameController,
                  labelText: "Company",
                  errorText: _companyNameError ? 'Please Enter Company' : null,
                  keyboardType: TextInputType.text,
                ),
                _buildTextField(
                  controller: widget.associationLengthController,
                  labelText: "Length of Association",
                  errorText: _associationLengthError ? 'Please Enter Length of Association' : null,
                  keyboardType: TextInputType.text,
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
                  errorText: _mobileNumberError ? 'Please enter a valid 10-digit phone number' : null,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Mobile Number';
                    }
                    if (value.length != 10 || int.tryParse(value) == null) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 6),
                SizedBox(width: MediaQuery.of(context).size.width / 6),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButtonTransparent(
                    text: "Cancel",
                    onPressed: widget.onpressedClose,
                  ),
                  const SizedBox(width: 10),
                  isLoading
                      ? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: ColorManager.blueprime),
                  )
                      : CustomElevatedButton(
                    text: "Save",
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
    String? errorText,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldRegister(
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
          labelText: labelText,
          keyboardType: keyboardType,
          padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
          onChanged: (value) {
            setState(() {
              switch (labelText) {
                case "Name":
                  _nameError = validator?.call(value) != null;
                  break;
                case "Email":
                  _emailError = validator?.call(value) != null;
                  break;
                case "Title/Position":
                  _titlePositionError = value.isEmpty;
                  break;
                case "How do you know this person?":
                  _knowPersonError = value.isEmpty;
                  break;
                case "Company":
                  _companyNameError = value.isEmpty;
                  break;
                case "Length of Association":
                  _associationLengthError = value.isEmpty;
                  break;
                case "Mobile Number":
                  _mobileNumberError = validator?.call(value) != null;
                  break;
              }
            });
          },
          validator: validator ?? (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter $labelText';
            }
            return null;
          },
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 10),
            ),
          ),
      ],
    );
  }

  void _handleSave() async {
    setState(() {
      isLoading = true;
      _nameError = widget.nameController.text.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(widget.nameController.text);
      _emailError = widget.emailController.text.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(widget.emailController.text);
      _titlePositionError = widget.titlePositionController.text.isEmpty;
      _knowPersonError = widget.knowPersonController.text.isEmpty;
      _companyNameError = widget.companyNameController.text.isEmpty;
      _associationLengthError = widget.associationLengthController.text.isEmpty;
      _mobileNumberError = widget.mobileNumberController.text.isEmpty ||
          widget.mobileNumberController.text.length != 10 ||
          int.tryParse(widget.mobileNumberController.text) == null;
    });

    if (!_nameError && !_emailError && !_titlePositionError && !_knowPersonError &&
        !_companyNameError && !_associationLengthError && !_mobileNumberError) {
      try {
        await widget.onpressedSave();
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
        _clearControllers();
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _clearControllers() {
    widget.nameController.clear();
    widget.emailController.clear();
    widget.companyNameController.clear();
    widget.titlePositionController.clear();
    widget.mobileNumberController.clear();
    widget.associationLengthController.clear();
    widget.knowPersonController.clear();
  }
}