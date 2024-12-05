// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_referral/widget/referral_agency_info/intake_agency_info_screen.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_referral/widget/referral_agency_info/intake_referral_submit_popup.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_referral/widget/referral_referral_info/intake_referal_info_screen.dart';
//
// import '../../../../../../app/resources/color.dart';
// import '../../../../../../app/resources/font_manager.dart';
// import '../../../widgets/constant_widgets/schedular_success_popup.dart';
//
// class SMIntakeReferralScreen extends StatefulWidget {
//   final int patientId;
//   const SMIntakeReferralScreen({super.key, required this.patientId});
//
//   @override
//   State<SMIntakeReferralScreen> createState() => _SMIntakeReferralScreenState();
// }
//
// class _SMIntakeReferralScreenState extends State<SMIntakeReferralScreen> {
//   int selectedIndex = 0;
//   final PageController smIntakePageController = PageController();
//
//   void selectButton(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//
//     smIntakePageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//       children: [
//         SizedBox(height: AppSize.s15,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width/5,
//               height: AppSize.s30,
//               decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.5),
//                       offset: Offset(0, 4),
//                       blurRadius: 4,
//                       spreadRadius: 0,
//                     ),
//                   ],
//                   color: ColorManager.blueprime,
//                   borderRadius: BorderRadius.circular(14)
//               ),
//               child: Row(
//                 children: [
//                   InkWell(
//                     child: Container(
//                       height: AppSize.s30,
//                       width: MediaQuery.of(context).size.width / 10,
//                       padding: EdgeInsets.symmetric(vertical: 6),
//                       decoration: BoxDecoration(
//
//                         borderRadius: BorderRadius.circular(20),
//                         color: selectedIndex == 0
//                             ? ColorManager.white
//                             : null,
//                       ),
//                       child: Text(
//                         'Referral Info',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.firaSans(
//                           fontSize: FontSize.s14,
//                           fontWeight: FontWeightManager.semiBold,
//                           color: selectedIndex == 0
//                               ? ColorManager.mediumgrey
//                               : ColorManager.white,
//                         ),
//                       ),
//                     ),
//                     onTap: () => selectButton(0),
//                   ),
//                   InkWell(
//                     child: Container(
//                       height: AppSize.s30,
//                       width: MediaQuery.of(context).size.width / 10,
//                       padding: EdgeInsets.symmetric(vertical: 6),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: selectedIndex == 1
//                             ? ColorManager.white
//                             : null,
//                       ),
//                       child: Text(
//                         'Agency Info',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.firaSans(
//                           fontSize: FontSize.s14,
//                           fontWeight: FontWeightManager.semiBold,
//                           color: selectedIndex == 1
//                               ? ColorManager.mediumgrey
//                               : ColorManager.white,
//                         ),
//                       ),
//                     ),
//                     onTap: () => selectButton(1),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width/3.5),
//             Padding(
//               padding: const EdgeInsets.only(right: 40.0),
//               child: Container(
//                 height: AppSize.s26,
//                 width: AppSize.s102,
//                 // child: ElevatedButton(
//                 //   onPressed: () {
//                 //     showDialog(
//                 //       context: context,
//                 //       builder: (BuildContext context) {
//                 //         return ReferralSubmitPopup();
//                 //       },
//                 //     );
//                 //   },
//                 //   child: Text(AppString.save,
//                 //     style: GoogleFonts.firaSans(
//                 //       fontSize: FontSize.s12,
//                 //       fontWeight: FontWeightManager.bold,
//                 //       color: ColorManager.white,
//                 //     ),
//                 //   ),
//                 //   style: ElevatedButton.styleFrom(
//                 //     padding: const EdgeInsets.symmetric(
//                 //       horizontal: 25,
//                 //       vertical: 10,
//                 //     ),
//                 //     backgroundColor: ColorManager.blueprime,
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(12),
//                 //     ),
//                 //   ),
//                 // ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: AppSize.s10,
//         ),
//         Expanded(
//           flex: 10,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               //horizontal: MediaQuery.of(context).size.width / 45,
//                 vertical: 5),
//             child: PageView(
//                 controller: smIntakePageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   IntakeReferralInfoScreen(patientId: widget.patientId,),
//                   IntakeAgencyInfoScreen(patientId: widget.patientId,),
//                 ]),
//           ),
//         ),
//       ],
//     );
//   }
// }
