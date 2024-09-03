import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SchedularTextFieldWithButton extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final String buttonText;
  final controller;

  SchedularTextFieldWithButton({
    super.key,
    required this.labelText,
    this.initialValue,
    required this.buttonText, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s25p38,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            initialValue: initialValue,
            style: GoogleFonts.firaSans(
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.black,
            ),
            cursorColor: ColorManager.black,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: GoogleFonts.firaSans(
                fontSize: FontSize.s10,
                color: ColorManager.lightgreyheading,                                                      // text color
              ),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.containerBorderGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.containerBorderGrey),
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
              height: AppSize.s18,                                  //  view zone height button
              width: AppSize.s72,
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
                    fontSize:FontSize.s10,
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.white,
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
