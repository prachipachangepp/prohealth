// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_compliance/intake_patients_compliance.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_info/intake_patients_info.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/intake_patients_plan_care.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_related_party/intake_patients_related_party.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_stay_info/intake_patients_stay_info.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/schedular_success_popup.dart';
//
// import '../../../../../../app/resources/color.dart';
// import '../../../../../../app/resources/font_manager.dart';
//
// class SmIntakePatientsScreen extends StatefulWidget {
//   SmIntakePatientsScreen({super.key});
//
//   @override
//   State<SmIntakePatientsScreen> createState() => _SmIntakePatientsScreenState();
// }
//
// class _SmIntakePatientsScreenState extends State<SmIntakePatientsScreen> {
//   int selectedIndex = 0;
//   final PageController smIntakePageController = PageController();
//
//   void selectButton(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//
//     smIntakePageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Material(
//       elevation: 4,
//       borderRadius: BorderRadius.circular(14),
//       child: Column(
//         children: [
//           SizedBox(height: 15,),
//           Container(
//             width: MediaQuery.of(context).size.width/1.97,  //1.97
//             height: 30,
//             decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     offset: Offset(0, 4),
//                     blurRadius: 4,
//                     spreadRadius: 0,
//                   ),
//                 ],
//                 color: ColorManager.blueprime,
//                 borderRadius: BorderRadius.circular(20)
//             ),
//             child: Row(
//               children: [
//                 InkWell(
//                   child: Container(
//                     height: 30,
//                     width: MediaQuery.of(context).size.width / 10,
//                     padding: EdgeInsets.symmetric(vertical: 6),
//                     decoration: BoxDecoration(
//
//                       borderRadius: BorderRadius.circular(20),
//                       color: selectedIndex == 0
//                           ? Colors.white
//                           : null,
//                     ),
//                     child: Text(
//                       'Info',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: selectedIndex == 0
//                             ? ColorManager.mediumgrey
//                             : Colors.white,
//                       ),
//                     ),
//                   ),
//                   onTap: () => selectButton(0),
//                 ),
//                 InkWell(
//                   child: Container(
//                     height: 30,
//                     width: MediaQuery.of(context).size.width / 10,
//                     padding: EdgeInsets.symmetric(vertical: 6),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: selectedIndex == 1
//                           ? Colors.white
//                           : null,
//                     ),
//                     child: Text(
//                       'Compliance',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: selectedIndex == 1
//                             ? ColorManager.mediumgrey
//                             : Colors.white,
//                       ),
//                     ),
//                   ),
//                   onTap: () => selectButton(1),
//                 ),
//                 InkWell(
//                   child: Container(
//                     height: 30,
//                     width: MediaQuery.of(context).size.width / 10,
//                     padding: EdgeInsets.symmetric(vertical: 6),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: selectedIndex == 2
//                           ? Colors.white
//                           : null,
//                     ),
//                     child: Text(
//                       'Plan of Care',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: selectedIndex == 2
//                             ? ColorManager.mediumgrey
//                             : Colors.white,
//                       ),
//                     ),
//                   ),
//                   onTap: () => selectButton(2),
//                 ),
//                 InkWell(
//                   child: Container(
//                     height: 30,
//                     width: MediaQuery.of(context).size.width / 9.5,
//                     padding: EdgeInsets.symmetric(vertical: 6),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: selectedIndex == 3
//                           ? Colors.white
//                           : null,
//                     ),
//                     child: Text(
//                       'Related Parties',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: selectedIndex == 3
//                             ? ColorManager.mediumgrey
//                             : Colors.white,
//                       ),
//                     ),
//                   ),
//                   onTap: () => selectButton(3),
//                 ),
//                 InkWell(
//                   child: Container(
//                     height: 30,
//                     width: MediaQuery.of(context).size.width / 9.8,
//                     padding: EdgeInsets.symmetric(vertical: 6),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: selectedIndex == 4
//                           ? Colors.white
//                           : null,
//                     ),
//                     child: Text(
//                       'Stay Info',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: selectedIndex == 4
//                             ? ColorManager.mediumgrey
//                             : Colors.white,
//                       ),
//                     ),
//                   ),
//                   onTap: () => selectButton(4),
//                 ),
//
//               ],
//             ),
//           ),
//
//           const SizedBox(
//             height: 10,
//           ),
//           Expanded(
//             flex: 10,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 //horizontal: MediaQuery.of(context).size.width / 45,
//                   vertical: 5),
//               child: PageView(
//                   controller: smIntakePageController,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: [
//                     IntakePatientsDatatInfo(),
//                     IntakePComplianceScreen(),
//                     IntakePlanCareScreen(),
//                     IntakeRelatedPartiesScreen(),
//                     IntakePatientsStayInfoScreen(),
//                   ]),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_compliance/intake_patients_compliance.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_info/intake_patients_info.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/intake_patients_plan_care.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_related_party/intake_patients_related_party.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_stay_info/intake_patients_stay_info.dart';
// import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/schedular_success_popup.dart';
//
// import '../../../../../../app/resources/color.dart';
// import '../../../../../../app/resources/font_manager.dart';
//
// class SmIntakePatientsScreen extends StatefulWidget {
//   SmIntakePatientsScreen({super.key});
//
//   @override
//   State<SmIntakePatientsScreen> createState() => _SmIntakePatientsScreenState();
// }
//
// class _SmIntakePatientsScreenState extends State<SmIntakePatientsScreen> {
//   int selectedIndex = 0;
//   final PageController smIntakePageController = PageController();
//
//   void selectButton(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//
//     smIntakePageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 4,
//       borderRadius: BorderRadius.circular(14),
//       child: Column(
//         children: [
//           SizedBox(height: 15,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width / 1.97,  //1.97
//                 height: 30,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.5),
//                       offset: Offset(0, 4),
//                       blurRadius: 4,
//                       spreadRadius: 0,
//                     ),
//                   ],
//                   color: ColorManager.blueprime,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       child: Container(
//                         height: 30,
//                         width: MediaQuery.of(context).size.width / 10,
//                         padding: EdgeInsets.symmetric(vertical: 6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: selectedIndex == 0 ? Colors.white : null,
//                         ),
//                         child: Text(
//                           'Info',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.firaSans(
//                             fontSize: 12,
//                             fontWeight: FontWeightManager.semiBold,
//                             color: selectedIndex == 0
//                                 ? ColorManager.mediumgrey
//                                 : Colors.white,
//                           ),
//                         ),
//                       ),
//                       onTap: () => selectButton(0),
//                     ),
//                     InkWell(
//                       child: Container(
//                         height: 30,
//                         width: MediaQuery.of(context).size.width / 10,
//                         padding: EdgeInsets.symmetric(vertical: 6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: selectedIndex == 1 ? Colors.white : null,
//                         ),
//                         child: Text(
//                           'Compliance',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.firaSans(
//                             fontSize: 12,
//                             fontWeight: FontWeightManager.semiBold,
//                             color: selectedIndex == 1
//                                 ? ColorManager.mediumgrey
//                                 : Colors.white,
//                           ),
//                         ),
//                       ),
//                       onTap: () => selectButton(1),
//                     ),
//                     InkWell(
//                       child: Container(
//                         height: 30,
//                         width: MediaQuery.of(context).size.width / 10,
//                         padding: EdgeInsets.symmetric(vertical: 6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: selectedIndex == 2 ? Colors.white : null,
//                         ),
//                         child: Text(
//                           'Plan of Care',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.firaSans(
//                             fontSize: 12,
//                             fontWeight: FontWeightManager.semiBold,
//                             color: selectedIndex == 2
//                                 ? ColorManager.mediumgrey
//                                 : Colors.white,
//                           ),
//                         ),
//                       ),
//                       onTap: () => selectButton(2),
//                     ),
//                     InkWell(
//                       child: Container(
//                         height: 30,
//                         width: MediaQuery.of(context).size.width / 9.5,
//                         padding: EdgeInsets.symmetric(vertical: 6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: selectedIndex == 3 ? Colors.white : null,
//                         ),
//                         child: Text(
//                           'Related Parties',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.firaSans(
//                             fontSize: 12,
//                             fontWeight: FontWeightManager.semiBold,
//                             color: selectedIndex == 3
//                                 ? ColorManager.mediumgrey
//                                 : Colors.white,
//                           ),
//                         ),
//                       ),
//                       onTap: () => selectButton(3),
//                     ),
//                     InkWell(
//                       child: Container(
//                         height: 30,
//                         width: MediaQuery.of(context).size.width / 9.8,
//                         padding: EdgeInsets.symmetric(vertical: 6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: selectedIndex == 4 ? Colors.white : null,
//                         ),
//                         child: Text(
//                           'Stay Info',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.firaSans(
//                             fontSize: 12,
//                             fontWeight: FontWeightManager.semiBold,
//                             color: selectedIndex == 4
//                                 ? ColorManager.mediumgrey
//                                 : Colors.white,
//                           ),
//                         ),
//                       ),
//                       onTap: () => selectButton(4),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width/6),
//               Padding(
//                 padding: const EdgeInsets.only(right: 40.0),
//                 child: Container(
//                   height: 26,
//                   width: 102,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return SchedularSuccessPopup(title: 'Success',);
//                         },
//                       );
//                     },
//                     child: Text(
//                       'Save',
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeightManager.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 25,
//                         vertical: 10,
//                       ),
//                       backgroundColor: ColorManager.blueprime,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10,),
//           Expanded(
//             flex: 10,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 5),
//               child: PageView(
//                 controller: smIntakePageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   IntakePatientsDatatInfo(),
//                   IntakePComplianceScreen(),
//                   IntakePlanCareScreen(),
//                   IntakeRelatedPartiesScreen(),
//                   IntakePatientsStayInfoScreen(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_compliance/intake_patients_compliance.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_info/intake_patients_info.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/intake_patients_plan_care.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_related_party/intake_patients_related_party.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_stay_info/intake_patients_stay_info.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_profile_bar.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/info_success_popup.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/schedular_success_popup.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';

