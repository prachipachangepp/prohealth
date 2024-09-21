import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/acknowledgement.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/health_record_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/banking_tab_constant.dart';
import '../../../../../../app/resources/value_manager.dart';

///prachi
class Banking extends StatelessWidget {
  final int employeeId;
  const Banking({Key? key, required this.employeeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              BankingTabContainerConstant(employeeId: employeeId,),
              SizedBox(
                height: AppSize.s8,
              )
            ],
          );
        });
  }
}


class HealthRecord extends StatelessWidget {
  final int employeeId;
  const HealthRecord({Key? key, required this.employeeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              HealthRecordConstant(employeeId: employeeId,),
              SizedBox(
                height: AppSize.s8,
              )
            ],
          );
        });
  }
}

class Acknowledgement extends StatelessWidget {
  final int employeeId;
  const Acknowledgement({Key? key, required this.employeeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              AcknowledgementTab(employeeId: employeeId,),
              SizedBox(
                height: AppSize.s8,
              )
            ],
          );
        });
  }
}