import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/clinical_licenses_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/clinical_license_data.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/compensation_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';

class ClinicalLicensesDoc extends StatelessWidget {
  final int employeeId;
  const ClinicalLicensesDoc({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context) {
    final StreamController<List<ClinicalLicenseDataModel>> drivingLicenseController =
    StreamController<List<ClinicalLicenseDataModel>>();
    final StreamController<List<PractitionerLicenseDataModel>> practitionerLicenseController =
    StreamController<List<PractitionerLicenseDataModel>>();
    bool _isLoading = false;
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
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
        //                   return ClinicalLicensesAddPopup(
        //                             title: 'Add Clinical Licenses',
        //                             employeeId: widget.employeeId,
        //                             // docTypeMetaIdCC: 10,
        //                             // selectedSubDocId: 48,
        //                           );
        //
        //                 });
        //             //showDialog(context: context, builder: (context)=> AcknowledgementsAddPopup());
        //           }),
        //     ),
        //
        //   ],
        // ),
        SizedBox(
          height: 20,
        ),
        /// Driving License
        Column(
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
              child: StreamBuilder<List<ClinicalLicenseDataModel>>(
                stream: drivingLicenseController.stream,
                builder: (context,snapshot) {
                  getDrivingLicenseRecord(context,employeeId,"yes")
                      .then((data) {
                    drivingLicenseController.add(data);
                  }).catchError((error) {
                    // Handle error
                  });
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: SizedBox(height:25,width:25,child: CircularProgressIndicator(color: ColorManager.blueprime,)),);
                  }
                  if(snapshot.data!.isEmpty){
                    return Center(
                        child:Text(AppString.noDrivingLicense,style: AllNoDataAvailable.customTextStyle(context),));
                  }
                  if(snapshot.hasData){
                    var drivingLicense = snapshot.data![0];
                    var fileUrl = drivingLicense.url;
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
                    return Row(
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
                                Text('Driving License',
                                    style:AknowledgementStyleConst.customTextStyle(context)),
                                SizedBox(height: 5,),
                                Text("Expiry Date: ${snapshot.data![0].expDate}",
                                    style: AknowledgementStyleNormal.customTextStyle(context)),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ///
                            drivingLicense.url == "--"?Offstage() :IconButton(
                              splashColor:
                              Colors.transparent,
                              highlightColor:
                              Colors.transparent,
                              hoverColor:
                              Colors.transparent,
                              onPressed: () {
                                print("FileExtension:${fileExtension}");
                                downloadFile(fileUrl);
                              },
                              icon: Icon(Icons.print_outlined,color: Color(0xff1696C8),),
                              iconSize: 20,),
                            drivingLicense.url == "--"?Offstage() : PdfDownloadButton(apiUrl: drivingLicense.url, documentName: drivingLicense.fileName,),
                            ///
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return FutureBuilder<ClinicalLicensePrefillDataModel>(
                                        future: getDrivingLicenseRecordPreFill(context: context, docId: drivingLicense.drivingLicenseId.toString()),
                                        builder: (context,snapshotPrefill) {
                                          if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                            return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                                          }
                                          return ClinicalLicensesAddPopup(
                                            title: 'Edit Driving Licenses',
                                            employeeId: employeeId,
                                            drivingList: snapshotPrefill.data!,
                                            docId: drivingLicense.drivingLicenseId.toString(),
                                            licenseName: 'Driving License',
                                            // docTypeMetaIdCC: 10,
                                            // selectedSubDocId: 48,
                                          );
                                        }
                                      );
                                    });
                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //
                                //       return FutureBuilder<EmployeeDocumentPrefillData>(
                                //           future: getPrefillEmployeeDocuments( context: context, empDocumentId: health.employeeDocumentId),
                                //           builder: (context, snapshotPreFill) {
                                //             if (snapshotPreFill.connectionState ==
                                //                 ConnectionState.waiting) {
                                //               return Center(
                                //                   child: CircularProgressIndicator());
                                //             }
                                //             if (snapshotPreFill.hasData) {
                                //               return CustomDocumedEditPopup(
                                //                 labelName: 'Edit Health Record',
                                //                 employeeId: widget.employeeId,
                                //                 docName: health.DocumentName,
                                //                 docMetaDataId: health.EmployeeDocumentTypeMetaDataId,
                                //                 docSetupId: health.EmployeeDocumentTypeSetupId,
                                //                 empDocumentId: health.employeeDocumentId,
                                //                 selectedExpiryType: health.ReminderThreshold,
                                //                 expiryDate: snapshotPreFill.data!.expiry,
                                //                 url: health.DocumentUrl, documentFileName: health.documentFileName,
                                //               );
                                //
                                //
                                //               // return CustomDocumedAddPopup(
                                //               //   title: 'Add Compensation', employeeId: widget.employeeId, dataList:snapshot.data! ,
                                //               // );
                                //             } else {
                                //               return ErrorPopUp(
                                //                   title: "Received Error",
                                //                   text: snapshot.error.toString());
                                //             }
                                //           });
                                //
                                //     });
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
                                    builder: (context) => StatefulBuilder(
                                      builder: (BuildContext context, void Function(void Function()) setState) {
                                        return DeletePopup(
                                          loadingDuration: _isLoading,
                                          title: 'Delete Driving License',
                                          onCancel: (){
                                            Navigator.pop(context);
                                          }, onDelete: () async{
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          try{
                                             await deleteDrivingLicense(context,drivingLicense.drivingLicenseId.toString());
                                             // setState((){
                                             //   getDrivingLicenseRecord(context,316,"no");
                                             // });
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
                                        );
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
                    );
                  }
                  else{
                    return Offstage();
                  }
                }
              ),
            ),
          ],
        ),

        /// practitioner License
        Column(
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
              child: StreamBuilder<List<PractitionerLicenseDataModel>>(
                stream: practitionerLicenseController.stream,
                builder: (context,snapshot) {
                  getPractitionerLicenseRecord(context,employeeId,"yes")
                      .then((data) {

                  practitionerLicenseController.add(data);
                  }).catchError((error) {
                  // Handle error
                  });
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: SizedBox(height:25,width:25,child: CircularProgressIndicator(color: ColorManager.blueprime,)),);
                  }
                  if(snapshot.data!.isEmpty){
                    return Center(
                        child:Text(AppString.noPractitionerLicense,style: AllNoDataAvailable.customTextStyle(context),));
                  }
                  if(snapshot.hasData){
                    var practionerlicense = snapshot.data![0];
                    var fileUrl = practionerlicense.url;
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
                    return Row(
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
                                Text('Practitioner License',
                                    style:AknowledgementStyleConst.customTextStyle(context)),
                                SizedBox(height: 5,),
                                Text("Expiry Date: ${snapshot.data![0].expDate}",
                                    style: AknowledgementStyleNormal.customTextStyle(context)),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ///
                            practionerlicense.url == "--"?Offstage() :  IconButton(
                              splashColor:
                              Colors.transparent,
                              highlightColor:
                              Colors.transparent,
                              hoverColor:
                              Colors.transparent,
                              onPressed: () {
                                print("FileExtension:${fileExtension}");
                                downloadFile(fileUrl);
                              },
                              icon: Icon(Icons.print_outlined,color: Color(0xff1696C8),),
                              iconSize: 20,),
                            practionerlicense.url == "--"?Offstage() :  PdfDownloadButton(apiUrl: practionerlicense.url, documentName: practionerlicense.fileName,),
                            ///
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return FutureBuilder<PractitionerLicensePreFillDataModel>(
                                        future: getPractitionerLicenseRecordPreFill(context: context, docId: practionerlicense.practitionerLicenceId.toString()),
                                        builder: (context,snapshotPrefill) {
                                          if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                            return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                                          }
                                          return ClinicalLicensesAddPopup(
                                            title: 'Edit Practitioner Licenses',
                                            employeeId: employeeId,
                                            practionerData: snapshotPrefill.data!,
                                            docId: practionerlicense.practitionerLicenceId.toString(),
                                            licenseName: 'Practitioner Licenses',
                                          );
                                        }
                                      );
                                    });
                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //
                                //       return FutureBuilder<EmployeeDocumentPrefillData>(
                                //           future: getPrefillEmployeeDocuments( context: context, empDocumentId: health.employeeDocumentId),
                                //           builder: (context, snapshotPreFill) {
                                //             if (snapshotPreFill.connectionState ==
                                //                 ConnectionState.waiting) {
                                //               return Center(
                                //                   child: CircularProgressIndicator());
                                //             }
                                //             if (snapshotPreFill.hasData) {
                                //               return CustomDocumedEditPopup(
                                //                 labelName: 'Edit Health Record',
                                //                 employeeId: widget.employeeId,
                                //                 docName: health.DocumentName,
                                //                 docMetaDataId: health.EmployeeDocumentTypeMetaDataId,
                                //                 docSetupId: health.EmployeeDocumentTypeSetupId,
                                //                 empDocumentId: health.employeeDocumentId,
                                //                 selectedExpiryType: health.ReminderThreshold,
                                //                 expiryDate: snapshotPreFill.data!.expiry,
                                //                 url: health.DocumentUrl, documentFileName: health.documentFileName,
                                //               );
                                //
                                //
                                //               // return CustomDocumedAddPopup(
                                //               //   title: 'Add Compensation', employeeId: widget.employeeId, dataList:snapshot.data! ,
                                //               // );
                                //             } else {
                                //               return ErrorPopUp(
                                //                   title: "Received Error",
                                //                   text: snapshot.error.toString());
                                //             }
                                //           });
                                //
                                //     });
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
                                    builder: (context) => StatefulBuilder(
                                      builder: (BuildContext context, void Function(void Function()) setState) {
                                        return DeletePopup(
                                          loadingDuration: _isLoading,
                                          title: 'Delete Practitioner License',
                                          onCancel: (){
                                            Navigator.pop(context);
                                          }, onDelete: () async{
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          try{
                                             await deletePractitionerLicense(context,practionerlicense.practitionerLicenceId.toString());
                                             // setState((){
                                             //   getPractitionerLicenseRecord(context,316,"no");
                                             // });

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
                                        );
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
                    );
                  }
                  else{
                    return Offstage();
                  }

                }
              ),
            ),
          ],
        )
    //     Container(
    //               height: MediaQuery.of(context).size.height/1,
    //               child: ListView.builder(
    //                 scrollDirection: Axis.vertical,
    //                 itemCount: 4
    // ,
    //                 itemBuilder: (context, index) {
    //                   // var health = snapshot.data![index];
    //                   // var fileUrl = health.DocumentUrl;
    //                   // final fileExtension = fileUrl.split('/').last;
    //                   //
    //                   // Widget fileWidget;
    //                   //
    //                   // if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
    //                   //   fileWidget = Image.network(
    //                   //     fileUrl,
    //                   //     fit: BoxFit.cover,
    //                   //     errorBuilder: (context, error, stackTrace) {
    //                   //       return Icon(
    //                   //         Icons.broken_image,
    //                   //         size: 45,
    //                   //         color: ColorManager.faintGrey,
    //                   //       );
    //                   //     },
    //                   //   );
    //                   // }
    //                   // else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
    //                   //   fileWidget = Icon(
    //                   //     Icons.description,
    //                   //     size: 45,
    //                   //     color: ColorManager.faintGrey,
    //                   //   );
    //                   // } else {
    //                   //   fileWidget = Icon(
    //                   //     Icons.insert_drive_file,
    //                   //     size: 45,
    //                   //     color: ColorManager.faintGrey,
    //                   //   );
    //                   // }
    //                   return Column(
    //                     children: [
    //                       SizedBox(height: 5),
    //                       Container(
    //                         padding: EdgeInsets.only(top: 5,bottom:5, left: 10,right: 100),
    //                         margin: EdgeInsets.symmetric(horizontal: 40),
    //                         decoration: BoxDecoration(
    //                           color:Colors.white,
    //                           borderRadius: BorderRadius.circular(8),
    //                           boxShadow: [
    //                             BoxShadow(
    //                               color: Colors.grey.withOpacity(0.25),
    //                               //spreadRadius: 1,
    //                               blurRadius: 4,
    //                               offset: Offset(0, 5),
    //                             ),
    //                           ],
    //                         ),
    //                         height: 65,
    //                         child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Container(
    //                                     width: 62,
    //                                     height: 45,
    //                                     padding: EdgeInsets.symmetric(horizontal: 10),
    //                                     decoration: BoxDecoration(
    //                                       borderRadius: BorderRadius.circular(4),
    //                                       border: Border.all(width: 2,color:ColorManager.faintGrey),
    //                                     ),
    //                                     child: Image.asset('images/Vector.png')),
    //                                 SizedBox(width: 10),
    //                                 Column(
    //                                   mainAxisAlignment: MainAxisAlignment.center,
    //                                   crossAxisAlignment: CrossAxisAlignment.start,
    //                                   children: [
    //                                     Text('Driving License',
    //                                         style:AknowledgementStyleConst.customTextStyle(context)),
    //                                     SizedBox(height: 5,),
    //                                     Text("Expiry Date: 2024-03-13",
    //                                         style: AknowledgementStyleNormal.customTextStyle(context)),
    //                                   ],
    //                                 )
    //                               ],
    //                             ),
    //                             Row(
    //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                               children: [
    //                                 ///
    //                                 IconButton(
    //                                   splashColor:
    //                                   Colors.transparent,
    //                                   highlightColor:
    //                                   Colors.transparent,
    //                                   hoverColor:
    //                                   Colors.transparent,
    //                                   onPressed: () {
    //                                     // print("FileExtension:${fileExtension}");
    //                                     // downloadFile(fileUrl);
    //                                   },
    //                                   icon: Icon(Icons.print_outlined,color: Color(0xff1696C8),),
    //                                   iconSize: 20,),
    //                                 // PdfDownloadButton(apiUrl: health.DocumentUrl, documentName: health.documentFileName,),
    //                                 ///
    //                                 IconButton(
    //                                   onPressed: () {
    //                                     showDialog(
    //                                         context: context,
    //                                         builder: (context) {
    //                                           return ClinicalLicensesAddPopup(
    //                                             title: 'Edit Clinical Licenses',
    //                                             employeeId: widget.employeeId,
    //                                             // docTypeMetaIdCC: 10,
    //                                             // selectedSubDocId: 48,
    //                                           );
    //                                         });
    //                                     // showDialog(
    //                                     //     context: context,
    //                                     //     builder: (BuildContext context) {
    //                                     //
    //                                     //       return FutureBuilder<EmployeeDocumentPrefillData>(
    //                                     //           future: getPrefillEmployeeDocuments( context: context, empDocumentId: health.employeeDocumentId),
    //                                     //           builder: (context, snapshotPreFill) {
    //                                     //             if (snapshotPreFill.connectionState ==
    //                                     //                 ConnectionState.waiting) {
    //                                     //               return Center(
    //                                     //                   child: CircularProgressIndicator());
    //                                     //             }
    //                                     //             if (snapshotPreFill.hasData) {
    //                                     //               return CustomDocumedEditPopup(
    //                                     //                 labelName: 'Edit Health Record',
    //                                     //                 employeeId: widget.employeeId,
    //                                     //                 docName: health.DocumentName,
    //                                     //                 docMetaDataId: health.EmployeeDocumentTypeMetaDataId,
    //                                     //                 docSetupId: health.EmployeeDocumentTypeSetupId,
    //                                     //                 empDocumentId: health.employeeDocumentId,
    //                                     //                 selectedExpiryType: health.ReminderThreshold,
    //                                     //                 expiryDate: snapshotPreFill.data!.expiry,
    //                                     //                 url: health.DocumentUrl, documentFileName: health.documentFileName,
    //                                     //               );
    //                                     //
    //                                     //
    //                                     //               // return CustomDocumedAddPopup(
    //                                     //               //   title: 'Add Compensation', employeeId: widget.employeeId, dataList:snapshot.data! ,
    //                                     //               // );
    //                                     //             } else {
    //                                     //               return ErrorPopUp(
    //                                     //                   title: "Received Error",
    //                                     //                   text: snapshot.error.toString());
    //                                     //             }
    //                                     //           });
    //                                     //
    //                                     //     });
    //                                   },
    //                                   icon: Icon(Icons.edit_outlined,color: Color(0xff1696C8),),
    //                                   splashColor:
    //                                   Colors.transparent,
    //                                   highlightColor:
    //                                   Colors.transparent,
    //                                   hoverColor:
    //                                   Colors.transparent,
    //                                   iconSize: 20,),
    //                                 IconButton(
    //                                   onPressed: () async{
    //                                     await showDialog(context: context,
    //                                         builder: (context) => StatefulBuilder(
    //                                           builder: (BuildContext context, void Function(void Function()) setState) {
    //                                             return DeletePopup(
    //                                               loadingDuration: _isLoading,
    //                                               title: 'Delete Clinical License',
    //                                               onCancel: (){
    //                                                 Navigator.pop(context);
    //                                               }, onDelete: () async{
    //                                               setState(() {
    //                                                 _isLoading = true;
    //                                               });
    //                                               try{
    //                                                 // await deleteEmployeeDocuments(context: context, empDocumentId: health.employeeDocumentId);
    //                                               }finally{
    //                                                 setState(() {
    //                                                   _isLoading = false;
    //                                                 });
    //                                                 Navigator.pop(context);
    //                                               }
    //                                               // setState(() async{
    //                                               //
    //                                               //   Navigator.pop(context);
    //                                               // });
    //                                             },
    //                                             );
    //                                           },
    //                                         )
    //                                     );
    //                                   },
    //                                   icon: Icon(Icons.delete_outline,color: Color(0xffFF0000),),
    //                                   splashColor:
    //                                   Colors.transparent,
    //                                   highlightColor:
    //                                   Colors.transparent,
    //                                   hoverColor:
    //                                   Colors.transparent,
    //                                   iconSize: 20,),
    //                               ],)
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   );
    //                 },
    //               ),
    //             ),
      ],
    );
  }
}
