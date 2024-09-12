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
                color: ColorManager.mediumgrey,
                fontWeight: FontWeightManager.regular,
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