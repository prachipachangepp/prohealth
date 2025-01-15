import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prohealth/app/resources/screen_route_name.dart';
import 'package:prohealth/presentation/widgets/tablet_constant/tab_menu_const.dart';
import 'package:provider/provider.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/provider/navigation_provider.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../../hr_module/hr_home_screen/desk_dashboard_hrm.dart';
import '../../oasis_module/widgets/home_screen/responsive_screen_oasis.dart';

class HomeScreenTab extends StatelessWidget {
  const HomeScreenTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
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
                    alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(
                      'images/vector.svg',
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 3.5,
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
                      child: SvgPicture.asset(
                        'images/vector1.svg',
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 3,
                      ),
                    ),
                  ]),
            ],
          )),
      ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.045),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(1, 4),
                          ),
                        ],
                        color: ColorManager.white.withOpacity(0.35),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppPadding.p20),
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
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.darkgrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Administration',
                                        textAlign: TextAlign.center,
                                        style: MenuScreenHeadStyle.menuHead(
                                            context),
                                      ),
                                      Row(
                                        children: [
                                          TabMenuConst(
                                            text: 'Referral Resource Manager',
                                            imageProvider:
                                                AssetImage("images/r_r_m.png"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          TabMenuConst(
                                            text:
                                                'Business Intelligence & Reports',
                                            imageProvider:
                                                AssetImage("images/b_i_r.png"),
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
                                                            HomeScreenHRM()));
                                              },
                                              child: TabMenuConst(
                                                text: 'Intake & Scheduler',
                                                imageProvider: AssetImage(
                                                    "images/i_s.png"),
                                              )),
                                        ],
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Business',
                                        textAlign: TextAlign.center,
                                        style: MenuScreenHeadStyle.menuHead(
                                            context),
                                      ),
                                      Row(
                                        children: [
                                          TabMenuConst(
                                            text: 'Rehab',
                                            imageProvider:
                                                AssetImage("images/rehab.png"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          TabMenuConst(
                                            text: 'Home Care',
                                            imageProvider:
                                                AssetImage("images/h_c.png"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Provider.of<RouteProvider>(
                                                        context,
                                                        listen: false)
                                                    .setRoute('/detail');
                                                // Navigate to the detail page
                                                Navigator.pushNamed(context,
                                                    RouteStrings.emDesktop);
                                              },
                                              child: TabMenuConst(
                                                text: 'Establishment Manager',
                                                imageProvider: AssetImage(
                                                    "images/e_m.png"),
                                              )),
                                        ],
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Patient Related',
                                        textAlign: TextAlign.center,
                                        style: MenuScreenHeadStyle.menuHead(
                                            context),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeScreenHRM()));
                                              },
                                              child: TabMenuConst(
                                                text: 'Human Resource Manager',
                                                imageProvider: AssetImage(
                                                    "images/h_r_m.png"),
                                              )),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // Provider.of<RouteProvider>(
                                              //     context,
                                              //     listen: false)
                                              //     .setRoute(
                                              //     RouteStrings.EMRDesktop);
                                              //
                                              // // Navigate to the detail page
                                              // Navigator.pushNamed(context,
                                              //     RouteStrings.EMRDesktop);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OasisScreenEMR()));
                                            },
                                            child: TabMenuConst(
                                              text: 'Home Health EMR',
                                              imageProvider: AssetImage(
                                                  "images/h_h_emr.png"),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          TabMenuConst(
                                            text: 'Hospice EMR',
                                            imageProvider:
                                                AssetImage("images/h_emr.png"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          TabMenuConst(
                                            text: 'Finance',
                                            imageProvider: AssetImage(
                                                "images/finance.png"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          TabMenuConst(
                                            text: 'Other',
                                            imageProvider:
                                                AssetImage("images/other.png"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ))))),
      Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppString.poweredby,
              style: CustomTextStylesCommon.commonStyle(
                color: ColorManager.black,
                fontSize: FontSize.s10,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: AppSize.s2,
            ),
            Image.asset('images/powered_logo.png',
                width: AppSize.s20, height: AppSize.s20)
          ],
        ),
      )
    ]));
  }
}
