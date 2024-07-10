import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';

class QualificationActionButtons extends StatelessWidget {
  final VoidCallback onRejectPressed;
  final VoidCallback onApprovePressed;
  final bool? approve;

  QualificationActionButtons({super.key, required this.onRejectPressed, required this.onApprovePressed,this.approve});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        approve == null
            ? ElevatedButton(
          onPressed: onRejectPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xff1696C8),
            side: BorderSide(color: Color(0xff1696C8)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Reject',
            style: GoogleFonts.firaSans(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
            : approve == false
            ? Text(
          'Rejected',
          textAlign: TextAlign.center,
          style: CustomTextStylesCommon.commonStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.mediumgrey,
          ),
        )
            : Offstage(),
        SizedBox(width: MediaQuery.of(context).size.width / 75),
        approve == null
            ? ElevatedButton(
          onPressed: onApprovePressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff1696C8),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Approve',
            style: GoogleFonts.firaSans(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
            : approve == true
            ? Text(
          'Approved',
          textAlign: TextAlign.center,
          style: CustomTextStylesCommon.commonStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.blueprime,
          ),
        )
            : Offstage(),
      ],
    );
  }
}
