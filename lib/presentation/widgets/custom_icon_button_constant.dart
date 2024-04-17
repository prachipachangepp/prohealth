import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///saloni
class CustomIconButtonConst extends StatelessWidget {
  final String text;
  final IconData? icon; // Making icon property nullable
  final VoidCallback onPressed;

  const CustomIconButtonConst({
    required this.text,
    this.icon, // Making icon property nullable
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null
          ? Icon(icon!, color: Colors.white, size: 20)
          : SizedBox.shrink(), // Conditionally include the icon
      label: Text(
        text,
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        )
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        backgroundColor: Color(0xFF50B5E5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        shadowColor: Color(0xff000000).withOpacity(0.4)
      ),
    );
  }
}
