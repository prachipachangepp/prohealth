import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/header_content_const.dart';

import '../../../../../app/constants/app_config.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../widgets/button_constant.dart';
import '../../widgets/text_form_field_const.dart';
import 'ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

class UploadDocumentAddPopup extends StatefulWidget {
  final String title;
  bool? loadingDuration;
  final String officeId;
  final int docTypeMetaIdCC;
  final String docTypeText;
  final String subDocTypeText;
  final int selectedSubDocId;
  final double? height;
  final Widget? uploadField;
  dynamic filePath;
  String? fileName;
  final List<TypeofDocpopup> dataList;
  // final Visibility? child3;
  UploadDocumentAddPopup({
    required this.title,
    this.loadingDuration,
    this.height,
    this.uploadField,
    required this.officeId,
    required this.docTypeMetaIdCC,
    required this.selectedSubDocId,
    required this.dataList,
    required this.docTypeText,
    required this.subDocTypeText,
    // this.child3
  });

  @override
  State<UploadDocumentAddPopup> createState() => _UploadDocumentAddPopupState();
}

class _UploadDocumentAddPopupState extends State<UploadDocumentAddPopup> {
  int docTypeId = 0;
  String documentTypeName = "";
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  String _url = "";
  bool showExpiryDateField = false;
  bool isFileSelected = false;
  bool isFileErrorVisible = false;
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController nameDocController = TextEditingController();
  TextEditingController idDocController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController subTypeController = TextEditingController();
  TextEditingController daysController = TextEditingController(text: "1");
  bool load = false;
  DateTime? datePicked;
  List<DropdownMenuItem<String>> dropDownMenuItems = [];
  String selectedExpiryType = "";
  bool _isFormValid = true;
  String? selectedYear = AppConfig.year;
  String? _idDocError;
  String? _nameDocError;
  String? _expiryTypeError;
  @override
  void initState() {
    dropDownMenuItems = widget.dataList
        .map((doc) => DropdownMenuItem<String>(
              value: doc.docname,
              child: Text(doc.docname),
            ))
        .toList();

    super.initState();
    _url = "";
    showExpiryDateField;
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
        isFileSelected = true;
        isFileErrorVisible = false;
      });
    }
  }
  bool loading = false;
  String selectedRadio = "Pre-defined";

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
      _idDocError = _validateTextField(idDocController.text, 'ID of the Document');
      _nameDocError = _validateTextField(nameDocController.text, 'Name of the Document');
      isFileErrorVisible = !isFileSelected;
      if (selectedExpiryType.isEmpty) {
        _expiryTypeError = "Please select an expiry type";
        _isFormValid = false;
      } else {
        _expiryTypeError = null;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return TerminationDialogueTemplate(
      width: AppSize.s420,
      height: selectedRadio == "Pre-defined"
          ? widget.height == null
              ? AppSize.s374
              : widget.height!
          : widget.height == null
              ? AppSize.s620
              : widget.height!,
      body: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRadioListTile(
                title: 'Pre-defined',
                value: 'Pre-defined',
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value!;
                  });
                },
              ),
              CustomRadioListTile(
                title: 'Other',
                value: 'Other',
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value!;
                  });
                },
              ),
            ],
          ),
        ),
        selectedRadio == "Pre-defined"
            ? Column(
                children: [
                  HeaderContentConst(
                    heading: AppString.type_of_the_document,
                    content: CICCDropdown(
                      width: 354,
                      initialValue: "Select",
                      onChange: (val) {
                        setState(() {
                          showExpiryDateField = false;
                          for (var doc in widget.dataList) {
                            if (doc.docname == val) {
                              docTypeId = doc.orgDocumentSetupid!;
                              documentTypeName = doc.idOfDocument;
                              if (doc.expirytype == AppConfig.issuer) {
                                showExpiryDateField = true;
                              }
                            }
                          }
                        });
                      },
                      items: dropDownMenuItems,
                    ),
                  ),
                  Visibility(
                    visible: showExpiryDateField,
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
                              style: DocumentTypeDataStyle.customTextStyle(
                                  context),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'yyyy-mm-dd',
                                hintStyle:
                                    DocumentTypeDataStyle.customTextStyle(
                                        context),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: ColorManager.fmediumgrey),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
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
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  /// Upload document
                  HeaderContentConst(
                      heading: AppString.upload_document,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap:
                                _pickFile, // Trigger file picking when the whole container is tapped
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
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        fileName,
                                        style: DocumentTypeDataStyle
                                            .customTextStyle(context),
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(4),
                                      onPressed:
                                          _pickFile, // Keep file picker here as well for icon press
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
                              ),
                            ),
                          ),
                          if (isFileErrorVisible)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'Please upload a document',
                                style: CommonErrorMsg.customTextStyle(context),
                              ),
                            ),
                        ],
                      ))
                ],
              )
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///name
                  FirstSMTextFConst(
                    controller: nameDocController,
                    keyboardType: TextInputType.text,
                    text: 'Name of the Document',
                  ),
                  if (_nameDocError != null) // Display error if any
                  Text(
                  _nameDocError!,
                  style:CommonErrorMsg.customTextStyle(context),
                  ),
                  SizedBox(height: AppSize.s2),

                  ///id
                  SMTextFConst(
                    controller: idDocController,
                    keyboardType: TextInputType.text,
                    text: 'ID of the Document',
                  ),
                  if (_idDocError != null) // Display error if any
                  Text(
                  _idDocError!,
                  style:CommonErrorMsg.customTextStyle(context),
                  ),
                  SizedBox(height: AppSize.s2),

                  /// Type of the Document
                  HeaderContentConst(
                    heading: AppString.type_of_the_document,
                    content: Container(
                      width: 354,
                      height: 30,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorManager.fmediumgrey, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.docTypeText,
                            style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.s2),

                  /// SubType of the Document
                  widget.selectedSubDocId == AppConfig.subDocId0
                      ? SizedBox()
                      : HeaderContentConst(
                    heading: AppString.sub_type_of_the_document,
                    content: Container(
                      width: 354,
                      height: 30,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorManager.fmediumgrey, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.subDocTypeText,
                            style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.s2),
                  // HeaderContentConst(
                  //   heading: AppString.type_of_the_document,
                  //   content: CICCDropdown(
                  //     width: 354,
                  //     initialValue: "Select",
                  //     onChange: (val) {
                  //       setState(() {
                  //         showExpiryDateField = false;
                  //         for (var doc in widget.dataList) {
                  //           if (doc.docname == val) {
                  //             docTypeId = doc.orgDocumentSetupid!;
                  //             documentTypeName = doc.idOfDocument;
                  //             if (doc.expirytype == AppConfig.issuer) {
                  //               showExpiryDateField = true;
                  //             }
                  //           }
                  //         }
                  //       });
                  //     },
                  //     items: dropDownMenuItems,
                  //   ),
                  // ),
                  // Visibility(
                  //   visible: showExpiryDateField,
                  //   child: HeaderContentConst(
                  //     heading: AppString.expiry_date,
                  //     content: FormField<String>(
                  //       builder: (FormFieldState<String> field) {
                  //         return SizedBox(
                  //           width: 354,
                  //           height: 30,
                  //           child: TextFormField(
                  //             controller: expiryDateController,
                  //             cursorColor: ColorManager.black,
                  //             style: DocumentTypeDataStyle.customTextStyle(context),
                  //             decoration: InputDecoration(
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color: ColorManager.fmediumgrey, width: 1),
                  //                 borderRadius: BorderRadius.circular(6),
                  //               ),
                  //               focusedBorder: OutlineInputBorder(
                  //                 borderSide: BorderSide(
                  //                     color: ColorManager.fmediumgrey, width: 1),
                  //                 borderRadius: BorderRadius.circular(6),
                  //               ),
                  //               hintText: 'yyyy-mm-dd',
                  //               hintStyle:
                  //               DocumentTypeDataStyle.customTextStyle(context),
                  //               border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(6),
                  //                 borderSide: BorderSide(
                  //                     width: 1, color: ColorManager.fmediumgrey),
                  //               ),
                  //               contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  //               suffixIcon: Icon(Icons.calendar_month_outlined,
                  //                   color: ColorManager.blueprime),
                  //               errorText: field.errorText,
                  //             ),
                  //             onTap: () async {
                  //               DateTime? pickedDate = await showDatePicker(
                  //                 context: context,
                  //                 initialDate: DateTime.now(),
                  //                 firstDate: DateTime(1901),
                  //                 lastDate: DateTime(3101),
                  //               );
                  //               if (pickedDate != null) {
                  //                 datePicked = pickedDate;
                  //                 expiryDateController.text =
                  //                     DateFormat('yyyy-MM-dd').format(pickedDate);
                  //               }
                  //             },
                  //             validator: (value) {
                  //               if (value == null || value.isEmpty) {
                  //                 return 'Please select a date';
                  //               }
                  //               return null;
                  //             },
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  ///radio
                  Row(
                    children: [
                      HeaderContentConst(
                        heading: AppString.expiry_type,
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRadioListTile(
                              value: AppConfig.notApplicable,
                              groupValue: selectedExpiryType,
                              onChanged: (value) {
                                setState(() {
                                  selectedExpiryType = value!;
                                });
                              },
                              title: AppConfig.notApplicable,
                            ),
                            CustomRadioListTile(
                              value: AppConfig.scheduled,
                              groupValue: selectedExpiryType,
                              onChanged: (value) {
                                setState(() {
                                  selectedExpiryType = value!;
                                });
                              },
                              title: AppConfig.scheduled,
                            ),
                            CustomRadioListTile(
                              value: AppConfig.issuer,
                              groupValue: selectedExpiryType,
                              onChanged: (value) {
                                setState(() {
                                  selectedExpiryType = value!;
                                });
                              },
                              title: AppConfig.issuer,
                            ),
                            if (_expiryTypeError != null)
                              Text(
                                _expiryTypeError!,
                                style:  CommonErrorMsg.customTextStyle(context),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.p20,
                          right: AppPadding.p20,
                        ),
                        child: Visibility(
                          visible:
                              selectedExpiryType == AppConfig.scheduled,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 50,
                                    //color: ColorManager.red,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller:
                                          daysController, // Use the controller initialized with "1"
                                      cursorColor: ColorManager.black,
                                      cursorWidth: 1,
                                      style: DocumentTypeDataStyle
                                          .customTextStyle(context),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ColorManager.fmediumgrey,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ColorManager.fmediumgrey,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding:
                                            EdgeInsets.symmetric(
                                                horizontal: 10),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .digitsOnly, // This ensures only digits are accepted
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 30,
                                    width: 80,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorManager.fmediumgrey),
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      value:
                                          selectedYear, // Initial value (you should define this variable)
                                      items: [
                                        DropdownMenuItem(
                                          value: AppConfig.year,
                                          child: Text(
                                            AppConfig.year,
                                            style: DocumentTypeDataStyle
                                                .customTextStyle(context),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: AppConfig.month,
                                          child: Text(
                                            AppConfig.month,
                                            style: DocumentTypeDataStyle
                                                .customTextStyle(context),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedYear =
                                              value; // Update the selected option (Year/Month)
                                        });
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: AppConfig.year,
                                        hintStyle: DocumentTypeDataStyle
                                            .customTextStyle(context),
                                        contentPadding:
                                            EdgeInsets.only(bottom: 20),
                                      ),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: ColorManager.black,
                                        size: IconSize.I16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///date
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppPadding.p5,
                      right: AppPadding.p5,
                    ),
                    child: Visibility(
                      visible: selectedExpiryType == AppConfig.issuer,
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
                                style: DocumentTypeDataStyle.customTextStyle(
                                    context),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.fmediumgrey,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorManager.fmediumgrey,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintText: 'yyyy-mm-dd',
                                  hintStyle:
                                      DocumentTypeDataStyle.customTextStyle(
                                          context),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ColorManager.fmediumgrey),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  suffixIcon: Icon(
                                      Icons.calendar_month_outlined,
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
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a date';
                                  }
                                  return null;
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  /// Upload document
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
                    child: HeaderContentConst(
                        heading: AppString.upload_document,
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap:
                              _pickFile, // Trigger file picking when the whole container is tapped
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
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          fileName,
                                          style: DocumentTypeDataStyle
                                              .customTextStyle(context),
                                        ),
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.all(4),
                                        onPressed:
                                        _pickFile, // Keep file picker here as well for icon press
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
                                ),
                              ),
                            ),
                            if (isFileErrorVisible)
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  'Please upload a document',
                                  style: CommonErrorMsg.customTextStyle(context),
                                ),
                              ),
                          ],
                        )),
                  )
                ],
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
          : selectedRadio == "Pre-defined"
              ? CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.add, // submit
                  onPressed: () async {
                    setState(() {
                      isFileErrorVisible = !isFileSelected;
                    });

                    // Ensure the file is selected before proceeding
                    if (!isFileSelected) {
                      return;
                    }

                    setState(() {
                      load = true;
                    });

                    try {
                      String? expiryDate;
                      if (expiryDateController.text.isEmpty) {
                        expiryDate = null;
                      } else {
                        expiryDate = datePicked!.toIso8601String() + "Z";
                      }
                      ApiData response = await addOrgDocPPPost(
                        context: context,
                        orgDocumentSetupid: docTypeId,
                        idOfDocument: documentTypeName,
                        expiryDate: expiryDate,
                        docCreated: DateTime.now().toIso8601String() + "Z",
                        url: "url",
                        officeId: widget.officeId,
                        fileName: fileName,
                      );
                      expiryDateController.clear();
                      if (response.statusCode == 200 || response.statusCode == 201) {
                      print("id >>>>>>>>>>>>>>>>>>>>>..... ${response.orgOfficeDocumentId}");
                        await uploadDocumentsoffice(
                          context: context,
                          documentFile: filePath,
                          orgOfficeDocumentId: response.orgOfficeDocumentId!,
                          fileName: fileName,
                        );
                      }
                    } finally {
                      setState(() {
                        // Navigator.pop(context);
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CountySuccessPopup(
                              message: 'Save Successfully',
                            );
                          },
                        );

                        load = false;
                      });
                    }
                  },
                )
              : CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.add, // submit
                  onPressed: () async {
                    _validateForm(); // Validate the form on button press
                    if (_isFormValid) {
                    setState(() {
                    load = true;
                   // isFileErrorVisible = !isFileSelected;
                    });

                    if (!isFileSelected) {
                      return;
                    }

                    setState(() {
                      load = true;
                    });

                    try{
                      String? expiryDate;
                      if (expiryDateController.text.isEmpty) {
                        expiryDate = null;
                      } else {
                        expiryDate = datePicked!.toIso8601String() + "Z";
                      }

                      int threshold = 0;
                      if (selectedExpiryType == AppConfig.scheduled &&
                          daysController.text.isNotEmpty) {
                        int enteredValue = int.parse(daysController.text);
                        if (selectedYear == AppConfig.year) {
                          threshold = enteredValue * 365;
                        } else if (selectedYear == AppConfig.month) {
                          threshold = enteredValue * 30;
                        }
                      }
                      ApiData newResponse = await addOtherOfficeDocPost(
                          context: context,
                          docTypeid: widget.docTypeMetaIdCC,
                          docSubTypeid: widget.selectedSubDocId == AppConfig.subDocId0 ? AppConfig.subDocId0 : widget.selectedSubDocId,
                          documentName: nameDocController.text,
                          expiryType: selectedExpiryType.toString(),
                          threshold: threshold,
                          expiryDate: expiryDate,
                          expiryReminder: selectedExpiryType.toString(),
                          idOfDoc: idDocController.text,
                          docCreated: DateTime.now().toIso8601String() + "Z",
                          fileName: fileName,
                          url: 'url',
                       officeId: widget.officeId);
                      if (newResponse.statusCode == 200 || newResponse.statusCode == 201) {
                        print("id >>>>>>>>>>>>>>>>>>>>>..... ${newResponse.orgOfficeDocumentId}");
                        await uploadDocumentsoffice(
                          context: context,
                          documentFile: filePath,
                          fileName: fileName,
                          orgOfficeDocumentId: newResponse.orgOfficeDocumentId!,
                        );
                      }
                    }
                    finally {
                      setState(() {
                        // Navigator.pop(context);
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CountySuccessPopup(
                              message: 'Save Successfully',
                            );
                          },
                        );

                        load = false;
                      });
                    }

                  }}
                ),
      title: widget.title,
    );
  }
}

