
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IntakeRelatedPartiesScreen extends StatefulWidget {
  const IntakeRelatedPartiesScreen({super.key});

  @override
  State<IntakeRelatedPartiesScreen> createState() => _RelatedPartiesScreenstate();
}

class _RelatedPartiesScreenstate extends State<IntakeRelatedPartiesScreen> {
  bool isOptForCAHPSSurvey = false;
  String? status = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 160.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Status: Partially Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffFFA500)
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/60),
                    Container(
                      height: 32,
                      width: 165,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return RelatedPartiesAddPopUp();
                          //   },
                          // );
                        },
                        icon: Icon(Icons.add,color: Colors.white, size: AppSize.s20),
                        label: Text(
                          'Add Related Parties',
                          style: GoogleFonts.firaSans(
                            color: Colors.white,
                            fontSize: AppSize.s12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF50B5E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 1219,
                height: 505,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Emergency Contact Information',
                            style: TextStyle(
                                fontSize: AppSize.s12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff686464)
                            ),)
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                labelText: 'Emergency Contact',)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                labelText: 'Telephone Number', )
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularDropdown(
                                labelText: 'Relationship',)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                labelText: 'Emergency Contact Address',)
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
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
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularDropdown(
                                labelText: 'Priority/ Disaster Code', )
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(child: SchedularTextField(
                              labelText: 'Comments')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: Container()), // Empty container for alignment
                          SizedBox(width: 35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: 35),
                          Flexible(
                              child: Container()),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text('Primary Care Giver',
                            style: TextStyle(
                                fontSize: AppSize.s12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff686464)
                            ),)
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(child: SchedularTextField(
                              labelText: 'Prefix')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                labelText: 'First Name', initialValue: 'Erica',)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                labelText: 'M.I.', initialValue: 'A',)
                          ),
                          SizedBox(width: 35),
                          Flexible(child: SchedularTextField(
                              labelText: 'Last Name')
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Suffix')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                            child: Row(
                              children: [
                                Checkbox(
                                  // checkColor: Color(0xff50B5E5),
                                  value: isOptForCAHPSSurvey,
                                  onChanged: (value) {
                                    setState(() {
                                      isOptForCAHPSSurvey = value!;
                                    });
                                  },
                                ),
                                Expanded(child: SchedularTextField(labelText: 'Opt for CAHPS Survey')),
                              ],
                            ),
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Address')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Suite/ Apt.')
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'City')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularDropdown(
                                labelText: 'State',)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextFieldWithButton(
                                  labelText: 'Zip Code',
                                  initialValue: '26586845121', buttonText: 'View Zone')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Phone')
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Cell')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Email')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularDropdown(
                                labelText: 'Relationship',)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Additional Information')
                          ), // Empty container for alignment
                        ],
                      ),
                    ],
                  ),
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
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
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
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
            fontWeight: FontWeight.w400,
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
        iconSize: 24, // Adjust the size of the dropdown icon
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
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
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
