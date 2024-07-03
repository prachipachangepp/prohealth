import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/onboarding_tab_bar_const.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';

///prachi
class OnboardingGeneral extends StatelessWidget {
  const OnboardingGeneral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight = MediaQuery.of(context).size.height * 0.2;
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Material(
                        color: ColorManager.white,
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: containerWidth,
                          height: containerHeight,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 28,
                                          child:
                                              Image.asset('images/profile.png'),
                                        ),
                                        SizedBox(height: 15,),
                                        Text(
                                         AppString.amogh,
                                          style: CustomTextStylesCommon.commonStyle(
                                              color: ColorManager.black,
                                              fontSize: MediaQuery.of(context).size.width / 99,
                                              fontWeight: FontWeightManager.bold
                                          )
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    CustomTextColumn(text: AppString.genSocSec, textStyle:  GoogleFonts.firaSans(
                                      fontWeight: FontWeightManager.lightbold,
                                      color: ColorManager.mediumgrey,
                                      fontSize: FontSize.s10,
                                    ),),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppString.genSocSec,
                                          style: GoogleFonts.firaSans(
                                            fontWeight: FontWeightManager.lightbold,
                                            color: ColorManager.mediumgrey,
                                            fontSize: FontSize.s10,
                                          ),),
                                        SizedBox(height: 5,),
                                        Text(AppString.genSocSec,
                                          style: GoogleFonts.firaSans(
                                            fontWeight: FontWeightManager.lightbold,
                                            color: ColorManager.mediumgrey,
                                            fontSize: FontSize.s10,
                                          ),),
                                        SizedBox(height: 5,),
                                        Text(AppString.genSocSec,
                                          style: GoogleFonts.firaSans(
                                            fontWeight: FontWeightManager.lightbold,
                                            color: ColorManager.mediumgrey,
                                            fontSize: FontSize.s10,
                                          ),),
                                        SizedBox(height: 5,),
                                        Text(AppString.genSocSec,
                                          style: GoogleFonts.firaSans(
                                            fontWeight: FontWeightManager.lightbold,
                                            color: ColorManager.mediumgrey,
                                            fontSize: FontSize.s10,
                                          ),),
                                      ],
                                    ),
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.s8,
                      )
                    ],
                  );
                }))
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