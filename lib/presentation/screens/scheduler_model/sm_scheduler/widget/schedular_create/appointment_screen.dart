import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/scheduler/scheduler_create_manager.dart';
import 'package:prohealth/data/api_data/sm_data/scheduler_create_data/schedular_data.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular_create/widget/calender_const.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/button_constant.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../app/resources/color.dart';
import '../schedular/sm_scheduler_screen.dart';

class SmProfileBar extends StatefulWidget {
  final VoidCallback onBack;
  const SmProfileBar({super.key, required this.onBack});

  @override
  State<SmProfileBar> createState() => _SmProfileBarState();
}

class _SmProfileBarState extends State<SmProfileBar> {
final StreamController<SchedularData> _schedulerController =
StreamController<SchedularData>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<SchedularData>(
        stream: _schedulerController.stream,
        builder: (context,snapshot) {
          getSchedularByClinitian(context: context, clinicialId: 134).then((data) {
            _schedulerController.add(data);
          }).catchError((error) {
// Handle error
          });
          if(snapshot.connectionState == ConnectionState.waiting){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),),
            );
          }
          if(snapshot.data!.isBlank!){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 150),
              child: Center(child: Text('No record found!'),),
            );
          }
          if(snapshot.hasData){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right:30,bottom:15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.whitebluecolor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
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
                        Column(
                          children: [
                            Row(
                              children: [
                                TextButton.icon(
                                  onPressed: widget.onBack,
                                  label: Text(
                                    'Back',
                                    style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.medium,
                                        color: ColorManager.textBlack),
                                  ),
                                  icon: Icon(Icons.keyboard_arrow_left_rounded, color: ColorManager.textBlack),
                                )
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height / 140),
                            CircleAvatar(
                              radius: 40, //MediaQuery.of(context).size.width * 0.03
                              backgroundImage: AssetImage('images/profile.png'),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height / 60),
                            Text(
                              snapshot.data!.fullname,
                              style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s10,
                                  // fontSize: MediaQuery.of(context).size.width * 0.006,
                                  fontWeight: FontWeightManager.medium),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height / 30),
                            Text(
                              snapshot.data!.status.capitalizeFirst!,
                              style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s10,
                                  // fontSize: MediaQuery.of(context).size.width * 0.006,
                                  fontWeight: FontWeightManager.bold,
                                  color: ColorManager.textPrimaryColor),
                            )
                          ],
                        ),
                        // SizedBox(width: MediaQuery.of(context).size.width / 40),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Zone :',
                                style: GoogleFonts.firaSans(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeightManager.regular,
                                    color: ColorManager.textPrimaryColor),
                              ),
                              Text(
                                'Expertise :',
                                style: GoogleFonts.firaSans(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeightManager.regular,
                                    color: ColorManager.textPrimaryColor),
                              ),
                              Text(
                                'Current Location :',
                                style: GoogleFonts.firaSans(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeightManager.regular,
                                    color: ColorManager.textPrimaryColor),
                              ),
                              Text(
                                'Total patients :',
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
                                  snapshot.data!.zone,
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
                              snapshot.data!.expertise,
                              style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s10,
                                  fontWeight: FontWeightManager.regular,
                                  color: ColorManager.textBlack),
                            ),
                            Text(
                              snapshot.data!.correntLocation,
                              style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s10,
                                  fontWeight: FontWeightManager.regular,
                                  color: ColorManager.textBlack),
                            ),
                            Text(
                            "${snapshot.data!.totalPatients}",
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
                              'Summary :',
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.medium,
                              ),
                            ),
                            Container(
                              height: AppSize.s144,
                              width: MediaQuery.of(context).size.width / 7,
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
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SummaryRowConst(
                                      title: 'Visits :', count1: '${snapshot.data!.summary.visit}', count2: '${snapshot.data!.summary.visit}'),
                                  SummaryRowConst(
                                      title: 'Travel :',
                                      count1: snapshot.data!.summary.travel,
                                      count2: '--'),
                                  SummaryRowConst(
                                      title: 'Earning :',
                                      count1: '\$${snapshot.data!.summary.earning}',
                                      count2: '\$--'),
                                  SummaryRowConst(
                                      title: 'Total OAISIS :', count1: '${snapshot.data!.summary.totalQAISIS}', count2: '${snapshot.data!.summary.totalQAISIS}'),
                                  SummaryRowConst(
                                      title: 'Rescheduled :', count1: '${snapshot.data!.summary.rescheduled}', count2: '${snapshot.data!.summary.rescheduled}'),
                                  SummaryRowConst(
                                      title: 'Reassigned :', count1: '${snapshot.data!.summary.reAssigned}', count2: '${snapshot.data!.summary.reAssigned}')
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
                              width: MediaQuery.of(context).size.width / 10,
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
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ComplianceRowConst(
                                    title: 'Missed Visits :',
                                    count1: '${snapshot.data!.compliance.missedVisit}',
                                  ),
                                  ComplianceRowConst(
                                    title: 'OAISIS Forms License :',
                                    count1: '${snapshot.data!.compliance.qaisisForms}',
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
                                width: MediaQuery.of(context).size.width / 5,
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
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 1,
                    child: CalenderConstant(schedularData: snapshot.data!,))
              ],
            );
          }
          else{
            return SizedBox();
          }

        }
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
      padding:
          const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
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
                    color: ColorManager.blueprime),
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
                    color: ColorManager.textBlack),
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
                    color: ColorManager.textBlack),
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
      padding:
          const EdgeInsets.only(left: AppPadding.p10, right: AppPadding.p10),
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
                    color: ColorManager.blueprime),
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
                    color: ColorManager.textBlack),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
