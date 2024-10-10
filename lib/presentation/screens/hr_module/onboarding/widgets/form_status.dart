import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/banking_tab_constant.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../manage/widgets/icon_button_constant.dart';

class FormStatusScreen extends StatelessWidget {
  final int employeeId;
  const FormStatusScreen({super.key,required this.employeeId});

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    return Container(

    );
    // // return Column(
    // //   children: [
    // //     Expanded(
    // //       child: StreamBuilder<List<SeeAllData>>(
    // //         stream: generalController.stream,
    // //         builder: (context, snapshot) {
    // //           print('1111111');
    // //           if (snapshot.connectionState == ConnectionState.waiting) {
    // //             return Center(
    // //               child: CircularProgressIndicator(
    // //                 color: ColorManager.blueprime,
    // //               ),
    // //             );
    // //           }
    // //           if (snapshot.data!.isEmpty) {
    // //             return Center(
    // //               child: Text(
    // //                 AppStringHRNoData.noOnboardingData,
    // //                 style: AllNoDataAvailable.customTextStyle(context),
    // //               ),
    // //             );
    // //           }
    // //           if (snapshot.hasData) {
    // //             int totalItems = snapshot.data!.length;
    // //             int totalPages = (totalItems / itemsPerPage).ceil();
    // //             List<SeeAllData> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
    //             return Column(
    //               children: [
    //                 Expanded(
    //                   child: ListView.builder(
    //                       scrollDirection: Axis.vertical,
    //                       itemCount: 20,//paginatedData.length,
    //                       itemBuilder: (context, index) {
    //                        // int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
    //                        // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
    //                        // SeeAllData general = paginatedData[index];
    //                         return Column(
    //                           children: [
    //                             Material(
    //                               color: ColorManager.white,
    //                               elevation: 4,
    //                               borderRadius: BorderRadius.circular(20),
    //                               child: Container(
    //                                 width: containerWidth,
    //                                 height: AppSize.s88,
    //                                 decoration: BoxDecoration(
    //                                   color: ColorManager.white,
    //                                   borderRadius: BorderRadius.circular(20),
    //                                   // border: Border.all(
    //                                   //   width: AppSize.s1,
    //                                   //   color: ColorManager.white,
    //                                   // ),
    //                                 ),
    //                                 child: Column(
    //                                   mainAxisAlignment: MainAxisAlignment.start,
    //                                   crossAxisAlignment: CrossAxisAlignment.start,
    //                                   children: [
    //                                     Row(
    //                                       mainAxisAlignment: MainAxisAlignment.end,
    //                                       crossAxisAlignment: CrossAxisAlignment.end,
    //                                       children: [
    //                                         ///status
    //                                         Container(
    //                                             width: AppSize.s88,
    //                                             height: AppSize.s20,
    //                                             decoration: BoxDecoration(
    //                                               color:
    //                                               // general.status == 'Signed'
    //                                               //     ?  ColorManager.redSign
    //                                               //     :
    //                                               ColorManager.greenF,
    //                                               borderRadius: BorderRadius.only(
    //                                                   topRight:
    //                                                   Radius.circular(20)),),
    //                                             child: Center(
    //                                               child: Text(
    //                                                 "Signed",
    //                                                   //general.status.toString(),
    //                                                   textAlign: TextAlign.center,
    //                                                   style: CustomTextStylesCommon.commonStyle(
    //                                                       color: ColorManager.white,
    //                                                       fontSize: FontSize.s12,
    //                                                       fontWeight: FontWeight.w600)),
    //                                             )),
    //                                       ],
    //                                     ),
    //                                     SizedBox(height: AppSize.s5),
    //                                     Padding(
    //                                       padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
    //                                       child: Row(
    //                                         crossAxisAlignment: CrossAxisAlignment.center,
    //                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                                         children: [
    //                                           Container(
    //                                               width: 62,
    //                                               height: 45,
    //                                               decoration: BoxDecoration(
    //                                                 borderRadius: BorderRadius.circular(4),
    //                                                 border: Border.all(
    //                                                     width: 2,
    //                                                     color: ColorManager.faintGrey),
    //                                               ),
    //                                               child: Image.asset('images/Vector.png')),
    //                                           SizedBox(width: AppSize.s30),
    //                                           Expanded(
    //                                             child: Text(
    //                                              'documentFileName',
    //                                               style: AknowledgementStyleConst.customTextStyle(context),
    //                                             ),
    //                                           ),
    //                                           Container(
    //                                             height: 32,
    //                                             decoration: BoxDecoration(
    //                                               border: Border.all(color: const Color(0xff1696C8)),
    //                                               borderRadius: BorderRadius.circular(8),
    //                                             ),
    //                                             child: IconButtonWidget(
    //                                               width: AppSize.s110,
    //                                               iconData1: Icons.save_alt_outlined,
    //                                               buttonText: 'Download',
    //                                               onPressed: (){},
    //                                             ),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               height: AppSize.s5,
    //                             )
    //                           ],
    //                         );
    //                       }),
    //                 ),
    //                 SizedBox(height: AppSize.s5),
    //               ],
    //             );
    //          // }
    // //           return Offstage();
    // //         },
    // //       ),
    // //     )
    // //   ],
    // // );
  }
}
