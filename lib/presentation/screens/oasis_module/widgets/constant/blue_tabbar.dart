import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
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
      color: Color(0xFF51B5E6),
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
                : Border.all(color: Color(0xFF51B5E6))
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


class Drawerrightside extends StatelessWidget {
  const Drawerrightside({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Not Attempted Questions",
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20,),
          Text("| do not currently have advance directives",
            style: AllHRTableData.customTextStyle(context),
          ),
          SizedBox(height: 20,),
          Text("I have had an opportunity to review this document and ask questions to assist me in understanding my rights relation to the protection of my health information. I am satisfied with the explanation provided to me and I am confident that the provider is committed to protecting my health Information.",
            style: AllHRTableData.customTextStyle(context),
          ),
        ],
      ),
    );
  }
}



class DrawerrightsideA extends StatelessWidget {
  const DrawerrightsideA({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Not Attempted Questions   A",
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20,),
          Text("| do not currently have advance directives",
            style: AllHRTableData.customTextStyle(context),
          ),
          SizedBox(height: 20,),
          Text("I have had an opportunity to review this document and ask questions to assist me in understanding my rights relation to the protection of my health information. I am satisfied with the explanation provided to me and I am confident that the provider is committed to protecting my health Information.",
            style: AllHRTableData.customTextStyle(context),
          ),
        ],
      ),
    );
  }
}

class DrawerrightsideB extends StatelessWidget {
  const DrawerrightsideB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Not Attempted Questions  B",
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20,),
          Text("| do not currently have advance directives",
            style: AllHRTableData.customTextStyle(context),
          ),
          SizedBox(height: 20,),
          Text("I have had an opportunity to review this document and ask questions to assist me in understanding my rights relation to the protection of my health information. I am satisfied with the explanation provided to me and I am confident that the provider is committed to protecting my health Information.",
            style: AllHRTableData.customTextStyle(context),
          ),
        ],
      ),
    );
  }
}



class DefaultDrawerContent extends StatelessWidget {
  const DefaultDrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Not Attempted Questions  B",
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20,),
          Text("| do not currently have advance directives",
            style: AllHRTableData.customTextStyle(context),
          ),
          SizedBox(height: 20,),
          Text("I have had an opportunity to review this document and ask questions to assist me in understanding my rights relation to the protection of my health information. I am satisfied with the explanation provided to me and I am confident that the provider is committed to protecting my health Information.",
            style: AllHRTableData.customTextStyle(context),
          ),
        ],
      ),
    );
  }
}