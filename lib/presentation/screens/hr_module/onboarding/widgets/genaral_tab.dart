import 'package:flutter/material.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
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
                            color: ColorManager.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width / 60),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 28,
                                          child:
                                              Image.asset('images/profile.png'),
                                        ),
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
                                    InfoTextWidget(
                                      texts: [
                                       AppString.genSocSec,
                                       AppString.genClinician,
                                       AppString.genPhoneNo,
                                       AppString.genEmail,
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    InfoTextWidget(
                                      texts: [
                                        AppString.gennum,
                                        AppString.genst,
                                        AppString.gennum2,
                                        AppString.genbdate,
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    InfoTextWidget(
                                      texts: [
                                        AppString.gennum,
                                        AppString.genst,
                                        AppString.gennum2,
                                        AppString.genbdate,
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    InfoTextWidget(
                                      texts: [
                                        AppString.gennum,
                                        AppString.genst,
                                        AppString.gennum2,
                                        AppString.genbdate,
                                      ],
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          50,
                                    ),
                                    InfoTextWidget(
                                      texts: [
                                        AppString.gennum,
                                        AppString.genst,
                                        AppString.gennum2,
                                        AppString.genbdate,
                                      ],
                                    ),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          texts.length,
          (index) => Text(
            texts[index],
            style: TextStyle(
              color: ColorManager.darktgrey,
              fontSize: MediaQuery.of(context).size.width / 120,
            ),
          ),
        ),
      ),
    );
  }
}