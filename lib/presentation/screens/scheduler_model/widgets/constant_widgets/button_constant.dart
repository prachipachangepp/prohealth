import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import '../../../../../app/resources/font_manager.dart';

///saloni///
class SchedularIconButtonConst extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;
  final double? width;

  const SchedularIconButtonConst({
    this.text,
    this.icon,
    required this.onPressed,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width / 15, //11
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon!, color: ColorManager.white, size: AppSize.s20)
            : SizedBox.shrink(),
        label: Text(
          text!,
          style: GoogleFonts.firaSans(
            fontSize: AppSize.s12,
            fontWeight: FontWeightManager.bold,
            color: ColorManager.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s10, vertical: AppSize.s10),
          backgroundColor: ColorManager.blueprime,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: ColorManager.black.withOpacity(0.4),
        ),
      ),
    );
  }
}

