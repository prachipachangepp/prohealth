// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import '../../../../../../../app/resources/color.dart';
// import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
// import '../../../../../../../app/resources/font_manager.dart';
//
// class SearchPatientPopUp extends StatefulWidget {
//   const SearchPatientPopUp({super.key});
//
//   @override
//   State<SearchPatientPopUp> createState() => _SearchPatientPopUpState();
// }
//
// class _SearchPatientPopUpState extends State<SearchPatientPopUp> {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       backgroundColor: Colors.white,
//       titlePadding: EdgeInsets.zero,
//       title: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           color: ColorManager.blueprime,
//         ),
//         height: 47,
//         width: 1280,
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Search Patient',
//                 style: GoogleFonts.firaSans(
//                   fontSize: FontSize.s14,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
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
//                 color: Colors.white,
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
//               width: MediaQuery.of(context).size.width/1,
//               height: 300,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           height: 25,
//                           width: 598,
//                           child: TextField(
//                             decoration: InputDecoration(
//                               labelText: 'Search for a patient',
//                               labelStyle: GoogleFonts.firaSans(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.regular,
//                                 color: ColorManager.greylight,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12.0),
//                                 borderSide: BorderSide(
//                                   color: ColorManager.containerBorderGrey,
//                                   width: 1.0,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12.0),
//                                 borderSide: BorderSide(
//                                   color: ColorManager.containerBorderGrey,
//                                   width: 1.0,
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12.0),
//                                 borderSide: BorderSide(
//                                   color: ColorManager.containerBorderGrey,
//                                   width: 1.0,
//                                 ),
//                               ),
//                               suffixIcon: Icon(
//                                 Icons.search,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text('DZ',
//                         style: GoogleFonts.firaSans(
//                           fontWeight: FontWeightManager.regular,
//                           fontSize: FontSize.s11,
//                           color: ColorManager.black
//                         ),),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(
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
//                   SizedBox(height: 20),
//                   Container(
//                     height: 30,
//                     decoration: BoxDecoration(
//                       color: ColorManager.mediumgrey,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 80.0),
//                             child: Text(
//                               'Sr.No.',
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 5.0),
//                             child: Text(
//                               'Type',
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(AppString.name,
//                             style: AllHRTableHeading.customTextStyle(context),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 4,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 25.0),
//                             child: Text(
//                               'Location',
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 25.0),
//                             child: Text(
//                               'Case',
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 25.0),
//                             child: Text(AppString.status,
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     height: 30,
//                     color: ColorManager.blueprime.withOpacity(0.17),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 80.0),
//                       child: Row(
//                         children: [
//                           Text('01',
//                           style: TextStyle(
//                             fontSize: FontSize.s10,
//                             fontWeight: FontWeightManager.medium,
//                             color: ColorManager.darkgray
//                           ),),
//                           SizedBox(width: MediaQuery.of(context).size.width/13,),
//                           Text('RN',
//                             style: TextStyle(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.darkgray
//                             ),),
//                           SizedBox(width:  MediaQuery.of(context).size.width/10,),
//                           Text('Dhillon Amarpreet',
//                             style: TextStyle(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.darkgray
//                             ),),
//                           SizedBox(width:  MediaQuery.of(context).size.width/13,),
//                           Text('ProHealth Walnut Creek-EI Dorado Sacramento',
//                             style: TextStyle(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.darkgray
//                             ),),
//                           SizedBox(width:  MediaQuery.of(context).size.width/7.4,),
//                           Text('Infection control',
//                             style: TextStyle(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: ColorManager.darkgray
//                             ),),
//                           SizedBox(width:  MediaQuery.of(context).size.width/11,),
//                           Text('Un-Scheduled',
//                             style: TextStyle(
//                                 fontSize: FontSize.s10,
//                                 fontWeight: FontWeightManager.medium,
//                                 color: Color(0xffB4DB4C)
//                             ),),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import '../../../../../../../app/resources/color.dart';
// import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
// import '../../../../../../../app/resources/font_manager.dart';
//
// class SearchPatientPopUp extends StatefulWidget {
//   const SearchPatientPopUp({super.key});
//
//   @override
//   State<SearchPatientPopUp> createState() => _SearchPatientPopUpState();
// }
//
// class _SearchPatientPopUpState extends State<SearchPatientPopUp> {
//   final List<Map<String, String>> patients = [
//     {
//       "srNo": "01",
//       "type": "RN",
//       "name": "Dhillon Amarpreet",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "case": "Infection control",
//       "status": "Un-Scheduled"
//     },
//     {
//       "srNo": "02",
//       "type": "NC",
//       "name": "Phan Steven",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "case": "Wound Care",
//       "status": "Scheduled"
//     },
//     {
//       "srNo": "03",
//       "type": "PT",
//       "name": "Dhillon Amarpreet",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "case": "Diabetes Management",
//       "status": "Un-Scheduled"
//     },
//     {
//       "srNo": "04",
//       "type": "RN",
//       "name": "Don Enrique",
//       "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
//       "case": "Infection control",
//       "status": "Un-Scheduled"
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       backgroundColor: Colors.white,
//       titlePadding: EdgeInsets.zero,
//       title: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           color: ColorManager.blueprime,
//         ),
//         height: 47,
//         width: 1280,
//         child: Row(
//           children: [
//             Padding(
//               padding:  EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Search Patient',
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
//               width: 1280,
//               height: 300,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         height: 25,
//                         width: 598,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             labelText: 'Search for a patient',
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
//                       SizedBox(width: 10),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text(
//                           'DZ',
//                           style: GoogleFonts.firaSans(
//                             fontWeight: FontWeightManager.regular,
//                             fontSize: FontSize.s11,
//                             color: ColorManager.black,
//                           ),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           padding:  EdgeInsets.symmetric(
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
//                   SizedBox(height: 20),
//                   Container(
//                     height: 29,
//                     width: 1240,
//                     decoration: BoxDecoration(
//                       color: ColorManager.granitegray,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Flexible(
//                           flex: 1,
//                           child: Padding(
//                             padding:  EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               'Sr.No.',
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Flexible(
//                           flex: 1,
//                           child: Padding(
//                             padding:  EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               'Type',
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Flexible(
//                           flex: 2,
//                           child: Padding(
//                             padding:  EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               AppString.name,
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Flexible(
//                           flex: 3,
//                           child: Padding(
//                             padding:  EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               'Location',
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding:  EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               'Case',
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding:  EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Text(
//                               AppString.status,
//                               style: AllHRTableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: patients.length,
//                       itemBuilder: (context, index) {
//                         final patient = patients[index];
//                         final statusColor = patient['status'] == 'Scheduled'
//                             ? Colors.red
//                             : Color(0xffB4DB4C);
//
//                         return Container(
//                           height: 30,
//                           color: index.isEven
//                               ? ColorManager.blueprime.withOpacity(0.17)
//                               : Colors.white,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Padding(
//                                   padding:
//                                    EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Text(
//                                     patient['srNo']!,
//                                     style: TextStyle(
//                                       fontSize: FontSize.s10,
//                                       fontWeight: FontWeightManager.medium,
//                                       color: ColorManager.darkgray,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: Padding(
//                                   padding:
//                                    EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Text(
//                                     patient['type']!,
//                                     style: TextStyle(
//                                       fontSize: FontSize.s10,
//                                       fontWeight: FontWeightManager.medium,
//                                       color: ColorManager.darkgray,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Padding(
//                                   padding:
//                                    EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Text(
//                                     patient['name']!,
//                                     style: TextStyle(
//                                       fontSize: FontSize.s10,
//                                       fontWeight: FontWeightManager.medium,
//                                       color: ColorManager.darkgray,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding:
//                                    EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Text(
//                                     patient['location']!,
//                                     style: TextStyle(
//                                       fontSize: FontSize.s10,
//                                       fontWeight: FontWeightManager.medium,
//                                       color: ColorManager.darkgray,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Padding(
//                                   padding:
//                                    EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Text(
//                                     patient['case']!,
//                                     style: TextStyle(
//                                       fontSize: FontSize.s10,
//                                       fontWeight: FontWeightManager.medium,
//                                       color: ColorManager.darkgray,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Padding(
//                                   padding:
//                                    EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Text(
//                                     patient['status']!,
//                                     style: TextStyle(
//                                       fontSize: FontSize.s10,
//                                       fontWeight: FontWeightManager.medium,
//                                       color: statusColor,
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


import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';

class SearchPatientPopUp extends StatefulWidget {
  const SearchPatientPopUp({super.key});

  @override
  State<SearchPatientPopUp> createState() => _SearchPatientPopUpState();
}

class _SearchPatientPopUpState extends State<SearchPatientPopUp> {
  final List<Map<String, String>> patients = [
    {
      "srNo": "01",
      "type": "RN",
      "name": "Dhillon Amarpreet",
      "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
      "case": "Infection control",
      "status": "Un-Scheduled"
    },
    {
      "srNo": "02",
      "type": "NC",
      "name": "Phan Steven",
      "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
      "case": "Wound Care",
      "status": "Scheduled"
    },
    {
      "srNo": "03",
      "type": "PT",
      "name": "Dhillon Amarpreet",
      "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
      "case": "Diabetes Management",
      "status": "Un-Scheduled"
    },
    {
      "srNo": "04",
      "type": "RN",
      "name": "Don Enrique",
      "location": "ProHealth Walnut Creek-EI Dorado Sacramento",
      "case": "Infection control",
      "status": "Un-Scheduled"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: ColorManager.blueprime,
        ),
        height: AppSize.s47,
        width: AppSize.s1280,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Search Patient',
                style: CustomTextStylesCommon.commonStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: ColorManager.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: AppSize.s300,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: AppSize.s25,
                        width: AppSize.s598,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Search for a patient',
                            labelStyle: CustomTextStylesCommon.commonStyle(
                              fontSize: FontSize.s10,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.greylight,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: ColorManager.containerBorderGrey,
                                width:  AppSize.s1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: ColorManager.containerBorderGrey,
                                width: AppSize.s1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: ColorManager.containerBorderGrey,
                                width:  AppSize.s1,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSize.s10),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'DZ',
                          style: CustomTextStylesCommon.commonStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.s13,
                            color: ColorManager.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.s20),
                  Container(
                    height: AppSize.s29,
                    // width: 1260,
                    decoration: BoxDecoration(
                      color: ColorManager.granitegray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Sr.No.',
                                style: CustomTextStylesCommon.commonStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppString.type,
                                style: CustomTextStylesCommon.commonStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppString.name,
                                style: CustomTextStylesCommon.commonStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppString.location,
                                style: CustomTextStylesCommon.commonStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Case',
                                style: CustomTextStylesCommon.commonStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppString.status,
                                style: CustomTextStylesCommon.commonStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.s10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: patients.length,
                      itemBuilder: (context, index) {
                        final patient = patients[index];
                        final statusColor = patient['status'] == 'Scheduled'
                            ? ColorManager.red
                            : Color(0xffB4DB4C);

                        return Container(
                          height: AppSize.s30,
                          color: index.isEven
                              ? ColorManager.blueprime.withOpacity(0.17)
                              : ColorManager.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      patient['srNo']!,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontSize: FontSize.s10,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.darkgray,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      patient['type']!,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontSize: FontSize.s10,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.darkgray,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      patient['name']!,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontSize: FontSize.s10,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.darkgray,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      patient['location']!,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontSize: FontSize.s10,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.darkgray,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      patient['case']!,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontSize: FontSize.s10,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.darkgray,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      patient['status']!,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontSize: FontSize.s10,
                                        fontWeight: FontWeight.w500,
                                        color: statusColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
