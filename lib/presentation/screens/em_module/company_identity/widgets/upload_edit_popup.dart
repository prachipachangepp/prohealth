import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/header_content_const.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../widgets/text_form_field_const.dart';

class VCScreenPopupEditConst extends StatefulWidget {
  final String title;
  bool? loadingDuration;
  final String officeId;
  final int orgDocId;
  final String docName;
  final String idOfDoc;
  final String url;
  final String selectedExpiryType;
  final int orgDocumentSetupid;
  final String? expiryDate;
  final String fileName;
  final String documentType;
  final String documentSubType;
  final int docTypeMetaIdCC;
  final int selectedSubDocId;
  final bool isOthersDocs;
  final String? expiryType;
  final int? threshhold;
  final double? height;
  final Widget? uploadField;
  VCScreenPopupEditConst({
    super.key,
    required this.title,
    required this.fileName,
    this.height,
    this.expiryType,
    this.threshhold,
    this.loadingDuration,
    this.uploadField,
    required this.officeId,
    required this.docTypeMetaIdCC,
    required this.selectedSubDocId,
    required this.orgDocId,
    required this.orgDocumentSetupid,
    required this.docName,
    required this.selectedExpiryType,
    this.expiryDate,
    required this.url, required this.documentType,
    required this.documentSubType,
    required this.isOthersDocs, required this.idOfDoc,
  });

  @override
  State<VCScreenPopupEditConst> createState() => _VCScreenPopupEditConstState();
}

class _VCScreenPopupEditConstState extends State<VCScreenPopupEditConst> {
  int docTypeId = 0;
  String? documentTypeName;
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  bool fileIsPicked = false;
  DateTime? datePicked;
  bool loading = false;
  String selectedRadio = "";
  String selectedExpiryType = "";
  bool _isFormValid = true;
  bool isFileErrorVisible = false;
  String? selectedYear = AppConfig.year;
  String? _idDocError;
  String? _nameDocError;
  String? _expiryTypeError;
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        fileIsPicked = true;
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController nameDocController = TextEditingController();
  TextEditingController idDocController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController subTypeController = TextEditingController();
  TextEditingController daysController = TextEditingController(text: "1");

