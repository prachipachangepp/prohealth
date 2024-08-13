import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../app/resources/color.dart';

class DoubleDatePickerTextField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final bool isDate;

  DoubleDatePickerTextField({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.isDate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _dateController = TextEditingController(text: initialValue);

    Future<void> _selectDateRange(BuildContext context) async {
      DateTimeRange? selectedDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(Duration(days: 1)),
        ),
      );

      if (selectedDateRange != null) {
        _dateController.text =
        "${DateFormat('yyyy-MM-dd').format(selectedDateRange.start)}    to   ${DateFormat('yyyy-MM-dd').format(selectedDateRange.end)}";
      }
    }

    return SizedBox(
      height: 25.38,
      child: TextFormField(
        controller: isDate ? _dateController : TextEditingController(text: initialValue),
        style: GoogleFonts.firaSans(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        cursorColor: ColorManager.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
            color: ColorManager.greylight, // label text color
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.containerBorderGrey), // border color
          ),
          suffixIcon: isDate
              ? Icon(
              Icons.calendar_month_outlined,
              color: ColorManager.blueprime) // calendar color
              : null,
        ),
        readOnly: isDate,
        onTap: isDate
            ? () async {
          await _selectDateRange(context);
        }
            : null,
      ),
    );
  }
}

