import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../app/resources/value_manager.dart';




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
             // contentPadding: padding
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3,
                top: AppPadding.p4,
                left: AppPadding.p12
            ),
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
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3,
                top: AppPadding.p4,
                left: AppPadding.p12
            ),
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
            //contentPadding: padding,
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


// class HRMamangeFlowTextfield extends StatelessWidget {
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
//   VoidCallback? onTap;
//   final FocusNode? focusNode;
//   final ValueChanged<String>? onFieldSubmitted;
//   final EdgeInsetsGeometry? padding;
//   final double? width;
//   final double? height;
//   final String? hintText;
//   final String text;
//   final TextStyle? hintStyle;
//   final TextStyle? prefixStyle;
//   final String? prefixText;
//   final double? cursorHeight;
//   final int? maxLength;
//   final bool capitalIsSelect;
//   final bool readOnly;
//   final bool? phoneNumberField;
//   HRMamangeFlowTextfield({
//     Key? key,
//     this.phoneNumberField = false,
//     this.capitalIsSelect = false, // Default to false
//     this.maxLength,
//     this.controller,
//     this.labelText,
//     this.keyboardType,
//     this.textInputAction,
//     this.obscureText = false,
//     this.autofocus = false,
//     this.enabled = true,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.hintText,
//     this.hintStyle,
//     this.prefixText,
//     this.prefixStyle,
//     this.onChanged,
//     this.validator,
//     this.focusNode,
//     this.onFieldSubmitted,
//     this.padding,
//     this.width,
//     this.height,
//     this.cursorHeight,
//     this.onTap,
//     this.readOnly = false, required this.text,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(
//             text: text, // Main text
//             style: AllPopupHeadings.customTextStyle(context), // Main style
//             children: [
//               TextSpan(
//                 text: ' *', // Asterisk
//                 style: AllPopupHeadings.customTextStyle(context).copyWith(
//                   color: ColorManager.red, // Asterisk color
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Text(
//         //   widget.text,
//         //   style: AllPopupHeadings.customTextStyle(context),
//         // ),
//         SizedBox(
//           height: 4,
//         ),
//         SizedBox(
//           width: width,
//           height: height,
//           child: Padding(
//             padding: const EdgeInsets.all(1.0),
//             child: TextFormField(
//               controller: controller,
//               cursorHeight: cursorHeight,
//               cursorColor: Colors.black,
//               cursorWidth: 1.5,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(
//                     bottom: AppPadding.p3,
//                     top: AppPadding.p4,
//                     left: AppPadding.p12
//                 ),
//                 hintText: hintText,
//                 hintStyle: hintStyle,
//                 prefixText: prefixText,
//                 prefixStyle: prefixStyle,
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                   borderSide:  BorderSide(
//                     color: Color(0xFFB1B1B1),
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                   borderSide:  BorderSide(
//                     color: Color(0xFFB1B1B1),
//                   ),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                   borderSide:  BorderSide(
//                     color: Color(0xFFB1B1B1),
//                   ),
//                 ),
//                 labelText: labelText,
//                 labelStyle: DocumentTypeDataStyle.customTextStyle(context),
//                 prefixIcon: prefixIcon,
//                 suffixIcon: suffixIcon,
//                 //contentPadding: padding,
//               ),
//               keyboardType: keyboardType,
//               textInputAction: textInputAction,
//               style:DocumentTypeDataStyle.customTextStyle(context),
//               obscureText: obscureText,
//               autofocus: autofocus,
//               enabled: enabled,
//               onTap: onTap,
//               onChanged: onChanged,
//               validator: validator,
//               focusNode: focusNode,
//               readOnly: readOnly,
//               onFieldSubmitted: onFieldSubmitted,
//               inputFormatters: capitalIsSelect ? [
//                 //CapitalizeFirstLetterFormatter()
//               ]:phoneNumberField! ? [PhoneNumberInputFormatter()] : [],
//
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }






///first letter capital
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
  final bool readOnly;
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
    this.readOnly = false,
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
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3,
                top: AppPadding.p4,
                left: AppPadding.p12
            ),
            hintText: hintText,
            hintStyle: hintStyle,
            prefixText: prefixText,
            prefixStyle: prefixStyle,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:  BorderSide(
                color: Color(0xFFB1B1B1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:  BorderSide(
                color: Color(0xFFB1B1B1),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:  BorderSide(
                color: Color(0xFFB1B1B1),
              ),
            ),
            labelText: labelText,
            labelStyle: DocumentTypeDataStyle.customTextStyle(context),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            //contentPadding: padding,
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
          readOnly: readOnly,
          onFieldSubmitted: onFieldSubmitted,
          inputFormatters: capitalIsSelect ? [
            //CapitalizeFirstLetterFormatter()
          ]:phoneNumberField! ? [PhoneNumberInputFormatter()] : [],

        ),
      ),
    );
  }
}


///normal textfield
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
                  //CapitalizeFirstLetterFormatter(),
                ]
                    : widget.inputFormated
            ),
          ),
        ],
      ),
    );
  }
}

///ssn number
class CustomTextFieldSSn extends StatelessWidget {
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

  CustomTextFieldSSn({
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: 15,
              horizontal: 5
            ),
            hintText: hintText,
            hintStyle: hintStyle,
            prefixText: prefixText,
            prefixStyle: prefixStyle,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:  BorderSide(
                color: Color(0xFFB1B1B1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:  BorderSide(
                color: Color(0xFFB1B1B1),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide:  BorderSide(
                color: Color(0xFFB1B1B1),
              ),
            ),
            labelText: labelText,
            labelStyle: DocumentTypeDataStyle.customTextStyle(context),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            //contentPadding: padding,
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
            FilteringTextInputFormatter.digitsOnly, // Only allow digits
            LengthLimitingTextInputFormatter(9), // Limit to 9 digits
          ],

        ),
      ),
    );
  }
}