class SmIntakePatientsScreen extends StatefulWidget {
  SmIntakePatientsScreen({super.key});

  @override
  State<SmIntakePatientsScreen> createState() => _SmIntakePatientsScreenState();
}

class _SmIntakePatientsScreenState extends State<SmIntakePatientsScreen> {
  int selectedIndex = 0;
  bool showProfileBar = false;
  final PageController smIntakePageController = PageController();

  void selectButton(int index) {
    setState(() {
      selectedIndex = index;
    });

    smIntakePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void toggleProfileBar() {
    setState(() {
      showProfileBar = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(14),
      child: Column(
        children: [
          if (showProfileBar) ...[

            IntakeProfileBar()
          ],
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.97,  //1.97
                height: 30,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                  color: ColorManager.blueprime,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 10,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectedIndex == 0 ? Colors.white : null,
                        ),
                        child: Text(
                          'Info',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: selectedIndex == 0
                                ? ColorManager.mediumgrey
                                : Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => selectButton(0),
                    ),
                    InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 10,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectedIndex == 1 ? Colors.white : null,
                        ),
                        child: Text(
                          'Compliance',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: selectedIndex == 1
                                ? ColorManager.mediumgrey
                                : Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => selectButton(1),
                    ),
                    InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 10,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectedIndex == 2 ? Colors.white : null,
                        ),
                        child: Text(
                          'Plan of Care',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: selectedIndex == 2
                                ? ColorManager.mediumgrey
                                : Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => selectButton(2),
                    ),
                    InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 9.5,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectedIndex == 3 ? Colors.white : null,
                        ),
                        child: Text(
                          'Related Parties',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: selectedIndex == 3
                                ? ColorManager.mediumgrey
                                : Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => selectButton(3),
                    ),
                    InkWell(
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width / 9.8,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectedIndex == 4 ? Colors.white : null,
                        ),
                        child: Text(
                          'Stay Info',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.semiBold,
                            color: selectedIndex == 4
                                ? ColorManager.mediumgrey
                                : Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => selectButton(4),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 6),
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Container(
                  height: 26,
                  width: 102,
                  child: ElevatedButton(
                    onPressed: () {
                      toggleProfileBar();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return SchedularSuccessPopup(title: 'Success');
                          return SchedularInfoSuccessPopup();
                        },
                      );
                    },
                    child: Text(
                      'Save',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      backgroundColor: ColorManager.blueprime,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: PageView(
                controller: smIntakePageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  IntakePatientsDatatInfo(),
                  IntakePComplianceScreen(),
                  IntakePlanCareScreen(),
                  IntakeRelatedPartiesScreen(),
                  IntakePatientsStayInfoScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
