import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../app/resources/color.dart';

class SchedularTextField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final bool isDate;

  const SchedularTextField({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.isDate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(text: initialValue);

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (selectedDate != null) {
        _controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    }

    return SizedBox(
      height: 25.38,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: _controller,
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorManager.black,
        ),
        cursorColor: ColorManager.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
            color: ColorManager.greylight, // label text color
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.containerBorderGrey), // border color
          ),
          suffixIcon: isDate
              ? Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime) // calendar color
              : null,
        ),
        readOnly: isDate,
        onTap: isDate
            ? () async {
          await _selectDate(context);
        }
            : null,
        onChanged: (text) {
          if (!isDate && text.isNotEmpty && text[0] != text[0].toUpperCase()) {
            _controller.value = _controller.value.copyWith(
              text: text[0].toUpperCase() + text.substring(1),
              selection: TextSelection.collapsed(offset: text.length),
            );
          }
        },
      ),
    );
  }
}