import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

///for emailid only
class CustomTextFieldForEmail extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool autofocus;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  VoidCallback? onTap;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final String? hintText;
  final hintStyle;
  final prefixStyle;
  final String? prefixText;
  final double? cursorHeight;


  CustomTextFieldForEmail({
    Key? key,
    this.controller,
    this.labelText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.autofocus = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.prefixText,
    this.prefixStyle,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.padding,
    this.width,
    this.height,
    this.cursorHeight, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextFormField(
          controller: controller,
          cursorHeight: cursorHeight,
          cursorColor: Colors.black,
          cursorWidth: 1.5,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              prefixText: prefixText,
              prefixStyle: prefixStyle,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color(0xffB1B1B1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color(0xffB1B1B1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color(0xffB1B1B1),
                ),
              ),
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(color: Color(0xffB1B1B1)),
              //   borderRadius: BorderRadius.circular(5.0),
              // ),
              labelText: labelText,
              labelStyle: GoogleFonts.firaSans(
                fontSize: FontSize.s10,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: padding
          ),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
          ),
          obscureText: obscureText,
          autofocus: autofocus,
          enabled: enabled,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,


        ),
      ),
    );
  }
}



///normal textfield
class CustomTextFieldRegister extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool autofocus;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
   VoidCallback? onTap;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final String? hintText;
  final hintStyle;
  final prefixStyle;
  final String? prefixText;
  final double? cursorHeight;


   CustomTextFieldRegister({
    Key? key,
    this.controller,
    this.labelText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.autofocus = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.prefixText,
    this.prefixStyle,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.padding,
    this.width,
    this.height,
    this.cursorHeight, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextFormField(
          controller: controller,

          cursorHeight: cursorHeight,
          cursorColor: Colors.black,
          cursorWidth: 1.5,
          decoration: InputDecoration(
            hintText: hintText,
              hintStyle: hintStyle,
              prefixText: prefixText,
              prefixStyle: prefixStyle,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color(0xffB1B1B1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color(0xffB1B1B1),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Color(0xffB1B1B1),
                ),
              ),
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(color: Color(0xffB1B1B1)),
              //   borderRadius: BorderRadius.circular(5.0),
              // ),
              labelText: labelText,
              labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
          ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: padding
          ),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
          ),
          obscureText: obscureText,
          autofocus: autofocus,
          enabled: enabled,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: [
            CapitalizeFirstLetterFormatter(),
          ],

        ),
      ),
    );
  }
}

///normal txtfield first letter const
class CapitalizeFirstLetterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // If the new text is empty or just whitespace, return it as is
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Capitalize the first letter
    final String newText = newValue.text.substring(0, 1).toUpperCase() +
        newValue.text.substring(1);

    // Return the updated text value
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
