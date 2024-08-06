
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';

class IntakeReferralInfoScreen extends StatefulWidget {
  const IntakeReferralInfoScreen({super.key});

  @override
  State<IntakeReferralInfoScreen> createState() => _ReferralInfoScreenstate();
}

class _ReferralInfoScreenstate extends State<IntakeReferralInfoScreen> {
  String? status = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 275,
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
                              labelText: 'Referral Date',)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Projected SOC Delete', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Referral Source',)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Referee’s First Name',)
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Referee’s Last Name', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Referee’s Company Name', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Phone', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Fax', )
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                            labelText: 'Prefix')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Protocol', )
                        ),
                        SizedBox(width: 35),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Episode timing override (first 30 days)',
                                  style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s10, fontWeight: FontWeightManager.regular)
                              ),
                              SizedBox(height: 1),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Early',
                                    groupValue: status,
                                    onChanged: (value) => setState(() => status = value),
                                  ),
                                  Text('Early',
                                      style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12, fontWeight: FontWeightManager.regular)
                                  ),
                                  SizedBox(width: 35),
                                  Radio<String>(
                                    value: 'Late',
                                    groupValue: status,
                                    onChanged: (value) => setState(() => status = value),
                                  ),
                                  Text('Late',
                                      style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12, fontWeight: FontWeightManager.regular)
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 35),
                        Flexible(child: SchedularTextField(
                            labelText: 'Referral Taken By')
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Reason if not visited within 48 hours')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Comments')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: Container()), // Empty container for alignment
                        SizedBox(width: 35),
                        Flexible(
                            child: Container()), // Empty container for alignment
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
            fontSize: FontSize.s10,
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
