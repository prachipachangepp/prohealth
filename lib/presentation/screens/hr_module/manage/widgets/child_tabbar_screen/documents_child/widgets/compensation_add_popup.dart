

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
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


class CustomDocumedAddPopup extends StatefulWidget {
  final String labelName;
  final TextEditingController AcknowledgementnameController;
  final VoidCallback onSavePressed;
  final int employeeId;
  final int documentMetaId;
  final int documentSetupId;

  const CustomDocumedAddPopup({
    Key? key,
    required this.labelName,
    required this.AcknowledgementnameController,
    required this.onSavePressed, required this.employeeId, required this.documentMetaId, required this.documentSetupId,
  }) : super(key: key);

  @override
  _CustomDocumedAddPopupState createState() => _CustomDocumedAddPopupState();
}

class _CustomDocumedAddPopupState extends State<CustomDocumedAddPopup> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDocumentType;
  bool _documentUploaded = true;
  dynamic finalPath;
  int documentMetaDataId = 0;
  int documentSetupId = 0;
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
                      style: DocumentTypeDataStyle.customTextStyle(context),
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
                      style: PopupCompStyle.customTextStyle(context)
                    ),
                    SizedBox(height: 3),
                    FutureBuilder<List<EmployeeDocSetupModal>>(
                        future: getEmployeeDocSetupDropDown(context),
                        builder: (context,snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Container(
                              width: 350,
                              height: 30,
                              decoration: BoxDecoration(color: ColorManager.white,borderRadius: BorderRadius.circular(10)),
                            );

                          }
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                AppString.dataNotFound,
                                style: CustomTextStylesCommon.commonStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.s12,
                                  color: ColorManager.mediumgrey,
                                ),
                              ),
                            );
                          }
                          if(snapshot.hasData){
                            List dropDown = [];
                            int docType = 0;
                            List<DropdownMenuItem<String>> dropDownMenuItems = [];
                            for(var i in snapshot.data!){
                              dropDownMenuItems.add(
                                DropdownMenuItem<String>(
                                  child: Text(i.documentName),
                                  value: i.documentName,
                                ),
                              );
                            }
                            return StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return  CICCDropdown(
                                    initialValue: dropDownMenuItems[0].value,
                                    onChange: (val){
                                      for(var a in snapshot.data!){
                                        if(a.documentName == val){
                                          documentMetaDataId = a.employeeDocMetaDataId;
                                          documentSetupId = a.employeeDocTypeSetupId;
                                          //docMetaId = docType;
                                        }
                                      }
                                      print(":::${docType}");
                                      //print(":::<>${docMetaId}");
                                    },
                                    items:dropDownMenuItems
                                );
                              },
                            );
                          }else{
                            return SizedBox();
                          }
                        }
                    ),
                    SizedBox(height: AppSize.s20),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                        );
                        if (result != null) {
                          PlatformFile file = result.files.first;
                          finalPath = result.files.first.bytes;
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
                  onPressed: () async{
                    if (_formKey.currentState!.validate() && widget.AcknowledgementnameController.text.isNotEmpty) {
                      var response = await uploadDocuments(context: context, employeeDocumentMetaId:documentMetaDataId, employeeDocumentTypeSetupId: documentSetupId,
                      employeeId: widget.employeeId, documentName: widget.AcknowledgementnameController.text,
                      documentFile: finalPath);
                      if(response.statusCode == 200 || response.statusCode == 201) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Future.delayed(Duration(seconds: 2), () {
                              if (Navigator.of(context).canPop()) {
                                Navigator.of(context).pop();
                              }
                            });
                            return AddSuccessPopup(message: 'Document Uploded',);
                          },
                        );
                      }else{
                        print('Error');
                      }
                      Navigator.pop(context);
                      widget.AcknowledgementnameController.clear();
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




///

class AcknowledgementAddPopuppp extends StatefulWidget {
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
  AcknowledgementAddPopuppp({
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
  State<AcknowledgementAddPopuppp> createState() => _AcknowledgementAddPopupppState();
}

class _AcknowledgementAddPopupppState extends State<AcknowledgementAddPopuppp> {
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
                initialValue: 'Select Document',
                onChange: (val){

                  setState((){
                    showExpiryDateField = false;

                    for(var a in widget.dataList!){
                      if(a.documentName == val){
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
                items:dropDownMenuItems
            )
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
                      hintStyle:  DocumentTypeDataStyle.customTextStyle(context),
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
        HeaderContentConst(
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
        onPressed: () async{
          try{
            //File filePath = File(finalPath!);
            String? expiryDate;
            if (expiryDateController.text.isEmpty) {
              expiryDate = null;
            } else {
              expiryDate = datePicked!.toIso8601String() + "Z";
            }
            var response  = await uploadDocuments(context: context, employeeDocumentMetaId: documentMetaDataId, employeeDocumentTypeSetupId: documentSetupId,
                employeeId: widget.employeeId, documentName: documentTypeName,
                documentFile: filePath,expiryDate: expiryDate);
            if(response.statusCode == 200 || response.statusCode == 201) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddSuccessPopup(message: 'Document Uploded',);
                },
              );
            }
            else{
              print('Error');
            }
          }catch(e){
            print(e);
          }
        },
      ),
      title: widget.title,
    );
  }
}