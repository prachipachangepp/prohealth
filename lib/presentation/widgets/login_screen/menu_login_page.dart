//

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/home_screen.dart';
import 'package:prohealth/presentation/widgets/login_screen/widgets/child_container_constant_login.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 4,
        child: Container(
            // height: 725,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/login_screen_no_blur.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height / 30,
                      vertical: MediaQuery.of(context).size.width / 30),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000).withOpacity(0.045),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(1, 4),
                            ),
                          ],
                          color: Color(0xffFFFFFF).withOpacity(0.35),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 90,
                              vertical:
                                  MediaQuery.of(context).size.height / 100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width / 90,
                                    vertical:
                                        MediaQuery.of(context).size.height /
                                            100),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ///head text
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              80),
                                      child: Text(
                                        'Select a Module',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'FiraSans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff565656),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Administration',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'FiraSans',
                                          color: Color(0xff565656),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        ResponsiveContainer(
                                          'Referral Resource Manager',
                                          AssetImage("images/r_r_m.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              40,
                                        ),
                                        ResponsiveContainer(
                                          'Establishment Manager',
                                          AssetImage("images/e_m.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              40,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeScreen()));
                                            },
                                            child: ResponsiveContainer(
                                              'Human Resource Manager',
                                              AssetImage("images/h_r_m.png"),
                                            )),
                                      ],
                                    ),
                                    Text(
                                      'Business',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'FiraSans',
                                          color: Color(0xff565656),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        ResponsiveContainer(
                                          'Business Intelligence & Reports',
                                          AssetImage("images/b_i_r.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              40,
                                        ),
                                        ResponsiveContainer(
                                          'Finance',
                                          AssetImage("images/finance.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              40,
                                        ),
                                        ResponsiveContainer(
                                          'Other',
                                          AssetImage("images/other.png"),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Patient Related',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'FiraSans',
                                          color: Color(0xff565656),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        ResponsiveContainer(
                                          'Intake & Scheduler',
                                          AssetImage("images/i_s.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              40,
                                        ),
                                        ResponsiveContainer(
                                          'Rehab',
                                          AssetImage("images/rehab.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              40,
                                        ),
                                        ResponsiveContainer(
                                          'Home Care',
                                          AssetImage("images/h_c.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              40,
                                        ),
                                        ResponsiveContainer(
                                          'Home Health EMR',
                                          AssetImage("images/h_h_emr.png"),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              40,
                                        ),
                                        ResponsiveContainer(
                                          'Hospice EMR',
                                          AssetImage("images/h_emr.png"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            )));
  }
}
