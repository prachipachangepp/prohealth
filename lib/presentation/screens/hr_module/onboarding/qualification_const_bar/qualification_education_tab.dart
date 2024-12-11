import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/education_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/education_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/reject_popup_constant.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../em_module/widgets/dialogue_template.dart';
import '../../manage/widgets/const_card_details.dart';
import '../widgets/widgets/banking_tab_constant.dart';

class QualificationEducation extends StatefulWidget {
  final int employeeId;
  const QualificationEducation({Key? key, required this.employeeId}) : super(key: key);

  @override
  State<QualificationEducation> createState() => _QualificationEducationState();
}

class _QualificationEducationState extends State<QualificationEducation> {
  final StreamController<List<OnboardingQualificationEducationData>> educationStreamController = StreamController<List<OnboardingQualificationEducationData>>.broadcast();

  @override
  void initState() {
    super.initState();
    getOnboardingQualificationEducation(context, widget.employeeId,'no').then((data){
      educationStreamController.add(data);
    }).catchError((error){});
  }
  @override
  void dispose() {
    educationStreamController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<OnboardingQualificationEducationData>>(
        stream: educationStreamController.stream,
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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
                    AppStringHRNoData.noOnboardEdnData,
                    style:AllNoDataAvailable.customTextStyle(context),
                  ),
                ));
          }
          if(snapshot.hasData){
            return Wrap(children: List.generate(snapshot.data!.length, (index){
              return CardDetails(childWidget: DetailsFormate(
                row1Child1: [
                  Text('College/University :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Graduate :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Degree :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Major Subject :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Text('Emergency Contact :',
                  //     style: ThemeManagerDark.customTextStyle(context)),
                ],
                row1Child2: [
                  Text(
                    snapshot.data![index].college,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].graduate,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].degree,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].major,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                ],
                row2Child1: [
                  Text('Phone :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('City :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('State :',
                      style: ThemeManagerDark.customTextStyle(context)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(' ',
                      style: ThemeManagerDark.customTextStyle(context)),
                ],
                row2Child2: [
                  Text(
                    snapshot.data![index].phone,
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data![index].city.toString(),
                    style: ThemeManagerDarkFont.customTextStyle(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(snapshot.data![index].state.toString(),
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
                      approve: snapshot.data![index].approved,
                      onRejectPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RejectDialog(onYesPressed: () async {
                              await rejectOnboardQualifyEducationPatch(context, snapshot.data![index].educationId);
                              getOnboardingQualificationEducation(context, widget.employeeId,'no').then((data){
                                educationStreamController.add(data);
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
                            return ApproveDialog(onYesPressed: () async {
                              await approveOnboardQualifyEducationPatch(context, snapshot.data![index].educationId);
                              getOnboardingQualificationEducation(context, widget.employeeId,'no').then((data){
                                educationStreamController.add(data);
                              }).catchError((error){});
                              Navigator.of(context).pop();
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
                title: 'Education #${index + 1}',));
            }));
          }else{
            return const SizedBox();
          }
        }
    );
  }
}


