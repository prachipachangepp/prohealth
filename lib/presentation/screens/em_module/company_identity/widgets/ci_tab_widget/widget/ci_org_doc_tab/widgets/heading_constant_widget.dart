import 'package:flutter/material.dart';
import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../../app/resources/value_manager.dart';

class TableHeadingConst extends StatelessWidget {
  const TableHeadingConst({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s30,
      margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
      decoration: BoxDecoration(
        color: ColorManager.fmediumgrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Center(
              child: Text(
                AppStringEM.srNo,
                style: AllHRTableHeading.customTextStyle(context),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppStringEM.docID,
                style: AllHRTableHeading.customTextStyle(context),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppStringEM.name,
                style: AllHRTableHeading.customTextStyle(context),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppStringEM.reminderthershold,
                style: AllHRTableHeading.customTextStyle(context),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                AppStringEM.actions,
                style: AllHRTableHeading.customTextStyle(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

