// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/profile_clipoval_const.dart';
// import '../../../../../app/resources/color.dart';
// import '../../../../../app/resources/const_string.dart';
// import '../../../../../app/resources/theme_manager.dart';
// import '../profile_bar/widget/profil_custom_widget.dart';
//
// class ProfileBar extends StatelessWidget {
//   const ProfileBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Material(
//           elevation: 4,
//           child: Container(
//               height: MediaQuery.of(context).size.height / 4,
//               width: AppSize.s50,
//               decoration: BoxDecoration(
//                 color: ColorManager.greenF,
//               ),
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(AppString.profile,
//                       style: ThemeManagerWhite.customTextStyle(context),
//                     ),
//                   ])),
//         ),
//         Material(
//           elevation: 4,
//           borderRadius: BorderRadius.only(
//               bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
//           child: Container(
//             height: MediaQuery.of(context).size.height / 4,
//             width: MediaQuery.of(context).size.width / 1.1,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(8),
//                   topRight: Radius.circular(8)),
//               color: ColorManager.whitebluecolor.withOpacity(0.25),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       SizedBox(
//                         width: AppSize.s70,
//                         height: AppSize.s70,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Image.asset(
//                               'images/profile.png',
//                               height: AppSize.s50,
//                               width: AppSize.s50
//                             ),
//                             // you can replace
//                             SizedBox(
//                               height: AppSize.s53,
//                               width: AppSize.s53,
//                               child:  CircularProgressIndicator(
//                                 valueColor:
//                                 AlwaysStoppedAnimation<Color>(ColorManager.greenF),
//                                 strokeWidth: 3,
//                                 value: 0.70,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Text(
//                         AppString.active,
//                         style: ThemeManagerBlack.customTextStyle(context),
//                       ),
//                       Text(
//                         AppString.annualSkill,
//                         style: ThemeManager.customTextStyle(context),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ///text john scott
//                       Text(
//                         AppString.johnSmith,
//                         style: ThemeManagerBlack.customTextStyle(context),
//                       ),
//                       SizedBox(height: AppSize.s2,),
//                       Container(
//                         height: MediaQuery.of(context).size.height / 40,
//                         width: MediaQuery.of(context).size.width / 10,
//                         child: ElevatedButton(
//                           child: Text(
//                             AppString.physical,
//                             style: ThemeManagerWhite.customTextStyle(context),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.zero,
//                             ),
//                             backgroundColor: ColorManager.faintOrange.withOpacity(0.9),
//                             elevation: 4,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                       Text(
//                         AppString.employmentType,
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         AppString.saanJoes,
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         AppString.address,
//                         style: ThemeManagerBlack.customTextStyle(context),
//                       ),
//                       Text(
//                         AppString.houseaddress,
//                         textAlign: TextAlign.start,
//                         style: GoogleFonts.firaSans(
//                           fontSize: AppSize.s10,
//                           color: ColorManager.primary,
//                           fontWeight: FontWeightManager.light,
//                         )
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: MyConstants.personalInfoTexts(context),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ///text john scott
//                       Text(
//                        AppString.dateprofile,
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         AppString.male,
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         AppString.star,
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//
//                       ///phone, comment
//                      ProfileBarPhoneCmtConst(),
//                      ProfileBarPhoneCmtConst(),
//                      ProfileBarPhoneCmtConst(),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: MyConstantsColumn.personalInfoTexts(context),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(AppString.personmail,
//                           style: ProfileBarConst.profileTextStyle(context)),
//                       Text(
//                           AppString.personmail,
//                         style: ProfileBarConst.profileTextStyle(context)
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             AppString.proheaalthsan,
//                             style: ThemeManagerDark.customTextStyle(context),
//                           ),
//                           SizedBox(
//                               width: MediaQuery.of(context).size.width / 99),
//                           Container(
//                             height: MediaQuery.of(context).size.height / 35,
//                             width: MediaQuery.of(context).size.width / 16,
//                             margin: EdgeInsets.only(right: AppSize.s40),
//                             child: ElevatedButton(
//                               onPressed:
//                                   () {},
//                               child: Text(
//                                AppString.viewzone,
//                                 style: GoogleFonts.firaSans(
//                                     fontSize: FontSize.s10,
//                                     fontWeight: FontWeightManager.bold,
//                                     color: ColorManager.white,
//                                     decoration: TextDecoration.underline,
//                                     decorationColor: ColorManager.white
//                                 ),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: AppSize.s15, vertical: AppSize.s10),
//                                 backgroundColor: ColorManager.blueprime,
//                                 shadowColor: ColorManager.grey.withOpacity(0.3),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         AppString.physical,
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         AppString.na,
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         AppString.na,
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),Text(
//                         AppString.na,
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             AppString.hideDate,
//                             style:ProfileBarConstText.profileTextStyle(context)
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width / 35,
//                           ),
//                           Text(
//                            AppString.datetime,
//                             style: ProfileBarConstText.profileTextStyle(context)
//                           ),
//                         ],
//                       ),
//
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ///"Expired License"
//                           ProfileBarClipConst(
//                               text: AppString.expiredlicense,
//                               containerColor: ColorManager.rednew,
//                               textOval: AppString.zero),
//
//                           SizedBox(height: MediaQuery.of(context).size.height/120),
//                           ///"About To Expired License"
//                           ProfileBarClipConst(
//                               text: AppString.abouttoexpire,
//                               containerColor: Colors.green,
//                               textOval: AppString.two),
//
//                           SizedBox(height: MediaQuery.of(context).size.height/120),
//                           ///"Up To Date License"
//                           ProfileBarClipConst(
//                               text: AppString.uptodate,
//                               containerColor: Colors.yellow,
//                               textOval: AppString.four),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



///////////////above code is original code///////////////



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/profile_clipoval_const.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
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
                        AppString.physical,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.na,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.na,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),Text(
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
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return licensepopup();
                                },
                              );
                            },
                            child: ProfileBarClipConst(
                              text: AppString.expiredlicense,
                              containerColor:Color(0xffD16D6A),
                              textOval: AppString.zero,
                            ),
                          ),


                          SizedBox(height: MediaQuery.of(context).size.height/120),
                          ///"About To Expired License"
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AboutToExpireLicensePopup();
                                },
                              );
                            },
                            child: ProfileBarClipConst(
                              text: AppString.abouttoexpire,
                              containerColor: Color(0xffFEBD4D),
                              textOval: AppString.two,
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height/120),
                          ///"Up To Date License"
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return UpToDateLicensePopup();
                                },
                              );
                            },
                            child: ProfileBarClipConst(
                              text: AppString.uptodate,
                              containerColor: Color(0xffB4DB4C),
                              textOval: AppString.four,
                            ),
                          ),
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

