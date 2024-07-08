import 'package:flutter/material.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../manage/widgets/row_container_widget_const.dart';


class OnboardingEmployement extends StatelessWidget {
  const OnboardingEmployement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 80,
            vertical: MediaQuery.of(context).size.height / 100),
        child: TwoContainersRow(
          child1: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Row(
                children: [
                  Text(
                    AppString.emp1,
                    style: CustomTextStylesCommon.commonStyle(
                        color: ColorManager.blackfaint,
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.medium
                    )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.finalposition,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.startdate,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.enddate,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.employer,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.emergencycont,
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       AppString.developer,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.dateone,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.detetwo,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.johnSmith,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.mobilenum,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.reasonleaving,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.lastSupName,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.supPhone,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.city,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.country,
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.personal,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.jerrychrist,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.tnum,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.hamburg,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.germany,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonTransparent(
                      onPressed: () async{},
                      text: AppString.reject,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 99,
                    ),
                    CustomIconButton(text: AppString.approve, onPressed: () async{}),
                  ],
                ),
              )
            ],
          ),
          child2: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                      AppString.emp2,
                      style: CustomTextStylesCommon.commonStyle(
                          color: ColorManager.blackfaint,
                          fontSize: FontSize.s13,
                          fontWeight: FontWeightManager.medium
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.finalposition,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.startdate,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.enddate,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.employer,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.emergencycont,
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.developer,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.dateone,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.detetwo,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.johnSmith,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.mobilenum,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.reasonleaving,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.lastSupName,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.supPhone,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.city,
                          style: ThemeManager.customTextStyle(context)),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(AppString.country,
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.personal,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.jerrychrist,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.tnum,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.hamburg,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      Text(
                        AppString.germany,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonTransparent(
                      onPressed: () async{},
                      text: AppString.reject,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 99,
                    ),
                    CustomIconButton(text: AppString.approve, onPressed: () async{}),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
