import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/app/services/base64/download_file_base64.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employee_document_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/compensation_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/print_pdf_files_hr.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../em_module/company_identity/widgets/error_pop_up.dart';

class CompensationChildTabbar extends StatefulWidget {
  final int employeeId;
  final String? base64PdfString; // This should be your Base64 string
  final String? fileUrl;
  const CompensationChildTabbar(
      {super.key, required this.employeeId, this.fileUrl,  this.base64PdfString});

  @override
  State<CompensationChildTabbar> createState() =>
      _CompensationChildTabbarState();
}

class _CompensationChildTabbarState extends State<CompensationChildTabbar> {
  TextEditingController editCompensationIdController = TextEditingController();
  TextEditingController editCompensationNameController =
      TextEditingController();
  TextEditingController compensitionAddIdController = TextEditingController();
  TextEditingController compensitionAddNameController = TextEditingController();
  final StreamController<List<OnboardingAckHealthData>>
      _controllerCompensation =
      StreamController<List<OnboardingAckHealthData>>();
  String compensationExpiryType = '';
  final StreamController<List<EmployeeDocumentModal>> _controller =
      StreamController<List<EmployeeDocumentModal>>();
  String expiryType = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 60),
              child: CustomIconButtonConst(
                  width: 130,
                  text: AppStringHr.addNew,
                  icon: Icons.add,
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FutureBuilder<List<EmployeeDocSetupModal>>(
                              future: getEmployeeDocSetupDropDown(
                                  context, AppConfig.compensationDocId),
                              builder: (contex, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  return CustomDocumedAddPopup(
                                    title: 'Add Compensation',
                                    employeeId: widget.employeeId,
                                    dataList: snapshot.data!,
                                  );
                                } else {
                                  return ErrorPopUp(
                                      title: "Received Error",
                                      text: snapshot.error.toString());
                                }
                              });
                        });
                    //showDialog(context: context, builder: (context)=> AcknowledgementsAddPopup());
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder(
            stream: _controllerCompensation.stream,
            builder: (context, snapshot) {
              getAckHealthRecord(context, AppConfig.compensationDocId,
                      widget.employeeId, 'no')
                  .then((data) {
                _controllerCompensation.add(data);
              }).catchError((error) {
                // Handle error
              });
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: CircularProgressIndicator(
                      color: ColorManager.blueprime,
                    ),
                  ),
                );
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Text(
                      AppStringHRNoData.compensationNoData,
                      style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s14,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var compaensation = snapshot.data![index];
                      var fileUrl = compaensation.DocumentUrl;
                      final fileExtension = fileUrl.split('/').last;

                      Widget fileWidget;

                      if (['jpg', 'jpeg', 'png', 'gif']
                          .contains(fileExtension)) {
                        fileWidget = Image.network(
                          fileUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 45,
                              color: ColorManager.faintGrey,
                            );
                          },
                        );
                      } else if (['pdf', 'doc', 'docx']
                          .contains(fileExtension)) {
                        fileWidget = Icon(
                          Icons.description,
                          size: 45,
                          color: ColorManager.faintGrey,
                        );
                      } else {
                        fileWidget = Icon(
                          Icons.insert_drive_file,
                          size: 45,
                          color: ColorManager.faintGrey,
                        );
                      }
                      return Column(
                        children: [
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 100),
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.25),
                                  //spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            height: 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 62,
                                        height: 45,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 2,
                                              color: ColorManager.faintGrey),
                                        ),
                                        child:
                                            Image.asset('images/Vector.png')),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'ID:${compaensation.idOfTheDocument}',
                                            style: AknowledgementStyleConst
                                                .customTextStyle(context)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(compaensation.documentFileName,
                                            style: AknowledgementStyleNormal
                                                .customTextStyle(context)),
                                      ],
                                    )
                                  ],
                                ),
                                //SizedBox(width: MediaQuery.of(context).size.width/2.2,),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [

                                    ///
                                    IconButton(
                                      onPressed: () {
                                        print("FileExtension:${fileExtension}");
                                        DowloadFile().downloadPdfFromBase64(
                                            fileExtension, "Compensation.pdf");
                                        downloadFile(fileUrl);
                                        // DowloadFile().downloadPdfFromBase64(fileExtension,"Compensation");
                                      },
                                      icon: Icon(
                                        Icons.print_outlined,
                                        color: Color(0xff1696C8),
                                      ),
                                      iconSize: 20,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                    ),
                                   // PdfDownloadButton(apiUrl: compaensation.DocumentUrl),
                                    ///
                                    IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return FutureBuilder<
                                                      EmployeeDocumentPrefillData>(
                                                  future: getPrefillEmployeeDocuments(
                                                      context: context,
                                                      empDocumentId: compaensation
                                                          .employeeDocumentId),
                                                  builder: (contex,
                                                      snapshotPreFill) {
                                                    if (snapshotPreFill
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    }
                                                    if (snapshotPreFill
                                                        .hasData) {
                                                      return CustomDocumedEditPopup(
                                                        labelName:
                                                            'Edit Compensation',
                                                        employeeId:
                                                            widget.employeeId,
                                                        docName: compaensation
                                                            .DocumentName,
                                                        docMetaDataId: compaensation
                                                            .EmployeeDocumentTypeMetaDataId,
                                                        docSetupId: compaensation
                                                            .EmployeeDocumentTypeSetupId,
                                                        empDocumentId: compaensation
                                                            .employeeDocumentId,
                                                        selectedExpiryType:
                                                            compaensation
                                                                .ReminderThreshold,
                                                        url: compaensation
                                                            .DocumentUrl,
                                                        expiryDate:
                                                            snapshotPreFill
                                                                .data!.expiry,
                                                        documentFileName:
                                                            compaensation
                                                                .documentFileName,
                                                      );
                                                    } else {
                                                      return ErrorPopUp(
                                                          title:
                                                              "Received Error",
                                                          text: snapshot.error
                                                              .toString());
                                                    }
                                                  });
                                            });
                                      },
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        color: Color(0xff1696C8),
                                      ),
                                      iconSize: 20,
                                    ),
                                    IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onPressed: () async {
                                        await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                StatefulBuilder(
                                                  builder: (BuildContext
                                                          context,
                                                      void Function(
                                                              void Function())
                                                          setState) {
                                                    return DeletePopup(
                                                      loadingDuration:
                                                          _isLoading,
                                                      onCancel: () {
                                                        Navigator.pop(context);
                                                      },
                                                      onDelete: () async {
                                                        setState(() {
                                                          _isLoading = true;
                                                        });
                                                        try {
                                                          await deleteEmployeeDocuments(
                                                              context: context,
                                                              empDocumentId:
                                                                  compaensation
                                                                      .employeeDocumentId);
                                                        } finally {
                                                          setState(() {
                                                            _isLoading = false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                        // setState(() async{
                                                        //
                                                        //   Navigator.pop(context);
                                                        // });
                                                      },
                                                      title:
                                                          'Delete Compensation',
                                                    );
                                                  },
                                                ));
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Color(0xffFF0000),
                                      ),
                                      iconSize: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              return SizedBox();
            }),
      ],
    );
  }
}

/// Fetch Base64 PDF string from the given URL
Future<String> fetchBase64FromS3(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body; // Assuming the response body is Base64-encoded
  } else {
    throw Exception("Failed to fetch Base64 data from S3");
  }
}


/// /// Print PDF from Base64 string
Future<void> printPdfFromBase64(String base64String) async {
  // Decode the Base64 string
  final bytes = base64Decode(base64String);

  // Create a PDF document from the bytes
  final pdf = pw.Document();
  pdf.addPage(pw.Page(build: (pw.Context context) {
    return pw.Center(child: pw.Text('Your PDF Content Here'));
  }));

  // Print the PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => bytes,
  );
}






