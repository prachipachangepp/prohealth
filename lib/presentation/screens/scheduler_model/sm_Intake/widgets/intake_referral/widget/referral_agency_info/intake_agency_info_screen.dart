
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';

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
              SizedBox(height: AppSize.s10),
              Container(
                height: AppSize.s249,
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
                child: Column(
                  children: [
                    SizedBox(height: AppSize.s20),
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
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: 'Rate',
                                items: ['Option 1', 'Option 2', 'Option 3'])
                        ),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: AppString.street,
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: AppString.suite_Apt, )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: AppString.city,
                                items: ['Option 1', 'Option 2', 'Option 3'])
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
                      ],
                    ),
                    SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                            labelText: AppString.phone)
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: AppString.fax )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText:AppString.email )
                        ),
                        SizedBox(width: AppSize.s35),
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

