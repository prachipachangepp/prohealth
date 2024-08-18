import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';

class IntakePatientsDatatInfo extends StatefulWidget {
  final TextEditingController ctlrSos;
  final TextEditingController ctlrMedicalRecord;
  final TextEditingController ctlrfirstName;
  final TextEditingController ctlrMI;
  final TextEditingController ctlrLastName;
  final TextEditingController ctlrSuffix;
  final TextEditingController ctlrDate;
  final TextEditingController ctlrStreet;
  final TextEditingController ctlrZipCode;
  final TextEditingController ctlrApartment;
  final TextEditingController ctlrCity;
  final TextEditingController ctlrMajorStreet;
  final TextEditingController ctlrPrimeNo;
  final TextEditingController ctlrSecNo;
  final TextEditingController ctlrEmail;
  final TextEditingController ctlrSocialSec;
  final TextEditingController ctlrDischargeResaon;
  final TextEditingController ctlrDateOfDeath;
  IntakePatientsDatatInfo({super.key, required this.ctlrSos, required this.ctlrMedicalRecord, required this.ctlrfirstName, required this.ctlrMI, required this.ctlrLastName, required this.ctlrSuffix, required this.ctlrDate, required this.ctlrStreet, required this.ctlrZipCode, required this.ctlrApartment, required this.ctlrCity, required this.ctlrMajorStreet, required this.ctlrPrimeNo, required this.ctlrSecNo, required this.ctlrEmail, required this.ctlrSocialSec, required this.ctlrDischargeResaon, required this.ctlrDateOfDeath});

  @override
  State<IntakePatientsDatatInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<IntakePatientsDatatInfo> {
  String? status = '';

  String? statustype;
  String? selectedStatus;
  String? selectedCountry;
  String? selectedRace;
  String? selectedState;
  String? selectedLanguage;
  String? selectedReligion;
  String? selectedMaritalStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppString.status_completed,
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: AppSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark),
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
                                  controller: widget.ctlrSos ,
                                  labelText: 'SOC Date',
                                suffixIcon: Icon(Icons.calendar_month_outlined),
                                 )),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrMedicalRecord,
                                  labelText: 'Medical Record',
                                  initialValue: '#632654')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularDropdown(
                                  labelText: AppString.status,
                                  items: ['Option 1', 'Option 2', 'Option 3'],
                                onChanged: (newValue) {
                                setState(() {
                                  selectedStatus = newValue;
                                  print(selectedState);
                                });
                              },)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrfirstName,
                                  labelText: AppString.fname,
                                  initialValue: 'Erica')),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrMI,
                                  labelText: 'M.I.',
                                  initialValue: 'A')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrLastName,
                                  labelText: AppString.lname)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrSuffix,
                                  labelText: AppString.suffix)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Status:',
                                    style: GoogleFonts.firaSans(
                                        fontSize: AppSize.s10,
                                        fontWeight: FontWeightManager.regular)),
                                SizedBox(height: 1),
                                Row(
                                  children: [
                                    CustomRadioListTile(
                                      title: 'Active',
                                      value: 'active',
                                      groupValue: statustype,
                                      onChanged: (value) {
                                        setState(() {
                                          statustype = value;
                                        });
                                      },
                                    ),
                                    CustomRadioListTile(
                                      title: 'Trainee',
                                      value: 'trainee',
                                      groupValue: statustype,
                                      onChanged: (value) {
                                        setState(() {
                                          statustype = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrDate,
                                  labelText: AppString.date_of_birth,
                                  initialValue: '25-05-1999',
                                  suffixIcon: Icon(Icons.calendar_month_outlined)
                                  )),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrStreet,
                                  labelText: 'Street',
                                  initialValue: '290,' ' Farewell Ave')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularDropdown(
                                  labelText: AppString.state,
                                  items: ['Option 1', 'Option 2', 'Option 3'],  onChanged: (newValue) {
                                setState(() {
                                  selectedState = newValue;
                                });
                              },)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextFieldWithButton(
                                  controller: widget.ctlrZipCode,
                                  labelText: AppString.zip_code,
                                  initialValue: '26586845121',
                                  buttonText: 'View Zone')),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrApartment,
                                  labelText: 'Suite/ Apt.')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrCity,
                                  labelText: AppString.city)),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularDropdown(
                            labelText: AppString.country,
                            items: ['Option 1', 'Option 2', 'Option 3'],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCountry = newValue;
                                  });
                                },
                          )),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrMajorStreet,
                                  labelText: 'Major Cross Street')),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrPrimeNo,
                                  labelText: AppString.primary_phone_number)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrSecNo,
                                  labelText: AppString.secondary_phone_number)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrEmail,
                                  labelText: AppString.email)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrSocialSec,
                                  labelText: 'Soc. sec#')),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child:


                              SchedularDropdown(
                            // controller: CtlrLanguageS,
                            labelText: 'Language Spoken',
                            items: ['Asian', 'African', 'European'],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedLanguage = newValue;
                                  });
                                },
                          )
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrDischargeResaon,
                                  labelText: 'Discharge Reason')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularDropdown(
                            // controller: ctlrRace,
                            labelText: 'Race / Ethnicity',
                            items: ['Hispanic', 'Latino American', 'Asian People'],
                                onChanged: (newValue) {
                                setState(() {
                                  selectedRace = newValue;
                                });
                              },
                          )),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularDropdown(
                            // controller: ctlrReligion,
                            labelText: 'Religion',
                            items: ['Christianity', 'Judaism', 'Islam'],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedReligion = newValue;
                                  });
                                },
                          )),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularDropdown(
                                  // controller: ctlrMaritalStatus,
                                  labelText: 'Marital Status',
                                  items: ['Married', 'Single', 'Separated'],  onChanged: (newValue) {
                                setState(() {
                                  selectedMaritalStatus = newValue;
                                });
                              },)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrDateOfDeath,
                                  labelText: AppString.date_of_death,
                                  suffixIcon: Icon(Icons.calendar_month_outlined)
                                  )),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child:
                                  Container()), // Empty container for alignment
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child:
                                  Container()), // Empty container for alignment
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
