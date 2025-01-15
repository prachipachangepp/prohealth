import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employee_document_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/compensation_add_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:html' as html;
import 'package:flutter/material.dart';

import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/services/token/token_manager.dart';
import '../../../../../em_module/company_identity/widgets/error_pop_up.dart';
import '../../../../onboarding/download_doc_const.dart';

///download

class HRDocAckStyle {
  static TextStyle customTextStyle(BuildContext context) {
    double fontSize = 10;
    // MediaQuery.of(context).size.width / 130;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
  }
}

class AcknowledgementsChildBar extends StatelessWidget {
  final int employeeId;
  final String? fileUrl;
  final String? fileExtension;
   AcknowledgementsChildBar(
      {super.key, required this.employeeId, this.fileUrl, this.fileExtension});

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    final StreamController<List<OnboardingAckHealthData>> _controller =
    StreamController<List<OnboardingAckHealthData>>();
    TextEditingController acknowldgementNameController = TextEditingController();
    //print('Employee Id in documents :: ${controller.employeeId}');
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
                                  context, AppConfig.acknowledgementDocId),
                              builder: (contex, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  return AcknowledgementAddPopup(
                                    title: 'Add Acknowledgement',
                                    employeeId: employeeId,
                                    // docTypeMetaIdCC: 10,
                                    // selectedSubDocId: 48,
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
            stream: _controller.stream,
            builder: (context, snapshot) {
              getAckHealthRecord(context, AppConfig.acknowledgementDocId,
                      employeeId, 'no')
                  .then((data) {
                _controller.add(data);
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
                    padding: const EdgeInsets.symmetric(vertical: 120),
                    child: Text(
                      AppStringHRNoData.ackNoData,
                      style: AllNoDataAvailable.customTextStyle(context),
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var ackData = snapshot.data![index];
                      var fileUrl = ackData.DocumentUrl;
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
                            margin: EdgeInsets.symmetric(horizontal: 40),
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
                                        Text('ID:${ackData.idOfTheDocument}',
                                            style: AknowledgementStyleConst
                                                .customTextStyle(context)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(ackData.documentFileName,
                                            style: AknowledgementStyleNormal
                                                .customTextStyle(context)),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ///download
                                    // IconButton(
                                    //   onPressed: () async {
                                    //     final url = fileUrl; // Use the fileUrl from your data
                                    //     if (await canLaunchUrl(Uri.parse(url))) {
                                    //       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                                    //     } else {
                                    //       // Handle the error if the URL can't be launched
                                    //       print("Could not launch $url");
                                    //     }
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.save_alt_outlined,
                                    //     color: Color(0xff1696C8),
                                    //   ),
                                    //   iconSize: 20,
                                    // ),
                                    ///
                                    // IconButton(
                                    //   splashColor:
                                    //   Colors.transparent,
                                    //   highlightColor:
                                    //   Colors.transparent,
                                    //   hoverColor:
                                    //   Colors.transparent,
                                    //   onPressed: () async{
                                    //     try{
                                    //       final String token = await TokenManager.getAccessToken();
                                    //       var response = await http.get(Uri.file(ackData.DocumentUrl),headers: {
                                    //         'accept': 'application/json',
                                    //         'Authorization': 'Bearer $token',
                                    //         'Content-Type': 'application/json'
                                    //       },);
                                    //
                                    //       if (response.statusCode == 200) {
                                    //         final String content = response.body;
                                    //
                                    //         final pdf = pw.Document();
                                    //
                                    //         pdf.addPage(
                                    //           pw.Page(
                                    //             build: (pw.Context context) => pw.Center(
                                    //               child: pw.Text(content),
                                    //             ),
                                    //           ),
                                    //         );
                                    //
                                    //         await Printing.layoutPdf(
                                    //           onLayout: (PdfPageFormat format) async => pdf.save(),
                                    //         );
                                    //       } else {
                                    //         // Handle error
                                    //         print('Failed to load document');
                                    //       }
                                    //
                                    //     }catch(e){
                                    //       print('Error ${e}');
                                    //
                                    //     }
                                    //   },
                                    //   icon: const Icon(Icons.print_outlined,color: Color(0xff1696C8),),
                                    //   iconSize: 20,),
                                    ///
                                    /// prinnt
                                    // IconButton(
                                    //   splashColor: Colors.transparent,
                                    //   highlightColor: Colors.transparent,
                                    //   hoverColor: Colors.transparent,
                                    //   onPressed: () async {
                                    //     try {
                                    //       // Debug output
                                    //       print("File URL: $fileUrl");
                                    //       print("File Extension: $fileExtension");
                                    //
                                    //       if (fileUrl != null && fileExtension != null) {
                                    //         if (fileExtension!.toLowerCase().endsWith('.pdf')) {
                                    //           // Attempt to fetch the PDF
                                    //           var response = await http.get(Uri.parse(fileUrl!));
                                    //           // Check for successful response
                                    //           if (response.statusCode == 200) {
                                    //             // Handle PDF rendering
                                    //             Uint8List pdfBytes = response.bodyBytes;
                                    //
                                    //             await Printing.layoutPdf(
                                    //               onLayout: (PdfPageFormat format) async => pdfBytes,
                                    //             );
                                    //           } else {
                                    //             print('Failed to fetch document from URL: ${response.statusCode}');
                                    //           }
                                    //         } else {
                                    //           print('Unsupported file type for printing. Expected PDF, got: $fileExtension');
                                    //         }
                                    //       } else {
                                    //         print('File URL or extension is null');
                                    //       }
                                    //     } catch (e) {
                                    //       // Catch network-related errors
                                    //       print('Error occurred during printing: $e');
                                    //     }
                                    //   },
                                    //
                                    //   icon: Icon(
                                    //     Icons.print_outlined,
                                    //     color: Color(0xff1696C8),
                                    //   ),
                                    //   iconSize: 20,
                                    // ),

                                    // IconButton(
                                    //   splashColor: Colors.transparent,
                                    //   highlightColor: Colors.transparent,
                                    //   hoverColor: Colors.transparent,
                                    //   onPressed: () {
                                    //     if (fileUrl != null && fileExtension != null && fileExtension!.toLowerCase().endsWith('.pdf')) {
                                    //       // Open the PDF file in a new tab
                                    //       js.context.callMethod('open', [fileUrl]);
                                    //     } else {
                                    //       print('Invalid or unsupported file type');
                                    //     }
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.print_outlined,
                                    //     color: Color(0xff1696C8),
                                    //   ),
                                    //   iconSize: 20,
                                    // ),
                                    /// working
                                    // IconButton(
                                    //   splashColor: Colors.transparent,
                                    //   highlightColor: Colors.transparent,
                                    //   hoverColor: Colors.transparent,
                                    //   onPressed: () {
                                    //     if (fileUrl != null && fileExtension != null &&
                                    //         fileExtension!.toLowerCase().endsWith('.pdf')) {
                                    //       // Create an iframe to load the PDF file
                                    //       html.IFrameElement iframe = html.IFrameElement();
                                    //       iframe.src = fileUrl;
                                    //       iframe.style.display = 'none';
                                    //       html.document.body?.append(iframe);
                                    //
                                    //       // Wait for the PDF to load and trigger print
                                    //       iframe.onLoad.listen((event) {
                                    //         js.context.callMethod('print', []);
                                    //       });
                                    //     } else {
                                    //       print('Invalid or unsupported file type');
                                    //     }
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.print_outlined,
                                    //     color: Color(0xff1696C8),
                                    //   ),
                                    //   iconSize: 20,
                                    // ),
                                    ///
                                    IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onPressed: () {
                                        print("FileExtension:${fileExtension}");
                                        //DowloadFile().downloadPdfFromBase64(fileExtension,"Health.pdf");
                                        downloadFile(fileUrl);
                                      },
                                      icon: Icon(
                                        Icons.print_outlined,
                                        color: Color(0xff1696C8),
                                      ),
                                      iconSize: 20,
                                    ),
                                    PdfDownloadButton(apiUrl: ackData.DocumentUrl, documentName: ackData.documentFileName,),
                                    ///edit
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return FutureBuilder<EmployeeDocumentPrefillData>(
                                                  future: getPrefillEmployeeDocuments(
                                                          context: context,
                                                          empDocumentId: ackData
                                                              .employeeDocumentId),
                                                  builder: (context,
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
                                                            'Edit Acknowledgement',
                                                        employeeId:
                                                            employeeId,
                                                        docName: ackData
                                                            .DocumentName,
                                                        docMetaDataId: ackData
                                                            .EmployeeDocumentTypeMetaDataId,
                                                        docSetupId: ackData
                                                            .EmployeeDocumentTypeSetupId,
                                                        empDocumentId: ackData
                                                            .employeeDocumentId,
                                                        selectedExpiryType: ackData
                                                            .ReminderThreshold,
                                                        expiryDate:
                                                            snapshotPreFill
                                                                .data!.expiry,
                                                        url:
                                                            ackData.DocumentUrl,
                                                        documentFileName: ackData
                                                            .documentFileName,
                                                      );

                                                      // return CustomDocumedAddPopup(
                                                      //   title: 'Add Compensation', employeeId: widget.employeeId, dataList:snapshot.data! ,
                                                      // );
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
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      iconSize: 20,
                                    ),
                                    ///delete
                                    IconButton(
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
                                                      title:
                                                          'Delete Acknowledgement',
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
                                                              empDocumentId: ackData
                                                                  .employeeDocumentId);
                                                        } finally {
                                                          setState(() {
                                                            _isLoading = false;
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        }
                                                        // setState(() async{
                                                        //
                                                        //   Navigator.pop(context);
                                                        // });
                                                      },
                                                    );
                                                  },
                                                ));
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Color(0xffFF0000),
                                      ),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
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

// Function to handle printing
void printFile(String url) {
  // Create an IFrameElement to load the PDF
  final iframe = html.IFrameElement()
    ..src = url
    ..style.border = 'none'
    ..style.width = '0'
    ..style.height = '0';

  // Append the iframe to the document body
  html.document.body!.append(iframe);

  // Listen for the load event
  iframe.onLoad.listen((_) {
    // After the PDF is loaded, trigger the print dialog
    html.window.print();

    // Remove the iframe from the document after printing
    iframe.remove();
  });
}