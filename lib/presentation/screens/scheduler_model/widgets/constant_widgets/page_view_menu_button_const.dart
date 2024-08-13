
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../app/resources/color.dart';

typedef void OnManuButtonTapCallBack(int index);

class PageViewMenuButtonConst extends StatelessWidget {
  const PageViewMenuButtonConst(
      {super.key,
        required this.onTap,
        required this.index,
        required this.grpIndex,
        required this.heading});
  final OnManuButtonTapCallBack onTap;
  final int index;
  final int grpIndex;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return MenuClickableWidget(
      onTap: () {
        onTap(index);
      },
      onHover: (bool val) {},
      child: Column(
        children: [
          Text(
            heading,
            style: GoogleFonts.firaSans(
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.bold,
              color: grpIndex == index
                  ? ColorManager.blueprime
                  : const Color(0xff686464),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: AppSize.s6,
            width: AppSize.s120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13.0),
              color: grpIndex == index ? ColorManager.blueprime : Colors.transparent,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.5),
              //     offset: Offset(0, 4),
              //     blurRadius: 4,
              //     spreadRadius: 0,
              //   ),
              // ],
            ),
          ),
        ],
      ),
    );
  }
}


typedef OnClickableTap = Function();
typedef OnClickableHover = Function(bool val);

class MenuClickableWidget extends StatelessWidget {
  MenuClickableWidget(
      {super.key,
        required this.onTap,
        required this.child,
        required this.onHover});
  final OnClickableTap onTap;
  final OnClickableHover onHover;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        onHover: (value) {
          onHover(value);
        },
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: child);
  }
}
