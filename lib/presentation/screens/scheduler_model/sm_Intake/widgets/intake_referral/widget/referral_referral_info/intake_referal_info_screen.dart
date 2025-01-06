import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/referral_data/referral_info_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/button_constant.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';

class IntakeReferralInfoScreen extends StatefulWidget {
  final int patientId;
  IntakeReferralInfoScreen({super.key, required this.patientId});

  @override
  State<IntakeReferralInfoScreen> createState() => _ReferralInfoScreenstate();
}

class _ReferralInfoScreenstate extends State<IntakeReferralInfoScreen> {
  String? status = '';
  String? selectedReferalSource;
  String? selectedCompanyName;
  String? selectedFax;
  String? selectedPhone;
  TextEditingController ctlrReferralDate = TextEditingController();
  TextEditingController ctlrProjectedSOCDate = TextEditingController();
  TextEditingController ctlrReferralSource = TextEditingController();
  TextEditingController ctlrRefereeFirstName= TextEditingController();
  TextEditingController ctlrRefereeLastName = TextEditingController();
  TextEditingController ctlrRefereeCompanyName = TextEditingController();
  TextEditingController ctlrphone = TextEditingController();
  TextEditingController ctlrfax = TextEditingController();
  TextEditingController ctlrprotocol= TextEditingController();
  TextEditingController ctlradmissionSource = TextEditingController();
  TextEditingController ctlrepisodeTimingOverride = TextEditingController();
  TextEditingController ctlrReferralTakenBy = TextEditingController();
  TextEditingController ctlrReasonForVisitin48 = TextEditingController();
  TextEditingController ctlrComments = TextEditingController();

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
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.greenDark
                      ),),
                    SizedBox(width: 15,),
                SchedularIconButtonConst(
                  text: AppString.save,
                  onPressed: () async {
                    await AddReferralInfo(context,
                        widget.patientId,
                        ctlrReferralDate.text,
                        ctlrProjectedSOCDate.text,
                        ctlrReferralSource.text,
                        ctlrRefereeFirstName.text,
                        ctlrRefereeLastName.text,
                        ctlrRefereeCompanyName.text,
                        ctlrphone.text,
                        ctlrfax.text,
                        ctlrprotocol.text,
                        ctlradmissionSource.text,
                        status.toString(),
                        ctlrReferralTakenBy.text,
                        ctlrReasonForVisitin48.text,
                        ctlrComments.text);
                    print('${ctlrReferralDate.text}');
                    print('${ctlrProjectedSOCDate.text}');
                  },
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
                            child:
                            SchedularTextField(
                              controller: ctlrReferralDate ,
                              labelText: 'Referral Date',
                              suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime,),
                            )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child:
                            SchedularTextField(
                              controller: ctlrProjectedSOCDate ,
                              labelText: 'Projected SOC Date',
                              suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime,),
                            )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child:   SchedularTextField(
                              controller: ctlrReferralSource ,
                              labelText: 'Referral Source',

                            )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlrRefereeFirstName,
                              labelText: 'Referee’s First Name',)
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlrRefereeLastName,
                              labelText: 'Referee’s Last Name', )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child:   SchedularTextField(
                              controller: ctlrRefereeCompanyName ,
                              labelText: "Refferee's Company Name ",

                            )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlrphone ,
                              labelText: "Phone",
                                phoneField:true

                            )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlrfax ,
                              labelText: "Fax",

                            )
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                          controller: ctlrprotocol ,
                          labelText: "Protocol",

                        )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlradmissionSource,
                              labelText: 'Admission Source', )
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Episode timing override (first 30 days)',
                                  style: CustomTextStylesCommon.commonStyle(
                                      fontSize: FontSize.s10, fontWeight: FontWeight.w400)
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
                                      style: CustomTextStylesCommon.commonStyle(
                                          fontSize: FontSize.s14, fontWeight: FontWeight.w400)
                                  ),
                                  SizedBox(width: AppSize.s35),
                                  Radio<String>(
                                    value: 'Late',
                                    groupValue: status,
                                    onChanged: (value) => setState(() => status = value),
                                  ),
                                  Text('Late',
                                      style: CustomTextStylesCommon.commonStyle(
                                          fontSize: FontSize.s14,
                                          fontWeight: FontWeight.w400)
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(child: SchedularTextField(
                          controller: ctlrReferralTakenBy,
                            labelText: 'Referral Taken By')
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlrReasonForVisitin48,
                                labelText: 'Reason if not visited within 48 hours')
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlrComments,
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
