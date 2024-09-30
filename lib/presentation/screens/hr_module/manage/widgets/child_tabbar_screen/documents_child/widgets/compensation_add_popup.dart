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
// class CompensationAddEditPopup extends StatefulWidget {
//   final TextEditingController idController;
//   final TextEditingController nameController;
//   final String labelName;
//   String expiryType;
//   final Future<void> Function() onSavePredded;
//   CompensationAddEditPopup({
//     super.key,
//     required this.idController,
//     required this.nameController,
//     required this.labelName,
//     required this.onSavePredded,
//     required this.expiryType,
//   });
//
//   @override
//   State<CompensationAddEditPopup> createState() => _CompensationAddEditPopupState();
// }
//
// class _CompensationAddEditPopupState extends State<CompensationAddEditPopup> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: Dialog(
//         backgroundColor: Colors.transparent,
//         child: Container(
//           width: AppSize.s400,
//           height: AppSize.s500,
//           decoration: BoxDecoration(
//             color: ColorManager.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Container(
//                   height: 34,
//                   decoration: BoxDecoration(
//                     color: Color(0xff50B5E5),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           widget.labelName,
//                           style: GoogleFonts.firaSans(
//                             fontSize: FontSize.s14,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(Icons.close, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: AppPadding.p3,
//                     horizontal: AppPadding.p20,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       FormField<String>(
//                         builder: (FormFieldState<String> field) {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SMTextFConst(
//                                 controller: widget.idController,
//                                 keyboardType: TextInputType.text,
//                                 text: 'ID of the Document',
//                               ),
//                               if (field.hasError)
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 5.0),
//                                   child: Text(
//                                     field.errorText!,
//                                     style: TextStyle(color: Colors.red, fontSize: 12),
//                                   ),
//                                 ),
//                             ],
//                           );
//                         },
//                         validator: (value) {
//                           if (widget.idController.text.isEmpty) {
//                             return 'Please enter Id of the document';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: AppSize.s8),
//                       FormField<String>(
//                         builder: (FormFieldState<String> field) {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SMTextFConst(
//                                 controller: widget.nameController,
//                                 keyboardType: TextInputType.text,
//                                 text: 'Name of the Document',
//                               ),
//                               if (field.hasError)
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 5.0),
//                                   child: Text(
//                                     field.errorText!,
//                                     style: TextStyle(color: Colors.red, fontSize: 12),
//                                   ),
//                                 ),
//                             ],
//                           );
//                         },
//                         validator: (value) {
//                           if (widget.nameController.text.isEmpty) {
//                             return 'Please Enter Name of the Document';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: AppSize.s8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Type',
//                             style: GoogleFonts.firaSans(
//                               fontSize: FontSize.s12,
//                               fontWeight: FontWeight.w700,
//                               color: ColorManager.mediumgrey,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           CICCDropdown(
//                             initialValue: 'Compensation',
//                             items: [
//                               DropdownMenuItem(value: 'Type 1', child: Text('Type 1')),
//                               DropdownMenuItem(value: 'Type 2', child: Text('Type 2')),
//                               DropdownMenuItem(value: 'Type 3', child: Text('Type 3')),
//                               DropdownMenuItem(value: 'Type 4', child: Text('Type 4')),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: AppSize.s12),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: AppPadding.p3,
//                     horizontal: AppPadding.p20,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Expiry Type',
//                         style: GoogleFonts.firaSans(
//                           fontSize: FontSize.s12,
//                           fontWeight: FontWeight.w700,
//                           color: ColorManager.mediumgrey,
//                           decoration: TextDecoration.none,
//                         ),
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           RadioListTile<String>(
//                             title: Text(
//                               'Not Applicable',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.mediumgrey,
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                             value: 'type1',
//                             groupValue: widget.expiryType,
//                             onChanged: (value) {
//                               setState(() {
//                                 widget.expiryType = value!;
//                               });
//                             },
//                           ),
//                           RadioListTile<String>(
//                             title: Text(
//                               'Scheduled',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.mediumgrey,
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                             value: 'type2',
//                             groupValue: widget.expiryType,
//                             onChanged: (value) {
//                               setState(() {
//                                 widget.expiryType = value!;
//                               });
//                             },
//                           ),
//                           RadioListTile<String>(
//                             title: Text(
//                               'Issuer Expiry',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.mediumgrey,
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                             value: 'type3',
//                             groupValue: widget.expiryType,
//                             onChanged: (value) {
//                               setState(() {
//                                 widget.expiryType = value!;
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: AppPadding.p24),
//                   child: Center(
//                     child: CustomElevatedButton(
//                       width: AppSize.s105,
//                       height: AppSize.s30,
//                       text: AppStringEM.submit,
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           widget.onSavePredded();
//                           Navigator.pop(context);
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