class licensepopup extends StatefulWidget {
  const licensepopup({super.key});

  @override
  State<licensepopup> createState() => _licensepopupState();
}

class _licensepopupState extends State<licensepopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(16),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          color: Color(0xff50B5E5),
        ),
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Expired Licence',
                style: GoogleFonts.firaSans(
                  fontSize: 10,
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
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      content: Container(
        height: 492,
        width: 833,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF6D6D6D),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      _buildTableHeader('SR. No.'),
                      _buildTableHeader('Name of License'),
                      _buildTableHeader('Date'),
                    ],
                  ),
                ],
              ),
            ),
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(2),
              },
              children: List.generate(8, (index) {
                return TableRow(
                  children: [
                    _buildTableCell('0${index + 1}'),
                    _buildTableCell('Driving License'),
                    _buildTableCell('01-07-2024'),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Text(text),
    );
  }
}


////////////////////////////////about to expire//////////////////////////


class AboutToExpireLicensePopup extends StatefulWidget {
  const AboutToExpireLicensePopup({Key? key}) : super(key: key);

  @override
  State<AboutToExpireLicensePopup> createState() => _AboutToExpireLicensePopupState();
}

class _AboutToExpireLicensePopupState extends State<AboutToExpireLicensePopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(16),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          color: Color(0xff50B5E5),
        ),
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'About to Expired Licence',
                style: GoogleFonts.firaSans(
                  fontSize: 10,
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
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      content: Container(
        height: 492,
        width: 833,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF6D6D6D),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      _buildTableHeader('SR. No.'),
                      _buildTableHeader('Name of License'),
                      _buildTableHeader('Date'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(2),
                    },
                    children: List.generate(8, (index) {
                      return TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        children: [
                          _buildTableCell('0${index + 1}'),
                          _buildTableCell('Driving License'),
                          _buildTableCell('12-09-2024'),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Text(text),
    );
  }
}

/////////////////////////////up to date license/////////////////////////////


class UpToDateLicensePopup extends StatefulWidget {
  const UpToDateLicensePopup({Key? key}) : super(key: key);

  @override
  State<UpToDateLicensePopup> createState() => _UpToDateLicensePopupState();
}

class _UpToDateLicensePopupState extends State<UpToDateLicensePopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(16),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          color: Color(0xff50B5E5),
        ),
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Up to Date License',
                style: GoogleFonts.firaSans(
                  fontSize: 10,
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
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      content: Container(
        height: 492,
        width: 833,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF6D6D6D),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      _buildTableHeader('SR. No.'),
                      _buildTableHeader('Up to Date License'),
                      _buildTableHeader('Date'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8), // Add space between header and content
            Expanded(
              child: ListView(
                children: [
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(2),
                    },
                    children: List.generate(8, (index) {
                      return TableRow(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        children: [
                          _buildTableCell('0${index + 1}'),
                          _buildTableCell('Driving License'),
                          _buildTableCell('Up-To-Date'),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Text(text),
    );
  }
}