import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TableHeadConstant extends StatelessWidget {
  final List<TableHeadItem> items;

  const TableHeadConstant({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return Text(
            item.text,
            textAlign: item.textAlign,
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class TableHeadItem {
  final String text;
  final TextAlign textAlign;

  const TableHeadItem({
    required this.text,
    this.textAlign = TextAlign.start,
  });
}
