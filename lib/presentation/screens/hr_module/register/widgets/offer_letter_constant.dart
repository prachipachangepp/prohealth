import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/resources/color.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final double? height;

  CustomTextField({required this.controller, required this.labelText, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
              color: Color(0xff575757)),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_month, color: Color(0xff686464)),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                controller.text = "${pickedDate.toLocal()}".split(' ')[0];
              }
            },
          ),
        ),
      ),
    );
  }
}




class CustomDropdownFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final double height;

  const CustomDropdownFormField({
    Key? key,
    required this.hintText,
    this.labelText,
    required this.items,
    this.value,
    this.height = 26,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: GoogleFonts.firaSans(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: Color(0xff686464),
        ),
        labelText: labelText,
        labelStyle: GoogleFonts.firaSans(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: Color(0xff686464),
        ),
      ),
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
    );
  }
}

