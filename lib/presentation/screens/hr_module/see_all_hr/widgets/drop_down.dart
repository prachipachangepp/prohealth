import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    Key? key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xff575757)
          ),
            fillColor: Colors.white,
            filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xffB1B1B1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xffB1B1B1),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xffB1B1B1),
            ),
          ),
          // border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff575757)
            ),),
          );
        }).toList(),
        onChanged: onChanged,
        value: value,
        isExpanded: true,
      ),
    );
  }
}
