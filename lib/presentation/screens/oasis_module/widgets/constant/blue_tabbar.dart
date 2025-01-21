import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../widgets/app_clickable_widget.dart';

class CustomTitleButtonoasis extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;
  final String text;
  final bool isSelected;

  CustomTitleButtonoasis({
    required this.height,
    required this.width,
    required this.onPressed,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      child: AppClickableWidget(
        onTap: onPressed,
        onHover: (bool val) {},
        child: Container(

        alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFF51B5E6), // Make the inside transparent
            border: isSelected
                ? Border.all(color: ColorManager.white, width: 2) // White border when selected
                : null,
          ),
          child: Text(
            text,
            style: CustomTextStylesCommon.commonStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeight.w700,
              color: ColorManager.white, // Text stays white
            ),
          ),
        ),
      ),
    );
  }
}




class ButtonSelectionControlleroasis extends GetxController {
  // Reactive variables
  var selectedIndex = 0.obs;
  var selectedText = "Consent For Care".obs;

  // Method to update the selected index and text
  void selectButton(int index, String text) {
    selectedIndex.value = index;
    selectedText.value = text;
  }
}