import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/references_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/references_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualificatin_emloyment_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/reject_popup_constant.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../manage/const_wrap_widget.dart';
import '../../manage/widgets/const_card_details.dart';

class QualificationReferance extends StatefulWidget {
  final int employeeId;
  const QualificationReferance({Key? key, required this.employeeId}) : super(key: key);

  @override
  State<QualificationReferance> createState() => _QualificationReferanceState();
}

class _QualificationReferanceState extends State<QualificationReferance> {
  final StreamController<List<OnboardingQualificationReferanceData>> referenceStreamController = StreamController<List<OnboardingQualificationReferanceData>>.broadcast();

  @override
  void initState() {
    super.initState();
    getOnboardingQualificationReference(context, widget.employeeId,'no').then((data){
      referenceStreamController.add(data);
    }).catchError((error){});
  }
  @override
  void dispose() {
    referenceStreamController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<OnboardingQualificationReferanceData>>(
        stream: referenceStreamController.stream,
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Text(
                    AppStringHRNoData.noOnboardRefData,
                    style: AllNoDataAvailable.customTextStyle(context),
                  ),
                ));
          }
          if(snapshot.hasData){
            return WrapWidget(childern: List.generate(snapshot.data!.length, (index){
              return CardDetails(childWidget: DetailsFormate(
                row1Child1: [
                  Text('Name :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Title/Position :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Company/Organization :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Email :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Text('Emergency Contact :',
                  //     style: ThemeManagerDark.customTextStyle(context)),
                ],
                row1Child2: [
                  Text(
                    snapshot.data![index].name,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].title,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].company,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].email,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                ],
                row2Child1: [
                  Text('Mobile Number :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('How do you know this person ? :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Length of Association :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('',
                      style: ThemeManagerDark.customTextStyle(context)),
                ],
                row2Child2: [
                  Text(
                    snapshot.data![index].mob,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].references.toString(),
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(snapshot.data![index].association.toString(),
                      style: ThemeManagerDarkFont.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('',
                      style: ThemeManagerDarkFont.customTextStyle(context)),
                ],
                button:  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    QualificationActionButtons(
                      approve: snapshot.data![index].approve,
                      onRejectPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RejectDialog(onYesPressed: () async {
                              await rejectOnboardQualifyReferencePatch(context, snapshot.data![index].referenceId);
                              getOnboardingQualificationReference(context, widget.employeeId,'no').then((data){
                                referenceStreamController.add(data);
                              }).catchError((error){});
                              Navigator.of(context).pop();
                            },);
                          },
                        );
                      },

                      onApprovePressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ApproveDialog(onYesPressed:
                                () async {
                              await approveOnboardQualifyReferencePatch(context, snapshot.data![index].referenceId);
                              getOnboardingQualificationReference(context, widget.employeeId,'no').then((data){
                                referenceStreamController.add(data);
                              }).catchError((error){});
                              Navigator.of(context).pop();
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
                title: 'References #${index + 1}',));
            }));
          }else{
            return const SizedBox();
          }
        }
    );
  }
}
