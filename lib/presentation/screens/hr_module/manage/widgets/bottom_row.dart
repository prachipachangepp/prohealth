import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

class BottomBarRow extends StatelessWidget {
  const BottomBarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s50,
      // width: AppSize.s
      // double.infinity,
      //flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 120),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///text
            Text('#2031ABC01BA',
                style: GoogleFonts.firaSans(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.grey,
                  decoration: TextDecoration.none,
                )),

            ///text + address
            Row(
              children: [
                Text(
                  'Washington DC',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.darkgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  width: AppSize.s10,
                ),
                Text(
                  '198.168.1.231',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.grey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),

            ///logo
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/powered_logo.png',
                  //  height: 27,
                  width: MediaQuery.of(context).size.width / 50,
                ),
                Text(
                  'Powered by',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.grey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
