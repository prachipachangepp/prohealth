import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/others_doc_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/others_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/header_content_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class OthersDocAddpopup extends StatefulWidget {
  final String title;
  bool? loadingDuration;
  // final String officeId;
  // final int docTypeMetaIdCC;
  // final List<OthersDocModel> dataList;
  //final int selectedSubDocId;
  final int employeeId;
  final double? height;
  final Widget? uploadField;
  dynamic filePath;
  String? fileName;
   OthersDocAddpopup({super.key, required this.title,  required this.employeeId, this.height, this.uploadField});

  @override
  State<OthersDocAddpopup> createState() => _OthersDocAddpopupState();
}

class _OthersDocAddpopupState extends State<OthersDocAddpopup> {
  int docTypeId = 0;
  int documentMetaDataId = 0;
  int documentSetupId = 0;
  bool _submitted = false;
  // String documentTypeName = "";
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  String _url = "";
  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController documentTypeName = TextEditingController();

  bool load = false;
  DateTime? datePicked;
  List<DropdownMenuItem<String>> dropDownMenuItems = [];
  @override
  void initState() {
    // dropDownMenuItems = widget.dataList
    //     .map((doc) => DropdownMenuItem<String>(
    //   value: doc.idOfDocument,
    //   child: Text(doc.idOfDocument),
    // ))
    //     .toList();

    super.initState();
    _url = "";
    showExpiryDateField; // Reset _url when the popup is initialized
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
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: widget.height == null ? AppSize.s390 : widget.height!,
      body: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SMTextFConst(controller: documentTypeName, keyboardType: TextInputType.text, text: 'Enter document name'),
                // CICCDropdown(
                //   width: 354,
                //   initialValue: 'Select Document',
                //   onChange: (val) {
                //     setState(() {
                //       showExpiryDateField = false;
                //       for (var a in widget.dataList) {
                //         if (a.idOfDocument == val) {
                //           documentMetaDataId = a.employeeDocMetaDataId;
                //           documentSetupId = a.employeeDocTypeSetupId;
                //           documentTypeName = a.documentName;
                //           if (a.reminderThreshould == AppConfig.issuer) {
                //             showExpiryDateField = true;
                //           }
                //         }
                //       }
                //     });
                //   },
                //   items: dropDownMenuItems,
                // ),
                SizedBox(height: 2),
                if (_submitted && documentTypeName.text == null) // Check _submitted before showing the error
                  Text(
                    'Please select document',
                    style: TextStyle(fontSize: 10, color: ColorManager.red),
                  ),
              ],
            ),
        ),


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
                    errorText: _submitted && expiryDateController.text.isEmpty
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
                onTap: _pickFile,
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
                              child: Text(fileName, style: DocumentTypeDataStyle.customTextStyle(context)),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(4),
                              onPressed: _pickFile,
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
              if (_submitted && filePath == null) // Show error only if filePath is null and form is submitted
                Text(
                  'Please select document',
                  style: TextStyle(fontSize: 10, color: ColorManager.red),
                ),
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
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.add,
        onPressed: () async {
          setState(() {
            _submitted = true;
          });

          if (filePath != null ) {
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
              var addedResponse = await addOthersDocumentData(
                  context: context,
                  fileName: '',
                  url: '',
                  employeeId: widget.employeeId,
                  expDate: expiryDateController.text,
                  ifOfDocument: documentTypeName.text,
                  createdAt: DateTime.now().toString());
              var response = await uploadOtherDoc(
                context: context,
                documentName: fileName,
                documentFile: filePath, otherDocId: addedResponse.otherDocId!,
              );
              // var result = await singleBatchApproveOnboardAckHealthPatch(context, response.documentId!);
              if (response.statusCode == 200 || response.statusCode == 201) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddSuccessPopup(message: 'Document Uploaded Successfully');
                  },
                );
              }
               if (response.statusCode == 413) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddErrorPopup(
                      message: 'Request entity to large!',
                    );
                  },
                );
              }
              setState(() {
                load = true;
              });
            } finally {
              setState(() {
                load = true;
              });
            }
          } else {
            print('Validation error');
          }
        },
      ),
      title: widget.title,
    );
  }
}

