import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_update_schedular/information_update.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_update_schedular/sent_to_schedular.dart';

import '../../../../app/resources/establishment_resources/em_dashboard_string_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../../em_module/company_identity/company_identity_screen.dart';
import '../../em_module/dashboard/widgets/em_dashboard_const.dart';
import '../sm_scheduler/widget/schedular/schedular_new_screen.dart';

class IntakeMainScreen extends StatefulWidget {
  const IntakeMainScreen({super.key});

  @override
  State<IntakeMainScreen> createState() => _IntakeMainScreenState();
}

class _IntakeMainScreenState extends State<IntakeMainScreen> {

  final PageController _tabPageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          /// tab bar
          Container(
           //color: Colors.green,
            margin: const EdgeInsets.symmetric(vertical: AppPadding.p8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SMTabbar(onTap: (int index){
                  _selectButton(0);
                }, index: 0, grpIndex: _selectedIndex, heading: "Information Update"),
                SizedBox(width: 20,),
                SMTabbar(onTap: (int index){
                  _selectButton(1);
                }, index: 1, grpIndex: _selectedIndex, heading: "Send to Scheduler"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                  // documentTypeGet(context);
                });
              },
              children: [
                InformationUpdateScreen(),
                SentToSchedularScreen(),
                // GeneralSettingScreen(),
                // OfficeLocationScreen(),
                // OfficeClinicianScreen(),
                // ContractDocAuditingScreen(),

              ],
            ),
          ),
        ]));
  }
}
