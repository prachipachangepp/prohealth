import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/provider/hr_onboarding_provider.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/qualificatin_emloyment_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/reject_popup_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
import '../../manage/const_wrap_widget.dart';
import '../../manage/widgets/const_card_details.dart';

class QualificationLicense extends StatelessWidget {
  final int employeeId;
  const QualificationLicense({Key? key, required this.employeeId}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    final providerLicenseState = Provider.of<HrOnboardingProvider>(context,listen:false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      providerLicenseState.getLicenseData(context,employeeId);
    });
    final mediaQuery = MediaQuery.of(context).size;
    return Consumer<HrOnboardingProvider>(
      builder: (context,providerState,child) {
        return StreamBuilder<List<OnboardingQualificationLicenseData>>(
            stream: providerState.licenseStreamController.stream,
            builder: (context, snapshot) {
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
                      padding:  EdgeInsets.symmetric(vertical: 150),
                      child: Text(
                        AppStringHRNoData.noOnboardLicData,
                        style: AllNoDataAvailable.customTextStyle(context),
                      ),
                    ));
              }
              if (snapshot.hasData) {
                return WrapWidget(
                    children: List.generate(snapshot.data!.length, (index) {
                  return CardDetails(childWidget: DetailsFormate(
                    row1Child1: [
                      Text('Licensure/Certification :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Issuing Organization :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Country :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Number/ID :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Text('Emergency Contact :',
                      //     style: ThemeManagerDark.customTextStyle(context)),
                    ],
                    row1Child2: [

                      Text(
                        snapshot.data![index].licensure,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data![index].org,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data![index].country,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data![index].licenseNumber,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                    ],
                    row2Child1: [
                      Text('Issue Date :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('End Date :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('',
                          style: ThemeManagerDark.customTextStyle(context)),
                    ],
                    row2Child2: [
                      Text(
                        snapshot.data![index].issueDate,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data![index].expDate,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('',
                          style: ThemeManagerDarkFont.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('',
                          style: ThemeManagerDarkFont.customTextStyle(context)),
                    ],
                    button:   Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        QualificationActionButtons(

                          isBackColor: false,
                          approve: snapshot.data![index].approve,
                          onRejectPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RejectDialog(onYesPressed: () async {
                                  await rejectOnboardQualifyLicensePatch(
                                      context, snapshot.data![index].licenseId);
                                  providerState.getLicenseData(context, employeeId);
                                  Navigator.of(context)
                                      .pop();
                                },);
                              },
                            );
                          },

                          onApprovePressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ApproveDialog(onYesPressed: () async {
                                  await approveOnboardQualifyLicensePatch(
                                      context,
                                      snapshot
                                          .data![index]
                                          .licenseId);
                                  providerState.getLicenseData(context, employeeId);
                                  Navigator.of(context)
                                      .pop();
                                },);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    title: 'License #${index + 1}',));
                }));
              } else {
                return const SizedBox();
              }
            });
      }
    );
  }
}
