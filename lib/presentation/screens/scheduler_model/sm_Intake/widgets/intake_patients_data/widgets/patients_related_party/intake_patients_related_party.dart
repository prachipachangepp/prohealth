import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../sm_scheduler/widget/schedular_create/widget/assign_visit_pop_up.dart';
import '../../../../../sm_scheduler/widget/schedular_create/widget/edit_appointment_pop_up.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';
import '../../../intake_physician_info/widget/physician_info_info/physician_info_info.dart';
import '../../../intake_referral/widget/referral_agency_info/intake_referral_submit_popup.dart';

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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Status: Partially Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.orangeheading
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/60),
                    Container(
                      height: AppSize.s32,
                      width: AppSize.s165,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AssignVisitPopUp();
                          //   },
                          // );
                        },
                        icon: Icon(Icons.add,
                            color: ColorManager.white,
                            size: FontSize.s20),
                        label: Text(
                          'Add Related Parties',
                          style: GoogleFonts.firaSans(
                            color: ColorManager.white,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.blueprime,
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
              SizedBox(height: AppSize.s10),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                // height: 405,
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Emergency Contact Information',
                          style: TextStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.mediumgrey
                          ),)
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Emergency Contact')
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Telephone Number' )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Relationship',
                                items: ['Option 1', 'Option 2', 'Option 3'])
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Emergency Contact Address',)
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: AppString.city)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: AppString.state,
                                items: ['Option 1', 'Option 2', 'Option 3'])
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                                labelText: AppString.zip_code,
                                initialValue: '26586845121',
                                buttonText: 'View Zone')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Priority/ Disaster Code',
                                items: ['Option 1', 'Option 2', 'Option 3'])
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                            labelText: AppString.comments)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: Container()), // Empty container for alignment
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
                        Text('Primary Care Giver',
                          style: TextStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.mediumgrey
                          ),)
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                            labelText: 'Prefix')
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'First Name', initialValue: 'Erica',)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'M.I.', initialValue: 'A',)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(child: SchedularTextField(
                            labelText: 'Last Name')
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Suffix')
                        ),
                        SizedBox(width: AppSize.s35),
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
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.address)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Suite/ Apt.')
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.city)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: AppString.state,
                                items: ['Option 1', 'Option 2', 'Option 3'])
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                                labelText: AppString.zip_code,
                                initialValue: '26586845121', buttonText: 'View Zone')
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Phone')
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Cell')
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.email)
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Relationship',
                                items: ['Option 1', 'Option 2', 'Option 3']
                            )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Additional Information')
                        ), // Empty container for alignment
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


