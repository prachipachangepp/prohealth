import 'package:flutter/material.dart';
///done by saloni
class IconButtonWidget extends StatelessWidget {
  final IconData iconData;
  final String buttonText;
  final Color iconColor;
  final Color textColor;
  final Function onPressed;

  const IconButtonWidget({
    Key? key,
    required this.iconData,
    required this.buttonText,
    required this.onPressed,
    this.iconColor = const Color(0xFF1696C8),
    this.textColor = const Color(0xFF1696C8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: IconButton(
        style: IconButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.width/100), // Adjust vertical padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Color(0xFF50B5E5)),
          ),
        ),
        onPressed: () => onPressed(),
        icon: Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: MediaQuery.of(context).size.width/100,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 200,
            ),
            Text(
              buttonText,
              style: TextStyle(
                fontFamily: 'FiraSans',
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.width / 150,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
