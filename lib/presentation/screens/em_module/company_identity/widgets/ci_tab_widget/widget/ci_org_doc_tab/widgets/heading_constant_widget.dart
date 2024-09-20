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
      padding: EdgeInsets.only(left: 100,right: 50),
      decoration: BoxDecoration(
        color: ColorManager.fmediumgrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              AppStringEM.srNo,
              style: AllHRTableHeading.customTextStyle(context),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Text(
                AppStringEM.docID,
                textAlign: TextAlign.start,
                style: AllHRTableHeading.customTextStyle(context),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Text(
                AppStringEM.name,
                style: AllHRTableHeading.customTextStyle(context),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                AppStringEM.reminderthershold,
                style: AllHRTableHeading.customTextStyle(context),
              ),
            ),
          ),
          Expanded(
            child: Text(
              AppStringEM.actions,
              textAlign: TextAlign.center,
              style: AllHRTableHeading.customTextStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}

