import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_insurance/intake_insurance_home_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_lab_result/intake_lab_result_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_medications/intake_medications_home_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_notes/intake_notes_home_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/intake_patients_data_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_physician_info/intake_physician_home_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_referral/intake_referral_home_screen.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../widgets/constant_widgets/page_view_menu_button_const.dart';

class SMIntakeScreen extends StatefulWidget {
  const SMIntakeScreen({super.key});

  @override
  State<SMIntakeScreen> createState() => _SMIntakeScreenState();
}

class _SMIntakeScreenState extends State<SMIntakeScreen> {
  final PageController intakePageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  int patientId = 51;

  void intakeSelectButton(int index) {
    if (index == 0 || patientId != 0) {
      setState(() {
        _selectedIndex = index;
      });
      intakePageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.5),
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: AppPadding.p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PageViewMenuButtonConst(
              onTap: (int index) {
                intakeSelectButton(index);
              },
              index: 0,
              grpIndex: _selectedIndex,
              heading: "Patients Data",
            ),
            // PageViewMenuButtonConst(
            //   onTap: (int index) {
            //     intakeSelectButton(index);
            //   },
            //   index: 1,
            //   grpIndex: _selectedIndex,
            //   heading: "Referral",
            //   enabled: patientId != 0,
            // ),
            PageViewMenuButtonConst(
              onTap: (int index) {
                intakeSelectButton(index);
              },
              index: 1,
              grpIndex: _selectedIndex,
              heading: "Physician Info",
              enabled: patientId != 0,
            ),
            PageViewMenuButtonConst(
              onTap: (int index) {
                intakeSelectButton(index);
              },
              index: 2,
              grpIndex: _selectedIndex,
              heading: "Medications",
              enabled: patientId != 0,
            ),
            PageViewMenuButtonConst(
              onTap: (int index) {
                intakeSelectButton(index);
              },
              index: 3,
              grpIndex: _selectedIndex,
              heading: "Lab Results",
              enabled: patientId != 0,
            ),
            PageViewMenuButtonConst(
              onTap: (int index) {
                intakeSelectButton(index);
              },
              index: 4,
              grpIndex: _selectedIndex,
              heading: "Insurance",
              enabled: patientId != 0,
            ),
            PageViewMenuButtonConst(
              onTap: (int index) {
                intakeSelectButton(index);
              },
              index: 5,
              grpIndex: _selectedIndex,
              heading: "Notes",
              enabled: patientId != 0,
            ),
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: NonScrollablePageView(
          controller: intakePageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            SmIntakePatientsScreen(
              onPatientIdGenerated: (int id) {
                setState(() {
                  patientId = id;
                });
              },
            ),
            // SMIntakeReferralScreen(patientId: patientId),
            IntakePhysicianScreen(patientId: patientId),
            IntakeMedicationScreen(patientId: patientId),
            IntakeLabResultScreen(patientId: patientId),
            SMIntakeInsuranceScreen(patientId: patientId),
            SmIntakeNotesScreen(patientId: patientId),
          ],
        ),
      ),
    ]);
  }
}


///
class NonScrollablePageView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int> onPageChanged;
  final List<Widget> children;
  const NonScrollablePageView({
    Key? key,
    required this.controller,
    required this.onPageChanged,
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) => true,
      child: PageView(
        controller: controller,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(), // Disables scrolling
        children: children,
      ),
    );
  }
}