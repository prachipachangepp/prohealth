import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';

import '../../../app/resources/color.dart';
import '../../../app/resources/font_manager.dart';
import '../../../app/resources/screen_route_name.dart';

class ReferalResourceDesktop extends StatelessWidget {
  const ReferalResourceDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
              child: Text('Coming Soon...',
                style: TextStyle(
                  fontSize: FontSize.s18,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.mediumgrey,
                  decoration: TextDecoration.none,
                )),
            ),
    );
        }
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       child: Text('Coming Soon',
  //       style: AllNoDataAvailable.customTextStyle(context),),
  //     ),
  //   );


class RRTablet extends StatelessWidget {
  const RRTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Tablet Screen'),
    ),
    body: Center(
    child: Text(
    'Tablet Screen Content',
    style: TextStyle(fontSize: 24.0),
    ),
    ),
    );
    }
}