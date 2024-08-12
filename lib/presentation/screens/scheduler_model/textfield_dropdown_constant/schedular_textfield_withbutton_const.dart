import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SchedularTextFieldWithButton extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final String buttonText;

  SchedularTextFieldWithButton({
    super.key,
    required this.labelText,
    this.initialValue,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            initialValue: initialValue,
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: GoogleFonts.firaSans(
                fontSize: 10,
                color: Color(0XFF575757),                                                      // text color
              ),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFB1B1B1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFB1B1B1)),
              ),
              contentPadding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 10,
                right: 90, // padding to make space for the button
              ),
            ),
          ),
          Positioned(
            right: 5,
            child: Container(
              height: 18,                                  //  view zone height button
              width: 72,
              child: ElevatedButton(
                onPressed: () async {
                  String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=19.113284653915976, 72.86915605796655';
                  if (await canLaunchUrlString(googleMapsUrl)) {
                    await launchUrlString(googleMapsUrl);
                  } else {
                    print('Could not open the map.');
                  }
                },
                child: Text(
                  buttonText,
                  style: GoogleFonts.firaSans(
                    fontSize:10,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
