import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/value_manager.dart';

class HeaderContentConst extends StatelessWidget {
  final String heading;
  final Widget content;
  final bool isAsterisk;

  const HeaderContentConst({
    super.key,
    required this.heading,
    required this.content,
    this.isAsterisk = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Using RichText for heading with optional red asterisk
          RichText(
            text: TextSpan(
              text: heading, // Main heading text
              style: AllPopupHeadings.customTextStyle(context), // Main style
              children: isAsterisk
                  ? [
                TextSpan(
                  text: ' *', // Asterisk
                  style: AllPopupHeadings
                      .customTextStyle(context)
                      ?.copyWith(color: Colors.red), // Red color for asterisk
                ),
              ]
                  : [], // Empty if isAsterisk is false
            ),
          ),
          const SizedBox(height: AppSize.s5),

          /// Content widget (e.g., upload doc)
          content,
        ],
      ),
    );
  }
}