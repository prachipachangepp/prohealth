import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';

class IntakePatientsDatatInfo extends StatefulWidget {
  const IntakePatientsDatatInfo({super.key});

  @override
  State<IntakePatientsDatatInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<IntakePatientsDatatInfo> {
  String? status = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Status Completed',
                    style: GoogleFonts.firaSans(
                        decoration: TextDecoration.none,
                        fontSize: 12.0,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.greenDark
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 19.5),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorManager.white,
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
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'SOC Date', isDate: true)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Medical Record', initialValue: '#632654')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                                labelText: AppString.status, initialValue: 'Scheduled')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.fname, initialValue: 'Erica')
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'M.I.', initialValue: 'A')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.lname)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.suffix)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status:',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10, fontWeight: FontWeight.w400)
                              ),
                              SizedBox(height: 1),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'Active',
                                    groupValue: status,
                                    onChanged: (value) => setState(() => status = value),
                                  ),
                                  Text('Active',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 12, fontWeight: FontWeight.w400)
                                  ),
                                  SizedBox(width: 10),
                                  Radio<String>(
                                    value: 'Trainee',
                                    groupValue: status,
                                    onChanged: (value) => setState(() => status = value),
                                  ),
                                  Text('Trainee',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 12, fontWeight: FontWeight.w400)
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.date_of_birth,
                                initialValue: '25-05-1999',
                                isDate: true)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Street',
                                initialValue: '290,'' Farewell Ave')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                                labelText: AppString.state, initialValue: 'CA')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                                labelText: AppString.zip_code,
                                initialValue: '26586845121', buttonText: 'View Zone')
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                            labelText: 'Suite/ Apt.')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.city)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(labelText: AppString.country)
                        ),
                        SizedBox(width: 35),
                        Flexible(child: SchedularTextField(labelText: 'Major Cross Street')),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText:AppString.primary_phone_number)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(labelText: AppString.secondary_phone_number)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(labelText: AppString.email)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(labelText: 'Soc. sec#')
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularDropdown(
                                labelText: 'Language Spoken',
                                initialValue: 'English')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Discharge Reason')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                                labelText: 'Race / Ethnicity',
                                initialValue: 'English')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(labelText: 'Religion')
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularDropdown(
                                labelText: 'Marital Status')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.date_of_death, isDate: true)
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
            ),
          ],
        ),
      ),
    );
  }
}

class SchedularTextField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final bool isDate;
  final TextEditingController? controller;

  SchedularTextField({
    super.key,
    required this.labelText,
    this.initialValue,
    this.isDate = false,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorManager.black,
        ),
        cursorColor: ColorManager.black,
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
          suffixIcon: isDate ? Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime//calandercolour
          ) : null,
        ),
        readOnly: isDate,
        onTap: isDate
            ? () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            // Handle the picked date
          }
        }
            : null,
      ),
    );
  }
}

// class SchedularDropdown extends StatelessWidget {
//   final String labelText;
//   final String? initialValue;
//
//   const SchedularDropdown({
//     super.key,
//     required this.labelText,
//     this.initialValue,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 25.38,                                                          //DROPDOWN CONTAINER HEIGHT
//       child: DropdownButtonFormField<String>(
//         value: initialValue,
//         style: GoogleFonts.firaSans(
//           fontSize: 12,
//           fontWeight: FontWeightManager.regular,
//           color: ColorManager.black,
//         ),
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: GoogleFonts.firaSans(
//             fontSize: 10,
//             fontWeight: FontWeightManager.regular,
//             color: ColorManager.greylight,                                           // text color in dropdown
//           ),
//           border:  OutlineInputBorder(),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0XFFB1B1B1)),                         // border color
//           ),
//         ),
//         items: [initialValue ?? '']
//             .map((value) => DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         ))
//             .toList(),
//         onChanged: (value) {
//           // Handle dropdown change
//         },
//         iconEnabledColor: ColorManager.blueprime, // dropdown icon color
//         iconSize: 24, // Adjust the size of the dropdown icon
//         isDense: true, // Adjust the density of the dropdown
//       ),
//     );
//   }
// }


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
      height: 25.38, // DROPDOWN CONTAINER HEIGHT
      child: DropdownButtonFormField<String>(
        value: initialValue,
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.greylight, // text color in dropdown
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFB1B1B1)), // border color
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
        icon: Padding(
          padding: const EdgeInsets.only(right: 2,bottom: 500), // Add your desired padding here
          child: Icon(
            Icons.arrow_drop_down,
            color: ColorManager.blueprime,                                         // dropdown icon color
            size: 24,                                                              // size of icon
          ),
        ),
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
