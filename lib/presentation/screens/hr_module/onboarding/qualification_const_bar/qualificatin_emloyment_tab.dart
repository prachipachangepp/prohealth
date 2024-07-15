// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';
// import '../../../../../../../../app/resources/theme_manager.dart';
// import '../../../../../../app/resources/color.dart';
// import '../../../../../../app/resources/const_string.dart';
// import '../../../../../../app/resources/font_manager.dart';
// import '../../../../../../data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
// import '../../manage/const_wrap_widget.dart';
//
// class QualificationEmployment extends StatefulWidget {
//   @override
//   State<QualificationEmployment> createState() =>
//       _BankingTabContainerConstantState();
// }
//
// class _BankingTabContainerConstantState extends State<QualificationEmployment> {
//   final StreamController<List<OnboardingQualificationEmploymentData>>
//       qualificationempStreamController =
//       StreamController<List<OnboardingQualificationEmploymentData>>();
//
//   @override
//   void initState() {
//     super.initState();
//     getOnboardingQualificationEmp(context, 2).then((data) {
//       qualificationempStreamController.add(data);
//     }).catchError((error) {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;
//     return StreamBuilder<List<OnboardingQualificationEmploymentData>>(
//         stream: qualificationempStreamController.stream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: ColorManager.blueprime,
//               ),
//             );
//           }
//           if (snapshot.data!.isEmpty) {
//             return Center(
//                 child: Text(
//               AppString.dataNotFound,
//               style: CustomTextStylesCommon.commonStyle(
//                   fontWeight: FontWeightManager.medium,
//                   fontSize: FontSize.s12,
//                   color: ColorManager.mediumgrey),
//             ));
//           }
//           if (snapshot.hasData) {
//             // List<bool> approvedList = [];
//             // for(var i in snapshot.data!) {
//             //
//             // }
//             return WrapWidget(
//                 childern: List.generate(snapshot.data!.length, (index) {
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width / 2.3,
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                   ),
//                   height: 200,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: MediaQuery.of(context).size.width / 80,
//                       vertical: MediaQuery.of(context).size.height / 120,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Employment #${snapshot.data![index].empId.toString()}',
//                           style: GoogleFonts.firaSans(
//                             fontSize: 13,
//                             color: Color(0xFF333333),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 InfoText('Final Position Title'),
//                                 InfoText('Start Date'),
//                                 InfoText('End Date'),
//                                 InfoText('Employer'),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 InfoData(snapshot.data![index].title),
//                                 InfoData(snapshot.data![index].dateOfJoin),
//                                 InfoData(snapshot.data![index].endDate),
//                                 InfoData(snapshot.data![index].employer),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 InfoText(
//                                   'Reason of Leaving',
//                                 ),
//                                 InfoText(
//                                   'Last Supervisor’s Name',
//                                 ),
//                                 InfoText(
//                                   'Supervisor’s Phone No.',
//                                 ),
//                                 InfoText(
//                                   'City',
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 InfoData(snapshot.data![index].reason),
//                                 InfoData(snapshot.data![index].supervisor),
//                                 InfoData(snapshot.data![index].supMobile),
//                                 InfoData(snapshot.data![index].city),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             QualificationActionButtons(
//                             approve:  snapshot.data![index].approve,
//                                 onRejectPressed: () {},
//                                 onApprovePressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return Dialog(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(12.0),
//                                         ),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(20.0),
//                                           ),
//                                           height: 200.0,
//                                           width: 300.0,
//                                           child: Stack(children: <Widget>[
//                                             Container(
//                                               width: double.infinity,
//                                               height: 50,
//                                               alignment: Alignment.bottomCenter,
//                                               decoration: BoxDecoration(
//                                                 color:  Color(0xff1696C8),
//                                                 borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(12),
//                                                   topRight: Radius.circular(12),
//                                                 ),
//                                               ),
//                                               child: Align(
//                                                 alignment: Alignment.topRight,
//                                                 child: IconButton( onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                 }, icon: Icon(Icons.close,color: Colors.white,))
//                                               ),
//
//                                             ),
//                                             Align(
//                                               alignment: Alignment.center,
//                                               child: Text("Do yor really want to,\napprove this ?",textAlign: TextAlign.center,
//                                               style: GoogleFonts.firaSans(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeightManager.regular,
//                                                 color: ColorManager.mediumgrey
//                                               ),),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(10),
//                                               child: Align(
//                                                 alignment: Alignment.bottomCenter,
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.center,
//                                                   children: [
//                                                     ElevatedButton(
//                                                       onPressed: () {
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                       style: ElevatedButton.styleFrom(
//                                                         backgroundColor: Colors.white,
//                                                         foregroundColor:
//                                                         Color(0xff1696C8),
//                                                         side: BorderSide(
//                                                             color: Color(0xff1696C8)),
//                                                         shape: RoundedRectangleBorder(
//                                                           borderRadius:
//                                                           BorderRadius.circular(
//                                                               8),
//                                                         ),
//                                                       ),
//                                                       child: Text(
//                                                         'Cancle',
//                                                         style: GoogleFonts.firaSans(
//                                                           fontSize: 10.0,
//                                                           fontWeight: FontWeight.w700,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                         width: MediaQuery.of(context)
//                                                             .size
//                                                             .width /
//                                                             75),
//                                                     ElevatedButton(
//                                                       onPressed: ()async {
//                                                       await approveOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
//                                                       Navigator.of(context).pop();
//                                                       },
//                                                       style: ElevatedButton.styleFrom(
//                                                         backgroundColor:
//                                                         Color(0xff1696C8),
//                                                         foregroundColor: Colors.white,
//                                                         shape: RoundedRectangleBorder(
//                                                           borderRadius:
//                                                           BorderRadius.circular(
//                                                               8),
//                                                         ),
//                                                       ),
//                                                       child: Text(
//                                                         'Yes',
//                                                         style: GoogleFonts.firaSans(
//                                                           fontSize: 10.0,
//                                                           fontWeight: FontWeight.w700,
//                                                         ),
//                                                       ),
//                                                     ),
//
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                           ]),
//                                         ),
//                                       );
//                                       // AlertDialog(
//                                       //   //backgroundColor: Colors.indigo,
//                                       //
//                                       //   title: Container(
//                                       //     color: Colors.blue,
//                                       //     width: double.infinity,
//                                       //     child: Row(
//                                       //
//                                       //       mainAxisAlignment: MainAxisAlignment.end,
//                                       //       children: [
//                                       //         IconButton( onPressed: () {
//                                       //           Navigator.of(context).pop();
//                                       //         }, icon: Icon(Icons.close))
//                                       //       ],
//                                       //     ),
//                                       //   ),
//                                       //   content: Text(
//                                       //       "Do yor really want to approve this ?"),
//                                       //   actions: <Widget>[
//                                       //     // Button 1
//                                       //     Row(
//                                       //       mainAxisAlignment: MainAxisAlignment.end,
//                                       //       children: [
//                                       //         ElevatedButton(
//                                       //           onPressed: () {
//                                       //             Navigator.of(context).pop();
//                                       //           },
//                                       //           style: ElevatedButton.styleFrom(
//                                       //             backgroundColor: Colors.white,
//                                       //             foregroundColor:
//                                       //                 Color(0xff1696C8),
//                                       //             side: BorderSide(
//                                       //                 color: Color(0xff1696C8)),
//                                       //             shape: RoundedRectangleBorder(
//                                       //               borderRadius:
//                                       //                   BorderRadius.circular(
//                                       //                       8),
//                                       //             ),
//                                       //           ),
//                                       //           child: Text(
//                                       //             'Cancle',
//                                       //             style: GoogleFonts.firaSans(
//                                       //               fontSize: 10.0,
//                                       //               fontWeight: FontWeight.w700,
//                                       //             ),
//                                       //           ),
//                                       //         ),
//                                       //         SizedBox(
//                                       //             width: MediaQuery.of(context)
//                                       //                     .size
//                                       //                     .width /
//                                       //                 75),
//                                       //         ElevatedButton(
//                                       //           onPressed: () {
//                                       //             Navigator.of(context).pop();
//                                       //           },
//                                       //           style: ElevatedButton.styleFrom(
//                                       //             backgroundColor:
//                                       //                 Color(0xff1696C8),
//                                       //             foregroundColor: Colors.white,
//                                       //             shape: RoundedRectangleBorder(
//                                       //               borderRadius:
//                                       //                   BorderRadius.circular(
//                                       //                       8),
//                                       //             ),
//                                       //           ),
//                                       //           child: Text(
//                                       //             'Yes',
//                                       //             style: GoogleFonts.firaSans(
//                                       //               fontSize: 10.0,
//                                       //               fontWeight: FontWeight.w700,
//                                       //             ),
//                                       //           ),
//                                       //         ),
//                                       //       ],
//                                       //     ),
//                                       //   ],
//                                       // );
//                                     },
//                                   );
//                                 }),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }));
//           } else {
//             return const SizedBox();
//           }
//         });
//   }
// }
//
// class InfoText extends StatelessWidget {
//   final String text;
//
//   const InfoText(this.text, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(text, style: ThemeManager.customTextStyle(context)),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
// class InfoData extends StatelessWidget {
//   final String text;
//
//   const InfoData(
//     this.text,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(text, style: ThemeManagerDark.customTextStyle(context)),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
// }
//
// ///
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/qualification_const_bar/widgets/qualification_tab_constant.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
import '../../manage/const_wrap_widget.dart';

