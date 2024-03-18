import 'package:flutter/material.dart';
///done by saloni
///button constant for circularborder with text and with/without icon
class CustomIconButton extends StatelessWidget {
  final String text;
  final IconData? icon; // Making icon property nullable
  final VoidCallback onPressed;

  const CustomIconButton({
    required this.text,
    this.icon, // Making icon property nullable
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon!, color: Colors.white, size: 20) : SizedBox.shrink(), // Conditionally include the icon
      label: Text(
        text,
        style: TextStyle(
          fontFamily: 'FiraSans',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        backgroundColor: Color(0xFF50B5E5),
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

///button constant with white bg, colored text
class CustomButtonTransparent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtonTransparent({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'FiraSans',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF50B5E5),
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Color(0xFF50B5E5)),
        ),
      ),
    );
  }
}
