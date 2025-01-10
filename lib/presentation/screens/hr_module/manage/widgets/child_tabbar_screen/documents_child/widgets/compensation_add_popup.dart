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
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/clinical_licenses_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/clinical_license_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/header_content_const.dart';

class CustomDocumedEditPopup extends StatelessWidget {
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
  final String documentFileName;

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
    required this.url, required this.documentFileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int docTypeId = 0;
    int documentMetaDataId = 0;
    int documentSetupId = 0;
    String documentTypeName = "";
    String? selectedDocType;
    TextEditingController expiryDateController = TextEditingController();
    final docEditProviderState = Provider.of<HrManageProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      docEditProviderState.assignedValue(documentFileName);
      docEditProviderState.editDocumentValue(selectedExpiryType,expiryDate,expiryDateController);
    });

    return Consumer<HrManageProvider>(
      builder: (context, editDocProvider,child) {
        return DialogueTemplate(
          width: AppSize.s420,
          height: AppSize.s390,
          body: [
            HeaderContentConst(
              isAsterisk: true,
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
                      docName,
                      style: DocumentTypeDataStyle.customTextStyle(context),
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
            HeaderContentConst(
              isAsterisk: true,
              heading: AppString.upload_document,
              content: InkWell(
                onTap: editDocProvider.pickEditFile,
                child: Container(
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
                        editDocProvider.editFileName,
                                style: DocumentTypeDataStyle.customTextStyle(context),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(4),
                              onPressed: editDocProvider.pickEditFile,
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
              visible: editDocProvider.showExpiryDateField,
              /// Conditionally display expiry date field
              child: HeaderContentConst(
                isAsterisk: true,
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
                          hintText: 'yyyy-mm-dd',
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
                            editDocProvider.newDatePicked(pickedDate);
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
          bottomButtons: editDocProvider.load
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
              editDocProvider.loaderTrue();
              String? validateExpDate = expiryDateController.text;
              String? expiryDate;
              expiryDate = selectedExpiryType == AppConfig.issuer
                  ? validateExpDate == expiryDateController.text ? expiryDate : "${editDocProvider.datePicked.toIso8601String()}Z"
                  : null;
              try{
                var updatedResponse = await patchEmployeeDocuments(
                    context: context,
                    empDocumentId: empDocumentId,
                    employeeDocumentMetaId: docMetaDataId,
                    employeeDocumentTypeSetupId: docSetupId,
                    employeeId: employeeId,
                    documentUrl: url,
                    uploadDate: DateTime.now().toIso8601String()+"Z",
                    expiryDate: expiryDate,);

                if (updatedResponse.statusCode == 200 ||
                    updatedResponse.statusCode == 201) {

                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddSuccessPopup(
                        message: 'Document Edited Successfully',
                      );
                    },
                  );
                  if (editDocProvider.fileIsPicked) {
                    if(editDocProvider.editFileAbove20Mb){
                      var response = await patchEmployeeBase64Documents(
                          context: context,
                          employeeDocumentId: empDocumentId,
                          expiryDate: expiryDate,
                          employeeDocumentMetaId: docMetaDataId,
                          employeeDocumentTypeSetupId: docSetupId,
                          employeeId: employeeId,
                          documentName: editDocProvider.editFileName,
                          documentFile: editDocProvider.editFilePath);
                      if (response.statusCode == 200 || response.statusCode == 201) {
                        editDocProvider.clearAddedValue();
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddSuccessPopup(
                              message: 'Document Edited Successfully',
                            );
                          },
                        );
                      }
                      else if (response.statusCode == 413) {
                        editDocProvider.clearAddedValue();
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddErrorPopup(
                              message: 'File is too large!',
                            );
                          },
                        );
                      }
                      else {
                        Navigator.pop(context);
                        print('Error');
                      }
                    }else{
                      editDocProvider.clearAddedValue();
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddErrorPopup(
                            message: 'File is too large!',
                          );
                        },
                      );
                    }

                  } else {
                    editDocProvider.clearAddedValue();
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddSuccessPopup(
                          message: 'Document Edited Successfully',
                        );
                      },
                    );
                  }
                }
                editDocProvider.loaderFalse();
              }finally {
                editDocProvider.loaderFalse();
              }

            },
          ),
          title: labelName,
        );
      }
    );
  }
}

