import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_insurance/intake_insurance_home_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_medications/intake_medications_home_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/intake_patiets_data_screen.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_phhysician_info/intake_physician_home_screen.dart';
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

  void intakeSelectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    intakePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      Container(

        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
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
                heading: "Patients Data"),
            PageViewMenuButtonConst(
                onTap: (int index) {
                  intakeSelectButton(index);
                },
                index: 1,
                grpIndex: _selectedIndex,
                heading: "Referral"),
            PageViewMenuButtonConst(
                onTap: (int index) {
                  intakeSelectButton(index);
                },
                index: 2,
                grpIndex: _selectedIndex,
                heading: "Physician Info"),
            PageViewMenuButtonConst(
                onTap: (int index) {
                  intakeSelectButton(index);
                },
                index: 3,
                grpIndex: _selectedIndex,
                heading: "Medications"),
            PageViewMenuButtonConst(
                onTap: (int index) {
                  intakeSelectButton(index);
                },
                index: 4,
                grpIndex: _selectedIndex,
                heading: "Lab Results"),
            PageViewMenuButtonConst(
                onTap: (int index) {
                  intakeSelectButton(index);
                },
                index: 5,
                grpIndex: _selectedIndex,
                heading: "Insurance"),
            PageViewMenuButtonConst(
                onTap: (int index) {
                  intakeSelectButton(index);
                },
                index: 6,
                grpIndex: _selectedIndex,
                heading: "Notes"),
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
              // documentTypeGet(context);
            });
          },
          children: [
            SmIntakePatientsScreen(),
            SMIntakeReferralScreen(),
            IntakePhysicianScreen(),
            IntakeMedicationScreen(),
            Container(color: Colors.greenAccent,),
            SMIntakeInsuranceScreen(),
            Container(color: Colors.greenAccent,),
          ],
        ),
      ),

    ]);
  }
}

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
