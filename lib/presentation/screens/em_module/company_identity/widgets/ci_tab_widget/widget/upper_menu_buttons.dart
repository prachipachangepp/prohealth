import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/widgets/app_clickable_widget.dart';

import '../../../../../../../app/resources/color.dart';

typedef void OnManuButtonTapCallBack(int index);

class UpperMenuButtons extends StatelessWidget {
  const UpperMenuButtons(
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
    return AppClickableWidget(
      onTap: () {
        onTap(index);
      },
      onHover: (bool val) {},
      child: Column(
        children: [
          Text(
            heading,
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: grpIndex == index
                  ? ColorManager.blueprime
                  : const Color(0xff686464),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 2,
            width: 120,
            color:
                grpIndex == index ? ColorManager.blueprime : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
