import 'package:flutter/material.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/value_manager.dart';

class HealthRecordTab extends StatelessWidget {
  const HealthRecordTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p80, vertical: AppPadding.p40),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: AppSize.s181,
          width: MediaQuery.of(context).size.width / 70,
          padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
    );
  }
}
