import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

///prach to do
class McqWidget extends StatelessWidget {
  final String title;
  final List<String> items;
  final RxInt selectedItemIndex = RxInt(-1);
  final Function(int)? onChanged;
  McqWidget({
    required this.title,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double textFontSize = screenWidth / 99;
    final double radioButtonSize = screenWidth / 300;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: textFontSize,
            color: Color(0xff686464),
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3.0,right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildItemList(context, textFontSize, radioButtonSize),
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
                    activeColor: Color(0xff50B5E5),
                    focusColor: Color(0xff686464),
                    hoverColor: Color(0xff686464),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 7.0,
                  ),
            )),
            Text(
              items[i],
              style: TextStyle(
                fontSize: textFontSize,
                color: Color(0xff6000000),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      );
    }
    return widgets;
  }
}

///saloni
class RegisterPopupMcq extends StatelessWidget {
  final String title;
  final List<String> items;
  final RxInt selectedItemIndex = RxInt(-1);
  final Function(int)? onChanged;
  RegisterPopupMcq({
    required this.title,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double textFontSize = screenWidth / 150;
    final double textFontSizeHead = screenWidth / 120;
    final double radioButtonSize = screenWidth / 300;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: textFontSizeHead,
            color: Color(0xff575757),
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildItemList(context, textFontSize, radioButtonSize),
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
              scale: 0.6,
              child: Radio(
                    value: i,
                    groupValue: selectedItemIndex.value,
                    onChanged: (value) {
                      selectedItemIndex.value = value as int;
                    },
                    visualDensity: VisualDensity.compact,
                    activeColor: Color(0xff50B5E5),
                    focusColor: Color(0xff686464),
                    hoverColor: Color(0xff686464),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 7.0,
                  ),
            )),
            SizedBox(width: 4),
            Text(
              items[i],
              style: TextStyle(
                fontSize: textFontSize,
                color: Color(0xff6000000),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4),
          ],
        ),
      );
    }
    return widgets;
  }
}
