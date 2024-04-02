import 'package:flutter/material.dart';

///done by saloni
///button constant for circularborder with text and with/without icon
class CustomIconButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    required this.text,
    this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null
          ? Icon(icon!, color: Colors.white, size: 20)
          : SizedBox.shrink(),
      label: Text(
        text,
        textAlign: TextAlign.center,
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
          borderRadius: BorderRadius.circular(20),
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

///custombutton size managebleimport 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  // final Color color;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double width;
  final double height;
  final TextStyle style;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    // this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 14.0,
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 16.0,
    this.width = double.infinity,
    this.height = 50.0,
     this.style = const TextStyle(color: Colors.white),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF50B5E5),
          onPrimary: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal,
          ),
        ),
        child: Text(text,style: style,),
      ),
    );
  }
}
