// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
//
// class AcknowledgementAddPopup extends StatefulWidget {
//   final String labelName;
//   final TextEditingController AcknowledgementnameController;
//   final VoidCallback onSavePressed;
//
//   const AcknowledgementAddPopup({
//     Key? key,
//     required this.labelName,
//     required this.AcknowledgementnameController,
//     required this.onSavePressed,
//   }) : super(key: key);
//
//   @override
//   _AcknowledgementAddPopupState createState() => _AcknowledgementAddPopupState();
// }
//
// class _AcknowledgementAddPopupState extends State<AcknowledgementAddPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s400,
//         height: AppSize.s300,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: 34,
//               decoration: BoxDecoration(
//                 color: Color(0xff50B5E5),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       widget.labelName,
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s14,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(Icons.close,color: Colors.white,),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height/40,),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppPadding.p3,
//                 horizontal: AppPadding.p20,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Type of the Document',
//                     style: GoogleFonts.firaSans(
//                       fontSize: FontSize.s12,
//                       fontWeight: FontWeight.w700,
//                       color: ColorManager.mediumgrey,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   CICCDropdown(
//                     items: [
//                       DropdownMenuItem(value: 'Type 1', child: Text('Type 1')),
//                       DropdownMenuItem(value: 'Type 2', child: Text('Type 2')),
//                       DropdownMenuItem(value: 'Type 3', child: Text('Type 3')),
//                       DropdownMenuItem(value: 'Type 4', child: Text('Type 4')),
//                     ],
//                   ),
//                   SizedBox(height: AppSize.s20),
//                   GestureDetector(
//                     onTap: () async {
//                       FilePickerResult? result = await FilePicker.platform.pickFiles(
//                         allowMultiple: false,
//                       );
//                       if (result != null) {
//                         PlatformFile file = result.files.first;
//                         print('File picked: ${file.name}');
//                         widget.AcknowledgementnameController.text = file.name;
//                       } else {
//                       }
//                     },
//                     child: AbsorbPointer(
//                       child: SMTextFConst(
//                         controller: widget.AcknowledgementnameController,
//                         keyboardType: TextInputType.text,
//                         text: 'Upload Document',
//                         icon: Icon(Icons.file_upload_outlined,color: Colors.black,),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.only(bottom: AppPadding.p24),
//               child: Center(
//                 child: CustomElevatedButton(
//                   width: AppSize.s105,
//                   height: AppSize.s30,
//                   text: AppStringEM.submit,
//                   onPressed: () {
//                     widget.onSavePressed();
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

///////////////////////////////////after validation/////////////////////////////////


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

class AcknowledgementAddPopup extends StatefulWidget {
  final String labelName;
  final TextEditingController AcknowledgementnameController;
  final VoidCallback onSavePressed;
  final Widget child;

  const AcknowledgementAddPopup({
    Key? key,
    required this.labelName,
    required this.AcknowledgementnameController,
    required this.onSavePressed, required this.child,
  }) : super(key: key);

  @override
  _AcknowledgementAddPopupState createState() => _AcknowledgementAddPopupState();
}

class _AcknowledgementAddPopupState extends State<AcknowledgementAddPopup> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDocumentType;
  bool _documentUploaded = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s300,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: 34,
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.labelName,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: Colors.white,),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40,),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type of the Document',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                    SizedBox(height: 3),
                    widget.child,
                    // DropdownButtonFormField<String>(
                    //   value: _selectedDocumentType,
                    //   items: [
                    //
                    //   ],
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _selectedDocumentType = value;
                    //     });
                    //   },
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please select the document type';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //       borderSide: BorderSide(color: Color(0xffB1B1B1)),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: AppSize.s20),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                        );
                        if (result != null) {
                          PlatformFile file = result.files.first;
                          print('File picked: ${file.name}');
                          setState(() {
                            widget.AcknowledgementnameController.text = file.name;
                            _documentUploaded = true;
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: SMTextFConst(
                          controller: widget.AcknowledgementnameController,
                          keyboardType: TextInputType.text,
                          text: 'Upload Document',
                          icon: Icon(Icons.file_upload_outlined, color: Colors.black,),
                        ),
                      ),
                    ),
                    if (!_documentUploaded)
                      Text(
                        'Please upload a document',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.submit,
                  onPressed: () {
                    if (_formKey.currentState!.validate() && widget.AcknowledgementnameController.text.isNotEmpty) {
                      widget.onSavePressed();
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _documentUploaded = widget.AcknowledgementnameController.text.isNotEmpty;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
