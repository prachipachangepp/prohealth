import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';

class QualificationGeneralLicenses extends StatefulWidget {
  final int employeeId;
  const QualificationGeneralLicenses({super.key, required this.employeeId});

  @override
  State<QualificationGeneralLicenses> createState() => _QualificationGeneralLicensesState();
}

class _QualificationGeneralLicensesState extends State<QualificationGeneralLicenses> {
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
                Padding(
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
                            style: AknowledgementStyleConst.customTextStyle(context),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Expiry Date', style: AknowledgementStyleConst.customTextStyle(context)),
                          SizedBox(width: AppSize.s20),
                          Text('2024-03-14', style: AknowledgementStyleConst.customTextStyle(context)),
                        ],
                      ),

                      Row(
                        children: [
                          QualificationActionButtons( approve: false ,onRejectPressed: () {  }, onApprovePressed: () {  },isBackColor: true,),
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
                )
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
                Padding(
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
                            "Practioner License",
                            style: AknowledgementStyleConst.customTextStyle(context),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Expiry Date', style: AknowledgementStyleConst.customTextStyle(context)),
                          SizedBox(width: AppSize.s20),
                          Text('2024-03-14', style: AknowledgementStyleConst.customTextStyle(context)),
                        ],
                      ),

                      Row(
                        children: [
                          QualificationActionButtons( approve: false ,onRejectPressed: () {  }, onApprovePressed: () {  },isBackColor: true,),
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