class QualificationEmployment extends StatefulWidget {
  @override
  _BankingTabContainerConstantState createState() => _BankingTabContainerConstantState();
}

class _BankingTabContainerConstantState extends State<QualificationEmployment> {
  final StreamController<List<OnboardingQualificationEmploymentData>> qualificationempStreamController =
  StreamController<List<OnboardingQualificationEmploymentData>>.broadcast();

  @override
  void initState() {
    super.initState();
    getOnboardingQualificationEmp(context, 10).then((data) {
      qualificationempStreamController.add(data);
    }).catchError((error) {});
  }

  @override
  void dispose() {
    qualificationempStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<OnboardingQualificationEmploymentData>>(
      stream: qualificationempStreamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.blueprime,
            ),
          );
        }
        if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              AppString.dataNotFound,
              style: CustomTextStylesCommon.commonStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s12,
                color: ColorManager.mediumgrey,
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          return WrapWidget(
            childern: List.generate(snapshot.data!.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 80,
                      vertical: MediaQuery.of(context).size.height / 120,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Employment #${snapshot.data![index].employmentId.toString()}',
                          style: GoogleFonts.firaSans(
                            fontSize: 13,
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoText('Final Position Title'),
                                InfoText('Start Date'),
                                InfoText('End Date'),
                                InfoText('Employer'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoData(snapshot.data![index].title),
                                InfoData(snapshot.data![index].dateOfJoin),
                                InfoData(snapshot.data![index].endDate),
                                InfoData(snapshot.data![index].employer),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoText('Reason of Leaving'),
                                InfoText('Last Supervisor’s Name'),
                                InfoText('Supervisor’s Phone No.'),
                                InfoText('City'),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoData(snapshot.data![index].reason),
                                InfoData(snapshot.data![index].supervisor),
                                InfoData(snapshot.data![index].supMobile),
                                InfoData(snapshot.data![index].city),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            QualificationActionButtons(
                              approve: snapshot.data![index].approve,
                              onRejectPressed: () async {
                                await rejectOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
                                getOnboardingQualificationEmp(context, 10).then((data) {
                                  qualificationempStreamController.add(data);
                                }).catchError((error) {});
                              },
                              onApprovePressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        height: 200.0,
                                        width: 300.0,
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              height: 50,
                                              alignment: Alignment.bottomCenter,
                                              decoration: BoxDecoration(
                                                color: Color(0xff1696C8),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(Icons.close, color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Do you really want to,\napprove this?",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.firaSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeightManager.regular,
                                                  color: ColorManager.mediumgrey,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.white,
                                                        foregroundColor: Color(0xff1696C8),
                                                        side: BorderSide(color: Color(0xff1696C8)),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Cancel',
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 10.0,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: MediaQuery.of(context).size.width / 75),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await approveOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
                                                        getOnboardingQualificationEmp(context, 10).then((data) {
                                                          qualificationempStreamController.add(data);
                                                        }).catchError((error) {});
                                                        Navigator.of(context).pop();
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Color(0xff1696C8),
                                                        foregroundColor: Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Yes',
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 10.0,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
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
}

class InfoText extends StatelessWidget {
  final String text;

  const InfoText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style: ThemeManager.customTextStyle(context)),
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
        Text(text, style:  ThemeManager.customTextStyle(context)),
        const SizedBox(height: 10),
      ],
    );
  }
}
