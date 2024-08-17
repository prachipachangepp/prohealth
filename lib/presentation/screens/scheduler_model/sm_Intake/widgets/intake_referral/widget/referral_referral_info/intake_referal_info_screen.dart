
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';

class IntakeReferralInfoScreen extends StatefulWidget {
  const IntakeReferralInfoScreen({super.key});

  @override
  State<IntakeReferralInfoScreen> createState() => _ReferralInfoScreenstate();
}

class _ReferralInfoScreenstate extends State<IntakeReferralInfoScreen> {
  String? status = '';
  String? selectedReferalSource;
  String? selectedCompanyName;
  String? selectedFax;
  String? selectedPhone;

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
              SizedBox(height: AppSize.s10),
              Container(
                height: AppSize.s275,
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
                    SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Referral Date',)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Projected SOC Delete', )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Referral Source',
                                items: ['Option 1', 'Option 2', 'Option 3'],
                              onChanged: (newValue) {
                                setState(() {
                                  selectedReferalSource = newValue;
                                });
                              },)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Referee’s First Name',)
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Referee’s Last Name', )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Referee’s Company Name',
                                items: ['Option 1', 'Option 2', 'Option 3'],  onChanged: (newValue) {
                              setState(() {
                                selectedCompanyName = newValue;
                              });
                            },)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Phone',
                                items: ['Option 1', 'Option 2', 'Option 3'],  onChanged: (newValue) {
                              setState(() {
                                selectedPhone = newValue;
                              });
                            },)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: AppString.fax,
                                items: ['Option 1', 'Option 2', 'Option 3'],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedFax = newValue;
                                  });
                                },)
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                            labelText: AppString.prefix)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Protocol', )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Episode timing override (first 30 days)',
                                  style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s10, fontWeight: FontWeightManager.regular)
                              ),
                              SizedBox(height: AppSize.s1),
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
                                  SizedBox(width: AppSize.s35),
                                  Radio<String>(
                                    value: 'Late',
                                    groupValue: status,
                                    onChanged: (value) => setState(() => status = value),
                                  ),
                                  Text('Late',
                                      style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeightManager.regular)
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(child: SchedularTextField(
                            labelText: 'Referral Taken By')
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Reason if not visited within 48 hours')
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Comments')
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
            ],
          ),
        ),
      ),
    );
  }
}

///////