  void ExpityTypeRadio(){
    if (widget.expiryType == AppConfig.scheduled) {
      selectedExpiryType = AppConfig.scheduled;
    }
    else if (widget.expiryType == AppConfig.notApplicable) {
      selectedExpiryType = AppConfig.notApplicable;
    }
    else if (widget.expiryType == AppConfig.issuer) {
      selectedExpiryType = AppConfig.issuer;
    }
  }

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
      _nameDocError = _validateTextField(nameDocController.text, 'Name of the Document');
      _idDocError = _validateTextField(idDocController.text, 'id of the Document');
      if (selectedExpiryType == AppConfig.issuer) {
        if (expiryDateController.text.isEmpty) {
          _expiryTypeError = "Please select expiry date";
          _isFormValid = false;
        } else {
          _expiryTypeError = null;
        }
      } else {
        _expiryTypeError = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.expiryType);
    nameDocController.text = widget.docName;
    idDocController.text = widget.idOfDoc;
    if (widget.selectedExpiryType == AppConfig.issuer) {
      if(widget.expiryDate == "")
        {
          expiryDateController = TextEditingController(
              text: "");
        }
      else {
        DateTime dateTime =
        DateTime.parse(widget.expiryDate ?? DateTime.now().toString());
        showExpiryDateField = true;
        datePicked = dateTime;
        expiryDateController = TextEditingController(
            text: DateFormat('yyyy-MM-dd').format(dateTime));
      }
    }
    fileName = widget.fileName;
    ExpityTypeRadio();
    if (selectedExpiryType == AppConfig.scheduled && widget.threshhold != null) {
      int threshold = widget.threshhold!;

      if (threshold >= 365) {
        daysController.text = (threshold ~/ 365).toString(); // Set years
        selectedYear = AppConfig.year;
      } else {
        daysController.text = (threshold ~/ 30).toString(); // Set months
        selectedYear = AppConfig.month;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TerminationDialogueTemplate(
      width: AppSize.s420,
      height:  widget.isOthersDocs == false
          ? widget.height == null ? AppSize.s390 : widget.height!
          : widget.height == null ? AppSize.s580 : widget.height! ,

      body: [
        // Padding(
        //   padding: const EdgeInsets.only(left: 5.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       CustomRadioListTile(
        //         title:  widget.isOthersDocs == false ? 'Pre-defined' : 'Other',
        //         value: widget.isOthersDocs == false ? 'Pre-defined' : 'Other',
        //         groupValue: widget.isOthersDocs == false ?  'Pre-defined' : 'Other',
        //         onChanged: (value) {
        //           setState(() {
        //             selectedRadio = value!;
        //           });
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        widget.isOthersDocs == false
            ? Column(
          children: [
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
                heading: AppString.upload_document,
                content: InkWell(
                  onTap: _pickFile,
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
                )),
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
                          hintText: 'yyyy-mm-dd',
                          hintStyle: ConstTextFieldRegister.customTextStyle(context),
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
                            initialDate: datePicked,
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
                  )),

              // /// Type of the Document
              // HeaderContentConst(
              //   heading: AppString.type_of_the_document,
              //   content: Container(
              //     width: 354,
              //     height: 30,
              //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              //     decoration: BoxDecoration(
              //       color: ColorManager.white,
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(color: ColorManager.fmediumgrey, width: 1),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           widget.documentType,
              //           style: DocumentTypeDataStyle.customTextStyle(context),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: AppSize.s2),
              //
              // /// SubType of the Document
              // widget.selectedSubDocId == AppConfig.subDocId0
              //     ? SizedBox()
              //     : HeaderContentConst(
              //   heading: AppString.sub_type_of_the_document,
              //   content: Container(
              //     width: 354,
              //     height: 30,
              //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              //     decoration: BoxDecoration(
              //       color: ColorManager.white,
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(color: ColorManager.fmediumgrey, width: 1),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           widget.documentSubType,
              //           style: DocumentTypeDataStyle.customTextStyle(context),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: AppSize.s2),
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
                                  icon: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: ColorManager.black,
                                      size: IconSize.I16,
                                    ),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
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
                  if (_expiryTypeError != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        _expiryTypeError!,
                        style:  CommonErrorMsg.customTextStyle(context),
                      ),
                    ),
                ],
              ),

            ],
          ),
        )
      ],
      bottomButtons: loading
          ? SizedBox(
        height: AppSize.s25,
        width: AppSize.s25,
        child: CircularProgressIndicator(
          color: ColorManager.blueprime,
        ),
      )
          :  widget.isOthersDocs == false
            ? CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.save, //submit
        onPressed: () async {
          setState(() {
            loading = true;
          });
          try {
            String? expiryDate;
            expiryDate = widget.selectedExpiryType == AppConfig.issuer
                ? datePicked!.toIso8601String() + "Z"
                : null;
            var response = await updateOrgDoc(
              context: context,
              orgDocId: widget.orgDocId,
              orgDocumentSetupid: widget.orgDocumentSetupid,
              idOfDocument: widget.docName,
              expiryDate: expiryDate,
              docCreatedat: DateTime.now().toIso8601String() + "Z",
              url: widget.url,
              fileName: fileIsPicked ? fileName: widget.fileName,
              officeid: widget.officeId,
            );

            if (response.statusCode == 200 ||
                response.statusCode == 201) {
              if (fileIsPicked) {
                await uploadDocumentsoffice(
                    context: context,
                    documentFile: filePath,
                    fileName: fileName,
                    orgOfficeDocumentId: response.orgOfficeDocumentId!);
              }
              setState(() {
                loading = false;
              });
            }
          } finally {
            setState(() {
              loading = false;
            });
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CountySuccessPopup(
                  message: 'Save Successfully',
                );
              },
            );
          }
        },
      )
            : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.save, //submit
          onPressed: () async {
            _validateForm();
            if (!_isFormValid) {
              return; // Stop here if the form is not valid
            }
            // if (_isFormValid) {
            //   setState(() {
            //     loading = true;
            //   });
            setState(() {
              loading = true;
              });

              try {
                int threshold = 0;
                String? expiryDateToSend;

                if (selectedExpiryType == AppConfig.scheduled) {
                  if (daysController.text.isNotEmpty) {
                    int enteredValue = int.parse(daysController.text);
                    if (selectedYear == AppConfig.year) {
                      threshold = enteredValue * 365;
                    } else if (selectedYear == AppConfig.month) {
                      threshold = enteredValue * 30;
                    }
                  }
                  expiryDateToSend = null;
                } else if (selectedExpiryType == AppConfig.notApplicable) {
                  threshold = 0;
                  expiryDateToSend = null;
                } else if (selectedExpiryType == AppConfig.issuer) {
    // Ensure expiry date is not empty
                  if (expiryDateController.text.isEmpty) {
                  setState(() {
                  _expiryTypeError = "Please select expiry date";
                  loading = false;
                  });
                  return;
                  }
                  threshold = 0;
                  expiryDateToSend = datePicked != null
                  ? datePicked!.toIso8601String() + "Z"
                      : widget.expiryDate;
                  }

                // Determine the final document name and ID
                String finalDocName = nameDocController.text.isNotEmpty
                    ? nameDocController.text
                    : widget.docName;
                String finalDocId = idDocController.text.isNotEmpty
                    ? idDocController.text
                    : widget.idOfDoc;

                // Make the API call to update the document
                var response = await updateOtherDoc(
                  context: context,
                  orgOfficeDocumentId: widget.orgDocId,
                  orgDocumentSetupid: widget.orgDocumentSetupid,
                  docTypeID: widget.docTypeMetaIdCC,
                  docSubTypeID: widget.selectedSubDocId,
                  docName: finalDocName,
                  expiryType: selectedExpiryType,
                  threshold: threshold,
                  expiryDate: expiryDateToSend,
                  expiryReminder: selectedExpiryType,
                  idOfDocument: finalDocId,
                  docCreatedat: DateTime.now().toIso8601String() + "Z",
                  url: widget.url,
                  officeid: widget.officeId,
                  fileName: fileIsPicked ? fileName : widget.fileName,
                );

                // Handle the response
                if (response.statusCode == 200 || response.statusCode == 201) {
                  // Upload the document if a new file was picked
                  if (fileIsPicked) {
                    await uploadDocumentsoffice(
                      context: context,
                      documentFile: filePath,
                      fileName: fileName,
                      orgOfficeDocumentId: response.orgOfficeDocumentId!,
                    );
                  }
                  setState(() {
                    loading = false;
                  });

                  // Show success message
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CountySuccessPopup(
                        message: 'Saved Successfully',
                      );
                    },
                  );
                }
              } catch (e) {
                print('Error updating document: $e');
              } finally {
                setState(() {
                  loading = false;
                });
              }
            }
          ),
      title: widget.title,
    );
  }
}


