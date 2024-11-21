import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/termination_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/termination_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/row_container_widget_const.dart';

import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../../em_module/widgets/button_constant.dart';
import '../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../em_module/widgets/header_content_const.dart';
import '../../../../register/taxtfield_constant.dart';
import '../../custom_icon_button_constant.dart';

class TerminationHeadTabbar extends StatefulWidget {
  final int employeeId;
  const TerminationHeadTabbar({super.key, required this.employeeId});

  @override
  State<TerminationHeadTabbar> createState() => _TerminationHeadTabbarState();
}

class _TerminationHeadTabbarState extends State<TerminationHeadTabbar> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  List<TerminationData> listData = [];
  final StreamController<List<TerminationData>> terminationStremController =
      StreamController<List<TerminationData>>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TerminationData>>(
        stream: terminationStremController.stream,
        builder: (context, snapshot) {
          getTermination(context).then((data) {
            terminationStremController.add(data);
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
            return Column(
              children: [
                snapshot.data!.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // CustomIconButtonConst(
                          //     width: 110,
                          //     text: "Terminate",
                          //     icon: Icons.add,
                          //     onPressed: () {
                          //       showDialog(
                          //           context: context,
                          //           builder: (_) =>
                          //               FutureBuilder<TerminateEmployeePrefillData>(
                          //                   future:getTerminationEmployeePerfill(context: context, employeeId: widget.employeeId) ,
                          //                   builder: (context,snapshotPrefill) {
                          //                     if(snapshotPrefill.connectionState == ConnectionState.waiting){
                          //                       return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                          //                     }
                          //                     if(snapshotPrefill.hasData){
                          //                       return TerminatePopup(employeeId: widget.employeeId, preFillData: snapshotPrefill.data!,);
                          //                     }else{
                          //                       return SizedBox();
                          //                     }
                          //
                          //                   }
                          //               ));
                          //     }
                          // ),
                        ],
                      )
                    : Offstage(),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Text(
                    AppStringHRNoData.terminationNoData,
                    style: AllNoDataAvailable.customTextStyle(context),
                  ),
                )),
              ],
            );
          }
          if (snapshot.hasData) {
            return Container();

            ///
            //   Column(
            //   children: [
            //     snapshot.data!.isEmpty
            //         ? Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Colors.grey.withOpacity(0.25),
            //                 blurRadius: 4,
            //                 offset: Offset(0, 5),
            //               ),
            //             ],
            //           ),
            //           padding: EdgeInsets.only(right: 20),
            //           child: CustomIconButtonConst(
            //               width: 110,
            //               text: "Terminate",
            //               icon: Icons.add,
            //               onPressed: () {
            //                 showDialog(
            //                     context: context,
            //                     builder: (_) => FutureBuilder<TerminateEmployeePrefillData>(
            //                         future: getTerminationEmployeePerfill(
            //                             context: context,
            //                             employeeId: widget.employeeId),
            //                         builder: (context, snapshotPrefill) {
            //                           if (snapshotPrefill.connectionState ==
            //                               ConnectionState.waiting) {
            //                             return Center(
            //                               child: CircularProgressIndicator(
            //                                 color: ColorManager.blueprime,
            //                               ),
            //                             );
            //                           }
            //                           if (snapshotPrefill.hasData) {
            //                             return TerminatePopup(
            //                               employeeId: widget.employeeId,
            //                               preFillData: snapshotPrefill.data!,
            //                             );
            //                           } else {
            //                             return SizedBox();
            //                           }
            //                         }));
            //               }),
            //         ),
            //       ],
            //     )
            //         : Offstage(),
            //     SizedBox(height: 10),
            //     Expanded(
            //       child: Container(
            //         child: WrapWidget(
            //           children: List.generate(snapshot.data!.length, (index) {
            //             var termination = snapshot.data![index];
            //             return Container(
            //               width: MediaQuery.of(context).size.width / 2.3,
            //               height: MediaQuery.of(context).size.height /2.5,
            //               margin: EdgeInsets.all(10),
            //               decoration: BoxDecoration(
            //                 boxShadow: [
            //                   BoxShadow(
            //                     color: Colors.grey.withOpacity(0.5),
            //                     spreadRadius: 1,
            //                     blurRadius: 4,
            //                     offset: const Offset(0, 4),
            //                   ),
            //                 ],
            //                 color: ColorManager.white,
            //                 borderRadius: const BorderRadius.all(Radius.circular(12)),
            //               ),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                     children: [
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             children: [
            //                               Text(AppString.nameTermination,
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Date of Termination :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Date of Resignation :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Date of Hire :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(AppString.terminationStatus,
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(AppString.terminationPosition,
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Phone No. :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Rehirable :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Final Address :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                             ],
            //                           ),
            //                           const SizedBox(width: AppSize.s25),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 "${termination.firstName} " +
            //                                     "${termination.lastName}",
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(
            //                                 termination.dateOfTermination,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(
            //                                 termination.dateOfResignation,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(
            //                                 termination.checkDate,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(
            //                                 termination.status,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(
            //                                 termination.employment,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(
            //                                 termination.primaryPhoneNo,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(
            //                                 termination.rehirable,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(
            //                                 termination.finalAddress,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                       Row(
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             children: [
            //                               Text(AppString.terminationType,
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Reason :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Final Paycheck :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(AppString.terminationDate,
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Gross Pay :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Net Pay :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Methods :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('Materials :',
            //                                   style: ThemeManagerDark.customTextStyle(context)),
            //                               SizedBox(height: 30),
            //                             ],
            //                           ),
            //                           const SizedBox(width: AppSize.s25),
            //                           Column(
            //                             crossAxisAlignment: CrossAxisAlignment.start,
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 termination.type,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(
            //                                 termination.reson,
            //                                 style: ThemeManager.customTextStyle(context),
            //                               ),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('\$${termination.finalPayCheck}',
            //                                   style: ThemeManager.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(termination.checkDate,
            //                                   style: ThemeManager.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('\$${termination.grossPay}',
            //                                   style: ThemeManager.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text('\$${termination.netPay}',
            //                                   style: ThemeManager.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(termination.methods,
            //                                   style: ThemeManager.customTextStyle(context)),
            //                               const SizedBox(height: AppSize.s10),
            //                               Text(termination.materials,
            //                                   style: ThemeManager.customTextStyle(context)),
            //                               SizedBox(height: 30),
            //                             ],
            //                           ),
            //                         ],
            //                       )
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             );
            //           }),
            //         ),
            //       ),
            //     ),
            //   ],
            // );
          }

          ///old
          // if (snapshot.hasData) {
          //   return Container(
          //     height: 700,
          //     color:  Colors.green,
          //     child: Expanded(
          //       flex: 2,
          //       child: Column(
          //         children: [
          //           snapshot.data!.isEmpty?Row(
          //             mainAxisAlignment: MainAxisAlignment.end,
          //             children: [
          //               Container(
          //                 // width: 100,
          //                 decoration: BoxDecoration(
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.grey.withOpacity(0.25),
          //                       //spreadRadius: 1,
          //                       blurRadius: 4,
          //                       offset: Offset(0, 5),
          //                     ),
          //                   ],
          //                 ),
          //                 padding: EdgeInsets.only(right: 20),
          //                 child: CustomIconButtonConst(
          //                     width: 110,
          //                     text: "Terminate",
          //                     icon: Icons.add,
          //                     onPressed: () {
          //                       showDialog(
          //                           context: context,
          //                           builder: (_) =>
          //                               FutureBuilder<TerminateEmployeePrefillData>(
          //                                   future:getTerminationEmployeePerfill(context: context, employeeId: widget.employeeId) ,
          //                                   builder: (context,snapshotPrefill) {
          //                                     if(snapshotPrefill.connectionState == ConnectionState.waiting){
          //                                       return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
          //                                     }
          //                                     if(snapshotPrefill.hasData){
          //                                       return TerminatePopup(employeeId: widget.employeeId, preFillData: snapshotPrefill.data!,);
          //                                     }else{
          //                                       return SizedBox();
          //                                     }
          //
          //                                   }
          //                               ));
          //                     }
          //                 ),
          //               ),
          //             ],
          //           ):Offstage(),
          //           SizedBox(
          //             height: 20,
          //           ),
          //           SingleChildScrollView(
          //             child: WrapWidget(
          //                 childern: List.generate(snapshot.data!.length, (index) {
          //               var termination = snapshot.data![index];
          //               return
          //                 Container(
          //                   width: MediaQuery.of(context).size.width / 2.3,
          //                   height: MediaQuery.of(context).size.height / 2.9,
          //                   margin: EdgeInsets.all(10),
          //                   decoration: BoxDecoration(
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: Colors.grey.withOpacity(0.5),
          //                         spreadRadius: 1,
          //                         blurRadius: 4,
          //                         offset: const Offset(0, 4),
          //                       ),
          //                     ],
          //                     color: ColorManager.white,
          //                     borderRadius:
          //                         const BorderRadius.all(Radius.circular(12)),
          //                   ),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Row(
          //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //
          //                         children: [
          //                           Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.start,
          //                             children: [
          //                               Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 mainAxisAlignment:
          //                                 MainAxisAlignment.start,
          //                                 children: [
          //                                   Text(AppString.nameTermination,
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Date of Termination :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Date of Resignation :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Date of Hire :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(AppString.terminationStatus,
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(AppString.terminationPosition,
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Phone No. :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Rehirable :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Final Address :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                 ],
          //                               ),
          //                               const SizedBox(width: AppSize.s25),
          //                               Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 mainAxisAlignment:
          //                                 MainAxisAlignment.start,
          //                                 children: [
          //                                   Text(
          //                                     "${termination.firstName} " +
          //                                         "${termination.lastName}",
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     termination.dateOfTermination,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     termination.dateOfResignation,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     termination.checkDate,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     termination.status,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     termination.employment,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     termination.primaryPhoneNo,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     termination.rehirable,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     termination.finalAddress,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                 ],
          //                               ),
          //                             ],
          //                           ),
          //
          //                           Row(
          //                             mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                             crossAxisAlignment:
          //                             CrossAxisAlignment.start,
          //                             children: [
          //                               Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 mainAxisAlignment:
          //                                 MainAxisAlignment.start,
          //                                 children: [
          //                                   Text(AppString.terminationType,
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Reason :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Final Paycheck :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(AppString.terminationDate,
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Gross Pay :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Net Pay :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Methods :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('Materials :',
          //                                       style:
          //                                       ThemeManagerDark
          //                                           .customTextStyle(context)),
          //                                   SizedBox(
          //                                     height: 30
          //                                   )
          //                                 ],
          //                               ),
          //                               const SizedBox(width: AppSize.s25),
          //                               Column(
          //                                 crossAxisAlignment:
          //                                     CrossAxisAlignment.start,
          //                                 mainAxisAlignment:
          //                                 MainAxisAlignment.start,
          //                                 children: [
          //                                   Text(
          //                                     termination.type,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     termination.reson,
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text('\$${termination.finalPayCheck}',
          //                                       style: ThemeManager.customTextStyle(
          //                                           context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(termination.checkDate,
          //                                       style: ThemeManager.customTextStyle(
          //                                           context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     '\$${termination.grossPay}',
          //                                     style: ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(
          //                                     '\$${termination.netPay}',
          //                                     style:ThemeManager.customTextStyle(
          //                                         context),
          //                                   ),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(termination.methods,
          //                                       style: ThemeManager.customTextStyle(
          //                                           context)),
          //                                   const SizedBox(height: AppSize.s10),
          //                                   Text(termination.materials,
          //                                       style: ThemeManager.customTextStyle(
          //                                           context)),
          //                                   SizedBox(
          //                                       height: 30
          //                                   )
          //                                 ],
          //                               ),
          //                             ],
          //                           )
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 );
          //             })),
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
          // }
          return const SizedBox();
        });
  }
}

///add termination
class TerminatePopup extends StatefulWidget {
  final int employeeId;
  final TerminateEmployeePrefillData preFillData;
  TerminatePopup(
      {super.key, required this.employeeId, required this.preFillData});
  @override
  State<TerminatePopup> createState() => _TerminatePopupState();
}

class _TerminatePopupState extends State<TerminatePopup> {
  TextEditingController terminationdatecltr = TextEditingController();
  TextEditingController namecltr = TextEditingController();
  TextEditingController resignationdatecltr = TextEditingController();
  TextEditingController dateofhirecltr = TextEditingController();
  TextEditingController materialscltr = TextEditingController();
  TextEditingController methodscltr = TextEditingController();
  TextEditingController rehirablecltr = TextEditingController();
  TextEditingController phonenocltr = TextEditingController();
  TextEditingController finaladdrescltr = TextEditingController();
  TextEditingController finalpaycheckcltr = TextEditingController();
  TextEditingController typecltr = TextEditingController();
  TextEditingController reasoncltr = TextEditingController();
  TextEditingController statuscltr = TextEditingController();
  TextEditingController positioncltr = TextEditingController();
  TextEditingController grosspaycltr = TextEditingController();
  TextEditingController netpaycltr = TextEditingController();
  TextEditingController datecltr = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    terminationdatecltr =
        TextEditingController(text: widget.preFillData.dateofTermination);
    namecltr = TextEditingController(text: widget.preFillData.firstName);
    resignationdatecltr =
        TextEditingController(text: widget.preFillData.dateofResignation);
    dateofhirecltr = TextEditingController(text: widget.preFillData.dateofHire);
    materialscltr = TextEditingController(text: widget.preFillData.materials);
    methodscltr = TextEditingController(text: widget.preFillData.methods);
    rehirablecltr = TextEditingController(text: widget.preFillData.rehirable);
    phonenocltr =
        TextEditingController(text: widget.preFillData.primaryPhoneNbr);
    finaladdrescltr =
        TextEditingController(text: widget.preFillData.finalAddress);
    finalpaycheckcltr = TextEditingController(
        text: widget.preFillData.finalPayCheck.toString());
    typecltr = TextEditingController(text: widget.preFillData.type);
    reasoncltr = TextEditingController(text: widget.preFillData.reason);
    statuscltr = TextEditingController(text: widget.preFillData.status);
    positioncltr = TextEditingController(text: widget.preFillData.position);
    grosspaycltr =
        TextEditingController(text: widget.preFillData.grossPay.toString());
    netpaycltr =
        TextEditingController(text: widget.preFillData.netPay.toString());
    datecltr = TextEditingController(text: widget.preFillData.checkDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TerminationDialogueTemplate(
      width: 800,
      height: 800,
      body: [
        SingleChildScrollView(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstHRTextFConst(
                        controller: namecltr,
                        keyboardType: TextInputType.text,
                        text: 'Name'),
                    HeaderContentConst(
                      heading: "Termination Date",
                      content: FormField<String>(
                        builder: (FormFieldState<String> field) {
                          return SizedBox(
                            width: 300,
                            height: 30,
                            child: TextFormField(
                              controller: terminationdatecltr,
                              cursorColor: ColorManager.black,
                              style: DocumentTypeDataStyle.customTextStyle(
                                  context),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'MM-DD-YYYY',
                                hintStyle:
                                    DocumentTypeDataStyle.customTextStyle(
                                        context),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: ColorManager.fmediumgrey),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                suffixIcon: Icon(Icons.calendar_month_outlined,
                                    color: ColorManager.blueprime),
                                errorText: field.errorText,
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1901),
                                  lastDate: DateTime(3101),
                                );
                                if (pickedDate != null) {
                                  terminationdatecltr.text =
                                      "${pickedDate.toLocal()}".split(' ')[0];
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please select date';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    HeaderContentConst(
                      heading: "Resignation Date",
                      content: FormField<String>(
                        builder: (FormFieldState<String> field) {
                          return SizedBox(
                            width: 300,
                            height: 30,
                            child: TextFormField(
                              controller: resignationdatecltr,
                              cursorColor: ColorManager.black,
                              style: DocumentTypeDataStyle.customTextStyle(
                                  context),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'MM-DD-YYYY',
                                hintStyle:
                                    DocumentTypeDataStyle.customTextStyle(
                                        context),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: ColorManager.fmediumgrey),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                suffixIcon: Icon(Icons.calendar_month_outlined,
                                    color: ColorManager.blueprime),
                                errorText: field.errorText,
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1901),
                                  lastDate: DateTime(3101),
                                );
                                if (pickedDate != null) {
                                  resignationdatecltr.text =
                                      "${pickedDate.toLocal()}".split(' ')[0];
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please select date';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    HeaderContentConst(
                      heading: "Date of Hire",
                      content: FormField<String>(
                        builder: (FormFieldState<String> field) {
                          return SizedBox(
                            width: 300,
                            height: 30,
                            child: TextFormField(
                              controller: dateofhirecltr,
                              cursorColor: ColorManager.black,
                              style: DocumentTypeDataStyle.customTextStyle(
                                  context),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorManager.fmediumgrey,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                hintText: 'MM-DD-YYYY',
                                hintStyle:
                                    DocumentTypeDataStyle.customTextStyle(
                                        context),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: ColorManager.fmediumgrey),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                suffixIcon: Icon(Icons.calendar_month_outlined,
                                    color: ColorManager.blueprime),
                                errorText: field.errorText,
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1901),
                                  lastDate: DateTime(3101),
                                );
                                if (pickedDate != null) {
                                  dateofhirecltr.text =
                                      "${pickedDate.toLocal()}".split(' ')[0];
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please select date';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    FirstHRTextFConst(
                        controller: positioncltr,
                        keyboardType: TextInputType.text,
                        text: 'Position:'),
                    FirstHRTextFConst(
                        controller: phonenocltr,
                        keyboardType: TextInputType.number,
                        text: 'Phone No.'),
                    FirstHRTextFConst(
                        controller: rehirablecltr,
                        keyboardType: TextInputType.text,
                        text: 'Rehirable'),
                    // FirstHRTextFConst(controller: rehirablecltr, keyboardType: TextInputType.text, text: ''),
                    FirstHRTextFConst(
                        controller: finaladdrescltr,
                        keyboardType: TextInputType.text,
                        text: 'Final Address'),
                  ],
                ),
                // SizedBox(
                //   width: 20,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstHRTextFConst(
                        controller: typecltr,
                        keyboardType: TextInputType.text,
                        text: 'Type'),
                    FirstHRTextFConst(
                        controller: reasoncltr,
                        keyboardType: TextInputType.text,
                        text: 'Reason'),
                    FirstHRTextFConst(
                        controller: finalpaycheckcltr,
                        keyboardType: TextInputType.text,
                        text: 'Final Paycheck'),
                    FirstHRTextFConst(
                        controller: datecltr,
                        keyboardType: TextInputType.text,
                        text: 'Date'),
                    FirstHRTextFConst(
                        controller: grosspaycltr,
                        keyboardType: TextInputType.text,
                        text: 'Gross Pay'),
                    FirstHRTextFConst(
                        controller: netpaycltr,
                        keyboardType: TextInputType.text,
                        text: 'Net Pay'),
                    FirstHRTextFConst(
                        controller: methodscltr,
                        keyboardType: TextInputType.text,
                        text: 'Methods'),
                    FirstHRTextFConst(
                        controller: materialscltr,
                        keyboardType: TextInputType.text,
                        text: 'Materials'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
      bottomButtons: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtonTransparent(
            text: AppString.cancel,
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 25),
          CustomElevatedButton(
            width: AppSize.s100,
            text: "Terminate",
            onPressed: () async {
              var response = await patchEmployeeTermination(
                context: context,
                employeeId: widget.employeeId,
                dateofTermination: widget.preFillData.dateofTermination ==
                        terminationdatecltr.text
                    ? widget.preFillData.dateofTermination
                    : terminationdatecltr.text,
                dateofResignation: widget.preFillData.dateofResignation ==
                        resignationdatecltr.text
                    ? widget.preFillData.dateofResignation
                    : resignationdatecltr.text,
                dateofHire: widget.preFillData.dateofHire == dateofhirecltr.text
                    ? widget.preFillData.dateofHire
                    : dateofhirecltr.text,
                rehirable: widget.preFillData.rehirable == rehirablecltr.text
                    ? widget.preFillData.rehirable
                    : rehirablecltr.text,
                position: widget.preFillData.position == positioncltr.text
                    ? widget.preFillData.position
                    : positioncltr.text,
                finalAddress:
                    widget.preFillData.finalAddress == finaladdrescltr.text
                        ? widget.preFillData.finalAddress
                        : finaladdrescltr.text,
                type: widget.preFillData.type == typecltr.text
                    ? widget.preFillData.type
                    : typecltr.text,
                reason: widget.preFillData.reason == reasoncltr.text
                    ? widget.preFillData.reason
                    : reasoncltr.text,
                finalPayCheck: widget.preFillData.finalPayCheck ==
                        double.parse(finalpaycheckcltr.text)
                    ? widget.preFillData.finalPayCheck
                    : double.parse(finalpaycheckcltr.text),
                checkDate: widget.preFillData.checkDate == datecltr.text
                    ? widget.preFillData.checkDate
                    : datecltr.text,
                grossPay: widget.preFillData.grossPay ==
                        double.parse(grosspaycltr.text)
                    ? widget.preFillData.grossPay
                    : double.parse(grosspaycltr.text),
                netPay:
                    widget.preFillData.netPay == double.parse(netpaycltr.text)
                        ? widget.preFillData.netPay
                        : double.parse(netpaycltr.text),
                methods: widget.preFillData.methods == methodscltr.text
                    ? widget.preFillData.methods
                    : methodscltr.text,
                materials: widget.preFillData.materials == materialscltr.text
                    ? widget.preFillData.materials
                    : materialscltr.text,
                status: widget.preFillData.status == statuscltr.text
                    ? widget.preFillData.status
                    : statuscltr.text,
              );
              Navigator.pop(context);
              if (response.statusCode == 200 || response.statusCode == 201) {
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // Future.delayed(
                    //   const Duration(seconds: 3),
                    //       () {
                    //     if (Navigator.of(context).canPop()) {
                    //       Navigator.of(context).pop();
                    //     }
                    //   },
                    // );
                    return const AddSuccessPopup(
                      message: 'Employee Terminated Successfully',
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      title: "Terminate",
      // height:MediaQuery.of(context).size.height/1,
    );
  }
}
