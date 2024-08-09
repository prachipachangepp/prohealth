import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';

class IntakePatientsDatatInfo extends StatefulWidget {
  const IntakePatientsDatatInfo({super.key});

  @override
  State<IntakePatientsDatatInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<IntakePatientsDatatInfo> {
  String? status = '';

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
                    Text('Status Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: AppSize.s12,
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
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Medical Record',
                                  initialValue: '#632654')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularDropdown(
                                  labelText: AppString.status,
                                items: ['Option 1', 'Option 2', 'Option 3']
                                )
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.fname,
                                  initialValue: 'Erica')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'M.I.', initialValue: 'A')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.lname)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.suffix)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Status:',
                                    style: GoogleFonts.firaSans(
                                        fontSize: AppSize.s10,
                                        fontWeight: FontWeightManager.regular)
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
                                            fontSize: AppSize.s12,
                                            fontWeight: FontWeightManager.regular)
                                    ),
                                    SizedBox(width: AppSize.s10),
                                    Radio<String>(
                                      value: 'Trainee',
                                      groupValue: status,
                                      onChanged: (value) => setState(() => status = value),
                                    ),
                                    Text('Trainee',
                                        style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeightManager.regular)
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
                                  labelText: AppString.date_of_birth,
                                  initialValue: '25-05-1999',
                                  isDate: true)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Street',
                                  initialValue: '290,'' Farewell Ave')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularDropdown(
                                  labelText: AppString.state,
                                  items: ['Option 1', 'Option 2', 'Option 3']
                                  )
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextFieldWithButton(
                                  labelText: AppString.zip_code,
                                  initialValue: '26586845121',
                                  buttonText: 'View Zone')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(child: SchedularTextField(
                              labelText: 'Suite/ Apt.')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.city)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularDropdown(
                                  labelText: AppString.country,
                                  items: ['Option 1', 'Option 2', 'Option 3'],
                              )
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Major Cross Street')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText:AppString.primary_phone_number)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.secondary_phone_number)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.email)
                          ),
                          SizedBox(width:AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Soc. sec#')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularDropdown(
                                  labelText: 'Language Spoken',
                                  items: ['Option 1', 'Option 2', 'Option 3'],
                                  )
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Discharge Reason')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularDropdown(
                                  labelText: 'Race / Ethnicity',
                                items: ['Option 1', 'Option 2', 'Option 3'],
                                )
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularDropdown(
                                labelText: 'Religion',
                                  items: ['Option 1', 'Option 2', 'Option 3'],
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularDropdown(
                                  labelText: 'Marital Status',
                                items: ['Option 1', 'Option 2', 'Option 3']
                              )
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.date_of_death,
                                  isDate: true)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()), // Empty container for alignment
                          SizedBox(width: AppSize.s35),
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
      ),
    );
  }
}



