import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/patient_data/patient_data_related_party_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../sm_scheduler/widget/schedular_create/widget/assign_visit_pop_up.dart';
import '../../../../../sm_scheduler/widget/schedular_create/widget/edit_appointment_pop_up.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';
import '../../../intake_physician_info/widget/physician_info_info/physician_info_info.dart';
import '../../../intake_referral/widget/referral_agency_info/intake_referral_submit_popup.dart';

class IntakeRelatedPartiesScreen extends StatefulWidget {
  final int patientId;

  const IntakeRelatedPartiesScreen({
    super.key,
    required this.patientId,
  });

  @override
  State<IntakeRelatedPartiesScreen> createState() =>
      _RelatedPartiesScreenstate();
}

class _RelatedPartiesScreenstate extends State<IntakeRelatedPartiesScreen> {
  TextEditingController ctlrEmgContact = TextEditingController();
  TextEditingController ctlrTelphoneNo = TextEditingController();
  TextEditingController ctlrEmgContactAddress = TextEditingController();
  TextEditingController ctlrCity = TextEditingController();
  TextEditingController ctlrCityy = TextEditingController();
  TextEditingController ctlrComment = TextEditingController();
  TextEditingController ctlrSuffix = TextEditingController();
  TextEditingController ctlrPreffix = TextEditingController();
  TextEditingController ctlrFirstname = TextEditingController();
  TextEditingController ctlrLastName = TextEditingController();
  TextEditingController ctlrMi = TextEditingController();
  TextEditingController ctlrAddress = TextEditingController();
  TextEditingController ctlrPhoneNo = TextEditingController();
  TextEditingController ctlrZipCode = TextEditingController();
  TextEditingController ctlrApartment = TextEditingController();
  TextEditingController ctlrCell = TextEditingController();
  TextEditingController ctlrAddInfo = TextEditingController();
  TextEditingController ctlrEmail = TextEditingController();
  bool isOptForCAHPSSurvey = false;
  String? status = 'Active';
  String? selectedState;
  String? selectedCity;
  String? selectedCountry;
  String? selectedRelationship;
  String? selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Status: Partially Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.orangeheading),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 60),
                    Container(
                        height: 30,
                        width: 170,
                        child: SchedularIconButtonConst(
                          icon: Icons.add,
                          text: 'Add Related Parties',
                          onPressed: () async {
                            await IntakeRelatedPartyAdd(
                                context,
                                1,
                                ctlrEmgContact.text,
                                ctlrTelphoneNo.text,
                                "emg_relationship",
                                ctlrEmgContactAddress.text,
                                ctlrCity.text,
                                "emg_State",
                                ctlrZipCode.text,
                                "emg_priorityDisasterCode",
                                ctlrComment.text,
                                ctlrPreffix.text,
                                ctlrFirstname.text,
                                ctlrMi.text,
                                ctlrLastName.text,
                                ctlrSuffix.text,
                                "pcg_OptforCAHPS",
                                ctlrAddress.text,
                                ctlrApartment.text,
                                ctlrCityy.text,
                                "pcg_State",
                                ctlrZipCode.text,
                                ctlrPhoneNo.text,
                                ctlrCell.text,
                                ctlrEmail.text,
                                "pcg_Relationship",
                                ctlrAddInfo.text);
                          },
                        ))
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
                        Text(
                          'Emergency Contact Information',
                          style: TextStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.mediumgrey),
                        )
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrEmgContact,
                                labelText: 'Emergency Contact')),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrTelphoneNo,
                                labelText: 'Telephone Number')),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                                labelText: 'Relationship',
                                items: ['Single', 'Married', 'Separated'],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedRelationship = newValue;
                                  });
                                })

                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                          controller: ctlrEmgContactAddress,
                          labelText: 'Emergency Contact Address',
                        )),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrCity,
                                labelText: AppString.city)),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                          child: SchedularDropdown(
                            labelText: AppString.state,
                            items: ['State 1', 'State 2', 'State 3'],
                            onChanged: (newValue) {
                              setState(() {
                                selectedState = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                                controller: ctlrZipCode,
                                labelText: AppString.zip_code,
                                initialValue: '',
                                buttonText: 'View Zone')),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                                labelText: 'Priority/ Disaster Code',
                                items: ['Option 1', 'Option 2', 'Option 3'],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedPriority = newValue;
                                  });
                                })),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrComment,
                                labelText: AppString.comments)),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child:
                                Container()), // Empty container for alignment
                        SizedBox(width: AppSize.s35),
                        Flexible(child: Container()),
                        SizedBox(width: AppSize.s35),
                        Flexible(child: Container()),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Text(
                          'Primary Care Giver',
                          style: TextStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.mediumgrey),
                        )
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrPreffix, labelText: 'Prefix')),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                          controller: ctlrFirstname,
                          labelText: 'First Name',
                          initialValue: 'Erica',
                        )),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                          controller: ctlrMi,
                          labelText: 'M.I.',
                          initialValue: 'A',
                        )),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrLastName,
                                labelText: 'Last Name')),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrSuffix, labelText: 'Suffix')),
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
                              Expanded(
                                  child: SchedularTextField(
                                      labelText: 'Opt for CAHPS Survey')),
                            ],
                          ),
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrAddress,
                                labelText: AppString.address)),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrApartment,
                                labelText: 'Suite/ Apt.')),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrCityy,
                                labelText: AppString.city)),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                                labelText: AppString.state,
                                items: ['Option 1', 'Option 2', 'Option 3'],
                              onChanged: (newValue) {
                              setState(() {
                                selectedState = newValue;
                              });
                            },




                            )



                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                                labelText: AppString.zip_code,
                                initialValue: '',
                                buttonText: 'View Zone')),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrPhoneNo, labelText: 'Phone')),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrCell, labelText: 'Cell')),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrEmail,
                                labelText: AppString.email)),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularDropdown(
                                labelText: 'Relationship',
                                items: ['Single', 'Married', 'Separated'], onChanged: (newValue) {
                              setState(() {
                                selectedRelationship = newValue;
                              });
                            },)),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrAddInfo,
                                labelText:
                                    'Additional Information')), // Empty container for alignment
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