class OthersEditPopup extends StatefulWidget {
  final int otherDocId;
  final String title;
  final String documentName;
  final String expDate;
  bool? loadingDuration;
  // final String officeId;
  // final int docTypeMetaIdCC;
  // final List<OthersDocModel> dataList;
  //final int selectedSubDocId;
  final int employeeId;
  final double? height;
  final Widget? uploadField;
  dynamic filePath;
  String? fileName;
  String? url;
   OthersEditPopup({super.key, this.url,this.fileName,required this.title, required this.employeeId, this.height, this.uploadField,
     required this.otherDocId, required this.documentName, required this.expDate});

  @override
  State<OthersEditPopup> createState() => _OthersEditPopupState();
}

class _OthersEditPopupState extends State<OthersEditPopup> {
  int docTypeId = 0;
  int documentMetaDataId = 0;
  int documentSetupId = 0;
  bool _submitted = false;
  bool isFilePicked = false;
  // String documentTypeName = "";
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  String _url = "";
  bool showExpiryDateField = false;
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController documentTypeName = TextEditingController();

  bool load = false;
  DateTime? datePicked;
  List<DropdownMenuItem<String>> dropDownMenuItems = [];
  @override
  void initState() {
    expiryDateController = TextEditingController(text: widget.expDate);
    documentTypeName = TextEditingController(text: widget.documentName);
    fileName = widget.fileName!;
    super.initState();
    // Reset _url when the popup is initialized
  }
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      isFilePicked = true;
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
      height: widget.height == null ? AppSize.s390 : widget.height!,
      body: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SMTextFConst(controller: documentTypeName, keyboardType: TextInputType.text, text: 'Enter document name'),
              // CICCDropdown(
              //   width: 354,
              //   initialValue: 'Select Document',
              //   onChange: (val) {
              //     setState(() {
              //       showExpiryDateField = false;
              //       for (var a in widget.dataList) {
              //         if (a.idOfDocument == val) {
              //           documentMetaDataId = a.employeeDocMetaDataId;
              //           documentSetupId = a.employeeDocTypeSetupId;
              //           documentTypeName = a.documentName;
              //           if (a.reminderThreshould == AppConfig.issuer) {
              //             showExpiryDateField = true;
              //           }
              //         }
              //       }
              //     });
              //   },
              //   items: dropDownMenuItems,
              // ),
              SizedBox(height: 2),
              if (_submitted && documentTypeName.text == null) // Check _submitted before showing the error
                Text(
                  'Please select document',
                  style: TextStyle(fontSize: 10, color: ColorManager.red),
                ),
            ],
          ),
        ),


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
                    errorText: _submitted && expiryDateController.text.isEmpty
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
                onTap: _pickFile,
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
                              child: Text(fileName, style: DocumentTypeDataStyle.customTextStyle(context)),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(4),
                              onPressed: _pickFile,
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
              if (_submitted && filePath == null) // Show error only if filePath is null and form is submitted
                Text(
                  'Please select document',
                  style: TextStyle(fontSize: 10, color: ColorManager.red),
                ),
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
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.add,
        onPressed: () async {
          setState(() {
            _submitted = true;
          });

          // if (filePath != null ) {
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
              var editResponse = await patchOthersDocumentData(
                  context: context,
                  fileName: fileName,
                  url: widget.url!,
                  employeeId: widget.employeeId,
                  expDate: expiryDateController.text,
                  ifOfDocument: documentTypeName.text,
                  createdAt: DateTime.now().toString(),
                  otherDocumentId: widget.otherDocId);
              if(isFilePicked) {
                await patchUploadOtherDoc(
                context: context,
                documentName: fileName,
                documentFile: filePath, otherDocId: widget.otherDocId!,
              );
              }else{

              }
              // var result = await singleBatchApproveOnboardAckHealthPatch(context, response.documentId!);
              if (editResponse.statusCode == 200 || editResponse.statusCode == 201) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddSuccessPopup(message: 'Document Edited Successfully');
                  },
                );
              }
              setState(() {
                load = true;
              });
            } finally {
              setState(() {
                load = true;
              });
            }
          //  else {
          //   print('Validation error');
          // }
        },
      ),
      title: widget.title,
    );
  }
}
