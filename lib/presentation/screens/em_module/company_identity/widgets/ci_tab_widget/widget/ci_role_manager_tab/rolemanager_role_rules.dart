import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/theme_manager.dart';

class RoleManagerRoleRules extends StatelessWidget {
  const RoleManagerRoleRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            ErrorMessageString.noRoleRules,
            style: CustomTextStylesCommon.commonStyle(
              fontWeight: FontWeightManager.medium,
              fontSize: FontSize.s12,
              color: ColorManager.mediumgrey,
            ),
          ),
        ),
      ],
    );
  }
}
