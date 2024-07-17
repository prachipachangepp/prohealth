import 'dart:async';

import 'package:flutter/material.dart';
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

///prachi
class OnboardingGeneral extends StatefulWidget {
  const OnboardingGeneral({Key? key}) : super(key: key);

  @override
  State<OnboardingGeneral> createState() => _OnboardingGeneralState();
}

class _OnboardingGeneralState extends State<OnboardingGeneral> {
  final StreamController<List<SeeAllData>> generalController = StreamController<List<SeeAllData>>();
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    getEmployeeSeeAll(context, 1).then((data){generalController.add(data);
    }).catchError((error){});
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
          // int totalPages = (totalItems / itemsPerPage).ceil();
          List<SeeAllData> currentPageItems =
          snapshot.data!.sublist(
            (currentPage - 1) * itemsPerPage,
            (currentPage * itemsPerPage) > totalItems
                ? totalItems
                : (currentPage * itemsPerPage),
          );
          return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: currentPageItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Material(
                        color: ColorManager.white,
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
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ///approve
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
                                              topRight: Radius.circular(20))),
                                      child: Text(
                                        AppString.approve,
                                        textAlign: TextAlign.center,
                                        style: CustomTextStylesCommon.commonStyle(
                                            color: ColorManager.white,
                                            fontSize: FontSize.s11,
                                            fontWeight: FontWeightManager.bold
                                        )
                                      )),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width / 60),
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // CircleAvatar(
                                          //   radius: MediaQuery.of(context).size.width/50,
                                          //   child:
                                          //       Image.asset('images/profile.png'),
                                          // ),
                                          CircleAvatar(
                                            radius: MediaQuery.of(context).size.width / 50,
                                            backgroundImage: NetworkImage(snapshot.data![index].imgurl ?? 'images/profile.png'),
                                            onBackgroundImageError: (_, __) => Image.asset('images/profile.png'),
                                          ),
                                          SizedBox(height: MediaQuery.of(context).size.width/80,),
                                          Text(
                                            '${snapshot.data![index].firstName ?? ''} ${snapshot.data![index].lastName ?? ''}',
                                            style: CustomTextStylesCommon.commonStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeightManager.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width /
                                            50,
                                      ),

                                      ObGeneralHeadingConstant(
                                          text1: 'Social Security Number',
                                          text2: 'Type of Clinician',
                                          text3: 'Phone Number',
                                          text4: 'Personal Email'
                                      ),

                                      Column(
                                        children: [
                                          ObGeneralDataConstant(
                                              text1: snapshot.data![index].ssnnbr,
                                              text2: snapshot.data![index].type,
                                              text3: snapshot.data![index].primaryPhoneNbr,
                                              text4: snapshot.data![index].personalEmail,
                                          )
                                        ],
                                      ),


                                      ObGeneralHeadingConstant(
                                          text1: 'Drivers License Number',
                                          text2: 'Speciality',
                                          text3: 'City',
                                          text4: 'Zone',
                                      ),

                                      Column(
                                        children: [
                                          ObGeneralDataConstant(
                                            text1: snapshot.data![index].regOfficId,
                                            text2: snapshot.data![index].experties,
                                            text3: snapshot.data![index].cityID.toString(),
                                            text4: snapshot.data![index].zoneId.toString(),
                                          )
                                        ],
                                      ),

                                      ObGeneralHeadingConstant(
                                          text1: 'Address',
                                          text2: 'Employment',
                                          text3: 'City',
                                          text4: 'Date of Birth'
                                      ),

                                      Column(
                                        children: [
                                          ObGeneralDataConstant(
                                            text1: snapshot.data![index].address,
                                            text2: snapshot.data![index].employment,
                                            text3: snapshot.data![index].cityID.toString(),
                                            text4: snapshot.data![index].dateOfBirth,
                                          )
                                        ],
                                      ),

                                      ObGeneralHeadingConstant(
                                          text1: 'Status',
                                          text2: 'Race',
                                          text3: 'Service',
                                        text4: '',
                                      ),

                                      Column(
                                        children: [
                                          ObGeneralDataConstant(
                                            text1: snapshot.data![index].status,
                                            text2: snapshot.data![index].rehirable,
                                            text3: snapshot.data![index].service,
                                          )
                                        ],
                                      ),




                                      // CustomTextColumn(
                                      //   text: AppString.genSocSec,
                                      //   textStyle:  GoogleFonts.firaSans(
                                      //   fontWeight: FontWeightManager.lightbold,
                                      //   color: ColorManager.mediumgrey,
                                      //   fontSize: FontSize.s10,
                                      // ),),



                                      // Column(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Social Security Number',
                                      //         text2: '123-45-6789'
                                      //     ),
                                      //     // Text(AppString.genSocSec,
                                      //     //   style: GoogleFonts.firaSans(
                                      //     //     fontWeight: FontWeightManager.lightbold,
                                      //     //     color: ColorManager.mediumgrey,
                                      //     //     fontSize: FontSize.s10,
                                      //     //   ),),
                                      //     SizedBox(height: 5,),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Type of Clinician',
                                      //         text2: 'ST'
                                      //     ),
                                      //     // Text(AppString.genSocSec,
                                      //     //   style: GoogleFonts.firaSans(
                                      //     //     fontWeight: FontWeightManager.lightbold,
                                      //     //     color: ColorManager.mediumgrey,
                                      //     //     fontSize: FontSize.s10,
                                      //     //   ),),
                                      //     SizedBox(height: 5,),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Phone Number',
                                      //         text2: '1234567890'
                                      //     ),
                                      //     // Text(AppString.genSocSec,
                                      //     //   style: GoogleFonts.firaSans(
                                      //     //     fontWeight: FontWeightManager.lightbold,
                                      //     //     color: ColorManager.mediumgrey,
                                      //     //     fontSize: FontSize.s10,
                                      //     //   ),),
                                      //     SizedBox(height: 5,),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Personal Email',
                                      //         text2: 'abc@gmail.com'
                                      //     ),
                                      //     // Text(AppString.genSocSec,
                                      //     //   style: GoogleFonts.firaSans(
                                      //     //     fontWeight: FontWeightManager.lightbold,
                                      //     //     color: ColorManager.mediumgrey,
                                      //     //     fontSize: FontSize.s10,
                                      //     //   ),),
                                      //   ],
                                      // ),
                                      // Column(
                                      //   children: [
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Drivers License Number',
                                      //         text2: '1234687654'
                                      //     ),
                                      //     SizedBox(height: 5),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Speciality',
                                      //         text2: 'TPN'
                                      //     ),SizedBox(height: 5),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'City',
                                      //         text2: 'Hamburg'
                                      //     ),SizedBox(height: 5),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Zone',
                                      //         text2: '02'
                                      //     ),
                                      //   ],
                                      // ),
                                      //
                                      // Column(
                                      //   children: [
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Address',
                                      //         text2: 'Montvert Tropez'
                                      //     ),
                                      //     SizedBox(height: 5),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Employment',
                                      //         text2: 'Full Time'
                                      //     ),SizedBox(height: 5),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'City',
                                      //         text2: 'Hamburg'
                                      //     ),SizedBox(height: 5),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Date of Birth',
                                      //         text2: '02/01/2000'
                                      //     ),
                                      //   ],
                                      // ),
                                      //
                                      // Column(
                                      //   children: [
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Status',
                                      //         text2: 'Active'
                                      //     ),
                                      //     SizedBox(height: 5),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Race',
                                      //         text2: 'Asian'
                                      //     ),SizedBox(height: 5),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: 'Service',
                                      //         text2: 'Hospice'
                                      //     ),SizedBox(height: 5),
                                      //     ObGeneralHeadingConstant(
                                      //         text1: '',
                                      //         text2: ''
                                      //     ),
                                      //   ],
                                      // ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width /
                                            50,
                                      ),
                                      // InfoTextWidget(
                                      //   texts: [
                                      //    AppString.genSocSec,
                                      //    AppString.genClinician,
                                      //    AppString.genPhoneNo,
                                      //    AppString.genEmail,
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   width: MediaQuery.of(context).size.width / 50,
                                      // ),
                                      // InfoTextWidget(
                                      //   texts: [
                                      //     AppString.gennum,
                                      //     AppString.genst,
                                      //     AppString.gennum2,
                                      //     AppString.genbdate,
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   width: MediaQuery.of(context).size.width /
                                      //       50,
                                      // ),
                                      // InfoTextWidget(
                                      //   texts: [
                                      //     AppString.gennum,
                                      //     AppString.genst,
                                      //     AppString.gennum2,
                                      //     AppString.genbdate,
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   width: MediaQuery.of(context).size.width /
                                      //       50,
                                      // ),
                                      // InfoTextWidget(
                                      //   texts: [
                                      //     AppString.gennum,
                                      //     AppString.genst,
                                      //     AppString.gennum2,
                                      //     AppString.genbdate,
                                      //   ],
                                      // ),
                                      // SizedBox(
                                      //   width: MediaQuery.of(context).size.width /
                                      //       50,
                                      // ),
                                      // InfoTextWidget(
                                      //   texts: [
                                      //     AppString.gennum,
                                      //     AppString.genst,
                                      //     AppString.gennum2,
                                      //     AppString.genbdate,
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),
                      SizedBox(height: AppSize.s5,
                      )
                    ],
                  );
                }) ;
  }
  return Offstage();
},
),
        )],
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