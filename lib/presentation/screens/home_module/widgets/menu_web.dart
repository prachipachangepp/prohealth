import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/desktop_module/em_module/responsive_screen_sm.dart';
import 'package:prohealth/presentation/screens/desktop_module/widgets/login_screen/desk_dashboard_hrm.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../../app/resources/value_manager.dart';

import '../../desktop_module/widgets/login_screen/widgets/child_container_constant_login.dart';

class HomeScreenWeb extends StatelessWidget {
  const HomeScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///bg image
          Container(
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          'images/menu_vector.svg',
                          height: MediaQuery.of(context).size.height / 1.28,
                          // width: MediaQuery.of(context).size.width / 1,
                        ),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset('images/vector1.svg',
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width),
                        ),
                      ]),
                ],
              )),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000).withOpacity(0.045),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(1, 4),
                        ),
                      ],
                      color: ColorManager.white.withOpacity(0.35),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select a Module',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeightManager.bold,
                                      color: ColorManager.darkgrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Administration',
                                      textAlign: TextAlign.center,
                                      style:
                                          MenuScreenHeadStyle.menuHead(context),
                                    ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Row(
                                      children: [
                                        const ResponsiveContainer(
                                          'Referral Resource Manager',
                                          AssetImage("images/r_r_m.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ResponsiveScreenSM()));
                                            },
                                            child: const ResponsiveContainer(
                                              'Establishment Manager',
                                              AssetImage("images/e_m.png"),
                                            )),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomeScreenHRM()));
                                            },
                                            child: const ResponsiveContainer(
                                              'Human Resource Manager',
                                              AssetImage("images/h_r_m.png"),
                                            )),
                                      ],
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Business',
                                      textAlign: TextAlign.center,
                                      style:
                                          MenuScreenHeadStyle.menuHead(context),
                                    ),
                                    Row(
                                      children: [
                                        const ResponsiveContainer(
                                          'Business Intelligence & Reports',
                                          AssetImage("images/b_i_r.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                        ),
                                        const ResponsiveContainer(
                                          'Finance',
                                          AssetImage("images/finance.png"),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Patient Related',
                                      textAlign: TextAlign.center,
                                      style:
                                          MenuScreenHeadStyle.menuHead(context),
                                    ),
                                    Row(
                                      children: [
                                        const ResponsiveContainer(
                                          'Intake & Scheduler',
                                          AssetImage("images/i_s.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                        ),
                                        const ResponsiveContainer(
                                          'Rehab',
                                          AssetImage("images/rehab.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                        ),
                                        const ResponsiveContainer(
                                          'Home Care',
                                          AssetImage("images/h_c.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                        ),
                                        const ResponsiveContainer(
                                          'Home Health EMR',
                                          AssetImage("images/h_h_emr.png"),
                                        ),
                                      ],
                                    ),
                                    const ResponsiveContainer(
                                      'Hospice EMR',
                                      AssetImage("images/h_emr.png"),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('#2031ABC01BA',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    )),
                const Row(
                  children: [
                    Text(
                      'Washington DC',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '198.168.1.231',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('images/powered_logo.png',
                        width: AppSize.s20, height: AppSize.s20),
                    Text(
                      'Powered by',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: MediaQuery.of(context).size.height / 90,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
