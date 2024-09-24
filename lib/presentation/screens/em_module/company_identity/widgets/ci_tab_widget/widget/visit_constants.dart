import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

import '../../../../widgets/dialogue_template.dart';

class AddVisitPopup extends StatefulWidget {
  final TextEditingController nameOfDocumentController;
  final TextEditingController idOfDocumentController;
  final Future<void> Function() onSavePressed;
  final Widget child;
  final bool? enable;
  //final Widget child1;
  final String title;
  final Widget dropdownServices;
  final Future<void> Function() onClosePressed;

  const AddVisitPopup({
    super.key,
    this.enable,
    required this.nameOfDocumentController,
    required this.idOfDocumentController,
    required this.onSavePressed,
    required this.child,
    //required this.child1,
    required this.title, required this.dropdownServices, required this.onClosePressed,
  });

  @override
  State<AddVisitPopup> createState() => _AddVisitPopupState();
}

class _AddVisitPopupState extends State<AddVisitPopup> {
  bool isLoading = false;
  bool _isNameOfDocumentValid = true;
  String _nameOfDocumentErrorText = '';

  void _validateInputs() {
    setState(() {
      final nameOfDocumentText = widget.nameOfDocumentController.text;

      if (nameOfDocumentText.isEmpty) {
        _isNameOfDocumentValid = false;
        _nameOfDocumentErrorText = 'Please Enter Type of Visit';
      } else if (nameOfDocumentText.isNotEmpty &&
          nameOfDocumentText[0] != nameOfDocumentText[0].toUpperCase())
      {
        _isNameOfDocumentValid = false;
        _nameOfDocumentErrorText = 'First letter must be capitalized';
      }
      else {
        _isNameOfDocumentValid = true;
        _nameOfDocumentErrorText = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
        width: AppSize.s400,
        height: AppSize.s450,
          body: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p5,
                horizontal: AppPadding.p10,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // TextField with Validation Message
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FirstSMTextFConst(
                          enable: widget.enable,
                          controller: widget.nameOfDocumentController,
                          keyboardType: TextInputType.text,
                          text: 'Type of Visit',
                        ),
                        if (!_isNameOfDocumentValid)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              _nameOfDocumentErrorText,
                              style: CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: AppSize.s30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select services',
                          style:AllPopupHeadings.customTextStyle(context),
                        ),
                        SizedBox(height: AppSize.s5),
                        widget.dropdownServices

                      ],
                    ),
                    SizedBox(height: AppSize.s30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Eligible Clinician',
                          style: AllPopupHeadings.customTextStyle(context),
                        ),
                        SizedBox(height: AppSize.s5),
                        widget.child,
                      ],
                    ),
                  ],
                ),
              ),
            ),


          ],
      bottomButtons: isLoading
          ? CircularProgressIndicator(
        color: ColorManager.blueprime,
      )
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.save,
        onPressed: () async {
          _validateInputs();
          if (_isNameOfDocumentValid) {
            setState(() {
              isLoading = true;
            });
            try {
              await widget.onSavePressed();
            } finally {
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
              widget.idOfDocumentController.clear();
              widget.nameOfDocumentController.clear();
            }
          }
        },
      ), title: widget.title,


    );
  }
}
///add
class EditVisitPopup extends StatefulWidget {
  final TextEditingController nameOfDocumentController;
  final TextEditingController idOfDocumentController;
  final Future<void> Function() onSavePressed;
 // final Widget child;
  final bool? enable;
  //final Widget child1;
  final String title;
  final Widget dropdownServices;
  final Future<void> Function() onClosePressed;
   EditVisitPopup({
     super.key,
     this.enable,
     required this.nameOfDocumentController,
     required this.idOfDocumentController,
     required this.onSavePressed,
    // required this.child,
     //required this.child1,
     required this.title, required this.dropdownServices, required this.onClosePressed,
   });

  @override
  State<EditVisitPopup> createState() => _EditVisitPopupState();
}

class _EditVisitPopupState extends State<EditVisitPopup> {
  bool isLoading = false;
  bool _isNameOfDocumentValid = true;
  String _nameOfDocumentErrorText = '';

