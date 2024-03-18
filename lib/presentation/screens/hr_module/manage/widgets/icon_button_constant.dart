import 'package:flutter/material.dart';

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
    return IconButton(
      onPressed: () => onPressed(),
      icon: Row(
        children: [
          Icon(
            iconData,
            color: iconColor,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 150,
          ), // Adjust the space between the icon and text as needed
          Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'FiraSans',
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.width / 120,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