///old working
// class VCScreenPopupEditConst extends StatefulWidget {
//   final String title;
//   bool? loadingDuration;
//   final String officeId;
//   final int orgDocId;
//   final String docName;
//   final String url;
//   final String selectedExpiryType;
//   final int orgDocumentSetupid;
//   final String? expiryDate;
//   final String fileName;
//   final int docTypeMetaIdCC;
//   final int selectedSubDocId;
//
//   final double? height;
//   final Widget? uploadField;
//   VCScreenPopupEditConst({
//     super.key,
//     required this.title,
//     required this.fileName,
//     this.height,
//     this.loadingDuration,
//     this.uploadField,
//     required this.officeId,
//     required this.docTypeMetaIdCC,
//     required this.selectedSubDocId,
//     required this.orgDocId,
//     required this.orgDocumentSetupid,
//     required this.docName,
//     required this.selectedExpiryType,
//     required this.expiryDate,
//     required this.url,
//   });
//
//   @override
//   State<VCScreenPopupEditConst> createState() => _VCScreenPopupEditConstState();
// }
//
// class _VCScreenPopupEditConstState extends State<VCScreenPopupEditConst> {
//   int docTypeId = 0;
//   String? documentTypeName;
//   dynamic filePath;
//   String? selectedDocType;
//   String fileName = '';
//   bool fileIsPicked = false;
//   DateTime? datePicked;
//   bool loading = false;
//
//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//         allowMultiple: true,
//         type: FileType.custom,
//         allowedExtensions: ['pdf']);
//     if (result != null) {
//       setState(() {
//         fileIsPicked = true;
//         filePath = result.files.first.bytes;
//         fileName = result.files.first.name;
//       });
//     }
//   }
//
//   bool _isLoading = false;
//   bool showExpiryDateField = false;
//   TextEditingController expiryDateController = TextEditingController();
//
//   @override
//   void initState() {
//     if (widget.selectedExpiryType == AppConfig.issuer) {
//       DateTime dateTime =
//           DateTime.parse(widget.expiryDate ?? DateTime.now().toString());
//       showExpiryDateField = true;
//       datePicked = dateTime;
//       expiryDateController = TextEditingController(
//           text: DateFormat('yyyy-MM-dd').format(dateTime));
//     }
//     fileName = widget.fileName;
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DialogueTemplate(
//       width: AppSize.s420,
//       height: widget.height == null ? AppSize.s390 : widget.height!,
//       body: [
//         HeaderContentConst(
//           heading: AppString.type_of_the_document,
//           content: Container(
//             width: 354,
//             padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
//             decoration: BoxDecoration(
//               color: ColorManager.white,
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(color: ColorManager.fmediumgrey, width: 1),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.docName,
//                   style: DocumentTypeDataStyle.customTextStyle(context),
//                 ),
//                 Icon(
//                   Icons.arrow_drop_down,
//                   color: Colors.transparent,
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//         /// upload  doc
//         HeaderContentConst(
//             heading: AppString.upload_document,
//             content: InkWell(
//               onTap: _pickFile,
//               child: Container(
//                 height: AppSize.s30,
//                 width: AppSize.s354,
//                 padding: EdgeInsets.only(left: AppPadding.p15),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: ColorManager.containerBorderGrey,
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: StatefulBuilder(
//                   builder: (BuildContext context,
//                       void Function(void Function()) setState) {
//                     return Padding(
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
//                             onPressed: _pickFile,
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
//                     );
//                   },
//                 ),
//               ),
//             )),
//         Visibility(
//           visible: showExpiryDateField,
//
//           /// Conditionally display expiry date field
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
//                       hintStyle: ConstTextFieldRegister.customTextStyle(context),
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
//                         initialDate: datePicked,
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
//                         return 'please select date';
//                       }
//                       return null;
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//       bottomButtons: loading
//           ? SizedBox(
//               height: AppSize.s25,
//               width: AppSize.s25,
//               child: CircularProgressIndicator(
//                 color: ColorManager.blueprime,
//               ),
//             )
//           : CustomElevatedButton(
//               width: AppSize.s105,
//               height: AppSize.s30,
//               text: AppStringEM.save, //submit
//               onPressed: () async {
//                 setState(() {
//                   loading = true;
//                 });
//                 try {
//                   String? expiryDate;
//                   expiryDate = widget.selectedExpiryType == AppConfig.issuer
//                       ? datePicked!.toIso8601String() + "Z"
//                       : null;
//                   var response = await updateOrgDoc(
//                     context: context,
//                     orgDocId: widget.orgDocId,
//                     orgDocumentSetupid: widget.orgDocumentSetupid,
//                     idOfDocument: widget.docName,
//                     expiryDate: expiryDate,
//                     docCreatedat: DateTime.now().toIso8601String() + "Z",
//                     url: widget.url,
//                     fileName: fileIsPicked ? fileName: widget.fileName,
//                     officeid: widget.officeId,
//                   );
//
//                   if (response.statusCode == 200 ||
//                       response.statusCode == 201) {
//                     if (fileIsPicked) {
//                       await uploadDocumentsoffice(
//                           context: context,
//                           documentFile: filePath,
//                           fileName: fileName,
//                           orgOfficeDocumentId: response.orgOfficeDocumentId!);
//                     }
//                     setState(() {
//                       loading = false;
//                     });
//                   }
//                 } finally {
//                   setState(() {
//                     loading = false;
//                   });
//                   Navigator.pop(context);
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return CountySuccessPopup(
//                         message: 'Save Successfully',
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//       title: widget.title,
//     );
//   }
// }
