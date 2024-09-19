import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';

class TableHeadConstant extends StatelessWidget {
  final List<TableHeadItem> items;

  const TableHeadConstant({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 30,),
      height: 30,
      decoration: BoxDecoration(
        color: ColorManager.fmediumgrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items.map((item) {
          return Expanded(
            child: Center(
              child: Text(
                item.text,
                textAlign: item.textAlign,
                style: GoogleFonts.firaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.white,
                  decoration: TextDecoration.none,
                ),
              ),
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
