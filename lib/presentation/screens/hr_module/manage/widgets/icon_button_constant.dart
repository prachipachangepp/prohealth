import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

import '../../../../../app/resources/value_manager.dart';
///done by saloni
class IconButtonWidget extends StatelessWidget {
  final IconData? iconData;
  final IconData? iconData1;
  final String buttonText;
  final Color iconColor;
  final Color textColor;
  final Function onPressed;
  final double? width;

  const IconButtonWidget({
    Key? key,
    this.iconData,
    this.width,
    required this.buttonText,
    required this.onPressed,
    this.iconColor = const Color(0xFF1696C8),
    this.textColor = const Color(0xFF1696C8), this.iconData1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:30,
      width: width,
      child: IconButton(
        style: IconButton.styleFrom(
          padding: EdgeInsets.symmetric(
              horizontal: 15), // Adjust vertical padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(width: 1, color: ColorManager.calandercolour),
          ),
        ),
        onPressed: () => onPressed(),
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData == null ? Offstage():
            Icon(
              iconData,
              color: iconColor,
              size: 15,
            ),
            iconData == null ? Offstage(): SizedBox(
              width: 20,
            ),
            Text(
              buttonText,
              style: TextStyle(

                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: textColor,
              ),
            ),
            iconData1 == null ? Offstage():
            SizedBox(
              width: 9,
            ),
            iconData1 == null ? Offstage():
            Icon(
              iconData1,
              color: iconColor,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}


class BorderIconButton extends StatelessWidget {
  final IconData iconData;
  final String buttonText;
  final VoidCallback onPressed;
  const BorderIconButton({super.key, required this.iconData, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s25,
      width: AppSize.s70,
      decoration: BoxDecoration(border: Border.all(
          color: ColorManager.blueprime
      ),borderRadius:BorderRadius.circular(8)),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconData == null ? Offstage():
              Icon(
                iconData,
                color: ColorManager.bluebottom,
                size: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 200,
              ),
              Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize:10,
                  color: ColorManager.bluebottom,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 200,
              ),
              // iconData1 == null ? Offstage():
              // Icon(
              //   iconData1,
              //   color: Color(0xFF1696C8),
              //   size: MediaQuery.of(context).size.width/100,
              // ),

          ],),
        ),
      ),
    );
  }
}

