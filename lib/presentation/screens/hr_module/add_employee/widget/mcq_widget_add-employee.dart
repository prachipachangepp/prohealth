import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

///prach to do
class McqWidget extends StatelessWidget {
  final String title;
  final List<String> items;
  final RxInt selectedItemIndex = RxInt(-1);
  final Function(int)? onChanged;
  final double? fontSize;
  McqWidget({
    required this.title,
    required this.items,
    this.onChanged,
    this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double textFontSize = screenWidth / 99;
    final double radioButtonSize = screenWidth / 300;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            title,
            style: GoogleFonts.firaSans(
              // fontSize: textFontSize,
              fontSize: fontSize,
              color: ColorManager.mediumgrey,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p3,right: AppPadding.p6),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildItemList(context, textFontSize, radioButtonSize),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildItemList(
      BuildContext context, double textFontSize, double radioButtonSize) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(
        Row(
          children: [
            Obx(() => Transform.scale(
              scale: 0.7,
              child: Radio(
                value: i,
                groupValue: selectedItemIndex.value,
                onChanged: (value) {
                  selectedItemIndex.value = value as int;
                },
                visualDensity: VisualDensity.compact,
                activeColor: ColorManager.blueprime,
                focusColor: ColorManager.mediumgrey,
                hoverColor: ColorManager.mediumgrey,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashRadius: 7.0,
              ),
            )),
            Text(
              items[i],
              style: GoogleFonts.firaSans(
                fontSize: 12,
                color: Color(0xff6000000),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: AppSize.s20),
          ],
        ),
      );
    }
    return widgets;
  }
}







//
// class RxInt {
//   int value;
//   RxInt(this.value);
// }

// ////////////
// class McqWidgetEnroll extends StatelessWidget {
//   final String title;
//   final List<String> items;
//   final RxInt selectedItemIndex = RxInt(-1);
//   final Function(int)? onChanged;
//   final double? fontSize;
//
//   McqWidgetEnroll({
//     required this.title,
//     required this.items,
//     this.onChanged,
//     this.fontSize,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double textFontSize = screenWidth / 99;
//     final double radioButtonSize = screenWidth / 300;
//
//     // Split items into two groups
//     final int midIndex = (items.length / 2).ceil();
//     final List<String> firstRowItems = items.sublist(0, midIndex);
//     final List<String> secondRowItems = items.sublist(midIndex);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Flexible(
//           child: Text(
//             title,
//             style: GoogleFonts.firaSans(
//               fontSize: fontSize,
//               color: ColorManager.mediumgrey,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: AppPadding.p3, right: AppPadding.p6),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: buildItemList(context, firstRowItems, textFontSize, radioButtonSize),
//               ),
//               SizedBox(height: AppSize.s10),
//               Row(
//                 children: buildItemList(context, secondRowItems, textFontSize, radioButtonSize),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   List<Widget> buildItemList(
//       BuildContext context, List<String> items, double textFontSize, double radioButtonSize) {
//     List<Widget> widgets = [];
//     for (int i = 0; i < items.length; i++) {
//       widgets.add(
//         Row(
//           children: [
//             Obx(() => Transform.scale(
//               scale: 0.7,
//               child: Radio(
//                 value: i,
//                 groupValue: selectedItemIndex.value,
//                 onChanged: (value) {
//                   selectedItemIndex.value = value as int;
//                 },
//                 // groupValue: selectedItemIndex.value,
//                 // onChanged: (value) {
//                 //   // Ensure that the selected value is not null and is an integer
//                 //   if (value != null) {
//                 //     selectedItemIndex.value = value as int;
//                 //     if (onChanged != null) {
//                 //       onChanged!(value as int);
//                 //     }
//                 //   }
//                 // },
//                 visualDensity: VisualDensity.compact,
//                 activeColor: ColorManager.blueprime,
//                 focusColor: ColorManager.mediumgrey,
//                 hoverColor: ColorManager.mediumgrey,
//                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 splashRadius: 7.0,
//               ),
//             )),
//             Text(
//               items[i],
//               style: GoogleFonts.firaSans(
//                 fontSize: textFontSize,
//                 color: ColorManager.mediumgrey,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(width: AppSize.s20),
//           ],
//         ),
//       );
//     }
//     return widgets;
//   }
// }




class McqWidgetEnroll extends StatelessWidget {
  final String title;
  final List<String> items;
  final RxInt selectedItemIndex;
  final Function(int)? onChanged;
  final double? fontSize;

  McqWidgetEnroll({
    required this.title,
    required this.items,
    required this.selectedItemIndex, // Required parameter
    this.onChanged,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double textFontSize = screenWidth / 99;
    final double radioButtonSize = screenWidth / 300;

    // Split items into two groups
    final int midIndex = (items.length / 2).ceil();
    final List<String> firstRowItems = items.sublist(0, midIndex);
    final List<String> secondRowItems = items.sublist(midIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            title,
            style: GoogleFonts.firaSans(
              fontSize: fontSize,
              color: ColorManager.mediumgrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p3, right: AppPadding.p6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: buildItemList(context, firstRowItems, textFontSize, radioButtonSize),
              ),
              SizedBox(height: AppSize.s10),
              Row(
                children: buildItemList(context, secondRowItems, textFontSize, radioButtonSize),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildItemList(
      BuildContext context, List<String> items, double textFontSize, double radioButtonSize) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(
        Row(
          children: [
            Obx(() => Transform.scale(
              scale: 0.7,
              child: Radio(
                value: i,
                groupValue: selectedItemIndex.value,
                onChanged: (value) {
                  if (value != null) {
                    selectedItemIndex.value = value as int;
                    if (onChanged != null) {
                      onChanged!(value as int);
                    }
                  }
                },
                visualDensity: VisualDensity.compact,
                activeColor: ColorManager.blueprime,
                focusColor: ColorManager.mediumgrey,
                hoverColor: ColorManager.mediumgrey,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashRadius: 7.0,
              ),
            )),
            Text(
              items[i],
              style: GoogleFonts.firaSans(
                fontSize: textFontSize,
                color: ColorManager.mediumgrey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: AppSize.s20),
          ],
        ),
      );
    }
    return widgets;
  }
}