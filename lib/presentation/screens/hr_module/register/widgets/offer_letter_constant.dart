import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/resources/color.dart';


class DropdownTextFormField extends StatefulWidget {
  final String labelText;
  final List<String> dropdownItems;
  final Function(String?) onChanged;
  final String hintText;

  const DropdownTextFormField({
    Key? key,
    required this.labelText,
    required this.dropdownItems,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _DropdownTextFormFieldState createState() => _DropdownTextFormFieldState();
}

class _DropdownTextFormFieldState extends State<DropdownTextFormField> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.labelText,
          labelStyle: GoogleFonts.firaSans(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0xff575757)),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.firaSans(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0xff575757)),
          suffixIcon: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
                widget.onChanged(newValue);
              },
              items: widget.dropdownItems
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              icon: Icon(Icons.arrow_drop_down, color: ColorManager.blueprime),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  CustomTextField({required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
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
    );
  }
}
