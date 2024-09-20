import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/value_manager.dart';

class HeaderContentConst extends StatelessWidget {
  final String heading;
  final Widget content;
  const HeaderContentConst(
      {super.key, required this.heading, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: AppbarCustomDropdownStyle.customTextStyle(context),
          ),
          SizedBox(height: AppSize.s5),

          /// upload  doc
          content,
        ],
      ),
    );
  }
}