////////////////////////////////////old popup///////////////////////////

//
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
// class CompensationAddEditPopup extends StatefulWidget {
//   final TextEditingController idController;
//   final TextEditingController nameController;
//   final String labelName;
//   String expiryType;
//   final Future<void> Function() onSavePredded;
//
//   CompensationAddEditPopup({
//     super.key,
//     required this.idController,
//     required this.nameController,
//     required this.labelName,
//     required this.onSavePredded,
//     required this.expiryType,
//   });
//
//   @override
//   State<CompensationAddEditPopup> createState() => _CompensationAddEditPopupState();
// }
//
// class _CompensationAddEditPopupState extends State<CompensationAddEditPopup> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? expiryTypeError;
//
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: Dialog(
//         backgroundColor: Colors.transparent,
//         child: Container(
//           width: AppSize.s400,
//           height: AppSize.s500,
//           decoration: BoxDecoration(
//             color: ColorManager.white,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Container(
//                   height: 34,
//                   decoration: BoxDecoration(
//                     color: Color(0xff50B5E5),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           widget.labelName,
//                           style: GoogleFonts.firaSans(
//                             fontSize: FontSize.s14,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(Icons.close, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: AppPadding.p3,
//                     horizontal: AppPadding.p20,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       FormField<String>(
//                         builder: (FormFieldState<String> field) {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SMTextFConst(
//                                 controller: widget.idController,
//                                 keyboardType: TextInputType.text,
//                                 text: 'ID of the Document',
//                               ),
//                               if (field.hasError)
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 5.0),
//                                   child: Text(
//                                     field.errorText!,
//                                     style: TextStyle(color: Colors.red, fontSize: 12),
//                                   ),
//                                 ),
//                             ],
//                           );
//                         },
//                         validator: (value) {
//                           if (widget.idController.text.isEmpty) {
//                             return 'Please enter Id of the document';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: AppSize.s8),
//                       FormField<String>(
//                         builder: (FormFieldState<String> field) {
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SMTextFConst(
//                                 controller: widget.nameController,
//                                 keyboardType: TextInputType.text,
//                                 text: 'Name of the Document',
//                               ),
//                               if (field.hasError)
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 5.0),
//                                   child: Text(
//                                     field.errorText!,
//                                     style: TextStyle(color: Colors.red, fontSize: 12),
//                                   ),
//                                 ),
//                             ],
//                           );
//                         },
//                         validator: (value) {
//                           if (widget.nameController.text.isEmpty) {
//                             return 'Please Enter Name of the Document';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: AppSize.s8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Type',
//                             style: GoogleFonts.firaSans(
//                               fontSize: FontSize.s12,
//                               fontWeight: FontWeight.w700,
//                               color: ColorManager.mediumgrey,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           CICCDropdown(
//                             initialValue: 'Compensation',
//                             items: [
//                               DropdownMenuItem(value: 'Type 1', child: Text('Type 1')),
//                               DropdownMenuItem(value: 'Type 2', child: Text('Type 2')),
//                               DropdownMenuItem(value: 'Type 3', child: Text('Type 3')),
//                               DropdownMenuItem(value: 'Type 4', child: Text('Type 4')),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: AppSize.s12),
//                       Text(
//                         'Expiry Type',
//                         style: GoogleFonts.firaSans(
//                           fontSize: FontSize.s12,
//                           fontWeight: FontWeight.w700,
//                           color: ColorManager.mediumgrey,
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           RadioListTile<String>(
//                             title: Text(
//                               'Not Applicable',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.mediumgrey,
//                               ),
//                             ),
//                             value: 'type1',
//                             groupValue: widget.expiryType,
//                             onChanged: (value) {
//                               setState(() {
//                                 widget.expiryType = value!;
//                                 expiryTypeError = null; // Clear error when a valid option is selected
//                               });
//                             },
//                           ),
//                           RadioListTile<String>(
//                             title: Text(
//                               'Scheduled',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.mediumgrey,
//                               ),
//                             ),
//                             value: 'type2',
//                             groupValue: widget.expiryType,
//                             onChanged: (value) {
//                               setState(() {
//                                 widget.expiryType = value!;
//                                 expiryTypeError = null; // Clear error when a valid option is selected
//                               });
//                             },
//                           ),
//                           RadioListTile<String>(
//                             title: Text(
//                               'Issuer Expiry',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.mediumgrey,
//                               ),
//                             ),
//                             value: 'type3',
//                             groupValue: widget.expiryType,
//                             onChanged: (value) {
//                               setState(() {
//                                 widget.expiryType = value!;
//                                 expiryTypeError = null; // Clear error when a valid option is selected
//                               });
//                             },
//                           ),
//                           if (expiryTypeError != null)
//                             Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Text(
//                                 expiryTypeError!,
//                                 style: TextStyle(color: Colors.red, fontSize: 12),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: AppPadding.p24),
//                   child: Center(
//                     child: CustomElevatedButton(
//                       width: AppSize.s105,
//                       height: AppSize.s30,
//                       text: AppStringEM.add,
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           if (widget.expiryType.isEmpty) {
//                             setState(() {
//                               expiryTypeError = 'Please select Expiry Type';
//                             });
//                           } else {
//                             setState(() {
//                               expiryTypeError = null; // Clear error when a valid option is selected
//                             });
//                             widget.onSavePredded();
//                             Navigator.pop(context);
//                           }
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

///////////////////////////////new popup////////////////////////////

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/header_content_const.dart';

class CustomDocumedEditPopup extends StatefulWidget {
  final String labelName;
  final int employeeId;
  //final List<EmployeeDocSetupModal> dataList;
  final int docMetaDataId;
  final int docSetupId;
  final int empDocumentId;
  final String selectedExpiryType;
  dynamic filePath;
  String? expiryDate;
  String? fileName;
  final String docName;
  final String url;

  CustomDocumedEditPopup({
    Key? key,
    required this.docName,
    this.expiryDate,
    required this.labelName,
    required this.employeeId,
    //required this.dataList,
    required this.docMetaDataId,
    required this.docSetupId,
    required this.empDocumentId,
    required this.selectedExpiryType,
    required this.url,
  }) : super(key: key);

  @override
  _CustomDocumedEditPopupState createState() => _CustomDocumedEditPopupState();
}

class _CustomDocumedEditPopupState extends State<CustomDocumedEditPopup> {
  int docTypeId = 0;
  int documentMetaDataId = 0;
  int documentSetupId = 0;

  String documentTypeName = "";
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  String _url = "";
  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();

  bool load = false;
  DateTime? datePicked;
  List<DropdownMenuItem<String>> dropDownMenuItems = [];
  @override
  void initState() {
    if (widget.selectedExpiryType == AppConfig.issuer) {
      DateTime dateTime =
          DateTime.parse(widget.expiryDate ?? DateTime.now().toString());
      showExpiryDateField = true;
      datePicked = dateTime;
      expiryDateController = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(dateTime));
    }
    fileName = widget.docName;
    // dropDownMenuItems = widget.dataList
    //     .map((doc) => DropdownMenuItem<String>(
    //   value: doc.documentName,
    //   child: Text(doc.documentName),
    // ))
    //     .toList();

    super.initState();
    _url = "";
    showExpiryDateField; // Reset _url when the popup is initialized
  }

  bool fileIsPicked = false;
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        fileIsPicked = true;
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: AppSize.s360,
      body: [
        HeaderContentConst(
          heading: AppString.type_of_the_document,
          content: Container(
            width: 354,
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: ColorManager.fmediumgrey, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.docName,
                  style: ConstTextFieldRegister.customTextStyle(context),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ),

        /// upload  doc
        InkWell(
          onTap: _pickFile,
          child: HeaderContentConst(
            heading: AppString.upload_document,
            content: Container(
              height: AppSize.s30,
              width: AppSize.s354,
              padding: EdgeInsets.only(left: AppPadding.p15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.containerBorderGrey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            fileName,
                            style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(4),
                          onPressed: _pickFile,
                          icon: Icon(
                            Icons.file_upload_outlined,
                            color: ColorManager.black,
                            size: 17,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Visibility(
          visible: showExpiryDateField,

          /// Conditionally display expiry date field
          child: HeaderContentConst(
            heading: AppString.expiry_date,
            content: FormField<String>(
              builder: (FormFieldState<String> field) {
                return SizedBox(
                  width: 354,
                  height: 30,
                  child: TextFormField(
                    controller: expiryDateController,
                    cursorColor: ColorManager.black,
                    style: DocumentTypeDataStyle.customTextStyle(context),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'MM-DD-YYYY',
                      hintStyle: DocumentTypeDataStyle.customTextStyle(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            width: 1, color: ColorManager.fmediumgrey),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: Icon(Icons.calendar_month_outlined,
                          color: ColorManager.blueprime),
                      errorText: field.errorText,
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1901),
                        lastDate: DateTime(3101),
                      );
                      if (pickedDate != null) {
                        datePicked = pickedDate;
                        expiryDateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please select date';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
      bottomButtons: loading
          ? SizedBox(
        height: AppSize.s25,
        width: AppSize.s25,
        child: CircularProgressIndicator(
          color: ColorManager.blueprime,
        ),
      )
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.submit,
        onPressed: () async {
          setState(() {
            loading = true;
          });
          String? expiryDate;
          expiryDate = widget.selectedExpiryType == AppConfig.issuer
              ? datePicked!.toIso8601String() + "Z"
              : null;
          try{
            var updatedResponse = await patchEmployeeDocuments(
                context: context,
                empDocumentId: widget.empDocumentId,
                employeeDocumentMetaId: widget.docMetaDataId,
                employeeDocumentTypeSetupId: widget.docSetupId,
                employeeId: widget.employeeId,
                documentUrl: widget.url,
                uploadDate: DateTime.now().toIso8601String() + "Z",
                expiryDate: expiryDate);

            if (updatedResponse.statusCode == 200 ||
                updatedResponse.statusCode == 201) {
              if (fileIsPicked) {
                var response = await uploadDocuments(
                    context: context,
                    employeeDocumentMetaId: widget.docMetaDataId,
                    employeeDocumentTypeSetupId: widget.docSetupId,
                    employeeId: widget.employeeId,
                    documentName: fileName,
                    documentFile: filePath);
                if (response.statusCode == 200 || response.statusCode == 201) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      Future.delayed(Duration(seconds: 2), () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      });
                      return AddSuccessPopup(
                        message: 'Document Edit',
                      );
                    },
                  );
                } else {
                  print('Error');
                }
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(Duration(seconds: 2), () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    });
                    return AddSuccessPopup(
                      message: 'Document Edit',
                    );
                  },
                );
              }
            }
            setState(() {
              loading = false;
            });
          }finally {
            setState(() {
              loading = false;
            });
            Navigator.pop(context);
          }

        },
      ),
      title: widget.labelName,
    );
  }
}

///////////////////////////////////////////////////

class CustomDocumedAddPopup extends StatefulWidget {
  final String title;
  bool? loadingDuration;
  // final String officeId;
  // final int docTypeMetaIdCC;
  final List<EmployeeDocSetupModal> dataList;
  //final int selectedSubDocId;
  final int employeeId;
  final double? height;
  final Widget? uploadField;
  dynamic filePath;
  String? fileName;
  // final Visibility? child3;
  CustomDocumedAddPopup({
    required this.title,
    this.loadingDuration,
    this.height,
    this.uploadField,
    required this.employeeId,
    // required this.docTypeMetaIdCC,
    // required this.selectedSubDocId,
    required this.dataList,
    // this.child3
  });

  @override
  State<CustomDocumedAddPopup> createState() => _CustomDocumedAddPopupState();
}

class _CustomDocumedAddPopupState extends State<CustomDocumedAddPopup> {
  int docTypeId = 0;
  int documentMetaDataId = 0;
  int documentSetupId = 0;

  String documentTypeName = "";
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  String _url = "";
  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();

  bool load = false;
  DateTime? datePicked;
  List<DropdownMenuItem<String>> dropDownMenuItems = [];
  @override
  void initState() {
    dropDownMenuItems = widget.dataList
        .map((doc) => DropdownMenuItem<String>(
              value: doc.documentName,
              child: Text(doc.documentName),
            ))
        .toList();

    super.initState();
    _url = "";
    showExpiryDateField; // Reset _url when the popup is initialized
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: widget.height == null ? AppSize.s360 : widget.height!,
      body: [
        HeaderContentConst(
            heading: AppString.type_of_the_document,
            content: CICCDropdown(
                width: 354,
                initialValue: 'Select Document',
                onChange: (val) {
                  setState(() {
                    showExpiryDateField = false;

                    for (var a in widget.dataList!) {
                      if (a.documentName == val) {
                        documentMetaDataId = a.employeeDocMetaDataId;
                        documentSetupId = a.employeeDocTypeSetupId;
                        //docMetaId = docType;
                        documentTypeName = a.documentName;
                        if (a.reminderThreshould == AppConfig.issuer) {
                          showExpiryDateField = true;
                        }
                      }
                    }
                  });
                  // print(":::${docType}");
                  //  print(":::<>${docMetaId}");
                },
                items: dropDownMenuItems)),

        Visibility(
          visible: showExpiryDateField,

          /// Conditionally display expiry date field
          child: HeaderContentConst(
            heading: AppString.expiry_date,
            content: FormField<String>(
              builder: (FormFieldState<String> field) {
                return SizedBox(
                  width: 354,
                  height: 30,
                  child: TextFormField(
                    controller: expiryDateController,
                    cursorColor: ColorManager.black,
                    style: DocumentTypeDataStyle.customTextStyle(context),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: 'MM-DD-YYYY',
                      hintStyle: DocumentTypeDataStyle.customTextStyle(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            width: 1, color: ColorManager.fmediumgrey),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: Icon(Icons.calendar_month_outlined,
                          color: ColorManager.blueprime),
                      errorText: field.errorText,
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1901),
                        lastDate: DateTime(3101),
                      );
                      if (pickedDate != null) {
                        datePicked = pickedDate;
                        expiryDateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please select date';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
          ),
        ),

        /// upload  doc
        InkWell(
          onTap:_pickFile,
          child: HeaderContentConst(
            heading: AppString.upload_document,
            content: Container(
              height: AppSize.s30,
              width: AppSize.s354,
              padding: EdgeInsets.only(left: AppPadding.p15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.containerBorderGrey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            fileName,
                            style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(4),
                          onPressed: _pickFile,
                          icon: Icon(
                            Icons.file_upload_outlined,
                            color: ColorManager.black,
                            size: 17,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
      bottomButtons: load
          ? SizedBox(
              height: AppSize.s25,
              width: AppSize.s25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
          : CustomElevatedButton(
              width: AppSize.s105,
              height: AppSize.s30,
              text: AppStringEM.add, //submit
              // onPressed: () async {
              //   setState(() {
              //     load = true;
              //   });
              //   try {
              //     String? expiryDate;
              //     if (expiryDateController.text.isEmpty) {
              //       expiryDate = null;
              //     } else {
              //       expiryDate = datePicked!.toIso8601String() + "Z";
              //     }
              //
              //     // ApiData response = await addOrgDocPPPost(
              //     //   context: context,
              //     //   orgDocumentSetupid: docTypeId,
              //     //   idOfDocument: documentTypeName,
              //     //   expiryDate: expiryDate,
              //     //   docCreated: DateTime.now().toIso8601String() + "Z",
              //     //   url: "url",
              //     //   officeId: widget.officeId,
              //     // );
              //     expiryDateController.clear();
              //     // if (response.statusCode == 200 ||
              //     //     response.statusCode == 201) {
              //     //   // await uploadDocumentsoffice(
              //     //   //     context: context,
              //     //   //     documentFile: filePath,
              //     //   //     orgOfficeDocumentId: response.orgOfficeDocumentId!);
              //     //   setState(() {
              //     //     load = false;
              //     //   });
              //     // }
              //   } finally {
              //     setState(() {
              //       Navigator.pop(context);
              //
              //
              //       load = false;
              //     });
              //
              //   }
              // },
              onPressed: () async {
                try {
                  //File filePath = File(finalPath!);
                  String? expiryDate;
                  if (expiryDateController.text.isEmpty) {
                    expiryDate = null;
                  } else {
                    expiryDate = datePicked!.toIso8601String() + "Z";
                  }
                  var response = await uploadDocuments(
                      context: context,
                      employeeDocumentMetaId: documentMetaDataId,
                      employeeDocumentTypeSetupId: documentSetupId,
                      employeeId: widget.employeeId,
                      documentName: fileName,
                      documentFile: filePath,
                      expiryDate: expiryDate);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddSuccessPopup(
                          message: 'Document Uploded',
                        );
                      },
                    );
                  } else {
                    print('Error');
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
      title: widget.title,
    );
  }
}
