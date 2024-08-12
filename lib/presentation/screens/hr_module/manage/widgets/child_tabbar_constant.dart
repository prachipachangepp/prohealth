import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/controller.dart';

///getx
class CenteredTabBarChild extends StatelessWidget {
  final CenteredTabBarChildController controller;

  CenteredTabBarChild(this.controller);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs!.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xFF50B5E5),
              boxShadow: [
                BoxShadow(
                  // color: Colors.black.withOpacity(0.2),
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            height: 30,
            width: controller.tabBarViewWidth,
            child: TabBar(
              isScrollable: false,
              tabs: controller.tabs!,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: Colors.white),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              labelColor: Color(0xFF686464),
              unselectedLabelStyle: GoogleFonts.firaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              labelStyle: GoogleFonts.firaSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelColor: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: controller.tabBarViewHeight,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: controller.tabViews!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
