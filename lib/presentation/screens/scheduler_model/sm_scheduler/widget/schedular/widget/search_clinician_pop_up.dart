// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:prohealth/app/resources/const_string.dart';
// // import '../../../../../../../app/resources/color.dart';
// // import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
// // import '../../../../../../../app/resources/font_manager.dart';
// //
// // class SearchClinicianPopUp extends StatefulWidget {
// //   const SearchClinicianPopUp({super.key});
// //
// //   @override
// //   State<SearchClinicianPopUp> createState() => _SearchPatientPopUpState();
// // }
// //
// // class _SearchPatientPopUpState extends State<SearchClinicianPopUp> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(20.0),
// //       ),
// //       backgroundColor: Colors.white,
// //       titlePadding: EdgeInsets.zero,
// //       title: Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(20.0),
// //             topRight: Radius.circular(20.0),
// //           ),
// //           color: ColorManager.blueprime,
// //         ),
// //         height: 47,
// //         width: 1280,
// //         child: Row(
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //               child: Text(
// //                 'Search Patient',
// //                 style: GoogleFonts.firaSans(
// //                   fontSize: FontSize.s14,
// //                   fontWeight: FontWeight.w700,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ),
// //             Spacer(),
// //             IconButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //               },
// //               icon: Icon(
// //                 Icons.close,
// //                 color: Colors.white,
// //
// //               ),
// //               splashColor: Colors.transparent,
// //               highlightColor: Colors.transparent,
// //               hoverColor: Colors.transparent,
// //             ),
// //           ],
// //         ),
// //       ),
// //       content: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             Container(
// //               width: MediaQuery.of(context).size.width/1,
// //               height: 300,
// //               child: Column(
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: Container(
// //                           height: 25,
// //                           child: TextField(
// //                             decoration: InputDecoration(
// //                               labelText: 'Search for a patient',
// //                               labelStyle: GoogleFonts.firaSans(
// //                                 fontSize: FontSize.s10,
// //                                 fontWeight: FontWeightManager.regular,
// //                                 color: ColorManager.greylight,
// //                               ),
// //                               border: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.circular(12.0),
// //                                 borderSide: BorderSide(
// //                                   color: ColorManager.containerBorderGrey,
// //                                   width: 1.0,
// //                                 ),
// //                               ),
// //                               enabledBorder: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.circular(12.0),
// //                                 borderSide: BorderSide(
// //                                   color: ColorManager.containerBorderGrey,
// //                                   width: 1.0,
// //                                 ),
// //                               ),
// //                               focusedBorder: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.circular(12.0),
// //                                 borderSide: BorderSide(
// //                                   color: ColorManager.containerBorderGrey,
// //                                   width: 1.0,
// //                                 ),
// //                               ),
// //                               suffixIcon: Icon(
// //                                 Icons.search,
// //                                 color: Colors.grey,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(width: 10),
// //                       ElevatedButton(
// //                         onPressed: () {},
// //                         child: Text('DZ',
// //                           style: GoogleFonts.firaSans(
// //                               fontWeight: FontWeightManager.regular,
// //                               fontSize: FontSize.s11,
// //                               color: ColorManager.black
// //                           ),),
// //                         style: ElevatedButton.styleFrom(
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: 20,
// //                             vertical: 10,
// //                           ),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(8.0),
// //                           ),
// //                           backgroundColor: Colors.white,
// //                           foregroundColor: Colors.black,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   SizedBox(height: 20),
// //                   Container(
// //                     height: 30,
// //                     decoration: BoxDecoration(
// //                       color: ColorManager.mediumgrey,
// //                       borderRadius: BorderRadius.circular(12),
// //                     ),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                       children: [
// //                         Expanded(
// //                           flex: 2,
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(left: 80.0),
// //                             child: Text(
// //                               'Sr.No.',
// //                               style: AllHRTableHeading.customTextStyle(context),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(width: 24.86),
// //                         Expanded(
// //                           flex: 2,
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(left: 5.0),
// //                             child: Text(
// //                               'Type',
// //                               style: AllHRTableHeading.customTextStyle(context),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(width: 32.29),
// //                         Expanded(
// //                           flex: 2,
// //                           child: Text(AppString.name,
// //                             style: AllHRTableHeading.customTextStyle(context),
// //                           ),
// //                         ),
// //                         SizedBox(width: 198.7),
// //                         Expanded(
// //                           flex: 4,
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(left: 25.0),
// //                             child: Text(
// //                               'Location',
// //                               style: AllHRTableHeading.customTextStyle(context),
// //                             ),
// //                           ),
// //                         ),
// //                         Expanded(
// //                           flex: 2,
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(left: 25.0),
// //                             child: Text(
// //                               'Specialisation',
// //                               style: AllHRTableHeading.customTextStyle(context),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: 10),
// //                   Container(
// //                     height: 30,
// //                     color: ColorManager.blueprime.withOpacity(0.17),
// //                     child: Padding(
// //                       padding: const EdgeInsets.only(left: 80.0),
// //                       child: Row(
// //                         children: [
// //                           Text('01',
// //                             style: TextStyle(
// //                                 fontSize: FontSize.s10,
// //                                 fontWeight: FontWeightManager.medium,
// //                                 color: ColorManager.darkgray
// //                             ),),
// //                           SizedBox(width: MediaQuery.of(context).size.width/13,),
// //                           Text('RN',
// //                             style: TextStyle(
// //                                 fontSize: FontSize.s10,
// //                                 fontWeight: FontWeightManager.medium,
// //                                 color: ColorManager.darkgray
// //                             ),),
// //                           SizedBox(width:  MediaQuery.of(context).size.width/10,),
// //                           Text('Dhillon Amarpreet',
// //                             style: TextStyle(
// //                                 fontSize: FontSize.s10,
// //                                 fontWeight: FontWeightManager.medium,
// //                                 color: ColorManager.darkgray
// //                             ),),
// //                           SizedBox(width:  MediaQuery.of(context).size.width/13,),
// //                           Text('ProHealth Walnut Creek-EI Dorado Sacramento',
// //                             style: TextStyle(
// //                                 fontSize: FontSize.s10,
// //                                 fontWeight: FontWeightManager.medium,
// //                                 color: ColorManager.darkgray
// //                             ),),
// //                           SizedBox(width:  MediaQuery.of(context).size.width/7.4,),
// //                           Text('Infection control',
// //                             style: TextStyle(
// //                                 fontSize: FontSize.s10,
// //                                 fontWeight: FontWeightManager.medium,
// //                                 color: ColorManager.darkgray
// //                             ),),
// //
// //                         ],
// //                       ),
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import '../../../../../../../app/resources/color.dart';
// import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
// import '../../../../../../../app/resources/font_manager.dart';
//
// class SearchClinicianPopUp extends StatefulWidget {
//   const SearchClinicianPopUp({super.key});
//
//   @override
//   State<SearchClinicianPopUp> createState() => _SearchClinicianPopUpState();
// }
//
// class _SearchClinicianPopUpState extends State<SearchClinicianPopUp> {
//   final List<Map<String, String>> clinicians = [
//     {
//       "srNo": "01",
//       "type": "RN",
//       "name": "Dhillon Amarpreet",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "specialisation": "Infection control"
//     },
//     {
//       "srNo": "02",
//       "type": "NC",
//       "name": "Phan Steven",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "specialisation": "Wound Care"
//     },
//     {
//       "srNo": "03",
//       "type": "PT",
//       "name": "Dhillon Amarpreet",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "specialisation": "Diabetes Management"
//     },
//     {
//       "srNo": "04",
//       "type": "RN",
//       "name": "Don Enrique",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "specialisation": "Infection control"
//     },
//     {
//       "srNo": "05",
//       "type": "NC",
//       "name": "Dhillon Amarpreet",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "specialisation": "Diabetes Management"
//     },
//     {
//       "srNo": "06",
//       "type": "PT",
//       "name": "Don Enrique",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "specialisation": "Wound Care"
//     },
//     {
//       "srNo": "09",
//       "type": "NC",
//       "name": "Dhillon Amarpreet",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "specialisation": "Infection control"
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       backgroundColor: ColorManager.white,
//       titlePadding: EdgeInsets.zero,
//       title: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           color: ColorManager.blueprime,
//         ),
//         height: AppSize.s47,
//         width: AppSize.s1280,
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Search Clinician',
//                 style: GoogleFonts.firaSans(
//                   fontSize: FontSize.s14,
//                   fontWeight: FontWeightManager.bold,
//                   color: ColorManager.white,
//                 ),
//               ),
//             ),
//             Spacer(),
//             IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 Icons.close,
//                 color: ColorManager.white,
//               ),
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               hoverColor: Colors.transparent,
//             ),
//           ],
//         ),
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: AppSize.s300,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         // height: MediaQuery.of(context).size.height/20,
//                         // width: MediaQuery.of(context).size.width/50,
//                         height: AppSize.s25,
//                         width: AppSize.s598,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             labelText: 'Search for a clinican',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: FontSize.s10,
//                               fontWeight: FontWeightManager.regular,
//                               color: ColorManager.greylight,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: BorderSide(
//                                 color: ColorManager.containerBorderGrey,
//                                 width: 1.0,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: BorderSide(
//                                 color: ColorManager.containerBorderGrey,
//                                 width: 1.0,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                               borderSide: BorderSide(
//                                 color: ColorManager.containerBorderGrey,
//                                 width: 1.0,
//                               ),
//                             ),
//                             suffixIcon: Icon(
//                               Icons.search,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: AppSize.s23),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text(
//                           'DZ',
//                           style: GoogleFonts.firaSans(
//                             fontWeight: FontWeightManager.regular,
//                             fontSize: FontSize.s13,
//                             color: ColorManager.black,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 10,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: AppSize.s26),
//                   Container(
//                     height: AppSize.s29,
//                     decoration: BoxDecoration(
//                       color: ColorManager.granitegray,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 'Sr.No.',
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: FontSize.s14,
//                                   fontWeight: FontWeightManager.bold,
//                                   color: ColorManager.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 AppString.type,
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: FontSize.s14,
//                                   fontWeight: FontWeightManager.bold,
//                                   color: ColorManager.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 AppString.name,
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: FontSize.s14,
//                                   fontWeight: FontWeightManager.bold,
//                                   color: ColorManager.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 AppString.location,
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: FontSize.s14,
//                                   fontWeight: FontWeightManager.bold,
//                                   color: ColorManager.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 AppString.specialisation,
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: FontSize.s14,
//                                   fontWeight: FontWeightManager.bold,
//                                   color: ColorManager.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: AppSize.s9),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: clinicians.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           height: AppSize.s30,
//                           color: index.isEven
//                               ? ColorManager.blueprime.withOpacity(0.17)
//                               : Colors.white,
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       clinicians[index]['srNo']!,
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: FontSize.s10,
//                                         fontWeight: FontWeightManager.medium,
//                                         color: ColorManager.darkgray,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       clinicians[index]['type']!,
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: FontSize.s10,
//                                         fontWeight: FontWeightManager.medium,
//                                         color: ColorManager.darkgray,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       clinicians[index]['name']!,
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: FontSize.s10,
//                                         fontWeight: FontWeightManager.medium,
//                                         color: ColorManager.darkgray,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 4,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       clinicians[index]['location']!,
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: FontSize.s10,
//                                         fontWeight: FontWeightManager.medium,
//                                         color: ColorManager.darkgray,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       clinicians[index]['specialisation']!,
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: FontSize.s10,
//                                         fontWeight: FontWeightManager.medium,
//                                         color: ColorManager.darkgray,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
