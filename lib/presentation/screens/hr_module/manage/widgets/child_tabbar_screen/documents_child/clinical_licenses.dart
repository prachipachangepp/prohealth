import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/compensation_add_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';

class ClinicalLicensesDoc extends StatefulWidget {
  final int employeeId;
  const ClinicalLicensesDoc({super.key, required this.employeeId});

  @override
  State<ClinicalLicensesDoc> createState() => _ClinicalLicensesDocState();
}

class _ClinicalLicensesDocState extends State<ClinicalLicensesDoc> {
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
                          return ClinicalLicensesAddPopup(
                                    title: 'Add Clinical Licenses',
                                    employeeId: widget.employeeId,
                                    // docTypeMetaIdCC: 10,
                                    // selectedSubDocId: 48,
                                  );

                        });
                    //showDialog(context: context, builder: (context)=> AcknowledgementsAddPopup());
                  }),
            ),

          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
                  height: MediaQuery.of(context).size.height/1,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 4
    ,
                    itemBuilder: (context, index) {
                      // var health = snapshot.data![index];
                      // var fileUrl = health.DocumentUrl;
                      // final fileExtension = fileUrl.split('/').last;
                      //
                      // Widget fileWidget;
                      //
                      // if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
                      //   fileWidget = Image.network(
                      //     fileUrl,
                      //     fit: BoxFit.cover,
                      //     errorBuilder: (context, error, stackTrace) {
                      //       return Icon(
                      //         Icons.broken_image,
                      //         size: 45,
                      //         color: ColorManager.faintGrey,
                      //       );
                      //     },
                      //   );
                      // }
                      // else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
                      //   fileWidget = Icon(
                      //     Icons.description,
                      //     size: 45,
                      //     color: ColorManager.faintGrey,
                      //   );
                      // } else {
                      //   fileWidget = Icon(
                      //     Icons.insert_drive_file,
                      //     size: 45,
                      //     color: ColorManager.faintGrey,
                      //   );
                      // }
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
                                        Text('Driving License',
                                            style:AknowledgementStyleConst.customTextStyle(context)),
                                        SizedBox(height: 5,),
                                        Text("Expiry Date: 2024-03-13",
                                            style: AknowledgementStyleNormal.customTextStyle(context)),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ///
                                    IconButton(
                                      splashColor:
                                      Colors.transparent,
                                      highlightColor:
                                      Colors.transparent,
                                      hoverColor:
                                      Colors.transparent,
                                      onPressed: () {
                                        // print("FileExtension:${fileExtension}");
                                        // downloadFile(fileUrl);
                                      },
                                      icon: Icon(Icons.print_outlined,color: Color(0xff1696C8),),
                                      iconSize: 20,),
                                    // PdfDownloadButton(apiUrl: health.DocumentUrl, documentName: health.documentFileName,),
                                    ///
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ClinicalLicensesAddPopup(
                                                title: 'Edit Clinical Licenses',
                                                employeeId: widget.employeeId,
                                                // docTypeMetaIdCC: 10,
                                                // selectedSubDocId: 48,
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
                                                  title: 'Delete Clinical License',
                                                  onCancel: (){
                                                    Navigator.pop(context);
                                                  }, onDelete: () async{
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  try{
                                                    // await deleteEmployeeDocuments(context: context, empDocumentId: health.employeeDocumentId);
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
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
      ],
    );
  }
}
