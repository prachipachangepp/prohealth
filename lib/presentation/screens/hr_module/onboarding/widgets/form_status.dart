import 'package:flutter/material.dart';

import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/const_string.dart';

class FormStatusScreen extends StatelessWidget {
  final int employeeId;
  const FormStatusScreen({super.key,required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 150),
          child: Text(
            AppStringHRNoData.noOnboardFormStatus,
            style:AllNoDataAvailable.customTextStyle(context),
          ),
        ),
      ),
    );
  }
}
