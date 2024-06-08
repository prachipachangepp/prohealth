import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';

class BottomBarRow extends StatelessWidget {
  const BottomBarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
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
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.grey,
                    decoration: TextDecoration.none,
                  )),

              ///text + address
              Row(
                children: [
                  Text(
                    'Washington DC',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.darkgrey,
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
                    width: 27,
                  ),
                  Text(
                    'Powered by',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.grey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
