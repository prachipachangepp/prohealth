



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import 'getx_oasis.dart';

class GreenContrainerConst extends StatelessWidget {
  final double? height;
  final Widget child;
  const GreenContrainerConst({super.key, this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppSize.s500,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30, vertical: AppPadding.p15),
      decoration: BoxDecoration(
        color: ColorManager.containergreen,
        borderRadius: BorderRadius.circular(8),
        // border: Border.symmetric(vertical: BorderSide(width: 0.2,color: ColorManager.grey),horizontal: BorderSide(width: 0.2,color: ColorManager.grey),),//all(width: 1, color: Color(0xFFBCBCBC)),
       // border: Border.all(width: 1,color: ColorManager.lightGrey),//all(width: 1, color: Color(0xFFBCBCBC)),

      ),
      child: child,
    );
  }
}






class CustomCheckBoxListTile extends StatelessWidget {
  final String title;
  final RxBool isChecked; // RxBool to manage checkbox state reactively
  final Function(bool) onChanged;

  const CustomCheckBoxListTile({
    Key? key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox part
        Obx(() {
          return Checkbox(
            value: isChecked.value,
            onChanged: (bool? value) {
              if (value != null) {
                onChanged(value); // Call the onChanged function passed to the widget
              }
            },
            checkColor: Colors.white, // Color of the check mark
            activeColor: Color(0xff50B5E5),
            side: BorderSide(color: Colors.blue, width: 2),// Set the checkbox active color
          );
        }),
        // Text part
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: DocumentTypeDataStyle.customTextStyle(context), // Customize the text style as needed
           // overflow: TextOverflow.ellipsis, // Prevent text overflow
          ),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}






// Custom class for Agree Terms Widget
// class CheckBoxConst extends StatelessWidget {
//   final String text;
//   final RxBool isChecked;// Customizable text
//
//   // Constructor with text parameter
//   const CheckBoxConst({
//     Key? key,
//     required this.text,
//     required this.isChecked,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Access the TermsController using GetX
//     final TermsController controller = Get.find();
//
//     return Row(
//       children: [
//         // Using Theme widget to override the splash and highlight colors of the Checkbox
//         Theme(
//           data: Theme.of(context).copyWith(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//           ),
//           child: Obx(() {
//             return Checkbox(
//               // Customizing the active color of the checkbox (when checked)
//               activeColor: ColorManager.blueprime,
//               // The current state of the checkbox (checked or not)
//               value: isChecked.value,
//               // The function that gets called when the checkbox state changes
//               onChanged: controller.toggleCheckbox,
//             );
//           }),
//         ),
//         // The customizable text next to the checkbox
//         Text(
//           text, // Use the provided text
//           style: onlyFormDataStyle.customTextStyle(context),
//         ),
//       ],
//     );
//   }
// }
