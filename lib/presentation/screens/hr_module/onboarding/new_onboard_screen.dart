// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/acknowledgement.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/banking_tab.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/genaral_tab.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/health_record_tab.dart';
// import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/qualification_tab.dart';
//
// import '../../../../app/resources/color.dart';
// import '../../../../app/resources/const_string.dart';
// import '../../../../app/resources/font_manager.dart';
// import '../manage/widgets/bottom_row.dart';
//
// class NewOnboardScreen extends StatefulWidget {
//   const NewOnboardScreen({super.key});
//
//   @override
//   State<NewOnboardScreen> createState() => _NewOnboardScreenState();
// }
//
// class _NewOnboardScreenState extends State<NewOnboardScreen> {
//   final PageController _onboardPageController = PageController();
//   int _selectedIndex = 0;
//
//   void _selectButton(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _onboardPageController.animateToPage(
//       index,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return OnboardingTabManage(managePageController: _onboardPageController, selectedIndex: _selectedIndex,
//       selectButton: _selectButton);
//   }
// }
//
//
// class OnboardingTabManage extends StatefulWidget {
//   final PageController managePageController;
//   final int selectedIndex;
//   final Function(int) selectButton;
//   const OnboardingTabManage({super.key, required this.managePageController, required this.selectedIndex, required this.selectButton,
//   });
//
//   @override
//   State<OnboardingTabManage> createState() => _OnboardingTabManageState();
// }
//
// class _OnboardingTabManageState extends State<OnboardingTabManage> {
//   final List<String> _categories = [
//     AppString.general,
//     AppString.qualification,
//     AppString.banking,
//     AppString.healthRecord,
//     AppString.acknowledgement
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Material(
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(20),
//                   child: Container(
//                     height: 28,
//                     width: MediaQuery.of(context).size.width / 1.68,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: ColorManager.blueprime,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: _categories
//                           .asMap()
//                           .entries
//                           .map(
//                             (entry) => InkWell(
//                           child: Container(
//                             height: 30,
//                             width: MediaQuery.of(context).size.width / 8.42,
//                             padding: EdgeInsets.symmetric(vertical: 6),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: widget.selectedIndex == entry.key
//                                   ? Colors.white : null,
//                             ),
//
//                             child: Text(
//                                 entry.value,
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.firaSans(textStyle:TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeightManager.semiBold,
//                                   color: widget.selectedIndex == entry.key
//                                       ? ColorManager.mediumgrey
//                                       : Colors.white,
//                                 ),)
//                             ),
//                           ),
//                           onTap: () => widget.selectButton(entry.key),
//                         ),
//                       )
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 10,
//             child:Padding(
//                     padding: EdgeInsets.only(
//                         top: MediaQuery.of(context).size.width / 45 ),
//                     child: PageView(
//                         controller: widget.managePageController,
//                         physics: NeverScrollableScrollPhysics(),
//                         children: [
//                           OnboardingGeneral(),
//                           OnboardingQualification(),
//                           Banking(),
//                           HealthRecordTab(),
//                           AcknowledgementTab()
//                         ]),
//                   ),
//
//           ),
//           BottomBarRow()
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/acknowledgement.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/banking_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/genaral_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/health_record_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/qualification_tab.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/font_manager.dart';
import '../manage/widgets/bottom_row.dart';

class NewOnboardScreen extends StatefulWidget {
  const NewOnboardScreen({super.key});

  @override
  State<NewOnboardScreen> createState() => _NewOnboardScreenState();
}

class _NewOnboardScreenState extends State<NewOnboardScreen> {
  final PageController _onboardPageController = PageController();
  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _onboardPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingTabManage(managePageController: _onboardPageController, selectedIndex: _selectedIndex,
        selectButton: _selectButton);
  }
}

class OnboardingTabManage extends StatefulWidget {
  final PageController managePageController;
  final int selectedIndex;
  final Function(int) selectButton;
  const OnboardingTabManage({super.key, required this.managePageController, required this.selectedIndex, required this.selectButton,
  });

  @override
  State<OnboardingTabManage> createState() => _OnboardingTabManageState();
}

class _OnboardingTabManageState extends State<OnboardingTabManage> {
  final List<String> _categories = [
    AppString.general,
    AppString.qualification,
    AppString.banking,
    AppString.healthRecord,
    AppString.acknowledgement
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          if (widget.selectedIndex != 0)
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 28,
                      width: MediaQuery.of(context).size.width / 1.68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorManager.blueprime,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _categories
                            .asMap()
                            .entries
                            .map(
                              (entry) => InkWell(
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 8.42,
                              padding: EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: widget.selectedIndex == entry.key
                                    ? Colors.white : null,
                              ),

                              child: Text(
                                  entry.value,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.firaSans(textStyle:TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeightManager.semiBold,
                                    color: widget.selectedIndex == entry.key
                                        ? ColorManager.mediumgrey
                                        : Colors.white,
                                  ),)
                              ),
                            ),
                            onTap: () => widget.selectButton(entry.key),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            flex: 10,
            child:Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 45 ),
              child: PageView(
                  controller: widget.managePageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    OnboardingGeneral( selectButton: widget.selectButton),
                    OnboardingQualification(),
                    Banking(),
                    HealthRecordTab(),
                    AcknowledgementTab()
                  ]),
            ),
          ),
          BottomBarRow()
        ],
      ),
    );
  }
}