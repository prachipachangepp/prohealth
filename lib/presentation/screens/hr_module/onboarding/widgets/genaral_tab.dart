import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/onboarding_tab_bar_const.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/ob_general_heading_constant.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/see_all/see_all_manager.dart';
import '../../../../../data/api_data/hr_module_data/see_all_data/see_all_data.dart';
import '../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';

class OnboardingGeneral extends StatefulWidget {
  final void Function(int,int) selectButton;
  const OnboardingGeneral({Key? key, required this.selectButton}) : super(key: key);

  @override
  State<OnboardingGeneral> createState() => _OnboardingGeneralState();
}
class _OnboardingGeneralState extends State<OnboardingGeneral> {
  final StreamController<List<SeeAllData>> generalController =
  StreamController<List<SeeAllData>>();
  late int currentPage;
  late int itemsPerPage;
  //late List<String> items;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 2;
    getEmployeeSeeAll(context).then((data) {
      generalController.add(data);
    }).catchError((error) {});
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

                List<SeeAllData> currentPageItems = snapshot.data!.sublist(
                  (currentPage - 1) * itemsPerPage,
                  (currentPage * itemsPerPage) > totalItems
                      ? totalItems
                      : (currentPage * itemsPerPage),
                );
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: currentPageItems.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Material(
                                  //color: ColorManager.white,
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: containerWidth,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 1,
                                        color: ColorManager.grey,
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
                                                    color: ColorManager.greenF,
                                                    borderRadius: BorderRadius.only(
                                                        topRight:
                                                        Radius.circular(20))),
                                                child: Center(
                                                  child: Text(
                                                      snapshot.data![index].status.toString(),
                                                      textAlign: TextAlign.center,
                                                      style: CustomTextStylesCommon
                                                          .commonStyle(
                                                          color:
                                                          ColorManager.white,
                                                          fontSize: FontSize.s11,
                                                          fontWeight:
                                                          FontWeightManager
                                                              .bold)),
                                                )),
                                          ],
                                        ),
                                        SizedBox(height: 2,),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                              MediaQuery.of(context).size.width /
                                                  60),
                                          child: InkWell(
                                            onTap: () => widget.selectButton(1,snapshot.data![index].empId!), // Corrected reference
                                            child: Container(
                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        // CircleAvatar(
                                                                //   radius: MediaQuery.of(context).size.width / 50,
                                                                //   child: Image.asset(
                                                                //       'images/profile.png'),
                                                                // ),
                                                                // CircleAvatar(
                                                                //   radius: MediaQuery.of(context).size.width / 50,
                                                                //   backgroundImage: NetworkImage(snapshot.data![index].imgurl ?? '')
                                                                //   as ImageProvider,
                                                                //   child: Image.network(
                                                                //     snapshot.data![index].imgurl ?? '',
                                                                //     fit: BoxFit.cover,
                                                                //     errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                //       print('Error loading image: $exception');
                                                                //       return Image.asset('images/profile.png', fit: BoxFit.cover);
                                                                //     },
                                                                //   ),
                                                                // ),
                                                                ///Error loading image: [object ProgressEvent]
                                                                // Error loading image: [object ProgressEvent]
                                                                // Error loading image: ImageCodecException: Failed to detect image file format using the file header.
                                                                // File header was [0x3c 0x21 0x44 0x4f 0x43 0x54 0x59 0x50 0x45 0x20].
                                                                /// Image source: encoded image bytes
                                                                // CircleAvatar(
                                                                //   radius: MediaQuery.of(context).size.width / 50,
                                                                //   backgroundColor: Colors.grey,                                                   child: ClipOval(
                                                                //     child: Image.network(
                                                                //       snapshot.data![index].imgurl ?? '',
                                                                //       fit: BoxFit.cover,
                                                                //       errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                //         print('Error loading image: $exception');
                                                                //         return Image.asset('images/profile.png', fit: BoxFit.cover);
                                                                //       },
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                                ///Error loading image: [object ProgressEvent]

                                                        CircleAvatar(
                                                          radius: MediaQuery.of(context).size.width / 50,
                                                          backgroundColor: Colors.grey,
                                                          child: ClipOval(
                                                            child: Builder(
                                                              builder: (context) {
                                                                String imageUrl = Uri.encodeFull(snapshot.data![index].imgurl ?? '');
                                                                return Image.network(
                                                                  imageUrl,
                                                                  fit: BoxFit.cover,
                                                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                                    print('Error loading image: $exception');
                                                                    return Image.asset('images/profile.png', fit: BoxFit.cover);
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(context).size.width / 80,
                                                        ),
                                                        Text(
                                                          '${snapshot.data![index].firstName?.capitalizeFirst ?? ''} ${snapshot.data![index].lastName?.capitalizeFirst ?? ''}',
                                                          style: CustomTextStylesCommon.commonStyle(
                                                            color: ColorManager.black,
                                                            fontSize: FontSize.s12,
                                                            fontWeight: FontWeightManager.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ObGeneralHeadingConstant(
                                                      text1: 'Social Security No.',
                                                      text2: 'Clinician Type',
                                                      text3: 'Phone Number',
                                                      text4: 'Personal Email',
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Column(
                                                    children: [
                                                      ObGeneralDataConstant(
                                                        text1: snapshot.data![index].ssnnbr ?? '--',
                                                        text2: snapshot.data![index].type ?? '--',
                                                        text3: snapshot.data![index].primaryPhoneNbr ?? '--',
                                                        text4: snapshot.data![index].personalEmail ?? '--',
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 20,),
                                                  Expanded(
                                                    child: ObGeneralHeadingConstant(
                                                      text1: 'Drivers License No.',
                                                      text2: 'Speciality',
                                                      text3: 'City',
                                                      text4: 'Zone',
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        ObGeneralDataConstant(
                                                          text1: snapshot.data![index].driverLicenseNum,
                                                          text2: snapshot.data![index].expertise,
                                                          text3: snapshot.data![index].city,
                                                          text4: snapshot.data![index].zone,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ObGeneralHeadingConstant(
                                                      text1: 'Address',
                                                      text2: 'Employment',
                                                      text3: 'City',
                                                      text4: 'Date of Birth',
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        ObGeneralDataConstant(
                                                          text1: snapshot.data![index].finalAddress,
                                                          text2: snapshot.data![index].employment,
                                                          text3: snapshot.data![index].city,
                                                          text4: snapshot.data![index].dateOfBirth,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ObGeneralHeadingConstant(
                                                      text1: 'Status',
                                                      text2: 'Race',
                                                      text3: 'Service',
                                                      text4: '',
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        ObGeneralDataConstant(
                                                          text1: snapshot.data![index].status,
                                                          text2: snapshot.data![index].race,
                                                          text3: snapshot.data![index].service,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   flex: 1,
                                                  //   child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))),),),

                                                ],
                                              )

                                              // Row(
                                              //   mainAxisAlignment:
                                              //   MainAxisAlignment.spaceEvenly,
                                              //   crossAxisAlignment:
                                              //   CrossAxisAlignment.center,
                                              //   children: [
                                              //     Column(
                                              //       mainAxisAlignment:
                                              //       MainAxisAlignment.spaceEvenly,
                                              //       children: [
                                              //         // CircleAvatar(
                                              //         //   radius: MediaQuery.of(context).size.width / 50,
                                              //         //   child: Image.asset(
                                              //         //       'images/profile.png'),
                                              //         // ),
                                              //         // CircleAvatar(
                                              //         //   radius: MediaQuery.of(context).size.width / 50,
                                              //         //   backgroundImage: NetworkImage(snapshot.data![index].imgurl ?? '')
                                              //         //   as ImageProvider,
                                              //         //   child: Image.network(
                                              //         //     snapshot.data![index].imgurl ?? '',
                                              //         //     fit: BoxFit.cover,
                                              //         //     errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                              //         //       print('Error loading image: $exception');
                                              //         //       return Image.asset('images/profile.png', fit: BoxFit.cover);
                                              //         //     },
                                              //         //   ),
                                              //         // ),
                                              //         ///Error loading image: [object ProgressEvent]
                                              //         // Error loading image: [object ProgressEvent]
                                              //         // Error loading image: ImageCodecException: Failed to detect image file format using the file header.
                                              //         // File header was [0x3c 0x21 0x44 0x4f 0x43 0x54 0x59 0x50 0x45 0x20].
                                              //         /// Image source: encoded image bytes
                                              //         // CircleAvatar(
                                              //         //   radius: MediaQuery.of(context).size.width / 50,
                                              //         //   backgroundColor: Colors.grey,                                                   child: ClipOval(
                                              //         //     child: Image.network(
                                              //         //       snapshot.data![index].imgurl ?? '',
                                              //         //       fit: BoxFit.cover,
                                              //         //       errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                              //         //         print('Error loading image: $exception');
                                              //         //         return Image.asset('images/profile.png', fit: BoxFit.cover);
                                              //         //       },
                                              //         //     ),
                                              //         //   ),
                                              //         // ),
                                              //         ///Error loading image: [object ProgressEvent]
                                              //         CircleAvatar(
                                              //           radius: MediaQuery.of(context).size.width / 50,
                                              //           backgroundColor: Colors.grey,
                                              //           child: ClipOval(
                                              //             child: Builder(
                                              //               builder: (context) {
                                              //                 // Encode the URL to handle special characters
                                              //                 String imageUrl = Uri.encodeFull(snapshot.data![index].imgurl ?? '');
                                              //                 return Image.network(
                                              //                   imageUrl,
                                              //                   fit: BoxFit.cover,
                                              //                   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                              //                     print('Error loading image: $exception');
                                              //                     return Image.asset('images/profile.png', fit: BoxFit.cover);
                                              //                   },
                                              //                 );
                                              //               },
                                              //             ),
                                              //           ),
                                              //         ),
                                              //
                                              //
                                              //
                                              //         SizedBox(
                                              //           height: MediaQuery.of(context)
                                              //               .size
                                              //               .width /80,
                                              //         ),
                                              //         Text(
                                              //           '${snapshot.data![index].firstName?.capitalizeFirst ?? ''} ${snapshot.data![index].lastName?.capitalizeFirst ?? ''}',
                                              //           style: CustomTextStylesCommon
                                              //               .commonStyle(
                                              //             color: ColorManager.black,
                                              //             fontSize: FontSize.s12,
                                              //             fontWeight:
                                              //             FontWeightManager.bold,
                                              //           ),
                                              //         )
                                              //       ],
                                              //     ),
                                              //
                                              //     ObGeneralHeadingConstant(
                                              //         text1: 'Social Security Number',
                                              //         text2: 'Type of Clinician',
                                              //         text3: 'Phone Number',
                                              //         text4: 'Personal Email'),
                                              //
                                              //     Column(
                                              //       children: [
                                              //         ObGeneralDataConstant(
                                              //           text1: snapshot.data![index].ssnnbr ?? '--',
                                              //           text2: snapshot.data![index].type ?? '--',
                                              //           text3: snapshot.data![index].primaryPhoneNbr ?? '--',
                                              //           text4: snapshot.data![index].personalEmail ?? '--',
                                              //         )
                                              //       ],
                                              //     ),
                                              //
                                              //     ObGeneralHeadingConstant(
                                              //       text1: 'Drivers License Number',
                                              //       text2: 'Speciality',
                                              //       text3: 'City',
                                              //       text4: 'Zone',
                                              //     ),
                                              //
                                              //     Column(
                                              //       children: [
                                              //         ObGeneralDataConstant(
                                              //           text1: snapshot.data![index].driverLicenseNum,
                                              //           text2: snapshot.data![index].expertise,///experties
                                              //           text3: snapshot.data![index].city,
                                              //           text4: snapshot.data![index].zone,
                                              //         )
                                              //       ],
                                              //     ),
                                              //
                                              //     ObGeneralHeadingConstant(
                                              //         text1: 'Address',
                                              //         text2: 'Employment',
                                              //         text3: 'City',
                                              //         text4: 'Date of Birth'),
                                              //
                                              //     Column(
                                              //       children: [
                                              //         ObGeneralDataConstant(
                                              //           text1: snapshot.data![index].finalAddress,
                                              //           text2: snapshot.data![index].employment,
                                              //           text3: snapshot.data![index].city,
                                              //           text4: snapshot.data![index].dateOfBirth,
                                              //         )
                                              //       ],
                                              //     ),
                                              //
                                              //     ObGeneralHeadingConstant(
                                              //       text1: 'Status',
                                              //       text2: 'Race',
                                              //       text3: 'Service',
                                              //       text4: '',
                                              //     ),
                                              //
                                              //     Column(
                                              //       children: [
                                              //         ObGeneralDataConstant(
                                              //           text1: snapshot.data![index].status,
                                              //           text2: snapshot.data![index].race,
                                              //           text3: snapshot.data![index].service,
                                              //         )
                                              //       ],
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                          ),
                                        ),
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
                    PaginationControlsWidget(
                      currentPage: currentPage,
                      items: snapshot.data!,
                      itemsPerPage: itemsPerPage,
                      onPreviousPagePressed: () {
                        setState(() {
                          currentPage = currentPage > 1 ? currentPage - 1 : 1;
                        });
                      },
                      onPageNumberPressed: (pageNumber) {
                        setState(() {
                          currentPage = pageNumber;
                        });
                      },
                      onNextPagePressed: () {
                        setState(() {
                          currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                          print('$currentPage');
                          getEmployeeSeeAll(context).then((data) {
                            generalController.add(data);
                          }).catchError((error) {});
                        });
                      },
                    ),
                    SizedBox(height: AppSize.s10),
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

class InfoTextWidget extends StatelessWidget {
  final List<String> texts;
  const InfoTextWidget({
    super.key,
    required this.texts,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          texts.length,
              (index) => Text(
            texts[index],
            style: GoogleFonts.firaSans(
              fontWeight: FontWeightManager.lightbold,
              color: ColorManager.mediumgrey,
              fontSize: FontSize.s10,
            ),
          ),
        ),
      ),
    );
  }
}


