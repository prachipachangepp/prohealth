
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';

class IntakeAgencyInfoScreen extends StatefulWidget {
  const IntakeAgencyInfoScreen({super.key});

  @override
  State<IntakeAgencyInfoScreen> createState() => _IntakeAgencyInfoScreenstate();
}

class _IntakeAgencyInfoScreenstate extends State<IntakeAgencyInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Status Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 249,
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Agency',)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Agency Name', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Rate',)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Street',)
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Suite/ Apt.', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'City', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'State', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                                labelText: 'Zip Code',
                                initialValue: '26586845121', buttonText: 'View Zone')
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                            labelText: 'Phone')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Fax', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Email', )
                        ),
                        SizedBox(width: 35),
                        Flexible(child: SchedularTextField(
                            labelText: 'Unites')
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///////

class SchedularTextField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final bool isDate;

  SchedularTextField({
    super.key,
    required this.labelText,
    this.initialValue,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      child: TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.firaSans(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.regular,
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
            color: ColorManager.greylight,                          // label text color
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFB1B1B1)), //  border color
          ),
        ),
      ),
    );
  }
}

class SchedularDropdown extends StatelessWidget {
  final String labelText;
  final String? initialValue;

  const SchedularDropdown({
    super.key,
    required this.labelText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      child: DropdownButtonFormField<String>(
        value: initialValue,
        style: GoogleFonts.firaSans(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.regular,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.greylight,                                           // text color in dropdown
          ),
          border:  OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFB1B1B1)),                         // border color
          ),
        ),
        items: [initialValue ?? '']
            .map((value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ))
            .toList(),
        onChanged: (value) {
          // Handle dropdown change
        },
        iconEnabledColor: ColorManager.blueprime, // dropdown icon color
        iconSize: FontSize.s24, // Adjust the size of the dropdown icon
        isDense: true, // Adjust the density of the dropdown
      ),
    );
  }
}

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
              fontSize: FontSize.s12,
              fontWeight: FontWeightManager.regular,
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: GoogleFonts.firaSans(
                fontSize: FontSize.s10,
                color: ColorManager.lightgreyheading,                                                      // text color
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
            right: 0,
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
                    fontSize: FontSize.s10,
                    fontWeight: FontWeightManager.regular,
                    color: Colors.white,
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
