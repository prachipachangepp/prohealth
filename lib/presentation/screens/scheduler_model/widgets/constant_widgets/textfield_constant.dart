import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

/////Schedular PopUp Textfield constant///////
class PopUpTextField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final bool isDate;
  final bool isTime;

  PopUpTextField({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.isDate = false,
    this.isTime = false,
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

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final now = DateTime.now();
        final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        _controller.text = DateFormat('HH:mm').format(selectedDateTime);
      }
    }

    return SizedBox(
      height: AppSize.s30,
      child: TextFormField(
        controller: _controller,
        style: GoogleFonts.firaSans(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        cursorColor: ColorManager.black,
        decoration: InputDecoration(
          labelText: '',
          labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.greylight,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          suffixIcon: isDate
              ? Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime)
              : isTime
              ? Icon(Icons.access_time_filled, color: ColorManager.blueprime)
              : null,
        ),
        readOnly: isDate || isTime,
        onTap: isDate
            ? () async {
          await _selectDate(context);
        }
            : isTime
            ? () async {
          await _selectTime(context);
        }
            : null,
      ),
    );
  }
}


class PopUpDropdown extends StatelessWidget {
  final String labelText;
  final String? initialValue;

  const PopUpDropdown({
    super.key,
    required this.labelText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s30, // DROPDOWN CONTAINER HEIGHT
      child: DropdownButtonFormField<String>(
        value: initialValue,
        style: GoogleFonts.firaSans(
          fontSize: FontSize.s10,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        decoration: InputDecoration(
          labelText: '',
          labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.greylight,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
        ),
        items: [initialValue ?? '']
            .map((value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ))
            .toList(),
        onChanged: (value) {
          // Handle dropdown change
        },
        icon: Icon(
          Icons.arrow_drop_down,
          color: ColorManager.blueprime, // dropdown icon color
          size: FontSize.s24, // size of icon
        ),
        isDense: false, // Adjust the density of the dropdown
      ),
    );
  }
}
