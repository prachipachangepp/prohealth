import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/button_constant.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../app/resources/color.dart';

class IntakeProfileBar extends StatefulWidget {
  const IntakeProfileBar({super.key});

  @override
  State<IntakeProfileBar> createState() => _IntakeProfileBarState();
}

class _IntakeProfileBarState extends State<IntakeProfileBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorManager.whitebluecolor.withOpacity(0.25),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.25),
              //     spreadRadius: 0,
              //     blurRadius: 4,
              //     offset: Offset(0, 4),
              //   ),
              // ],
            ),
            height: AppSize.s200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: AppSize.s80,
                            height: AppSize.s80,
                            child: CircularProgressIndicator(
                              strokeWidth: 4.0,
                              value: 0.7,
                              valueColor: AlwaysStoppedAnimation<Color>(ColorManager.greenDark),
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          CircleAvatar(
                            radius: 40, // MediaQuery.of(context).size.width * 0.03
                            backgroundImage: AssetImage('images/profile.png'),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                      Text(
                        'JOHN SCOTT',
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          // fontSize: MediaQuery.of(context).size.width * 0.006,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        AppString.active,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          // fontSize: MediaQuery.of(context).size.width * 0.006,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),

                ),
                // SizedBox(width: MediaQuery.of(context).size.width / 40),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.zone,
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                      Text(
                        'DOB',
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                      Text(
                        'Phone',
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                      Text(AppString.email,
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                    ],
                  ),
                ),
                // SizedBox(width: MediaQuery.of(context).size.width / 60),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'ProHealth, San Jose2',
                          style: GoogleFonts.firaSans(
                              fontSize: FontSize.s10,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.textBlack),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 100),
                        Container(
                          height: AppSize.s18,
                          width: AppSize.s72,
                          child: ElevatedButton(
                            onPressed: () async {
                              String googleMapsUrl =
                                  'https://www.google.com/maps/search/?api=1&query=19.113284653915976, 72.86915605796655';
                              if (await canLaunchUrlString(googleMapsUrl)) {
                                await launchUrlString(googleMapsUrl);
                              } else {
                                print('Could not open the map.');
                              }
                            },
                            child: Text(AppString.viewzone,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.blueprime,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '25-05-1999',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textBlack),
                    ),
                    Text(
                      '+49 5684654545',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textBlack),
                    ),
                    Text(
                      'john@gmail.com',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textBlack),
                    ),
                  ],
                ),

                // SizedBox(width: MediaQuery.of(context).size.width/120),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.address,
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                      Text(
                        'Patient Status',
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                      Text(
                        'Diagnosis',
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                    ],
                  ),
                ),
                // SizedBox(width: MediaQuery.of(context).size.width / 60),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: AppSize.s95,
                          child: Text(
                            '5445 Alvilde CT, Rio Linda CA 5645451516',
                            style: GoogleFonts.firaSans(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.textBlack),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 100),
                        Container(
                          height: AppSize.s18,
                          width: AppSize.s72,
                          child: ElevatedButton(
                            onPressed: () async {
                              String googleMapsUrl =
                                  'https://www.google.com/maps/search/?api=1&query=19.113284653915976, 72.86915605796655';
                              if (await canLaunchUrlString(googleMapsUrl)) {
                                await launchUrlString(googleMapsUrl);
                              } else {
                                print('Could not open the map.');
                              }
                            },
                            child: Text(
                              'View Zone',
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.blueprime,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Lead',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textBlack),
                    ),
                    Text(
                      'Alzeimer’s Care',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textBlack),
                    ),
                  ],
                ),


                // SizedBox(width: MediaQuery.of(context).size.width/120),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p15),
                      child: Container(
                        height: AppSize.s166,
                        width: MediaQuery.of(context).size.width/5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/mapImage.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          height: AppSize.s18,
                          width: AppSize.s72,
                          child: ElevatedButton(
                            onPressed: () async {
                              String googleMapsUrl =
                                  'https://www.google.com/maps/search/?api=1&query=19.113284653915976, 72.86915605796655';
                              if (await canLaunchUrlString(googleMapsUrl)) {
                                await launchUrlString(googleMapsUrl);
                              } else {
                                print('Could not open the map.');
                              }
                            },
                            child: Text(
                              'View map',
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.blueprime,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class SummaryRowConst extends StatelessWidget {
  final String title;
  final String count1;
  final String count2;

  const SummaryRowConst({
    Key? key,
    required this.title,
    required this.count1,
    required this.count2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: GoogleFonts.firaSans(
                  // fontSize: FontSize.s10,
                    fontSize: MediaQuery.of(context).size.width * 0.007,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.blueprime
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                count1,
                style: GoogleFonts.firaSans(
                  // fontSize: FontSize.s10,
                    fontSize: MediaQuery.of(context).size.width * 0.007,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textBlack
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                count2,
                style: GoogleFonts.firaSans(
                  // fontSize: FontSize.s10,
                    fontSize: MediaQuery.of(context).size.width * 0.007,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textBlack
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class ComplianceRowConst extends StatelessWidget {
  final String title;
  final String count1;

  const ComplianceRowConst({
    Key? key,
    required this.title,
    required this.count1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: GoogleFonts.firaSans(
                  // fontSize: FontSize.s10,
                    fontSize: MediaQuery.of(context).size.width * 0.007,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.blueprime
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                count1,
                style: GoogleFonts.firaSans(
                  // fontSize: FontSize.s10,
                    fontSize: MediaQuery.of(context).size.width * 0.007,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.textBlack
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}