///////////////////////////////////////////////////

class CustomDocumedAddPopup extends StatelessWidget {
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
  Widget build(BuildContext context) {
    int docTypeId = 0;
    int documentMetaDataId = 0;
    int documentSetupId = 0;
    bool _submitted = false;
    String documentTypeName = "";
    String? selectedDocType;
    TextEditingController expiryDateController = TextEditingController();

    DateTime? datePicked;
    final docAddProviderState = Provider.of<HrManageProvider>(context, listen: false,);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      docAddProviderState.loadDropDown(dataList);
    });
    return
      Consumer<HrManageProvider>(
          builder: (context, addDocProvider, child) {
            return DialogueTemplate(
              width: AppSize.s420,
              height: height == null ? AppSize.s390 : height!,
              body: [
                HeaderContentConst(
                  isAsterisk: true,
                  heading: AppString.type_of_the_document,
                  content: dataList.isEmpty
                      ? Container(
                    width: 354,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorManager.containerBorderGrey,
                          width: AppSize.s1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Text('No available document',
                          style: DocumentTypeDataStyle.customTextStyle(
                              context)),
                    ),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CICCDropdown(
                        width: 354,
                        initialValue: 'Select Document',
                        onChange: (val) {

                            // showExpiryDateField = false;
                            for (var a in dataList) {
                              if (a.documentName == val) {
                                documentMetaDataId = a.employeeDocMetaDataId;
                                documentSetupId = a.employeeDocTypeSetupId;
                                documentTypeName = a.documentName;
                                if (a.reminderThreshould == AppConfig.issuer) {
                                  addDocProvider.showExpDateFieldDoc();
                                }else{
                                  addDocProvider.showExpDateFieldDocFalse();
                                }
                              }
                            }

                        },
                        items: addDocProvider.dropDownMenuItems,
                      ),
                      SizedBox(height: 2),
                      if (addDocProvider.isFormSubmitted && documentTypeName
                          .isEmpty) // Check _submitted before showing the error
                        Text(
                          'Please select document',
                          style: TextStyle(
                              fontSize: 10, color: ColorManager.red),
                        ),
                    ],
                  ),
                ),

                Visibility(
                  visible: addDocProvider.showAddDocExpiryDateField,
                  child: HeaderContentConst(
                    isAsterisk: true,
                    heading: AppString.expiry_date,
                    content: FormField<String>(
                      builder: (FormFieldState<String> field) {
                        return SizedBox(
                          width: 354,
                          height: 30,
                          child: TextFormField(
                            controller: expiryDateController,
                            cursorColor: ColorManager.black,
                            style: DocumentTypeDataStyle.customTextStyle(
                                context),
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
                              hintText: 'yyyy-mm-dd',
                              hintStyle: DocumentTypeDataStyle.customTextStyle(
                                  context),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(
                                    width: 1, color: ColorManager.fmediumgrey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16),
                              suffixIcon: Icon(Icons.calendar_month_outlined,
                                  color: ColorManager.blueprime),
                              errorText: _submitted &&
                                  expiryDateController.text.isEmpty
                                  ? 'Please select date'
                                  : null, // Show error only after submission
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
                          ),
                        );
                      },
                    ),
                  ),
                ),

                HeaderContentConst(
                  isAsterisk: true,
                  heading: AppString.upload_document,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: addDocProvider.pickAckFile,
                        child: Container(
                          height: AppSize.s30,
                          width: AppSize.s354,
                          padding: EdgeInsets.only(left: AppPadding.p15),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManager.containerBorderGrey,
                                width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return Padding(
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(addDocProvider.fileName,
                                          style: DocumentTypeDataStyle
                                              .customTextStyle(context)),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(4),
                                      onPressed: addDocProvider.pickAckFile,
                                      icon: Icon(Icons.file_upload_outlined,
                                          color: ColorManager.black, size: 17),
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
                      SizedBox(height: 2),
                      if (_submitted && addDocProvider.filePath ==
                          null) // Show error only if filePath is null and form is submitted
                        Text(
                          'Please select document',
                          style: TextStyle(
                              fontSize: 10, color: ColorManager.red),
                        ),
                    ],
                  ),
                )
              ],
              bottomButtons: addDocProvider.load
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
                text: AppStringEM.add,
                onPressed: () async {
                  addDocProvider.loaderTrue();

                  if (addDocProvider.filePath != null &&
                      documentTypeName.isNotEmpty) {
                    try {
                      String? expiryDate;
                      if (expiryDateController.text.isEmpty) {
                        expiryDate = null;
                      } else {
                        expiryDate = datePicked!.toIso8601String() + "Z";
                      }
                      if (addDocProvider.fileAbove20Mb) {
                        var response = await uploadDocuments(
                          context: context,
                          employeeDocumentMetaId: documentMetaDataId,
                          employeeDocumentTypeSetupId: documentSetupId,
                          employeeId: employeeId,
                          documentName: addDocProvider.fileName,
                          documentFile: addDocProvider.filePath,
                          expiryDate: expiryDate,
                        );
                        var result = await singleBatchApproveOnboardAckHealthPatch(
                            context, response.documentId!);
                        if (result.statusCode == 200 ||
                            result.statusCode == 201) {
                          addDocProvider.clearAddedValue();
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddSuccessPopup(
                                  message: 'Document Uploaded Successfully');
                            },
                          );
                        }
                        if (response.statusCode == 413) {
                          addDocProvider.clearAddedValue();
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddErrorPopup(
                                message: 'File is too large!',
                              );
                            },
                          );
                        }
                      } else {
                        addDocProvider.clearAddedValue();
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddErrorPopup(
                              message: 'File is too large!',
                            );
                          },
                        );
                      }

                      addDocProvider.loaderFalse();
                    } finally {
                      addDocProvider.loaderFalse();
                    }
                  } else {
                    print('Validation error');
                  }
                },
              ),
              title: title,
            );
          }
      );


    ///old
    //   DialogueTemplate(
    //   width: AppSize.s420,
    //   height: widget.height == null ? AppSize.s390 : widget.height!,
    //   body: [
    //     HeaderContentConst(
    //         heading: AppString.type_of_the_document,
    //         content: widget.dataList.isEmpty?Container(
    //             width: 354,
    //             height:30,
    //             decoration: BoxDecoration(
    //               border: Border.all(color: ColorManager.containerBorderGrey, width: AppSize.s1),
    //               borderRadius: BorderRadius.circular(4),
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
    //               child: Text('No available document',style: DocumentTypeDataStyle.customTextStyle(context),),
    //             )) :Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             CICCDropdown(
    //                 width: 354,
    //                 initialValue: 'Select Document',
    //                 onChange: (val) {
    //                   setState(() {
    //                     showExpiryDateField = false;
    //                     for (var a in widget.dataList) {
    //                       if (a.documentName == val) {
    //                         documentMetaDataId = a.employeeDocMetaDataId;
    //                         documentSetupId = a.employeeDocTypeSetupId;
    //                         //docMetaId = docType;
    //                         documentTypeName = a.documentName;
    //                         if (a.reminderThreshould == AppConfig.issuer) {
    //                           showExpiryDateField = true;
    //                         }
    //                       }
    //                     }
    //                   });
    //                   // print(":::${docType}");
    //                   //  print(":::<>${docMetaId}");
    //                 },
    //                 items: dropDownMenuItems),
    //             SizedBox(height: 2,),
    //             if(documentTypeName == "")
    //               Text('Please select document',style: TextStyle(fontSize: 10,color: ColorManager.red))
    //           ],
    //         )),
    //
    //     Visibility(
    //       visible: showExpiryDateField,
    //       /// Conditionally display expiry date field
    //       child: HeaderContentConst(
    //         heading: AppString.expiry_date,
    //         content: FormField<String>(
    //           builder: (FormFieldState<String> field) {
    //             return SizedBox(
    //               width: 354,
    //               height: 30,
    //               child: TextFormField(
    //                 controller: expiryDateController,
    //                 cursorColor: ColorManager.black,
    //                 style: DocumentTypeDataStyle.customTextStyle(context),
    //                 decoration: InputDecoration(
    //                   enabledBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(
    //                         color: ColorManager.fmediumgrey, width: 1),
    //                     borderRadius: BorderRadius.circular(6),
    //                   ),
    //                   focusedBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(
    //                         color: ColorManager.fmediumgrey, width: 1),
    //                     borderRadius: BorderRadius.circular(6),
    //                   ),
    //                   hintText: 'MM-DD-YYYY',
    //                   hintStyle: DocumentTypeDataStyle.customTextStyle(context),
    //                   border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(6),
    //                     borderSide: BorderSide(
    //                         width: 1, color: ColorManager.fmediumgrey),
    //                   ),
    //                   contentPadding: EdgeInsets.symmetric(horizontal: 16),
    //                   suffixIcon: Icon(Icons.calendar_month_outlined,
    //                       color: ColorManager.blueprime),
    //                   errorText: field.errorText,
    //                 ),
    //                 onTap: () async {
    //                   DateTime? pickedDate = await showDatePicker(
    //                     context: context,
    //                     initialDate: DateTime.now(),
    //                     firstDate: DateTime(1901),
    //                     lastDate: DateTime(3101),
    //                   );
    //                   if (pickedDate != null) {
    //                     datePicked = pickedDate;
    //                     expiryDateController.text =
    //                         DateFormat('yyyy-MM-dd').format(pickedDate);
    //                   }
    //                 },
    //                 validator: (value) {
    //                   if (value == null || value.isEmpty) {
    //                     return 'please select date';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //     ),
    //
    //     /// upload  doc
    //     HeaderContentConst(
    //       heading: AppString.upload_document,
    //       content: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           InkWell(
    //             onTap: _pickFile,
    //             child: Container(
    //               height: AppSize.s30,
    //               width: AppSize.s354,
    //               padding: EdgeInsets.only(left: AppPadding.p15),
    //               decoration: BoxDecoration(
    //                 border: Border.all(
    //                   color: ColorManager.containerBorderGrey,
    //                   width: 1,
    //                 ),
    //                 borderRadius: BorderRadius.circular(4),
    //               ),
    //               child: StatefulBuilder(
    //                 builder: (BuildContext context,
    //                     void Function(void Function()) setState) {
    //                   return Padding(
    //                     padding: const EdgeInsets.all(0),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Expanded(
    //                           child: Text(
    //                             fileName,
    //                             style: DocumentTypeDataStyle.customTextStyle(context),
    //                           ),
    //                         ),
    //                         IconButton(
    //                           padding: EdgeInsets.all(4),
    //                           onPressed: _pickFile,
    //                           icon: Icon(
    //                             Icons.file_upload_outlined,
    //                             color: ColorManager.black,
    //                             size: 17,
    //                           ),
    //                           splashColor: Colors.transparent,
    //                           highlightColor: Colors.transparent,
    //                           hoverColor: Colors.transparent,
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 2,),
    //           if(filePath == null)
    //             Text('Please select document',style: TextStyle(fontSize: 10,color: ColorManager.red),)
    //         ],
    //       ),
    //     )
    //   ],
    //   bottomButtons: load
    //       ? SizedBox(
    //           height: AppSize.s25,
    //           width: AppSize.s25,
    //           child: CircularProgressIndicator(
    //             color: ColorManager.blueprime,
    //           ),
    //         )
    //       : CustomElevatedButton(
    //           width: AppSize.s105,
    //           height: AppSize.s30,
    //           text: AppStringEM.add, //submit
    //           onPressed: () async {
    //             if(filePath != null && documentTypeName != ""){
    //               setState(() {
    //                 load = true;
    //               });
    //               try {
    //                 //File filePath = File(finalPath!);
    //                 String? expiryDate;
    //                 if (expiryDateController.text.isEmpty) {
    //                   expiryDate = null;
    //                 } else {
    //                   expiryDate = datePicked!.toIso8601String() + "Z";
    //                 }
    //                 var response = await uploadDocuments(
    //                     context: context,
    //                     employeeDocumentMetaId: documentMetaDataId,
    //                     employeeDocumentTypeSetupId: documentSetupId,
    //                     employeeId: widget.employeeId,
    //                     documentName: fileName,
    //                     documentFile: filePath,
    //                     expiryDate: expiryDate);
    //                 if (response.statusCode == 200 ||
    //                     response.statusCode == 201) {
    //                   Navigator.pop(context);
    //                   showDialog(
    //                     context: context,
    //                     builder: (BuildContext context) {
    //                       return AddSuccessPopup(
    //                         message: 'Document Uploded',
    //                       );
    //                     },
    //                   );
    //                 }
    //                 setState(() {
    //                   load = true;
    //                 });
    //               } finally {
    //                 setState(() {
    //                   load = true;
    //                 });
    //               }
    //             }else{
    //               print('Validation error');
    //             }
    //
    //           },
    //         ),
    //   title: widget.title,
    // );
  }
}