  void _validateInputs() {
    setState(() {
      final nameOfDocumentText = widget.nameOfDocumentController.text;

      if (nameOfDocumentText.isEmpty) {
        _isNameOfDocumentValid = false;
        _nameOfDocumentErrorText = 'Please Enter Type of Visit';
      } else if (nameOfDocumentText.isNotEmpty &&
          nameOfDocumentText[0] != nameOfDocumentText[0].toUpperCase())
      {
        _isNameOfDocumentValid = false;
        _nameOfDocumentErrorText = 'First letter must be capitalized';
      }
      else {
        _isNameOfDocumentValid = true;
        _nameOfDocumentErrorText = '';
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s450,
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p5,
            horizontal: AppPadding.p10,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // TextField with Validation Message
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstSMTextFConst(
                      enable: widget.enable,
                      controller: widget.nameOfDocumentController,
                      keyboardType: TextInputType.text,
                      text: 'Type of Visit',
                    ),
                    if (!_isNameOfDocumentValid)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          _nameOfDocumentErrorText,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: AppSize.s30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select services',
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: AppSize.s5),
                    widget.dropdownServices

                  ],
                ),
                SizedBox(height: AppSize.s30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Eligible Clinician',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: AppSize.s5),
                    // widget.child,
                  ],
                ),
              ],
            ),
          ),
        ),


      ],
      bottomButtons: isLoading
          ? CircularProgressIndicator(
        color: ColorManager.blueprime,
      )
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.save,
        onPressed: () async {
          _validateInputs();
          if (_isNameOfDocumentValid) {
            setState(() {
              isLoading = true;
            });
            try {
              await widget.onSavePressed();
            } finally {
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
              widget.idOfDocumentController.clear();
              widget.nameOfDocumentController.clear();
            }
          }
        },
      ), title: widget.title,


    );
  }
}

///
// class AddVisitPopup extends StatefulWidget {
//   final TextEditingController nameOfDocumentController;
//   final TextEditingController idOfDocumentController;
//   final Future<void> Function() onSavePressed;
//   final Widget child;
//   final bool? enable;
//   //final Widget child1;
//   final String title;
//   final Widget dropdownServices;
//   final Future<void> Function() onClosePressed;
//
//   const AddVisitPopup({
//     super.key,
//     this.enable,
//     required this.nameOfDocumentController,
//     required this.idOfDocumentController,
//     required this.onSavePressed,
//     required this.child,
//     //required this.child1,
//     required this.title, required this.dropdownServices, required this.onClosePressed,
//   });
//
//   @override
//   State<AddVisitPopup> createState() => _AddVisitPopupState();
// }
//
// class _AddVisitPopupState extends State<AddVisitPopup> {
//   bool isLoading = false;
//   bool _isNameOfDocumentValid = true;
//   String _nameOfDocumentErrorText = '';
//
//   void _validateInputs() {
//     setState(() {
//       final nameOfDocumentText = widget.nameOfDocumentController.text;
//
//       if (nameOfDocumentText.isEmpty) {
//         _isNameOfDocumentValid = false;
//         _nameOfDocumentErrorText = 'Please Enter Type of Visit';
//       } else if (nameOfDocumentText.isNotEmpty &&
//           nameOfDocumentText[0] != nameOfDocumentText[0].toUpperCase())
//       {
//         _isNameOfDocumentValid = false;
//         _nameOfDocumentErrorText = 'First letter must be capitalized';
//       }
//       else {
//         _isNameOfDocumentValid = true;
//         _nameOfDocumentErrorText = '';
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DialogueTemplate(
//
//       width: AppSize.s400,
//       height: AppSize.s450,
//
//
//       body: [
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: AppPadding.p5,
//             horizontal: AppPadding.p10,
//           ),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // TextField with Validation Message
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     FirstSMTextFConst(
//                       enable: widget.enable,
//                       controller: widget.nameOfDocumentController,
//                       keyboardType: TextInputType.text,
//                       text: 'Type of Visit',
//                     ),
//                     if (!_isNameOfDocumentValid)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 4.0),
//                         child: Text(
//                           _nameOfDocumentErrorText,
//                           style: CommonErrorMsg.customTextStyle(context),
//                         ),
//                       ),
//                   ],
//                 ),
//                 SizedBox(height: AppSize.s30),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Select services',
//                       style:AllPopupHeadings.customTextStyle(context),
//                     ),
//                     SizedBox(height: AppSize.s5),
//                     widget.dropdownServices
//
//                   ],
//                 ),
//                 SizedBox(height: AppSize.s30),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Select Eligible Clinician',
//                       style: AllPopupHeadings.customTextStyle(context),
//                     ),
//                     SizedBox(height: AppSize.s5),
//                     widget.child,
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//
//       ],
//       bottomButtons: isLoading
//           ? CircularProgressIndicator(
//         color: ColorManager.blueprime,
//       )
//           : CustomElevatedButton(
//         width: AppSize.s105,
//         height: AppSize.s30,
//         text: AppStringEM.save,
//         onPressed: () async {
//           _validateInputs();
//           if (_isNameOfDocumentValid) {
//             setState(() {
//               isLoading = true;
//             });
//             try {
//               await widget.onSavePressed();
//             } finally {
//               setState(() {
//                 isLoading = false;
//               });
//               Navigator.pop(context);
//               widget.idOfDocumentController.clear();
//               widget.nameOfDocumentController.clear();
//             }
//           }
//         },
//       ), title: widget.title,
//
//
//     );
//   }
// }
