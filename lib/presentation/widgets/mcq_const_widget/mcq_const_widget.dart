import 'package:flutter/material.dart';

///prachi
class McqWidget extends StatelessWidget {
  final String title;
  final List<String> items;
  McqWidget({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff686464),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: buildItemList(items),
          ),
        ),
      ],
    );
  }

  List<Widget> buildItemList(List<String> items) {
    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.addAll([
        Row(
          children: [
            Icon(
              Icons.circle_outlined,
              size: 15,
              color: Color(0xff686464),
            ),
            SizedBox(width: 4),
            Text(
              items[i],
              style: TextStyle(
                fontSize: 13,
                color: Color(0xff6000000),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 7),
          ],
        ),
        SizedBox(width: 12),
      ]);
    }
    return widgets;
  }
}