///old working
// class UploadDocumentAddPopup extends StatefulWidget {
//   final String title;
//   bool? loadingDuration;
//   final String officeId;
//   final int docTypeMetaIdCC;
//   final List<TypeofDocpopup> dataList;
//   final int selectedSubDocId;
//   final double? height;
//   final Widget? uploadField;
//   dynamic filePath;
//   String? fileName;
//   // final Visibility? child3;
//   UploadDocumentAddPopup({
//     required this.title,
//     this.loadingDuration,
//     this.height,
//     this.uploadField,
//     required this.officeId,
//     required this.docTypeMetaIdCC,
//     required this.selectedSubDocId,
//     required this.dataList,
//     // this.child3
//   });
//
//   @override
//   State<UploadDocumentAddPopup> createState() => _UploadDocumentAddPopupState();
// }
// class _UploadDocumentAddPopupState extends State<UploadDocumentAddPopup> {
//   int docTypeId = 0;
//   String documentTypeName = "";
//   dynamic filePath;
//   String? selectedDocType;
//   String fileName = '';
//   String _url = "";
//   bool showExpiryDateField = false;
//   bool isFileSelected = false;
//   bool isFileErrorVisible = false;
//   TextEditingController expiryDateController = TextEditingController();
//
//   bool load = false;
//   DateTime? datePicked;
//   List<DropdownMenuItem<String>> dropDownMenuItems = [];
//
//   @override
//   void initState() {
//     dropDownMenuItems = widget.dataList
//         .map((doc) => DropdownMenuItem<String>(
//       value: doc.docname,
//       child: Text(doc.docname),
//     ))
//         .toList();
//
//     super.initState();
//     _url = "";
//     showExpiryDateField;
//   }
//
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//
//     if (result != null) {
//       setState(() {
//         filePath = result.files.first.bytes;
//         fileName = result.files.first.name;
//         isFileSelected = true;
//         isFileErrorVisible = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DialogueTemplate(
//       width: AppSize.s420,
//       height: widget.height == null ? AppSize.s374 : widget.height!,
//       body: [
//         HeaderContentConst(
//           heading: AppString.type_of_the_document,
//           content: CICCDropdown(
//             width: 354,
//             initialValue: "Select",
//             onChange: (val) {
//               setState(() {
//                 showExpiryDateField = false;
//                 for (var doc in widget.dataList) {
//                   if (doc.docname == val) {
//                     docTypeId = doc.orgDocumentSetupid!;
//                     documentTypeName = doc.idOfDocument;
//                     if (doc.expirytype == AppConfig.issuer) {
//                       showExpiryDateField = true;
//                     }
//                   }
//                 }
//               });
//             },
//             items: dropDownMenuItems,
//           ),
//         ),
//         Visibility(
//           visible: showExpiryDateField,
//           child: HeaderContentConst(
//             heading: AppString.expiry_date,
//             content: FormField<String>(
//               builder: (FormFieldState<String> field) {
//                 return SizedBox(
//                   width: 354,
//                   height: 30,
//                   child: TextFormField(
//                     controller: expiryDateController,
//                     cursorColor: ColorManager.black,
//                     style: DocumentTypeDataStyle.customTextStyle(context),
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             color: ColorManager.fmediumgrey, width: 1),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             color: ColorManager.fmediumgrey, width: 1),
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       hintText: 'yyyy-mm-dd',
//                       hintStyle:
//                       DocumentTypeDataStyle.customTextStyle(context),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(6),
//                         borderSide: BorderSide(
//                             width: 1, color: ColorManager.fmediumgrey),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                       suffixIcon: Icon(Icons.calendar_month_outlined,
//                           color: ColorManager.blueprime),
//                       errorText: field.errorText,
//                     ),
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(1901),
//                         lastDate: DateTime(3101),
//                       );
//                       if (pickedDate != null) {
//                         datePicked = pickedDate;
//                         expiryDateController.text =
//                             DateFormat('yyyy-MM-dd').format(pickedDate);
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please select a date';
//                       }
//                       return null;
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//
//         /// Upload document
//         HeaderContentConst(
//             heading: AppString.upload_document,
//             content:
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InkWell(
//                   onTap: _pickFile, // Trigger file picking when the whole container is tapped
//                   child: Container(
//                     height: AppSize.s30,
//                     width: AppSize.s354,
//                     padding: EdgeInsets.only(left: AppPadding.p15),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: ColorManager.containerBorderGrey,
//                         width: 1,
//                       ),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               fileName,
//                               style: DocumentTypeDataStyle.customTextStyle(context),
//                             ),
//                           ),
//                           IconButton(
//                             padding: EdgeInsets.all(4),
//                             onPressed: _pickFile, // Keep file picker here as well for icon press
//                             icon: Icon(
//                               Icons.file_upload_outlined,
//                               color: ColorManager.black,
//                               size: 17,
//                             ),
//                             splashColor: Colors.transparent,
//                             highlightColor: Colors.transparent,
//                             hoverColor: Colors.transparent,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (isFileErrorVisible)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 5),
//                     child: Text(
//                       'Please upload a document',
//                       style: CommonErrorMsg.customTextStyle(context),
//                     ),
//                   ),
//               ],
//             )
//
//         )
//       ],
//       bottomButtons: load
//           ? SizedBox(
//         height: AppSize.s25,
//         width: AppSize.s25,
//         child: CircularProgressIndicator(
//           color: ColorManager.blueprime,
//         ),
//       )
//           : CustomElevatedButton(
//         width: AppSize.s105,
//         height: AppSize.s30,
//         text: AppStringEM.add, // submit
//         onPressed: () async {
//           setState(() {
//             isFileErrorVisible = !isFileSelected;
//           });
//
//           // Ensure the file is selected before proceeding
//           if (!isFileSelected) {
//             return;
//           }
//
//           setState(() {
//             load = true;
//           });
//
//           try {
//             String? expiryDate;
//             if (expiryDateController.text.isEmpty) {
//               expiryDate = null;
//             } else {
//               expiryDate = datePicked!.toIso8601String() + "Z";
//             }
//             ApiData response = await addOrgDocPPPost(
//               context: context,
//               orgDocumentSetupid: docTypeId,
//               idOfDocument: documentTypeName,
//               expiryDate: expiryDate,
//               docCreated: DateTime.now().toIso8601String() + "Z",
//               url: "url",
//               officeId: widget.officeId,
//               fileName: fileName,
//             );
//             expiryDateController.clear();
//             if (response.statusCode == 200 ||
//                 response.statusCode == 201) {
//               await uploadDocumentsoffice(
//                 context: context,
//                 documentFile: filePath,
//                 orgOfficeDocumentId: response.orgOfficeDocumentId!,
//                 fileName: fileName,
//               );
//
//             }
//           } finally {
//             setState(() {
//               // Navigator.pop(context);
//               Navigator.pop(context);
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return CountySuccessPopup(
//                     message: 'Save Successfully',
//                   );
//                 },
//               );
//
//               load = false;
//             });
//           }
//         },
//       ),
//       title: widget.title,
//     );
//   }
// }
