import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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

import '../../../../../../../../app/resources/theme_manager.dart';
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

class AcknowledgementsChildBar extends StatefulWidget {
  final int employeeId;
  const AcknowledgementsChildBar({super.key, required this.employeeId});

  @override
  State<AcknowledgementsChildBar> createState() =>
      _AcknowledgementsChildBarState();
}

class _AcknowledgementsChildBarState extends State<AcknowledgementsChildBar> {
  final StreamController<List<OnboardingAckHealthData>> _controller =
      StreamController<List<OnboardingAckHealthData>>();
  TextEditingController acknowldgementNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getAckHealthRecord(context, AppConfig.acknowledgementDocId, widget.employeeId, "no").then((data) {
      _controller.add(data);
    }).catchError((error) {
      // Handle error
    });
  }
bool _isLoading =false;
  @override
  Widget build(BuildContext context) {
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
                              future: getEmployeeDocSetupDropDown(context,AppConfig.acknowledgementDocId),
                              builder: (contex, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  return AcknowledgementAddPopup(
                                    title: 'Add Acknowledgement',
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
          height: 30,
        ),
        StreamBuilder(
            stream: _controller.stream,
            builder: (context,snapshot) {
              getAckHealthRecord(context, AppConfig.acknowledgementDocId,widget.employeeId,'no').then((data) {
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
                      var ackData = snapshot.data![index];
                      var fileUrl = ackData.DocumentUrl;
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
                                        Text('ID:${ackData.idOfTheDocument}',
                                            style:AknowledgementStyleConst.customTextStyle(context)),
                                        SizedBox(height: 5,),
                                        Text(ackData.documentFileName,
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
                                                  future: getPrefillEmployeeDocuments( context: context, empDocumentId: ackData.employeeDocumentId),
                                                  builder: (context, snapshotPreFill) {
                                                    if (snapshotPreFill.connectionState ==
                                                        ConnectionState.waiting) {
                                                      return Center(
                                                          child: CircularProgressIndicator());
                                                    }
                                                    if (snapshotPreFill.hasData) {
                                                      return CustomDocumedEditPopup(
                                                        labelName: 'Edit Acknowledgement',
                                                        employeeId: widget.employeeId,
                                                        docName: ackData.DocumentName,
                                                        docMetaDataId: ackData.EmployeeDocumentTypeMetaDataId,
                                                        docSetupId: ackData.EmployeeDocumentTypeSetupId,
                                                        empDocumentId: ackData.employeeDocumentId,
                                                        selectedExpiryType: ackData.ReminderThreshold,
                                                        expiryDate: snapshotPreFill.data!.expiry,
                                                        url: ackData.DocumentUrl,
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
                                              loadingDuration: _isLoading,
                                              title: 'Delete Acknowledgement',
                                              onCancel: (){
                                                Navigator.pop(context);
                                              }, onDelete: () async{
                                              setState(() {
                                                _isLoading = true;
                                              });
                                              try{
                                                await deleteEmployeeDocuments(context: context, empDocumentId: ackData.employeeDocumentId);
                                              }finally{
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                Navigator.pop(context);
                                              }
                                              // setState(() async{
                                              //
                                              //   Navigator.pop(context);
                                              // });
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

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
