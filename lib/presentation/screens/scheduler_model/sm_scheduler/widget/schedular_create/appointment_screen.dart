import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/button_constant.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../app/resources/color.dart';

class SmProfileBar extends StatefulWidget {
  const SmProfileBar({super.key});

  @override
  State<SmProfileBar> createState() => _SmProfileBarState();
}

class _SmProfileBarState extends State<SmProfileBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorManager.whitebluecolor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            height: AppSize.s200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p40),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.keyboard_arrow_left_rounded),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 180),
                          TextButton(
                            onPressed: () {
                             Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Back',
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.medium,
                                color: ColorManager.textBlack
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 140),
                      CircleAvatar(
                        radius: 40, //MediaQuery.of(context).size.width * 0.03
                        backgroundImage: AssetImage('images/profile.png'),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                      Text(
                        'JOHN SCOTT',
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            // fontSize: MediaQuery.of(context).size.width * 0.006,
                            fontWeight: FontWeightManager.medium),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'Active',
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            // fontSize: MediaQuery.of(context).size.width * 0.006,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.textPrimaryColor),
                      )
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
                      Text(
                        'Zone',
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                      Text(
                        'Expertise',
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                      Text(
                        'Current Location',
                        style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.textPrimaryColor),
                      ),
                      Text(
                        'Total patients',
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
                            child: Text(
                              'View Zone',
                              style: GoogleFonts.firaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
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
                      'Alzeimer’s Care',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textBlack),
                    ),
                    Text(
                      '8502 Preston Road, Inglewood.',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textBlack),
                    ),
                    Text(
                      '15',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.textBlack),
                    ),
                  ],
                ),

                // SizedBox(width: MediaQuery.of(context).size.width/120),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: GoogleFonts.firaSans(
                          fontSize: FontSize.s10,
                          fontWeight: FontWeightManager.medium,
                      ),
                    ),


                    Container(
                      height: AppSize.s144,
                      width: MediaQuery.of(context).size.width/7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8.0)
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SummaryRowConst(
                              title: 'Visits',
                              count1: '4',
                              count2: '20'
                          ),
                          SummaryRowConst(
                              title: 'Travel',
                              count1: '16 miles',
                              count2: '50 miles'
                          ),
                          SummaryRowConst(
                              title: 'Earning',
                              count1: '\$600',
                              count2: '\$1300'
                          ),
                          SummaryRowConst(
                              title: 'Total OAISIS',
                              count1: '2',
                              count2: '2'
                          ),
                          SummaryRowConst(
                              title: 'Rescheduled',
                              count1: '1',
                              count2: '4'
                          ),
                          SummaryRowConst(
                              title: 'Reassigned',
                              count1: '4',
                              count2: '4'
                          )
                        ],
                      ),

                    )
                  ],
                ),



                // SizedBox(width: MediaQuery.of(context).size.width/140),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compliance',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s10,
                        fontWeight: FontWeightManager.medium,
                      ),
                    ),

                    // SizedBox(height: MediaQuery.of(context).size.height/160),
                    Container(
                      height: AppSize.s77,
                      width: MediaQuery.of(context).size.width/10,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.0)
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ComplianceRowConst(
                              title: 'Missed Visits',
                              count1: '4',
                          ),
                          ComplianceRowConst(
                              title: 'OAISIS Forms License',
                              count1: '2 Expiring',
                          )
                        ],
                      ),

                    )
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