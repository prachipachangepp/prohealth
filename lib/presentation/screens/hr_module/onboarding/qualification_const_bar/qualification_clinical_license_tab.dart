import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/clinical_licenses_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/clinical_license_data.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/reject_popup_constant.dart';

class QualificationGeneralLicenses extends StatefulWidget {
  final int employeeId;
  const QualificationGeneralLicenses({super.key, required this.employeeId});

  @override
  State<QualificationGeneralLicenses> createState() => _QualificationGeneralLicensesState();
}

class _QualificationGeneralLicensesState extends State<QualificationGeneralLicenses> {
  @override
  void initState() {
    // TODO: implement initState
    //fetchDrivingLicense();
    super.initState();
  }
//   List<ClinicalLicenseDataModel> clinicalLicenseDataModel = [];
//   Future<List<ClinicalLicenseDataModel>> fetchDrivingLicense() async{
//     clinicalLicenseDataModel = await getDrivingLicenseRecord(context,316,"no");
//     print('Data fetched driving license');
//     return clinicalLicenseDataModel;
// }
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.62;
    return Column(
      children: [
        Material(
          color: ColorManager.white,
          elevation: 4,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: containerWidth,
            height: AppSize.s88,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(
              //   width: AppSize.s1,
              //   color: ColorManager.white,
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<List<ClinicalLicenseDataModel>>(
                  future:  getDrivingLicenseRecord(context,widget.employeeId,"no"),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: SizedBox(height:25,width:25,child: CircularProgressIndicator(color: ColorManager.blueprime,)),);
                    }
                    if(snapshot.data!.isEmpty){
                      return Center(
                          child:Text(AppString.noDrivingLicense,style: AllNoDataAvailable.customTextStyle(context),));
                    }
                    if(snapshot.hasData){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: 62,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          width: 2,
                                          color: ColorManager.faintGrey),
                                    ),
                                    child: Image.asset('images/Vector.png')),
                                SizedBox(width: AppSize.s30),
                                Text(
                                  "Driving License",
                                  style: AknowledgementStyleNormal
                                      .customTextStyle(context),
                                ),
                              ],
                            ),
                           Text("     "),
                            Row(
                              children: [
                                Text('Expiry Date', style: AknowledgementStyleNormal
                                    .customTextStyle(context)),
                                SizedBox(width: AppSize.s20),
                                Text(snapshot.data![0].expDate, style: AknowledgementStyleConst
                                    .customTextStyle(context)),
                              ],
                            ),
                            Text("     "),
                            Row(
                              children: [
                                QualificationActionButtons( approve: snapshot.data![0].approve ,onRejectPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context)
                                    {
                                      return RejectDialog(onYesPressed: () async {
                                        await singleDrivingLicenseRejectPatch(context,snapshot.data![0].drivingLicenseId);
                                        setState((){
                                          getDrivingLicenseRecord(context,widget.employeeId,"no");
                                        });

                                        //fetchDrivingLicense();
                                        Navigator.of(context)
                                            .pop();
                                      },);
                                    },
                                  );  }, onApprovePressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ApproveDialog(onYesPressed: () async {
                                        await singleDrivingLicenseApprovePatch(context,snapshot.data![0].drivingLicenseId);
                                        setState((){
                                          getDrivingLicenseRecord(context,widget.employeeId,"no");
                                        });
                                        Navigator.of(context)
                                            .pop();
                                      },);
                                    },
                                  );
                                },isBackColor: true,),
                              ],
                            )

                            // formStatus.signed || (formStatus.htmlname == AppStringLegalDocument.employeeHandbook) == true ?
                            // Container(
                            //   height: 32,
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: const Color(0xff1696C8)),
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   padding: EdgeInsets.only(bottom: 5,left: 10),
                            //   child:
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(top: 6.0),
                            //       child: Text('Download',style: TextStyle(
                            //         fontWeight: FontWeight.w700,
                            //         fontSize: FontSize.s12,
                            //         color: Color(0xff1696C8),
                            //       ),),
                            //     ),
                            // PdfDownloadButton(apiUrl: formStatus.url, documentName: formStatus.htmlname,)
                            //     : SizedBox(width: AppSize.s110,),
                          ],
                        ),
                      );
                    }
                    else{
                      return Offstage();
                    }

                  }
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppSize.s10),
        Material(
          color: ColorManager.white,
          elevation: 4,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: containerWidth,
            height: AppSize.s88,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(
              //   width: AppSize.s1,
              //   color: ColorManager.white,
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: getPractitionerLicenseRecord(context,widget.employeeId,"no"),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: SizedBox(height:25,width:25,child: CircularProgressIndicator(color: ColorManager.blueprime,)),);
                    }
                    if(snapshot.data!.isEmpty){
                      return Center(
                          child:Text(AppString.noPractitionerLicense,style: AllNoDataAvailable.customTextStyle(context),));
                    }
                    if(snapshot.hasData){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 62,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          width: 2,
                                          color: ColorManager.faintGrey),
                                    ),
                                    child: Image.asset('images/Vector.png')),
                                SizedBox(width: AppSize.s30),
                                Text(
                                  "Practitioner License",
                                  style: AknowledgementStyleNormal.customTextStyle(context),
                                ),
                              ],
                            ),
                            Text(""),
                            Row(
                              children: [
                                Text('Expiry Date', style: AknowledgementStyleNormal.customTextStyle(context)),
                            SizedBox(width: AppSize.s20),
                                Text(snapshot.data![0].expDate, style: AknowledgementStyleConst.customTextStyle(context)),
                              ],
                            ),
                            Text("     "),
                            Row(
                              children: [
                                QualificationActionButtons( approve: snapshot.data![0].approve ,
                                  onRejectPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context)
                                      {
                                        return RejectDialog(onYesPressed: () async {
                                          await singlePractitionerLicenseRejectPatch(context,snapshot.data![0].practitionerLicenceId);
                                          setState((){
                                            getPractitionerLicenseRecord(context,widget.employeeId,"no");
                                          });
                                          //fetchDrivingLicense();
                                          Navigator.of(context)
                                              .pop();
                                        },);
                                      },
                                    );
                                  },
                                  onApprovePressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ApproveDialog(onYesPressed: () async {
                                        await singlePractitionerLicenseApprovePatch(context,snapshot.data![0].practitionerLicenceId);
                                        setState((){
                                          getPractitionerLicenseRecord(context,widget.employeeId,"no");
                                        });

                                        Navigator.of(context)
                                            .pop();
                                      },);
                                    },
                                  );  },isBackColor: true,),
                              ],
                            )

                            // formStatus.signed || (formStatus.htmlname == AppStringLegalDocument.employeeHandbook) == true ?
                            // Container(
                            //   height: 32,
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: const Color(0xff1696C8)),
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   padding: EdgeInsets.only(bottom: 5,left: 10),
                            //   child:
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(top: 6.0),
                            //       child: Text('Download',style: TextStyle(
                            //         fontWeight: FontWeight.w700,
                            //         fontSize: FontSize.s12,
                            //         color: Color(0xff1696C8),
                            //       ),),
                            //     ),
                            // PdfDownloadButton(apiUrl: formStatus.url, documentName: formStatus.htmlname,)
                            //     : SizedBox(width: AppSize.s110,),
                          ],
                        ),
                      );
                    }
                    else{
                      return Offstage();
                    }

                  }
                )
              ],
            ),
          ),
        ),
        // Container(
        //   height: 500,
        //   child: ListView.builder(
        //       itemCount: 2,
        //       itemBuilder: (context, index) {
        //         // FormModel formStatus = snapshot.data![index];
        //         return Column(
        //           children: [
        //             Material(
        //               color: ColorManager.white,
        //               elevation: 4,
        //               borderRadius: BorderRadius.circular(20),
        //               child: Container(
        //                 width: containerWidth,
        //                 height: AppSize.s88,
        //                 decoration: BoxDecoration(
        //                   color: ColorManager.white,
        //                   borderRadius: BorderRadius.circular(20),
        //                   // border: Border.all(
        //                   //   width: AppSize.s1,
        //                   //   color: ColorManager.white,
        //                   // ),
        //                 ),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
        //                       child: Row(
        //                         crossAxisAlignment: CrossAxisAlignment.center,
        //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                         children: [
        //                           Row(
        //                             crossAxisAlignment: CrossAxisAlignment.center,
        //                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                             children: [
        //                               Container(
        //                                   width: 62,
        //                                   height: 45,
        //                                   decoration: BoxDecoration(
        //                                     borderRadius: BorderRadius.circular(4),
        //                                     border: Border.all(
        //                                         width: 2,
        //                                         color: ColorManager.faintGrey),
        //                                   ),
        //                                   child: Image.asset('images/Vector.png')),
        //                               SizedBox(width: AppSize.s30),
        //                               Text(
        //                                 "Driving License",
        //                                 style: AknowledgementStyleConst.customTextStyle(context),
        //                               ),
        //                             ],
        //                           ),
        //                           Row(
        //                             children: [
        //                               Text('Expiry Date', style: AknowledgementStyleConst.customTextStyle(context)),
        //                               SizedBox(width: AppSize.s20),
        //                               Text('2024-03-14', style: AknowledgementStyleConst.customTextStyle(context)),
        //                             ],
        //                           ),
        //
        //                           Row(
        //                                 children: [
        //                                   QualificationActionButtons( approve: false ,onRejectPressed: () {  }, onApprovePressed: () {  },isBackColor: true,),
        //                                 ],
        //                               )
        //
        //                           // formStatus.signed || (formStatus.htmlname == AppStringLegalDocument.employeeHandbook) == true ?
        //                           // Container(
        //                           //   height: 32,
        //                           //   decoration: BoxDecoration(
        //                           //     border: Border.all(color: const Color(0xff1696C8)),
        //                           //     borderRadius: BorderRadius.circular(8),
        //                           //   ),
        //                           //   padding: EdgeInsets.only(bottom: 5,left: 10),
        //                           //   child:
        //                           // Row(
        //                           //   children: [
        //                           //     Padding(
        //                           //       padding: const EdgeInsets.only(top: 6.0),
        //                           //       child: Text('Download',style: TextStyle(
        //                           //         fontWeight: FontWeight.w700,
        //                           //         fontSize: FontSize.s12,
        //                           //         color: Color(0xff1696C8),
        //                           //       ),),
        //                           //     ),
        //                           // PdfDownloadButton(apiUrl: formStatus.url, documentName: formStatus.htmlname,)
        //                           //     : SizedBox(width: AppSize.s110,),
        //                         ],
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             SizedBox(
        //               height: AppSize.s5,
        //             )
        //           ],
        //         );
        //       }),
        // ),
      ],
    );
  }
}
