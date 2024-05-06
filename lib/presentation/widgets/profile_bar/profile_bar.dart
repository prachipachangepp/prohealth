import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/widgets/profile_bar/widget/profile_clipoval_const.dart';
import '../../../app/resources/color.dart';
import '../../../app/resources/const_string.dart';
import '../../../app/resources/theme_manager.dart';
import '../profile_bar/widget/profil_custom_widget.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          elevation: 4,
          child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: AppSize.s50,
              decoration: BoxDecoration(
                color: ColorManager.greenF,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppString.profile,
                      style: ThemeManagerWhite.customTextStyle(context),
                    ),
                  ])),
        ),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8)),
              color: ColorManager.whitebluecolor.withOpacity(0.25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: AppSize.s70,
                        height: AppSize.s70,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'images/profile.png',
                              height: AppSize.s50,
                              width: AppSize.s50
                            ),
                            // you can replace
                            SizedBox(
                              height: AppSize.s53,
                              width: AppSize.s53,
                              child:  CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation<Color>(ColorManager.greenF),
                                strokeWidth: 3,
                                value: 0.70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        AppString.active,
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      Text(
                        AppString.annualSkill,
                        style: ThemeManager.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///text john scott
                      Text(
                        AppString.johnSmith,
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      SizedBox(height: AppSize.s2,),
                      Container(
                        height: MediaQuery.of(context).size.height / 40,
                        width: MediaQuery.of(context).size.width / 10,
                        child: ElevatedButton(
                          child: Text(
                            AppString.physical,
                            style: ThemeManagerWhite.customTextStyle(context),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            backgroundColor: ColorManager.faintOrange.withOpacity(0.9),
                            elevation: 4,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        AppString.employmentType,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.saanJoes,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.address,
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      Text(
                        AppString.houseaddress,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: AppSize.s10,
                          color: ColorManager.primary,
                          fontWeight: FontWeightManager.light,
                        )
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: MyConstants.personalInfoTexts(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///text john scott
                      Text(
                       AppString.dateprofile,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.male,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.star,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),

                      ///phone, comment
                     ProfileBarPhoneCmtConst(),
                     ProfileBarPhoneCmtConst(),
                     ProfileBarPhoneCmtConst(),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: MyConstantsColumn.personalInfoTexts(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.personmail,
                          style: ProfileBarConst.profileTextStyle(context)),
                      Text(
                          AppString.personmail,
                        style: ProfileBarConst.profileTextStyle(context)
                      ),
                      Row(
                        children: [
                          Text(
                            AppString.proheaalthsan,
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 99),
                          Container(
                            height: MediaQuery.of(context).size.height / 35,
                            width: MediaQuery.of(context).size.width / 16,
                            margin: EdgeInsets.only(right: AppSize.s40),
                            child: ElevatedButton(
                              onPressed:
                                  () {},
                              child: Text(
                               AppString.viewzone,
                                style: GoogleFonts.firaSans(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeightManager.bold,
                                    color: ColorManager.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager.white
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.s15, vertical: AppSize.s10),
                                backgroundColor: ColorManager.blueprime,
                                shadowColor: ColorManager.grey.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                       AppString.phone,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.physical,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.na,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            AppString.hideDate,
                            style:ProfileBarConstText.profileTextStyle(context)
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 35,
                          ),
                          Text(
                           AppString.datetime,
                            style: ProfileBarConstText.profileTextStyle(context)
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///"Expired License"
                          ProfileBarClipConst(
                              text: AppString.expiredlicense,
                              containerColor: ColorManager.rednew,
                              textOval: AppString.zero),
                          ///"About To Expired License"
                          ProfileBarClipConst(
                              text: AppString.abouttoexpire,
                              containerColor: Colors.green,
                              textOval: AppString.two),

                          ///"Up To Date License"
                          ProfileBarClipConst(
                              text: AppString.uptodate,
                              containerColor: Colors.yellow,
                              textOval: AppString.four),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}