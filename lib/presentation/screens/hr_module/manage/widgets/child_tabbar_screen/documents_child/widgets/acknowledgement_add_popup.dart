
import 'dart:io';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/header_content_const.dart';

class WebFile{
final html.File file;
final String url;
WebFile(this.file,this.url);

void dispose()
{
  print("File $file");
  html.Url.revokeObjectUrl(url);
}}

///

class AcknowledgementAddPopup extends StatelessWidget {
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
  AcknowledgementAddPopup({
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

    String documentTypeName = "";
    TextEditingController expiryDateController = TextEditingController();
    DateTime? datePicked;
    final ackProviderState = Provider.of<HrManageProvider>(
      context, listen: false,);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ackProviderState.loadDropDown(dataList);
      ackProviderState.clearAddedValue();
    });

    return
      Consumer<HrManageProvider>(
        builder: (context,loaderProvider,child) {
          return DialogueTemplate(
            width: AppSize.s420,
            height: height == null ? AppSize.s400 : height!,
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
                    padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      'No available document',
                      style: DocumentTypeDataStyle.customTextStyle(context),
                    ),
                  ),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CICCDropdown(
                      width: 354,
                      initialValue: "Select Document",
                      onChange: (val) {
                        // setState(() {
                        //showExpiryDateField = false;
                        for (var a in dataList!) {
                          if (a.documentName == val) {
                            documentMetaDataId = a.employeeDocMetaDataId;
                            documentSetupId = a.employeeDocTypeSetupId;
                            documentTypeName = a.documentName;
                            if (a.reminderThreshould == AppConfig.issuer) {
                              loaderProvider.showExpDateFieldAck();
                              loaderProvider.listenData();
                            }else{
                              loaderProvider.showExpDateFieldAckFalse();
                            }
                          }
                        }
                        // });
                      },
                      items: ackProviderState.dropDownMenuItems,
                    ),
                    SizedBox(height: 2),
                    loaderProvider.isFormSubmitted && documentTypeName == "" ?
                      Text(
                        'Please select document',
                        style: TextStyle(
                            fontSize: 10, color: ColorManager.red),
                      ):SizedBox(height: 12,),
                  ],
                ),
              ),
              Visibility(
                visible: loaderProvider.showAddAckExpiryDateField,
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
                            hintStyle:
                            DocumentTypeDataStyle.customTextStyle(context),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  width: 1, color: ColorManager.fmediumgrey),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                            if (loaderProvider.isFormSubmitted && (value == null || value.isEmpty)) {
                              return 'Please select date';
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                  visible: loaderProvider.showAddAckExpiryDateField,
                  child: SizedBox(height:12)),

              /// Upload document section...
              HeaderContentConst(
                isAsterisk: true,
                heading: AppString.upload_document,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: loaderProvider.pickAckFile,
                      child: Container(
                        height: AppSize.s30,
                        width: AppSize.s354,
                        padding: EdgeInsets.only(left: AppPadding.p10),
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
                                      loaderProvider.fileName,
                                      style: DocumentTypeDataStyle.customTextStyle(
                                          context),
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.all(4),
                                    onPressed: loaderProvider.pickAckFile,
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
                    SizedBox(height: 2),
                    loaderProvider.isFormSubmitted && ackProviderState.filePath == null ?
                      Text(
                        'Please Upload document',
                        style: TextStyle(fontSize: 10, color: ColorManager.red),
                      ):SizedBox(height: 12,)
                  ],
                ),
              ),
            ],
            bottomButtons: loaderProvider.load
                ? SizedBox(
              height: AppSize.s30,
              width: AppSize.s30,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
                : CustomElevatedButton(
              width: AppSize.s105,
              height: AppSize.s30,
              text: AppStringEM.add,
              onPressed: () async {
                loaderProvider.isFormSubmited();
                // setState(() {
                //   isFormSubmitted = true;
                // });

                if (documentTypeName == "" || ackProviderState.filePath == null ||
                    expiryDateController.text.isEmpty && ackProviderState.showAddAckExpiryDateField) {
                  return;
                }
                loaderProvider.loaderTrue();
                // setState(() {
                //   load = true;
                // });

                String? expiryDate;
                if (expiryDateController.text.isEmpty) {
                  expiryDate = null;
                } else {
                  expiryDate = datePicked!.toIso8601String() + "Z";
                }

                try {
                  print("empdocid: $documentMetaDataId");
                  print("documentSetupId: $documentSetupId");
                  print("empdocid: $employeeId");
                  print("ackProviderState.fileName: $ackProviderState.fileName");
                  print("ackProviderState.filePath: $ackProviderState.filePath");
                  print("expiryDate: $expiryDate");
                  if (ackProviderState.fileAbove20Mb) {
                    var response = await uploadDocuments(
                      context: context,
                      employeeDocumentMetaId: documentMetaDataId,
                      employeeDocumentTypeSetupId: documentSetupId,
                      employeeId: employeeId,
                      documentName: ackProviderState.fileName,
                      documentFile: ackProviderState.filePath,
                      expiryDate: expiryDate,
                    );
                    var result = await singleBatchApproveOnboardAckHealthPatch(
                        context, response.documentId!);
                    if (result.statusCode == 200 || result.statusCode == 201) {
                      ackProviderState.clearAddedValue();
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddSuccessPopup(
                            message: 'Document Uploaded Successfully',
                          );
                        },
                      );
                    }
                    if (response.statusCode == 413) {
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
                } finally {
                  loaderProvider.loaderFalse();
                }
              },
            ),
            title: title,
          );
        }
      );

    ///
    //   DialogueTemplate(
    //   width: AppSize.s420,
    //   height: widget.height == null ? AppSize.s390 : widget.height!,
    //   body: [
    //     HeaderContentConst(
    //       heading: AppString.type_of_the_document,
    //       content: widget.dataList.isEmpty?Container(
    //           width: 354,
    //           height:30,
    //           decoration: BoxDecoration(
    //             border: Border.all(color: ColorManager.containerBorderGrey, width: AppSize.s1),
    //             borderRadius: BorderRadius.circular(4),
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
    //             child: Text('No available document',style: DocumentTypeDataStyle.customTextStyle(context),),
    //           )):Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           CICCDropdown(
    //             width: 354,
    //               initialValue: "Select Document",
    //               onChange: (val){
    //                 setState((){
    //                   showExpiryDateField = false;
    //                   for(var a in widget.dataList!){
    //                     if(a.documentName == val){
    //                       documentMetaDataId = a.employeeDocMetaDataId;
    //                       documentSetupId = a.employeeDocTypeSetupId;
    //                       //docMetaId = docType;
    //                       documentTypeName = a.documentName;
    //                       if (a.reminderThreshould == AppConfig.issuer) {
    //                         showExpiryDateField = true;
    //                       }
    //                     }
    //                   }
    //                 });
    //                // print(":::${docType}");
    //                //  print(":::<>${docMetaId}");
    //               },
    //               items:dropDownMenuItems
    //           ),
    //           SizedBox(height: 2,),
    //           if(documentTypeName == "")
    //           Text('Please select document',style: TextStyle(fontSize: 10,color: ColorManager.red))
    //         ],
    //       )
    //     ),
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
    //                   hintStyle:  DocumentTypeDataStyle.customTextStyle(context),
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
    //     height: AppSize.s25,
    //     width: AppSize.s25,
    //     child: CircularProgressIndicator(
    //       color: ColorManager.blueprime,
    //     ),
    //   )
    //       : CustomElevatedButton(
    //     width: AppSize.s105,
    //     height: AppSize.s30,
    //     text: AppStringEM.add,
    //     onPressed: () async{
    //       setState(() {
    //         load = true;
    //       });
    //       String? expiryDate;
    //       if (expiryDateController.text.isEmpty) {
    //         expiryDate = null;
    //       } else {
    //         expiryDate = datePicked!.toIso8601String() + "Z";
    //       }
    //       try{
    //         //File filePath = File(finalPath!);
    //         var response  = await uploadDocuments(context: context, employeeDocumentMetaId: documentMetaDataId, employeeDocumentTypeSetupId: documentSetupId,
    //             employeeId: widget.employeeId, documentName: fileName,
    //             documentFile: filePath,expiryDate:expiryDate);
    //
    //         if(response.statusCode == 200 || response.statusCode == 201) {
    //           Navigator.pop(context);
    //           showDialog(
    //             context: context,
    //             builder: (BuildContext context) {
    //               return AddSuccessPopup(message: 'Document Uploded',);
    //             },
    //           );
    //         }
    //         setState(() {
    //           load = false;
    //         });
    //       }finally{
    //         setState(() {
    //           load = false;
    //         });
    //       }
    //     },
    //   ),
    //   title: widget.title,
    // );
  }
}
