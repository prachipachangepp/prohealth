import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/hr_resources/hr_theme_manager.dart';
import 'package:prohealth/app/resources/provider/hr_onboarding_provider.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/reject_popup_constant.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../manage/const_wrap_widget.dart';
import '../../manage/widgets/const_card_details.dart';

class QualificationEmployment extends StatelessWidget {
  final int employeeId;
  QualificationEmployment({required this.employeeId});
  // final StreamController<List<OnboardingQualificationEmploymentData>> qualificationempStreamController =
  @override
  Widget build(BuildContext context) {
    final providerEmpState = Provider.of<HrOnboardingProvider>(context,listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      providerEmpState.getEmployeeData(context,employeeId);
    });
    final mediaQuery = MediaQuery.of(context).size;
    return Consumer<HrOnboardingProvider>(

      builder: (context,providerState, child) {
        return StreamBuilder<List<OnboardingQualificationEmploymentData>>(
          stream:providerState.qualificationempStreamController.stream,
          builder: (context, snapshot) {
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
            //////s
            ////////
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Text(
                    AppStringHRNoData.noOnboardEmpData,
                    style:AllNoDataAvailable.customTextStyle(context),
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              return WrapWidget(
                children: List.generate(snapshot.data!.length, (index) {
                  return CardDetails(childWidget: DetailsFormate(
                    row1Child1: [
                      Text('Final Position Title :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Start Date :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('End Date :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Employer :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Text('Emergency Contact :',
                      //     style: ThemeManagerDark.customTextStyle(context)),
                    ],
                    row1Child2: [

                      Text(
                        snapshot.data![index].title,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data![index].dateOfJoin,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data![index].endDate,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data![index].employer,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                    ],
                    row2Child1: [
                      Text('Reason of Leaving :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Last Supervisor’s Name :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Supervisor’s Phone No. :',
                          style: ThemeManagerDark.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('City :',
                          style: ThemeManagerDark.customTextStyle(context)),
                    ],
                    row2Child2: [
                      Text(
                        snapshot.data![index].reason,
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data![index].supervisor.toString(),
                        style: ThemeManagerDarkFont.customTextStyle(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(snapshot.data![index].supMobile.toString(),
                          style: ThemeManagerDarkFont.customTextStyle(context)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(snapshot.data![index].city.toString(),
                          style: ThemeManagerDarkFont.customTextStyle(context)),                  ],
                    button:  Row(
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
                                  await rejectOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
                                  providerState.getEmployeeData(context,employeeId);
                                  Navigator.of(context).pop();
                                },);
                                //   Dialog(
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(12.0),
                                //   ),
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(20.0),
                                //     ),
                                //     height: 181.0,
                                //     width: 500.0,
                                //     child: Stack(
                                //       children: <Widget>[
                                //         Container(
                                //           decoration: BoxDecoration(
                                //             color: ColorManager.bluebottom,
                                //             borderRadius: BorderRadius.only(
                                //               topLeft: Radius.circular(8),
                                //               topRight: Radius.circular(8),
                                //             ),
                                //           ),
                                //           height: 35,
                                //           child: Row(
                                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               Padding(
                                //                 padding: const EdgeInsets.only(left: 10.0),
                                //                 child: Text(
                                //                     'Reject',
                                //                     style: PopupBlueBarText.customTextStyle(context)
                                //                 ),
                                //               ),
                                //               IconButton(
                                //                 onPressed: () {
                                //                   Navigator.pop(context);
                                //                 },
                                //                 icon: Icon(Icons.close, color: ColorManager.white),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //         Align(
                                //           alignment: Alignment.centerLeft,
                                //           child: Padding(
                                //             padding: const EdgeInsets.only(left: 20.0),
                                //             child: Text(
                                //                 "Do you really want to reject this?",
                                //                 textAlign: TextAlign.center,
                                //                 style: PopupTextConst.customTextStyle(context)
                                //             ),
                                //           ),
                                //         ),
                                //         Padding(
                                //           padding: const EdgeInsets.only(bottom: AppPadding.p24,right: AppPadding.p10),
                                //           child: Align(
                                //             alignment: Alignment.bottomRight,
                                //             child: Row(
                                //               mainAxisAlignment: MainAxisAlignment.end,
                                //               children: [
                                //                 ElevatedButton(
                                //                   onPressed: () {
                                //                     Navigator.of(context).pop();
                                //                   },
                                //                   style: ElevatedButton.styleFrom(
                                //                     elevation: 5,
                                //                     backgroundColor: Colors.white,
                                //                     foregroundColor: Color(0xff1696C8),
                                //                     side: BorderSide(color: Color(0xff1696C8)),
                                //                     shape: RoundedRectangleBorder(
                                //                       borderRadius: BorderRadius.circular(8),
                                //                     ),
                                //                   ),
                                //                   child: Text(
                                //                       'Cancel',
                                //                       style: TransparentButtonTextConst.customTextStyle(context)
                                //                   ),
                                //                 ),
                                //                 SizedBox(width: MediaQuery.of(context).size.width / 75),
                                //                 Container(
                                //                   width: AppSize.s80,
                                //                   child: ElevatedButton(
                                //                     onPressed: () async {
                                //                       await rejectOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
                                //                       getOnboardingQualificationEmp(context, widget.employeeId,'no').then((data) {
                                //                         qualificationempStreamController.add(data);
                                //                       }).catchError((error) {});
                                //                       Navigator.of(context).pop();
                                //                     },
                                //                     style: ElevatedButton.styleFrom(
                                //                       backgroundColor: Color(0xff1696C8),
                                //                       foregroundColor: Colors.white,
                                //                       shape: RoundedRectangleBorder(
                                //                         borderRadius: BorderRadius.circular(8),
                                //                       ),
                                //                     ),
                                //                     child: Text(
                                //                       'Yes',
                                //                       style: BlueButtonTextConst.customTextStyle(context),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // );
                              },
                            );
                          },
                          onApprovePressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ApproveDialog(onYesPressed: () async {
                                  await approveOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
                                   providerState.getEmployeeData(context,employeeId);
                                  Navigator.of(context).pop();
                                },);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    title: 'Employment #${index + 1}',));
                }),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(child: Text("No data available"));
            }
          },
        );
      }
    );
  }
}

class InfoText extends StatelessWidget {
  final String text;

  const InfoText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: ThemeManager.customTextStyle(context),),
        const SizedBox(height: 10),
      ],
    );
  }
}

class InfoData extends StatelessWidget {
  final String text;

  const InfoData(
      this.text,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style:  ThemeManagerDark.customTextStyle(context)),
        const SizedBox(height: 10),
      ],
    );
  }
}