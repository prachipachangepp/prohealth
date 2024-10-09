import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/login_resources/login_flow_theme_const.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/widgets/app_clickable_widget.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../app/resources/theme_manager.dart';

///done by saloni
///button constant for circularborder with text and with/without icon
class CustomIconButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final Future<void> Function() onPressed;

   CustomIconButton({
     this.textColor,
    required this.text,
    this.icon,
    required this.onPressed,
    Key? key,  this.color,
  }) : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}


class _CustomIconButtonState extends State<CustomIconButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator( color: ColorManager.blueprime,)
        :ElevatedButton.icon(
      onPressed: () async{
          await widget.onPressed();
      },
      icon: widget.icon != null
          ? Icon(widget.icon!, color: Colors.white, size: 20)
          : const SizedBox.shrink(),
      label: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeight.w500,
              color: widget.textColor == null ?ColorManager.white:widget.textColor)),
      style: ElevatedButton.styleFrom(
        padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        backgroundColor:  widget.color == null ? Color(0xFF50B5E5) : widget.color,
        // shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5
      ),
    );
  }
}

///button constant with white bg, colored text
class CustomButtonTransparent extends StatefulWidget {
  final String text;
   VoidCallback onPressed;
  final double? height;
  final double? width;

   CustomButtonTransparent({
    required this.text,
    required this.onPressed,
     this.height,
     this.width,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomButtonTransparent> createState() => _CustomButtonTransparentState();
}

class _CustomButtonTransparentState extends State<CustomButtonTransparent> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator( color: ColorManager.blueprime,)
        :SizedBox(height: AppSize.s35,width: AppSize.s100,

          child: ElevatedButton(
                onPressed: () async{
          setState(() {
            isLoading = true;
          });
          try {
            await widget.onPressed;
          } finally {
            setState(() {
              isLoading = false;
            });
          }
          Navigator.pop(context);
          },
                style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          backgroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF50B5E5)),
          ),
                ),
                child: Text(
          widget.text,
          style: LoginFlowBase.customTextStyle(context)
                ),
              ),
        );
  }
}

class CustomeTransparentAddShift extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  const CustomeTransparentAddShift(
      {super.key, required this.text, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: MediaQuery.of(context).size.height / 30,
          width: MediaQuery.of(context).size.width / 17,
          decoration: BoxDecoration(
              border: Border.all(color: ColorManager.blueprime),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.add,
                  color: ColorManager.blueprime,
                  size: 15),
              Text(
                text,
                style: TransparentButtonTextConst.customTextStyle(context),
              ),
            ],
          )),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color backgroundColor; // Added parameter for background color
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double width;
  final double height;
  final TextStyle? style;
  final Widget? child;

  const CustomButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF50B5E5), // Default background color
    this.textColor = Colors.white,
    this.borderRadius = 14.0,
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 16.0,
    this.width = 50,
    this.height = 50.0,
    this.style,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      color: textColor,
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
    );
    final mergedTextStyle = defaultTextStyle.merge(style);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          const BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Utilizing the backgroundColor parameter
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal,
          ),
        ),
        child: text != null
            ? Text(text!, textAlign: TextAlign.center, style: mergedTextStyle)
            : child,
      ),
    );
  }
}

///CustomTitleButton
class CustomTitleButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;
  final String text;
  final bool isSelected;

  CustomTitleButton({
    required this.height,
    required this.width,
    required this.onPressed,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: isSelected ? 4 : 0,
      borderRadius: BorderRadius.circular(12),
      color: ColorManager.white,
      child: AppClickableWidget(
        onTap: onPressed,
        onHover: (bool val) {},
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff51B5E6),
                      Color(0xff008ABD),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                )
              : null,
          child: Text(
            text,
            style: CustomTextStylesCommon.commonStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeight.w700,
              color: isSelected ? ColorManager.white : ColorManager.textPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// DZone button
class DZoneButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
   DZoneButton({super.key,required this.isSelected,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s32,
      height: AppSize.s25,
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.blueprime : ColorManager.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            'DZ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FontSize.s13,
              fontWeight: FontWeight.w600,
              color: isSelected ? ColorManager.white : ColorManager.black,
            ),
          ),
        ),
      ),
    );
  }
}

