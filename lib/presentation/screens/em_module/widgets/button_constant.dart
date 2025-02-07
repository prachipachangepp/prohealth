import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/value_manager.dart';

///button constant with transparent bg, colored text
class CustomButtonTransparentSM extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtonTransparentSM({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 4,
      child: Container(
        height:AppSize.s25,
        width: AppSize.s100,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
              fontWeight: FontWeight.w500,
              color: ColorManager.blueprime,)
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: ColorManager.blueprime),
            ),
          ),
        ),
      ),
    );
  }
}

///
class CustomElevatedButton extends StatefulWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color? color;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double width;
  final double height;
  final TextStyle style;
  final Widget? child;
  final int? loadingDuration;

  const CustomElevatedButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.color,
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 16.0,
    this.width = 150,
    this.height = 35.0,
    this.style = const TextStyle(color: Colors.white),
    this.child,  this.loadingDuration,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool _isLoading = false;
  bool  _isSubmitting= false;

  void _handlePress() {
    setState(() {
      _isLoading = true;
    });

    widget.onPressed.call();
    Future.delayed(Duration(seconds: widget.loadingDuration!), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color ?? Color(0xFF1696C8),
          foregroundColor: widget.textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: widget.paddingVertical,
            horizontal: widget.paddingHorizontal,
          ),
        ),
        child: widget.text != null
            ? Text(widget.text!,
            style: BlueButtonTextConst.customTextStyle(context))
            : widget.child,
      ),
    );
  }
}
