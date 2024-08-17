// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../../../app/resources/color.dart';
// import '../../../../../../app/resources/const_string.dart';
// import '../../../../../../app/resources/font_manager.dart';
// import '../../../../../../app/resources/theme_manager.dart';
// import '../../../../../../app/resources/value_manager.dart';
// import '../../../../../app/services/api/managers/hr_module_manager/see_all/see_all_manager.dart';
// import '../../../../../data/api_data/hr_module_data/see_all_data/see_all_data.dart';
//
//
// class OnboardingGeneral extends StatefulWidget {
//   final void Function(int,int) selectButton;
//   const OnboardingGeneral({Key? key, required this.selectButton}) : super(key: key);
//
//   @override
//   State<OnboardingGeneral> createState() => _OnboardingGeneralState();
// }
//
// class _OnboardingGeneralState extends State<OnboardingGeneral> {
//   final StreamController<List<SeeAllData>> generalController =
//   StreamController<List<SeeAllData>>();
//   @override
//   void initState() {
//     super.initState();
//     getEmployeeSeeAll(context).then((data) {
//       final filteredData = data.where((item) =>
//       item.status == 'Partial' || item.status == 'Opened').toList();
//       generalController.add(filteredData);
//     }).catchError((error) {});
//   }
//   int currentPage = 1;
//   final int itemsPerPage = 10;
//   final int totalPages = 5;
//
//   void onPageNumberPressed(int pageNumber) {
//     setState(() {
//       currentPage = pageNumber;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     double containerWidth = MediaQuery.of(context).size.width * 0.9;
//     double containerHeight = MediaQuery.of(context).size.height * 0.2;
//     return Column(
//       children: [
//         Expanded(
//           child: StreamBuilder<List<SeeAllData>>(
//             stream: generalController.stream,
//             builder: (context, snapshot) {
//               print('1111111');
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: ColorManager.blueprime,
//                   ),
//                 );
//               }
//               if (snapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text(
//                     AppString.dataNotFound,
//                     style: CustomTextStylesCommon.commonStyle(
//                       fontWeight: FontWeightManager.medium,
//                       fontSize: FontSize.s12,
//                       color: ColorManager.mediumgrey,
//                     ),
//                   ),
//                 );
//               }
//               if (snapshot.hasData) {
//                 int totalItems = snapshot.data!.length;
//                 int totalPages = (totalItems / itemsPerPage).ceil();
//                 List<SeeAllData> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
//                 return Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           itemCount: paginatedData.length,
//                           itemBuilder: (context, index) {
//                             int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
//                             String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
//                             SeeAllData general = paginatedData[index];
//                             return Column(
//                               children: [
//                                 Material(
//                                   color: ColorManager.white,
//                                   elevation: 4,
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Container(
//                                     width: containerWidth,
//                                     height: 150,
//                                     decoration: BoxDecoration(
//                                       color: ColorManager.white,
//                                       borderRadius: BorderRadius.circular(20),
//                                       border: Border.all(
//                                         width: 1,
//                                         color: ColorManager.grey,
//                                       ),
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           crossAxisAlignment: CrossAxisAlignment.end,
//                                           children: [
//                                             Container(
//                                                 width: AppSize.s88,
//                                                 height: AppSize.s20,
//                                                 decoration: BoxDecoration(
//                                                     color: general.status == 'Opened'
//                                                         ? const Color(0xff51B5E6)
//                                                         : general.status == 'Partial'
//                                                         ? const Color(0xffCA8A04)
//                                                         : const Color(0xffB4DB4C),
//                                                     borderRadius: BorderRadius.only(
//                                                         topRight:
//                                                         Radius.circular(20))),
//                                                 child: Center(
//                                                   child: Text(
//                                                       general.status.toString(),
//                                                       textAlign: TextAlign.center,
//                                                       style: CustomTextStylesCommon
//                                                           .commonStyle(
//                                                           color:
//                                                           ColorManager.white,
//                                                           fontSize: FontSize.s11,
//                                                           fontWeight:
//                                                           FontWeightManager
//                                                               .bold)),
//                                                 )),
//                                           ],
//                                         ),
//                                         SizedBox(height: 5,),
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal:
//                                               MediaQuery.of(context).size.width /
//                                                   60),
//                                           child: InkWell(
//                                             onTap: () => widget.selectButton(1,snapshot.data![index].empId!), // Corrected reference
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                               children: [
//                                                 Column(
//                                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                                   children: [
//                                                     CircleAvatar(
//                                                       radius: MediaQuery.of(context).size.width / 50,
//                                                       backgroundColor: ColorManager.white,
//                                                       child: ClipOval(
//                                                         child: Builder(
//                                                           builder: (context) {
//                                                             String imageUrl = Uri.encodeFull(general.imgurl ?? '');
//                                                             return Icon(Icons.person,color: ColorManager.mediumgrey,size: 40,);
//                                                             // return Image.network(
//                                                             //   imageUrl,
//                                                             //   fit: BoxFit.cover,
//                                                             //   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                                                             //     print('Error loading image: $exception');
//                                                             //     return Image.asset('images/profile.png', fit: BoxFit.cover);
//                                                             //   },
//                                                             // );
//                                                           },
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       height: MediaQuery.of(context).size.height / 40,
//                                                     ),
//                                                     Text(
//                                                       '${general.firstName?.capitalizeFirst ?? ''} ${general.lastName?.capitalizeFirst ?? ''}',
//                                                       style: CustomTextStylesCommon.commonStyle(
//                                                         color: ColorManager.black,
//                                                         fontSize: FontSize.s12,
//                                                         fontWeight: FontWeightManager.bold,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                  Row(
//                                                    children: [
//                                                      Column(
//                                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                                        children: [
//                                                          InfoText('Social Security No.'),
//                                                          InfoText('Clinician Type'),
//                                                          InfoText('Phone Number'),
//                                                          InfoText('Personal Email'),
//                                                        ],
//                                                      ),
//                                                      SizedBox(width: MediaQuery.of(context).size.width/30,),
//                                                      Column(
//                                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                                        children: [
//                                                          InfoData(general.ssnnbr ?? '--',),
//                                                          InfoData(general.type ?? '--'),
//                                                          InfoData(general.primaryPhoneNbr ?? '--'),
//                                                          Container(
//                                                            width:MediaQuery.of(context).size.width/8,
//                                                              height:MediaQuery.of(context).size.height/20,
//                                                              child: Center(child:  Text(general.personalEmail!,textAlign:TextAlign.start,style: GoogleFonts.firaSans(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff2A2827)),))),
//                                                        ],
//                                                      ),
//                                                    ],
//                                                  ),
//                                                 Row(
//                                                   children: [
//                                                     Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         InfoText('Drivers License No.'),
//                                                         InfoText('Speciality'),
//                                                         InfoText('City'),
//                                                         InfoText( 'Zone'),
//                                                       ],
//                                                     ),
//                                                     SizedBox(width: MediaQuery.of(context).size.width/30,),
//                                                     Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         InfoData(general.driverLicenseNum ?? '--'),
//                                                         InfoData(general.expertise ?? '--'),
//                                                         InfoData(general.city ?? '--'),
//                                                         InfoData(general.zone ?? '--'),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                                  Row(
//                                                    children: [
//                                                      Column(
//                                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                                        children: [
//                                                          InfoText('Address'),
//                                                          InfoText('Employment'),
//                                                          InfoText('Date of Birth'),
//                                                          InfoText('Race'),
//                                                        ],
//                                                      ),
//                                                      SizedBox(width: MediaQuery.of(context).size.width/30,),
//                                                      Column(
//                                                        crossAxisAlignment: CrossAxisAlignment.start,
//                                                        children: [
//                                                          InfoData(general.finalAddress ?? '--'),
//                                                          InfoData(general.employment ?? '--'),
//                                                          InfoData(general.dateOfBirth ?? '--'),
//                                                          InfoData(general.race ?? '--'),
//                                                        ],
//                                                      ),
//                                                    ],
//                                                  ),
//                                                 Row(
//                                                   children: [
//                                                     Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         InfoText('Service'),
//                                                       ],
//                                                     ),
//                                                     SizedBox(width: MediaQuery.of(context).size.width/30,),
//                                                     Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Container(
//                                                           width: 120,
//                                                             height:50,
//                                                             child: Center(
//                                                                 child: Text(general.service!,style: GoogleFonts.firaSans(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff2A2827)),))),
//
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//
//                                           ),
//                                         ),
//                                         // Padding(
//                                         //   padding: EdgeInsets.only(
//                                         //       left:
//                                         //       MediaQuery.of(context).size.width /
//                                         //           60),
//                                         //   child: InkWell(
//                                         //     onTap: () => widget.selectButton(1,snapshot.data![index].empId!), // Corrected reference
//                                         //     child: Container(
//                                         //         color: Colors.white,
//                                         //         child: Row(
//                                         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         //           crossAxisAlignment: CrossAxisAlignment.center,
//                                         //           children: [
//                                         //             Expanded(
//                                         //               flex: 1,
//                                         //               child: Column(
//                                         //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                         //                 children: [
//                                         //                   CircleAvatar(
//                                         //                     radius: MediaQuery.of(context).size.width / 50,
//                                         //                     backgroundColor: Colors.grey,
//                                         //                     child: ClipOval(
//                                         //                       child: Builder(
//                                         //                         builder: (context) {
//                                         //                           String imageUrl = Uri.encodeFull(general.imgurl ?? '');
//                                         //                           return Image.network(
//                                         //                             imageUrl,
//                                         //                             fit: BoxFit.cover,
//                                         //                             errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//                                         //                               print('Error loading image: $exception');
//                                         //                               return Image.asset('images/profile.png', fit: BoxFit.cover);
//                                         //                             },
//                                         //                           );
//                                         //                         },
//                                         //                       ),
//                                         //                     ),
//                                         //                   ),
//                                         //                   SizedBox(
//                                         //                     height: MediaQuery.of(context).size.width / 80,
//                                         //                   ),
//                                         //                   Text(
//                                         //                     '${general.firstName?.capitalizeFirst ?? ''} ${general.lastName?.capitalizeFirst ?? ''}',
//                                         //                     style: CustomTextStylesCommon.commonStyle(
//                                         //                       color: ColorManager.black,
//                                         //                       fontSize: FontSize.s12,
//                                         //                       fontWeight: FontWeightManager.bold,
//                                         //                     ),
//                                         //                   ),
//                                         //                 ],
//                                         //               ),
//                                         //             ),
//                                         //             Expanded(
//                                         //               child: ObGeneralHeadingConstant(
//                                         //                 text1: 'Social Security No.',
//                                         //                 text2: 'Clinician Type',
//                                         //                 text3: 'Phone Number',
//                                         //                 text4: 'Personal Email',
//                                         //               ),
//                                         //             ),
//                                         //             SizedBox(width: 10,),
//                                         //             Column(
//                                         //               children: [
//                                         //                 ObGeneralDataConstant(
//                                         //                   text1: general.ssnnbr ?? '--',
//                                         //                   text2: general.type ?? '--',
//                                         //                   text3: general.primaryPhoneNbr ?? '--',
//                                         //                   text4: general.personalEmail ?? '--',
//                                         //                 ),
//                                         //               ],
//                                         //             ),
//                                         //             SizedBox(width: 20,),
//                                         //             Expanded(
//                                         //               child: ObGeneralHeadingConstant(
//                                         //                 text1: 'Drivers License No.',
//                                         //                 text2: 'Speciality',
//                                         //                 text3: 'City',
//                                         //                 text4: 'Zone',
//                                         //               ),
//                                         //             ),
//                                         //             Expanded(
//                                         //               child: Column(
//                                         //                 children: [
//                                         //                   ObGeneralDataConstant(
//                                         //                     text1: general.driverLicenseNum,
//                                         //                     text2: general.expertise,
//                                         //                     text3: general.city,
//                                         //                     text4: general.zone,
//                                         //                   ),
//                                         //                 ],
//                                         //               ),
//                                         //             ),
//                                         //             Expanded(
//                                         //               child: ObGeneralHeadingConstant(
//                                         //                 text1: 'Address',
//                                         //                 text2: 'Employment',
//                                         //                 text3: 'Date of Birth',
//                                         //                 text4: 'Race',
//                                         //               ),
//                                         //             ),
//                                         //             Expanded(
//                                         //               child: Column(
//                                         //                 children: [
//                                         //                   ObGeneralDataConstant(
//                                         //                     text1: general.finalAddress,
//                                         //                     text2: general.employment,
//                                         //                     text3: general.dateOfBirth,
//                                         //                     text4: general.race,
//                                         //                   ),
//                                         //                 ],
//                                         //               ),
//                                         //             ),
//                                         //             Expanded(
//                                         //               child: ObGeneralHeadingConstant(
//                                         //                 text1: 'Service',
//                                         //                 text2: '',
//                                         //                 text3: '',
//                                         //                 text4: '',
//                                         //               ),
//                                         //             ),
//                                         //             Expanded(
//                                         //               child: Column(
//                                         //                 children: [
//                                         //                   ObGeneralDataConstant(
//                                         //                     text1: general.service,
//                                         //                     text2: '',
//                                         //                     text3: '',
//                                         //                   ),
//                                         //                 ],
//                                         //               ),
//                                         //             ),
//                                         //           ],
//                                         //         )
//                                         //     ),
//                                         //   ),
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: AppSize.s5,
//                                 )
//                               ],
//                             );
//                           }),
//                     ),
//                     SizedBox(height: AppSize.s5),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Previous Page Button
//                         InkWell(
//                           onTap: currentPage > 1 ? () {
//                             setState(() {
//                               currentPage--;
//                             });
//                           } : null,
//                           child: Container(
//                             height: 20,
//                             width: 20,
//                             margin: EdgeInsets.only(left: 5, right: 5),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4),
//                               color: ColorManager.bluelight,
//                             ),
//                             child: Icon(Icons.arrow_back_ios_sharp, size: 14, color: Colors.white),
//                           ),
//                         ),
//                         for (var i = 1; i <= totalPages; i++)
//                           if (i == 1 ||
//                               i == totalPages ||
//                               i == currentPage ||
//                               (i == currentPage - 1 && i > 1) ||
//                               (i == currentPage + 1 && i < totalPages))
//                             InkWell(
//                               onTap: () => onPageNumberPressed(i),
//                               child: Container(
//                                 width: 20,
//                                 height: 20,
//                                 margin: EdgeInsets.only(left: 5, right: 5),
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(4),
//                                   border: Border.all(
//                                     color: currentPage == i ? ColorManager.bluelight : ColorManager.fmediumgrey.withOpacity(0.2),
//                                     width: currentPage == i ? 2.0 : 1.0,
//                                   ),
//                                   color: currentPage == i ? ColorManager.bluelight : Colors.transparent,
//                                 ),
//                                 child: Text(
//                                   '$i',
//                                   style: TextStyle(
//                                     color: currentPage == i ? Colors.white : ColorManager.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           else if (i == currentPage - 2 || i == currentPage + 2)
//                             Text(
//                               '..',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                         ///Page Number Buttons
//                         InkWell(
//                           onTap: currentPage < totalPages ? () {
//                             setState(() {
//                               currentPage++;
//                             });
//                           } : null,
//                           child: Container(
//                             height: 20,
//                             width: 20,
//                             margin: EdgeInsets.only(left: 5, right: 5),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(4),
//                               color: ColorManager.bluelight,
//                             ),
//                             child: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: AppSize.s5),
//                   ],
//                 );
//               }
//               return Offstage();
//             },
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class InfoText extends StatelessWidget {
//   final String text;
//
//   const InfoText(this.text, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(text, style: GoogleFonts.firaSans(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff2A2827)),),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
// class InfoData extends StatelessWidget {
//   final String text;
//
//   const InfoData(
//       this.text,
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(text,style: GoogleFonts.firaSans(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff2A2827)),),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/see_all/see_all_manager.dart';
import '../../../../../data/api_data/hr_module_data/see_all_data/see_all_data.dart';

class OnboardingGeneral extends StatefulWidget {
  final void Function(int,int) selectButton;
  const OnboardingGeneral({Key? key, required this.selectButton}) : super(key: key);

  @override
  State<OnboardingGeneral> createState() => _OnboardingGeneralState();
}

class _OnboardingGeneralState extends State<OnboardingGeneral> {
  final StreamController<List<SeeAllData>> generalController =
  StreamController<List<SeeAllData>>();
  @override
  void initState() {
    super.initState();
    getEmployeeSeeAll(context).then((data) {
      final filteredData = data.where((item) =>
      item.status == 'Partial' || item.status == 'Opened').toList();
      generalController.add(filteredData);
    }).catchError((error) {});
  }
  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight = MediaQuery.of(context).size.height * 0.2;
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<SeeAllData>>(
            stream: generalController.stream,
            builder: (context, snapshot) {
              print('1111111');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
                );
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    AppString.dataNotFound,
                    style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s12,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                int totalItems = snapshot.data!.length;
                int totalPages = (totalItems / itemsPerPage).ceil();
                List<SeeAllData> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                            SeeAllData general = paginatedData[index];
                            return Column(
                              children: [
                                Material(
                                  color: ColorManager.white,
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: containerWidth,
                                    height: AppSize.s150,
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: AppSize.s1,
                                        color: ColorManager.white,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                                width: AppSize.s88,
                                                height: AppSize.s20,
                                                decoration: BoxDecoration(
                                                    color: general.status == 'Opened'
                                                        ? const Color(0xff51B5E6)
                                                        : general.status == 'Partial'
                                                        ? const Color(0xffCA8A04)
                                                        : const Color(0xffB4DB4C),
                                                    borderRadius: BorderRadius.only(
                                                        topRight:
                                                        Radius.circular(20)),),
                                                child: Center(
                                                  child: Text(
                                                      general.status.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: CustomTextStylesCommon
                                                          .commonStyle(
                                                          color:
                                                          ColorManager.white,
                                                          fontSize: FontSize.s11,
                                                          fontWeight:
                                                          FontWeightManager.bold)),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: AppSize.s5),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                              MediaQuery.of(context).size.width /
                                                  60),
                                          child: InkWell(
                                            onTap: () => widget.selectButton(1,snapshot.data![index].empId!), // Corrected reference
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: MediaQuery.of(context).size.width / 50,
                                                      backgroundColor: Colors.grey,
                                                      child: ClipOval(
                                                        child: Builder(
                                                          builder: (context) {
                                                            String imageUrl = Uri.encodeFull(general.imgurl ?? '');
                                                            return Image.network(
                                                              imageUrl,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                print('Error loading image: $exception');
                                                                // return Image.asset('images/profile.png', fit: BoxFit.cover);
                                                                return Icon(Icons.person,color: ColorManager.mediumgrey,size: 40,);
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: MediaQuery.of(context).size.height / 40),
                                                    Container(
                                                      height: AppSize.s30,
                                                      width: MediaQuery.of(context).size.width/18,
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          '${general.firstName?.capitalizeFirst ?? ''} ${general.lastName?.capitalizeFirst ?? ''}',
                                                          style: CustomTextStylesCommon.commonStyle(
                                                            color: ColorManager.black,
                                                            fontSize: FontSize.s12,
                                                            fontWeight: FontWeightManager.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: MediaQuery.of(context).size.width/40),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InfoText('Social Security No.'),
                                                        InfoText('Drivers License No.'),
                                                        InfoText('Clinician Type'),
                                                        InfoText('Phone Number'),
                                                        InfoText('Address'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InfoData(general.ssnnbr ?? '--',),
                                                        InfoData(general.driverLicenseNum ?? '--'),
                                                        InfoData(general.type ?? '--'),
                                                        InfoData(general.primaryPhoneNbr ?? '--'),
                                                        InfoData(general.finalAddress ?? '--'),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InfoText('Date of Birth'),
                                                        InfoText('Speciality'),
                                                        InfoText('Employment'),
                                                        InfoText('Service'),
                                                        InfoText('Race'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InfoData(general.dateOfBirth ?? '--'),
                                                        InfoData(general.expertise ?? '--'),
                                                        InfoData(general.employment ?? '--'),
                                                        InfoData(general.service ?? '--'),
                                                        InfoData(general.race ?? '--'),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InfoText('Personal Email'),
                                                        InfoText(AppString.city),
                                                        InfoText( AppString.zone),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        InfoData(general.personalEmail ?? '--'),
                                                        InfoData(general.city ?? '--'),
                                                        InfoData(general.zone ?? '--'),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Column(
                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     InfoText('Service'),
                                                //   ],
                                                // ),
                                                // Column(
                                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     InfoData(general.service ?? '--'),
                                                //
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left:
                                        //       MediaQuery.of(context).size.width /
                                        //           60),
                                        //   child: InkWell(
                                        //     onTap: () => widget.selectButton(1,snapshot.data![index].empId!), // Corrected reference
                                        //     child: Container(
                                        //         color: Colors.white,
                                        //         child: Row(
                                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //           crossAxisAlignment: CrossAxisAlignment.center,
                                        //           children: [
                                        //             Expanded(
                                        //               flex: 1,
                                        //               child: Column(
                                        //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //                 children: [
                                        //                   CircleAvatar(
                                        //                     radius: MediaQuery.of(context).size.width / 50,
                                        //                     backgroundColor: Colors.grey,
                                        //                     child: ClipOval(
                                        //                       child: Builder(
                                        //                         builder: (context) {
                                        //                           String imageUrl = Uri.encodeFull(general.imgurl ?? '');
                                        //                           return Image.network(
                                        //                             imageUrl,
                                        //                             fit: BoxFit.cover,
                                        //                             errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                        //                               print('Error loading image: $exception');
                                        //                               return Image.asset('images/profile.png', fit: BoxFit.cover);
                                        //                             },
                                        //                           );
                                        //                         },
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   SizedBox(
                                        //                     height: MediaQuery.of(context).size.width / 80,
                                        //                   ),
                                        //                   Text(
                                        //                     '${general.firstName?.capitalizeFirst ?? ''} ${general.lastName?.capitalizeFirst ?? ''}',
                                        //                     style: CustomTextStylesCommon.commonStyle(
                                        //                       color: ColorManager.black,
                                        //                       fontSize: FontSize.s12,
                                        //                       fontWeight: FontWeightManager.bold,
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //             ),
                                        //             Expanded(
                                        //               child: ObGeneralHeadingConstant(
                                        //                 text1: 'Social Security No.',
                                        //                 text2: 'Clinician Type',
                                        //                 text3: 'Phone Number',
                                        //                 text4: 'Personal Email',
                                        //               ),
                                        //             ),
                                        //             SizedBox(width: 10,),
                                        //             Column(
                                        //               children: [
                                        //                 ObGeneralDataConstant(
                                        //                   text1: general.ssnnbr ?? '--',
                                        //                   text2: general.type ?? '--',
                                        //                   text3: general.primaryPhoneNbr ?? '--',
                                        //                   text4: general.personalEmail ?? '--',
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             SizedBox(width: 20,),
                                        //             Expanded(
                                        //               child: ObGeneralHeadingConstant(
                                        //                 text1: 'Drivers License No.',
                                        //                 text2: 'Speciality',
                                        //                 text3: 'City',
                                        //                 text4: 'Zone',
                                        //               ),
                                        //             ),
                                        //             Expanded(
                                        //               child: Column(
                                        //                 children: [
                                        //                   ObGeneralDataConstant(
                                        //                     text1: general.driverLicenseNum,
                                        //                     text2: general.expertise,
                                        //                     text3: general.city,
                                        //                     text4: general.zone,
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //             ),
                                        //             Expanded(
                                        //               child: ObGeneralHeadingConstant(
                                        //                 text1: 'Address',
                                        //                 text2: 'Employment',
                                        //                 text3: 'Date of Birth',
                                        //                 text4: 'Race',
                                        //               ),
                                        //             ),
                                        //             Expanded(
                                        //               child: Column(
                                        //                 children: [
                                        //                   ObGeneralDataConstant(
                                        //                     text1: general.finalAddress,
                                        //                     text2: general.employment,
                                        //                     text3: general.dateOfBirth,
                                        //                     text4: general.race,
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //             ),
                                        //             Expanded(
                                        //               child: ObGeneralHeadingConstant(
                                        //                 text1: 'Service',
                                        //                 text2: '',
                                        //                 text3: '',
                                        //                 text4: '',
                                        //               ),
                                        //             ),
                                        //             Expanded(
                                        //               child: Column(
                                        //                 children: [
                                        //                   ObGeneralDataConstant(
                                        //                     text1: general.service,
                                        //                     text2: '',
                                        //                     text3: '',
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         )
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s5,
                                )
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: AppSize.s5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Previous Page Button
                        InkWell(
                          onTap: currentPage > 1 ? () {
                            setState(() {
                              currentPage--;
                            });
                          } : null,
                          child: Container(
                            height: AppSize.s20,
                            width: AppSize.s20,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ColorManager.bluelight,
                            ),
                            child: Icon(Icons.arrow_back_ios_sharp, size: 14, color: Colors.white),
                          ),
                        ),
                        for (var i = 1; i <= totalPages; i++)
                          if (i == 1 ||
                              i == totalPages ||
                              i == currentPage ||
                              (i == currentPage - 1 && i > 1) ||
                              (i == currentPage + 1 && i < totalPages))
                            InkWell(
                              onTap: () => onPageNumberPressed(i),
                              child: Container(
                                width: AppSize.s20,
                                height: AppSize.s20,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: currentPage == i ? ColorManager.bluelight : ColorManager.fmediumgrey.withOpacity(0.2),
                                    width: currentPage == i ? 2.0 : 1.0,
                                  ),
                                  color: currentPage == i ? ColorManager.bluelight : Colors.transparent,
                                ),
                                child: Text(
                                  '$i',
                                  style: TextStyle(
                                    color: currentPage == i ? Colors.white : ColorManager.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                              ),
                            )
                          else if (i == currentPage - 2 || i == currentPage + 2)
                            Text(
                              '..',
                              style: TextStyle(
                                color: ColorManager.black,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.s12,
                              ),
                            ),
                        ///Page Number Buttons
                        InkWell(
                          onTap: currentPage < totalPages ? () {
                            setState(() {
                              currentPage++;
                            });
                          } : null,
                          child: Container(
                            height: AppSize.s20,
                            width: AppSize.s20,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ColorManager.bluelight,
                            ),
                            child: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s5),
                  ],
                );
              }
              return Offstage();
            },
          ),
        )
      ],
    );
  }
}

class InfoText extends StatelessWidget {
  final String text;

  const InfoText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.textBlack),),
        const SizedBox(height: AppSize.s10),
      ],
    );
  }
}

class InfoData extends StatelessWidget {
  final String text;

  const InfoData(
      this.text,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text,style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.textBlack),),
        const SizedBox(height: AppSize.s10),
      ],
    );
  }
}
//////