/// Clinical licenses popup
class ClinicalLicensesAddPopup extends StatelessWidget {
  final String title;
  bool? loadingDuration;
  // final String officeId;
  // final int docTypeMetaIdCC;
  final String licenseName;
   ClinicalLicensePrefillDataModel? drivingList;
  PractitionerLicensePreFillDataModel? practionerData;
  final String docId;
  //final int selectedSubDocId;
  final int employeeId;
  final double? height;
  final Widget? uploadField;
  dynamic filePath;
  String? fileName;
  ClinicalLicensesAddPopup({super.key, this.practionerData,required this.title,required this.employeeId, this.height, this.uploadField,  this.drivingList, required this.docId, required this.licenseName,});
  @override
  Widget build(BuildContext context) {
    TextEditingController expiryDateController = TextEditingController();
    DateTime? datePicked;
    final clinicalDocAddProviderState = Provider.of<HrManageProvider>(context, listen: false,);
    licenseName == "Driving License"?
    expiryDateController = TextEditingController(text: drivingList!.expDate) :
    expiryDateController = TextEditingController(text: practionerData!.expDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      licenseName == "Driving License"?
      clinicalDocAddProviderState.getFileName(drivingList!.fileName)  :
      clinicalDocAddProviderState.getFileName(practionerData!.fileName);
    });
    return Consumer<HrManageProvider>(
      builder: (context, providerState, child) {
        return DialogueTemplate(
          width: AppSize.s420,
          height: height == null ? AppSize.s374 : height!,
          body: [
            // HeaderContentConst(
            //   heading: AppString.type_of_the_document,
            //   content: widget.dataList.isEmpty
            //       ? Container(
            //     width: 354,
            //     height: 30,
            //     decoration: BoxDecoration(
            //       border: Border.all(color: ColorManager.containerBorderGrey, width: AppSize.s1),
            //       borderRadius: BorderRadius.circular(4),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            //       child: Text('No available document', style: DocumentTypeDataStyle.customTextStyle(context)),
            //     ),
            //   )
            //       : Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CICCDropdown(
            //         width: 354,
            //         initialValue: 'Select Document',
            //         onChange: (val) {
            //           // setState(() {
            //           //   showExpiryDateField = false;
            //           //   for (var a in widget.dataList) {
            //           //     if (a.documentName == val) {
            //           //       documentMetaDataId = a.employeeDocMetaDataId;
            //           //       documentSetupId = a.employeeDocTypeSetupId;
            //           //       documentTypeName = a.documentName;
            //           //       if (a.reminderThreshould == AppConfig.issuer) {
            //           //         showExpiryDateField = true;
            //           //       }
            //           //     }
            //           //   }
            //           // });
            //         },
            //         items: dropDownMenuItems,
            //       ),
            //       SizedBox(height: 2),
            //       if (_submitted && documentTypeName.isEmpty) // Check _submitted before showing the error
            //         Text(
            //           'Please select document',
            //           style: TextStyle(fontSize: 10, color: ColorManager.red),
            //         ),
            //     ],
            //   ),
            // ),

            HeaderContentConst(
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
                          borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        hintText: 'yyyy-mm-dd',
                        hintStyle: DocumentTypeDataStyle.customTextStyle(context),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(width: 1, color: ColorManager.fmediumgrey),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
                        errorText: providerState.isSubmitted && expiryDateController.text.isEmpty
                            ? 'Please select date'
                            : null, // Show error only after submission
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
                          expiryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            HeaderContentConst(
              heading: AppString.upload_document,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: providerState.pickClinicalEditFile,
                    child: Container(
                      height: AppSize.s30,
                      width: AppSize.s354,
                      padding: EdgeInsets.only(left: AppPadding.p15),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorManager.containerBorderGrey, width: 1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) {
                          return Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(providerState.editClinicalLicenseFileName, style: DocumentTypeDataStyle.customTextStyle(context)),
                                ),
                                IconButton(
                                  padding: EdgeInsets.all(4),
                                  onPressed: providerState.pickClinicalEditFile,
                                  icon: Icon(Icons.file_upload_outlined, color: ColorManager.black, size: 17),
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
                  SizedBox(height: 2),
                  if (providerState.isSubmitted && providerState.editClinicalLicenseFilePath == null) // Show error only if filePath is null and form is submitted
                    Text(
                      'Please select document',
                      style: TextStyle(fontSize: 10, color: ColorManager.red),
                    ),
                ],
              ),
            )
          ],
          bottomButtons: providerState.load
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
            text: AppStringEM.add,
            onPressed: () async {
              providerState.isSumitted();

              // if (filePath != null && documentTypeName.isNotEmpty) {
                providerState.loaderTrue();
                try {
                  String? expiryDate;
                  // if (expiryDateController.text.isEmpty) {
                  //   expiryDate = null;
                  // } else {
                  //   expiryDate = datePicked!.toIso8601String() + "Z";
                  // }
                  var response = licenseName == 'Driving License'? await patchDrivingLicense(
                      context: context,
                      docId: docId,
                      employeeId: drivingList!.employeeId,
                      idOfDocument: drivingList!.idOFDocument,
                      expiryDate: expiryDateController.text,
                      createdAt: drivingList!.createdAt,
                      url: drivingList!.url,
                      officeId: drivingList!.officeId,
                      fileName: providerState.editClinicalLicenseFileName,
                      approved: drivingList!.approve!
                  ):await patchPractitionerLicense(
                      context: context,
                      docId: docId,
                      employeeId: practionerData!.employeeId,
                      idOfDocument: practionerData!.idOFDocument,
                      expiryDate: expiryDateController.text,
                      createdAt: practionerData!.createdAt,
                      url: practionerData!.url,
                      officeId: practionerData!.officeId,
                      fileName: providerState.editClinicalLicenseFileName,
                      approved: practionerData!.approve!
                  );
                  // var result = await singleBatchApproveOnboardAckHealthPatch(context, response.documentId!);
                  if (response.statusCode == 200 || response.statusCode == 201) {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddSuccessPopup(message: 'License Uploaded Successfully');
                      },
                    );
                    if(providerState.clinicalFileIsPicked){
                      if(providerState.editFileAbove20Mb){
                        var docResponse =  licenseName == 'Driving License'? await patchDocumentsDL(
                            context: context,
                            drivingLicenceId: int.parse(docId),
                            documentFile: providerState.editClinicalLicenseFilePath,
                            documentName: providerState.editClinicalLicenseFileName) : await patchDocumentsPL(
                            context: context,
                            practitionerLicenceId: int.parse(docId),
                            documentFile: providerState.editClinicalLicenseFilePath,
                            documentName: providerState.editClinicalLicenseFileName);
                        if (docResponse.statusCode == 200 || docResponse.statusCode == 201) {
                          providerState.clearAddedValue();
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddSuccessPopup(
                                message: 'Document Edited Successfully',
                              );
                            },
                          );
                        }
                        else if (response.statusCode == 413) {
                          providerState.clearAddedValue();
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddErrorPopup(
                                message: 'File is too large!',
                              );
                            },
                          );
                        }
                        else {
                          Navigator.pop(context);
                          print('Error');
                        }
                      }else{
                        providerState.clearAddedValue();
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddErrorPopup(
                              message: 'File is too large!',
                            );
                          },
                        );
                      }
                    }
                  }
                  // if (response.statusCode == 413) {
                  //   Navigator.pop(context);
                  //   showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AddErrorPopup(
                  //         message: 'Request entity to large!',
                  //       );
                  //     },
                  //   );
                  // }

                  providerState.loaderFalse();
                } finally {
                  providerState.clearAddedValue();
                  providerState.loaderFalse();
                }
              // } else {
              //   print('Validation error');
              // }
            },
          ),
          title: title,
        );
      }
    );
  }
}
