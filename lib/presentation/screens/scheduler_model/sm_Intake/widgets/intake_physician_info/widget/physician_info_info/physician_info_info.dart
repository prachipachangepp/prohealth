import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';
import '../../../../../widgets/constant_widgets/textfield_constant.dart';

class PhysicianInfoInfoScreen extends StatefulWidget {
  const PhysicianInfoInfoScreen({super.key});

  @override
  State<PhysicianInfoInfoScreen> createState() => _RelatedPartiesScreenstate();
}

class _RelatedPartiesScreenstate extends State<PhysicianInfoInfoScreen> {
  bool isOptForCAHPSSurvey = false;
  String? status = 'Active';
  String? selectedState;
  String? selectedStatus;

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
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 19.5),
              SizedBox(height: AppSize.s10),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                // height: 405,
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
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Primary Physician',)
                        ),
                        SizedBox(width:AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Physician’s First Name', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Physician’s Last Name',)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'PECOS Status',)
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'UPIN#', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'NPI#', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.street)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Suite/ Apt', )
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.city)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: AppString.state,
                                items: ['Option 1', 'Option 2', 'Option 3'],
                              onChanged: (newValue) {
                              setState(() {
                                selectedState = newValue;
                              });
                            },)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                                labelText: AppString.zip_code,
                                initialValue: '26586845121',
                                buttonText: 'View Zone')
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Phone')
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.fax)
                        ),
                        SizedBox(width:AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              labelText: AppString.protocol)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: Container()), // Empty container for alignment
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: Container()),
                      ],
                    ),
                    SizedBox(height:AppSize.s32),

                    Divider(
                      height: AppSize.s5,
                      color: ColorManager.cream,
                      thickness: 4,
                    ),

                    ////////////////////////second box///////////////////////////


                    SizedBox(height:AppSize.s32),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                            labelText: 'Certifying or F2F Physician')
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Physician’s First Name')
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Physician’s Last Name.',)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(child: SchedularTextField(
                            labelText: 'PECOS Status')
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'UPIN#', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'NPI#', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.street)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              labelText: 'Suite/ Apt', )
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.city)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularDropdown(
                              labelText: AppString.state,
                                items: ['Option 1', 'Option 2', 'Option 3'],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedState = newValue;
                                  });
                                },)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                                labelText: AppString.zip_code,
                                initialValue: '26586845121', buttonText: 'View Zone')
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                                labelText: 'Phone')
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                labelText: AppString.fax)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              labelText: AppString.protocol)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: Container()), // Empty container for alignment
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: Container()),
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
