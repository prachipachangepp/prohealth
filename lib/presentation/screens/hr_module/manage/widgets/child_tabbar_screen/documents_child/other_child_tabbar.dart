import 'dart:async';

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
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/compensation_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/other_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../em_module/company_identity/widgets/error_pop_up.dart';
class OtherChildTabbar extends StatefulWidget {
  final int employeeId;
  const OtherChildTabbar({super.key, required this.employeeId});

  @override
  State<OtherChildTabbar> createState() => _OtherChildTabbarState();
}

class _OtherChildTabbarState extends State<OtherChildTabbar> {
  TextEditingController otherEditIdController = TextEditingController();
  TextEditingController otherEditNameController = TextEditingController();
  TextEditingController otherAddIdController = TextEditingController();
  TextEditingController otherAddNameController = TextEditingController();
  final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //
        //     Container(
        //       margin: EdgeInsets.only(right: 60),
        //       child: CustomIconButtonConst(
        //           width: 130,
        //           text: AppStringHr.addNew,
        //           icon: Icons.add,
        //           onPressed: () async {
        //             showDialog(
        //                 context: context,
        //                 builder: (context) {
        //                   return FutureBuilder<List<EmployeeDocSetupModal>>(
        //                       future: getEmployeeDocSetupDropDown(context,AppConfig.clinicalVerificationDocId),
        //                       builder: (context, snapshot) {
        //                         if (snapshot.connectionState ==
        //                             ConnectionState.waiting) {
        //                           return Center(
        //                               child: CircularProgressIndicator());
        //                         }
        //                         if (snapshot.hasData) {
        //                           return CustomDocumedAddPopup(
        //                             title: 'Add Other Document', employeeId: widget.employeeId, dataList:snapshot.data! ,
        //                           );
        //                         } else {
        //                           return ErrorPopUp(
        //                               title: "Received Error",
        //                               text: snapshot.error.toString());
        //                         }
        //                       });
        //                 });
        //             //showDialog(context: context, builder: (context)=> AcknowledgementsAddPopup());
        //           }),
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder(
          stream: _controller.stream,
          builder: (BuildContext context, snapshot) {
            getAckHealthRecord(context, AppConfig.clinicalVerificationDocId,widget.employeeId,'no').then((data) {
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
                    AppStringHRNoData.othersnNoData,
                    style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s14,
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
                    var others = snapshot.data![index];
                    var fileUrl = others.DocumentUrl;
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
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.only(top: 5,bottom:5, left: 10,right: 100),
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            color:Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                //spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 5),
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
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(width: 2,color: ColorManager.faintGrey),
                                      ),
                                      child: Image.asset('images/Vector.png') ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('ID:${others.idOfTheDocument}',
                                          style:AknowledgementStyleConst.customTextStyle(context)),
                                      const SizedBox(height: 5,),
                                       Text(others.documentFileName,
                                           style: AknowledgementStyleNormal.customTextStyle(context)),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                    },
                                    splashColor:
                                    Colors.transparent,
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor:
                                    Colors.transparent,
                                    icon: const Icon(Icons.refresh_outlined,color: Color(0xff1696C8),),
                                    iconSize: 20,),
                                  IconButton(
                                    splashColor:
                                    Colors.transparent,
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor:
                                    Colors.transparent,
                                    onPressed: () async{
                                      try{
                                        final String token = await TokenManager.getAccessToken();
                                        var response = await http.get(Uri.file(others.DocumentUrl),headers: {
                                          'accept': 'application/json',
                                          'Authorization': 'Bearer $token',
                                          'Content-Type': 'application/json'
                                        },);

                                        if (response.statusCode == 200) {
                                          final String content = response.body;

                                          final pdf = pw.Document();

                                          pdf.addPage(
                                            pw.Page(
                                              build: (pw.Context context) => pw.Center(
                                                child: pw.Text(content),
                                              ),
                                            ),
                                          );

                                          await Printing.layoutPdf(
                                            onLayout: (PdfPageFormat format) async => pdf.save(),
                                          );
                                        } else {
                                          // Handle error
                                          print('Failed to load document');
                                        }

                                      }catch(e){
                                        print('Error ${e}');

                                      }
                                    },
                                    icon: const Icon(Icons.print_outlined,color: Color(0xff1696C8),),
                                    iconSize: 20,),
                                  IconButton(
                                    splashColor:
                                    Colors.transparent,
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor:
                                    Colors.transparent,
                                    onPressed: () {
                                      DowloadFile().downloadPdfFromBase64(fileExtension,"Other");
                                      downloadFile(fileUrl);
                                    },
                                    icon: const Icon(Icons.save_alt_outlined,color: Color(0xff1696C8),),
                                    iconSize: 20,),
                                  IconButton(
                                    splashColor:
                                    Colors.transparent,
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor:
                                    Colors.transparent,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return FutureBuilder<EmployeeDocumentPrefillData>(
                                                future: getPrefillEmployeeDocuments( context: context, empDocumentId: others.employeeDocumentId),
                                                builder: (context, snapshotPreFill) {
                                                  if (snapshotPreFill.connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child: CircularProgressIndicator());
                                                  }
                                                  if (snapshotPreFill.hasData) {
                                                    return CustomDocumedEditPopup(
                                                      labelName: 'Edit Other Document', employeeId: widget.employeeId, docName: others.DocumentName,
                                                      docMetaDataId: others.EmployeeDocumentTypeMetaDataId, docSetupId: others.EmployeeDocumentTypeSetupId, empDocumentId: others.employeeDocumentId,
                                                      selectedExpiryType: others.ReminderThreshold, url: others.ReminderThreshold,expiryDate: snapshotPreFill.data!.expiry, documentFileName: others.documentFileName,
                                                    );
                                                  } else {
                                                    return ErrorPopUp(
                                                        title: "Received Error",
                                                        text: snapshot.error.toString());
                                                  }
                                                });
                                          });
                                    },
                                    icon: const Icon(Icons.edit_outlined,color: Color(0xff1696C8),),
                                    iconSize: 20,),
                                  IconButton(
                                    splashColor:
                                    Colors.transparent,
                                    highlightColor:
                                    Colors.transparent,
                                    hoverColor:
                                    Colors.transparent,
                                    onPressed: () async{
                                      await showDialog(
                                      context: context,
                                      builder: (context) =>
                                          StatefulBuilder(
                                            builder: (BuildContext context, void Function(void Function()) setState) {
                                              return DeletePopup(onCancel: () {
                                                Navigator.pop(context);
                                              }, onDelete: () {
                                                setState(() async {
                                                  await deleteEmployeeDocuments(context: context, empDocumentId: others.employeeDocumentId);
                                                  Navigator.pop(context);
                                                });
                                              }, title: 'Delete Document',);
                                            },
                                          ));
                                    },
                                    icon: const Icon(Icons.delete_outline,color: Color(0xffFF0000),),
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

          },
        ),
      ],
    );

  }
}
