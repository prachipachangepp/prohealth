import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

class CustomRadioListTile extends StatefulWidget {
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final String title;

  const CustomRadioListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  _CustomRadioListTileState createState() => _CustomRadioListTileState();
}

class _CustomRadioListTileState extends State<CustomRadioListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
        ),
        const SizedBox(width: 0),
        Text(
          widget.title,
          style: GoogleFonts.firaSans(
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
            color: const Color(0xff9B9B9B),
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
