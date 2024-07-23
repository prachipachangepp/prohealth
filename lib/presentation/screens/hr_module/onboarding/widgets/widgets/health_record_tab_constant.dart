import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../app/resources/color.dart';

Widget HealthRecordConstantWithContainer(String title, String date,IconData icon, Color iconColor) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
        child: Container(
          height: 44.0,
          width: 44.0,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffC6C6C6)),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Icon(icon, color: iconColor),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.firaSans(
                color: Colors.black,
                fontSize: 10.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              date,
              style: GoogleFonts.firaSans(
                color: Colors.black,
                fontSize: 10.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

