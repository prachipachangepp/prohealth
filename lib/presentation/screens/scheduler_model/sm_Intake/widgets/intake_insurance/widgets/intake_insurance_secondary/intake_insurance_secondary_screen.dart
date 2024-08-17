import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_insurance/widgets/intake_insurance_primary/intake_insurance_primary_screen.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../textfield_dropdown_constant/double_date_picker_textfield.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../intake_patients_data/widgets/patients_info/intake_patients_info.dart';

class IntakeInsuranceSecondaryScreen extends StatefulWidget {
  const IntakeInsuranceSecondaryScreen({super.key});

  @override
  State<IntakeInsuranceSecondaryScreen> createState() => _IntakeInsuranceSecondaryScreenState();
}

class _IntakeInsuranceSecondaryScreenState extends State<IntakeInsuranceSecondaryScreen> {
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
                padding: const EdgeInsets.only(right: 50.0),
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
              SizedBox(height: 19.5),
              Container(
                // height: 490,
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
                                  labelText: 'Primary Insurance')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.name)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.street)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.code)
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: AppString.suite_Apt)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:AppString.city)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                labelText: AppString.state,)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:AppString.zip_code)
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText:AppString.type)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Phone')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                labelText:'Category',)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Authorisation')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: DoubleDatePickerTextField(
                                labelText: 'Effective from', isDate: true,)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Group #')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Group Name')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Policy/ HIC #')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularDropdown(
                                labelText: 'Eligibility Status', onChanged: (newValue) {  }, )
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Insurance Verified',
                                    style: GoogleFonts.firaSans(
                                        color: ColorManager.lightgreyheading,
                                        fontSize: FontSize.s10,
                                        fontWeight:FontWeightManager.regular)
                                ),
                                SizedBox(height: 1),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: status,
                                      onChanged: (value) => setState(() => status = value),
                                    ),
                                    Text(AppString.yes,
                                        style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeightManager.regular)
                                    ),
                                    SizedBox(width: AppSize.s35),
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: status,
                                      onChanged: (value) => setState(() => status = value),
                                    ),
                                    Text(AppString.no,
                                        style: GoogleFonts.firaSans(
                                            fontSize: 12, fontWeight:FontWeightManager.regular)
                                    ),
                                    SizedBox(width: AppSize.s20),
                                    TextButton(
                                      onPressed: () => setState(() => status = null), // Clear selection
                                      child: Text(
                                        'Clear',
                                        style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeightManager.regular,
                                            color: ColorManager.lightgreyheading
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: AppSize.s99,
                              child: TextFormField(
                                maxLines: 3,
                                cursorColor: ColorManager.black,
                                decoration: InputDecoration(
                                  labelText: AppString.contact,
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeightManager.regular,
                                    color: ColorManager.greylight,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: ColorManager.containerBorderGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: ColorManager.containerBorderGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: ColorManager.containerBorderGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

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

