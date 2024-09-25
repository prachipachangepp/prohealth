import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_ack_health_manager.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/employee_doc_repository.dart';
import 'package:prohealth/app/services/base64/download_file_base64.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employee_document_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/compensation_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/health_record_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../em_module/company_identity/widgets/error_pop_up.dart';
class AdditionalVaccinationsChildBar extends StatefulWidget {
  final int employeeId;
  const AdditionalVaccinationsChildBar({super.key, required this.employeeId});

  @override
  State<AdditionalVaccinationsChildBar> createState() => _AdditionalVaccinationsChildBarState();
}

class _AdditionalVaccinationsChildBarState extends State<AdditionalVaccinationsChildBar> {
  TextEditingController editIdController = TextEditingController();
  TextEditingController nameIdController = TextEditingController();
  TextEditingController healthRecordAddIdController = TextEditingController();
  TextEditingController healthRecordAddNameController = TextEditingController();
  final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
  String expiryType ='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  int documentMetaDataId = 0;
  int documentSetupId = 0;
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
                  width: 100,
                  text: AppStringHr.addNew,
                  icon: Icons.add,
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return FutureBuilder<List<EmployeeDocSetupModal>>(
                              future: getEmployeeDocSetupDropDown(context),
                              builder: (contex, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  return CustomDocumedAddPopup(
                                    title: 'Add Health Record',
                                    employeeId: widget.employeeId,
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
          builder: (context,snapshot) {
            getAckHealthRecord(context, 1,10,widget.employeeId,'no').then((data) {
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
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Text(
                    AppStringHRNoData.healthNoData,
                    style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s12,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                ),
              );
            }
            if(snapshot.hasData){

              return Container(
                height: MediaQuery.of(context).size.height/1,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var health = snapshot.data![index];
                    var fileUrl = health.DocumentUrl;
                    final fileExtension = fileUrl.split('/').last;

                    Widget fileWidget;

                    if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
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
                    }
                    else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
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
                          padding: EdgeInsets.only(top: 5,bottom:5, left: 10,right: 100),
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            color:Colors.white,
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
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(width: 2,color:ColorManager.faintGrey),
                                      ),
                                      child: Image.asset('images/Vector.png')),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('ID:${health.idOfTheDocument}',
                                          style:AknowledgementStyleConst.customTextStyle(context)),
                                      SizedBox(height: 5,),
                                      Text(health.documentFileName,
                                          style: AknowledgementStyleNormal.customTextStyle(context)),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  IconButton(
                                    splashColor:
                                    Colors.transparent,
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor:
                                    Colors.transparent,
                                    onPressed: () {
                                      print("FileExtension:${fileExtension}");
                                      //DowloadFile().downloadPdfFromBase64(fileExtension,"Health.pdf");
                                      downloadFile(fileUrl);
                                    },
                                    icon: Icon(Icons.save_alt_outlined,color: Color(0xff1696C8),),
                                    iconSize: 20,),
                                  ///
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {

                                            return FutureBuilder<EmployeeDocumentPrefillData>(
                                                future: getPrefillEmployeeDocuments( context: context, empDocumentId: health.employeeDocumentId),
                                                builder: (contex, snapshotPreFill) {
                                                  if (snapshot.connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child: CircularProgressIndicator());
                                                  }
                                                  if (snapshot.hasData) {
                                                    return CustomDocumedEditPopup(
                                                      labelName: 'Edit Health Record',
                                                      employeeId: widget.employeeId,
                                                      docName: health.DocumentName,
                                                      docMetaDataId: health.EmployeeDocumentTypeMetaDataId,
                                                      docSetupId: health.EmployeeDocumentTypeSetupId,
                                                      empDocumentId: health.employeeDocumentId,
                                                      selectedExpiryType: health.ReminderThreshold,
                                                      expiryDate: snapshotPreFill.data!.expiry,
                                                      url: health.DocumentUrl,
                                                    );


                                                    // return CustomDocumedAddPopup(
                                                    //   title: 'Add Compensation', employeeId: widget.employeeId, dataList:snapshot.data! ,
                                                    // );
                                                  } else {
                                                    return ErrorPopUp(
                                                        title: "Received Error",
                                                        text: snapshot.error.toString());
                                                  }
                                                });
                                            // return CustomDocumedAddPopup(
                                            //   // idController: compensitionAddIdController,
                                            //   // nameController: compensitionAddNameController,
                                            //   // expiryType: compensationExpiryType,
                                            //   labelName: 'Edit Health Record',
                                            //   AcknowledgementnameController:
                                            //   nameIdController, onSavePressed: () {  },
                                            //   employeeId: widget.employeeId,
                                            //   documentMetaId: 1,
                                            //   documentSetupId: 10,
                                            // );
                                          });
                                    },
                                    icon: Icon(Icons.edit_outlined,color: Color(0xff1696C8),),
                                    splashColor:
                                    Colors.transparent,
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor:
                                    Colors.transparent,
                                    iconSize: 20,),
                                  IconButton(
                                    onPressed: () async{
                                      await showDialog(context: context,
                                          builder: (context) => DeletePopup(
                                            title: 'Delete Health',
                                              onCancel: (){
                                                Navigator.pop(context);
                                              }, onDelete: (){
                                            setState(() async{
                                              await deleteEmployeeDocuments(context: context, empDocumentId: health.employeeDocumentId);
                                              Navigator.pop(context);
                                            });
                                          },
                                          )
                                      );
                                    },
                                    icon: Icon(Icons.delete_outline,color: Color(0xffFF0000),),
                                    splashColor:
                                    Colors.transparent,
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor:
                                    Colors.transparent,
                                    iconSize: 20,),
                                ],)
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
          }
        ),
      ],
    );
  }
}
// IconButton(
//   onPressed: () {
//   },
//   icon: Icon(Icons.refresh_outlined,color: Color(0xff1696C8),),
//   iconSize: 20,),
// IconButton(
//   onPressed: () async {
//    // final pdf = health.DocumentUrl as pw.Document;
//     try{
//       final String token = await TokenManager.getAccessToken();
//       var response = await http.get(Uri.file(health.DocumentUrl),headers: {
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
//
//
//     // pdf.addPage(
//     //   pw.Page(
//     //     build: (pw.Context context) => pw.Center(
//     //       child: pw.Text('Hello, this is a test print!'),
//     //     ),
//     //   ),
//     // );
//     //
//     // await Printing.layoutPdf(
//     //   onLayout: (PdfPageFormat format) async => pdf.save(),
//     // );
//   },
//   icon: Icon(Icons.print_outlined,color: Color(0xff1696C8),),
//
//iconSize: 20,),