import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../../em_module/widgets/text_form_field_const.dart';




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
              labelStyle:onlyFormDataStyle.customTextStyle(context),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: padding
          ),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style:onlyFormDataStyle.customTextStyle(context),
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

/// us phone number
///
class CustomTextFieldRegisterPhone extends StatelessWidget {
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
  final TextStyle? hintStyle;
  final TextStyle? prefixStyle;
  final String? prefixText;
  final double? cursorHeight;
  final int? maxLength;


  CustomTextFieldRegisterPhone({
    Key? key,
   // Default to false
    this.maxLength,
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
    this.cursorHeight,
    this.onTap,
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
            labelText: labelText,
            labelStyle: DocumentTypeDataStyle.customTextStyle(context),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: padding,
          ),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style:DocumentTypeDataStyle.customTextStyle(context),
          obscureText: obscureText,
          autofocus: autofocus,
          enabled: enabled,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: [
            PhoneNumberInputFormatter(),
          ],
        ),
      ),
    );
  }
}
///
class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    final StringBuffer newText = StringBuffer();

    text = text.replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters

    if (text.length > 10) {
      text = text.substring(0, 10);
    }

    // newText.write('+1 ');
    // Add formatting based on length
    if (text.length > 0) {
      newText.write('(');
    }
    if (text.length > 3) {
      newText.write('${text.substring(0, 3)}) ');
      text = text.substring(3);
    }
    if (text.length > 3) {
      newText.write('${text.substring(0, 3)}-');
      text = text.substring(3);
    }
    newText.write(text);

    return newValue.copyWith(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
///
///








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
  final TextStyle? hintStyle;
  final TextStyle? prefixStyle;
  final String? prefixText;
  final double? cursorHeight;
  final int? maxLength;
  final bool capitalIsSelect;
  final bool? phoneNumberField;

  CustomTextFieldRegister({
    Key? key,
    this.phoneNumberField = false,
    this.capitalIsSelect = false, // Default to false
    this.maxLength,
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
    this.cursorHeight,
    this.onTap,
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
            labelText: labelText,
            labelStyle: DocumentTypeDataStyle.customTextStyle(context),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: padding,
          ),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style:DocumentTypeDataStyle.customTextStyle(context),
          obscureText: obscureText,
          autofocus: autofocus,
          enabled: enabled,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: phoneNumberField! ?[PhoneNumberInputFormatter()]:[
            if (capitalIsSelect) CapitalizeFirstLetterFormatter(), // Apply formatter conditionally
            LengthLimitingTextInputFormatter(maxLength),
          ],
        ),
      ),
    );
  }
}







///enroll popup only
///

///normal textfield
class CustomTextFieldEnroll extends StatelessWidget {
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


  CustomTextFieldEnroll({
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
              labelStyle:onlyFormDataStyle.customTextStyle(context),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: padding
          ),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: onlyFormDataStyle.customTextStyle(context),
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










////terminate popup
class FirstHRTextFConst extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onChange;
  final bool? enable;
  final Widget? prefixWidget;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormated;

  FirstHRTextFConst({
    Key? key,
    this.inputFormated,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464),
    this.icon,
    this.onChange,
    this.readOnly,
    this.enable,
    this.validator,
    this.prefixWidget,
  }) : super(key: key);

  @override
  State<FirstHRTextFConst> createState() => _FirstHRTextFConstState();
}

class _FirstHRTextFConstState extends State<FirstHRTextFConst> {
  @override
  Widget build(BuildContext context) {
    String? errorText;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: ConstTextFieldStyles.customTextStyle(textColor: widget.textColor),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 300,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFB1B1B1), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
                autofocus: true,
                enabled: widget.enable == null ? true : false,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                cursorHeight: 17,
                cursorColor: Colors.black,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  suffixIcon: widget.icon,
                  prefix: widget.prefixWidget,
                  prefixStyle:AllHRTableData.customTextStyle(context),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                      bottom: AppPadding.p18, left: AppPadding.p15),
                ),
                style: DocumentTypeDataStyle.customTextStyle(context),
                //validator: widget.validator,
                onTap: widget.onChange,
                inputFormatters: widget.inputFormated == null
                    ? [
                  CapitalizeFirstLetterFormatter(),
                ]
                    : widget.inputFormated
            ),
          ),
        ],
      ),
    );
  }
}
















//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
//
// class CustomTextFieldRegister extends StatelessWidget {
//   final TextEditingController? controller;
//   final String? labelText;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final bool obscureText;
//   final bool autofocus;
//   final bool enabled;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final ValueChanged<String>? onChanged;
//   final FormFieldValidator<String>? validator;
//   final FocusNode? focusNode;
//   final ValueChanged<String>? onFieldSubmitted;
//   final EdgeInsetsGeometry? padding;
//   final double? width;
//   final double? height;
//   final double? cursorHeight;
//   final bool isDropdown; // New parameter to indicate dropdown
//   final List<String>? dropdownItems; // New parameter for dropdown items
//
//   const CustomTextFieldRegister({
//     Key? key,
//     this.controller,
//     this.labelText,
//     this.keyboardType,
//     this.textInputAction,
//     this.obscureText = false,
//     this.autofocus = false,
//     this.enabled = true,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.onChanged,
//     this.validator,
//     this.focusNode,
//     this.onFieldSubmitted,
//     this.padding,
//     this.width,
//     this.height,
//     this.cursorHeight,
//     this.isDropdown = false, // Default to false
//     this.dropdownItems, // Initialize the dropdown items
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: Padding(
//         padding: const EdgeInsets.all(1.0),
//         child: isDropdown && dropdownItems != null
//             ? DropdownButtonFormField<String>(
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xffB1B1B1)),
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             labelText: labelText,
//             labelStyle: TextStyle(fontSize: FontSize.s10),
//             prefixIcon: prefixIcon,
//             suffixIcon: suffixIcon,
//             contentPadding: padding,
//           ),
//           value: dropdownItems!.isNotEmpty ? dropdownItems![0] : null,
//           items: dropdownItems!.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Flexible(
//                 child: Text(value,
//                   overflow: TextOverflow.ellipsis,
//                 style: GoogleFonts.firaSans(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400
//                 ),),
//               ),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             controller?.text = newValue ?? '';
//             onChanged?.call(newValue ?? '');
//           },
//           validator: validator,
//           icon: SizedBox.shrink(),
//         )
//             : TextFormField(
//           controller: controller,
//           cursorHeight: cursorHeight,
//           cursorColor: Colors.black,
//           cursorWidth: 1.5,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xffB1B1B1)),
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             labelText: labelText,
//             labelStyle: TextStyle(fontSize: FontSize.s10),
//             prefixIcon: prefixIcon,
//             suffixIcon: suffixIcon,
//             contentPadding: padding,
//           ),
//           keyboardType: keyboardType,
//           textInputAction: textInputAction,
//           style: TextStyle(fontSize: FontSize.s12),
//           obscureText: obscureText,
//           autofocus: autofocus,
//           enabled: enabled,
//           onChanged: onChanged,
//           validator: validator,
//           focusNode: focusNode,
//           onFieldSubmitted: onFieldSubmitted,
//         ),
//       ),
//     );
//   }
// }
