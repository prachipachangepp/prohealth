import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../app/resources/font_manager.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
///normal textfield

class SMTextFConst extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onChange;
  final bool ? enable;
  final Widget? prefixWidget;
  final String? Function(String?)? validator;

   SMTextFConst({
     Key? key,
    required this.controller,
    required this.keyboardType,
     required this.text,
     this.textColor = const Color(0xff686464), this.icon,  this.onChange, this.readOnly, this.enable,  this.validator, this.prefixWidget,
  }) : super(key: key);

  @override
  State<SMTextFConst> createState() => _SMTextFConstState();
}

class _SMTextFConstState extends State<SMTextFConst> {
  // late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    String? errorText;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
            fontWeight: FontWeight.w700,
            color: widget.textColor,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 5,),
        Container(
          width: 354,
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
              prefixStyle: GoogleFonts.firaSans(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xff686464),
                decoration: TextDecoration.none,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: AppPadding.p18,left: AppPadding.p15),
            ),
            style: CustomTextStylesCommon.commonStyle(
              fontWeight: FontWeightManager.medium,
              fontSize: FontSize.s12,
              color: ColorManager.mediumgrey
            ),
            //validator: widget.validator,
            onTap: widget.onChange,
            validator: widget.validator,
            // onTap: widget.onChange,

          ),
        ),
      ],
    );
  }
}



////defualt Email

class DemailSMTextFConst extends StatefulWidget {
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

  DemailSMTextFConst({
    Key? key,
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
  State<DemailSMTextFConst> createState() => _DemailSMTextFConstState();
}

class _DemailSMTextFConstState extends State<DemailSMTextFConst> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with a listener
    _controller = widget.controller;
    _controller.addListener(_updateText);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateText);
    super.dispose();
  }

  void _updateText() {
    final text = _controller.text;
    if (!text.endsWith('@prohealth.us')) {
      // Ensure that the text ends with '@gmail.com'
      _controller.value = _controller.value.copyWith(
        text: text.endsWith('@prohealth.us') ? text : '$text@prohealth.us',
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.firaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: widget.textColor,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 354,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            autofocus: true,
            enabled: widget.enable ?? true,
            controller: _controller,
            keyboardType: widget.keyboardType,
            cursorHeight: 17,
            cursorColor: Colors.black,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              suffixIcon: widget.icon,
              prefix: widget.prefixWidget,
              prefixStyle: GoogleFonts.firaSans(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xff686464),
                decoration: TextDecoration.none,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 18, left: 15),
            ),
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff686464),
            ),
            // style: TextStyle(
            //   fontWeight: FontWeight.w500,
            //   fontSize: 12,
            //   color: Color(0xff686464),
            // ),
            onTap: widget.onChange,
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}




////us phone

class SMTextFConstPhone extends StatefulWidget {
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

  SMTextFConstPhone({
    Key? key,
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
  State<SMTextFConstPhone> createState() => _SMTextFConstPhoneState();
}

class _SMTextFConstPhoneState extends State<SMTextFConstPhone> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.firaSans(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: widget.textColor,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 354,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            autofocus: true,
            enabled: widget.enable ?? true,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            cursorHeight: 17,
            cursorColor: Colors.black,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              PhoneNumberInputFormatter(),
            ],
            decoration: InputDecoration(
              suffixIcon: widget.icon,
              prefix: widget.prefixWidget,
              prefixStyle: GoogleFonts.firaSans(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xff686464),
                decoration: TextDecoration.none,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 18, left: 15),
            ),
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff686464),
            ),
            validator: widget.validator,
            onTap: widget.onChange,
          ),
        ),
      ],
    );
  }
}





class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
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


//
// class PhoneNumberInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue,
//       ) {
//     // Remove any non-numeric characters
//     final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
//
//     // Limit to 10 digits
//     final newLength = newText.length > 10 ? 10 : newText.length;
//
//     return TextEditingValue(
//       text: newText.substring(0, newLength),
//       selection: newValue.selection.copyWith(
//         baseOffset: newLength,
//         extentOffset: newLength,
//       ),
//     );
//   }
// }


//
//
//
// class PhoneNumberInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     String text = newValue.text;
//     final StringBuffer newText = StringBuffer();
//
//     // Remove non-digit characters
//     text = text.replaceAll(RegExp(r'\D'), '');
//
//     // Limit to 10 digits
//     if (text.length > 10) {
//       text = text.substring(0, 10);
//     }
//
//     // Add +1 country code
//    // newText.write('+1 ');
//
//     // Add formatting based on length
//     if (text.length > 0) {
//       newText.write('(');
//     }
//     if (text.length > 3) {
//       newText.write('${text.substring(0, 3)}) ');
//       text = text.substring(3);
//     }
//     if (text.length > 3) {
//       newText.write('${text.substring(0, 3)}-');
//       text = text.substring(3);
//     }
//     newText.write(text);
//
//     return newValue.copyWith(
//       text: newText.toString(),
//       selection: TextSelection.collapsed(offset: newText.length),
//     );
//   }
// }



//
//
// class PhoneNumberFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue) {
//     // Define the phone number pattern
//     final String newText = _formatPhoneNumber(newValue.text);
//     // Return the updated text value
//     return newValue.copyWith(
//       text: newText,
//       selection: TextSelection.collapsed(offset: newText.length),
//     );
//   }
//
//   String _formatPhoneNumber(String phoneNumber) {
//     // Remove all non-digit characters
//     final String digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
//
//     // the digits into (XXX) XXX-XXXX
//     if (digits.length >= 10) {
//       return '+1 (${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6, 10)}';
//     } else if (digits.length >= 6) {
//       return '+1 (${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
//     } else if (digits.length >= 3) {
//       return '+1 (${digits.substring(0, 3)}) ${digits.substring(3)}';
//     }
//     else if (digits.isNotEmpty) {
//       return '+1 (${digits.substring(0)}';
//     }
//     else {
//       return '+1';
//     }
//   }
// }






///first latter capital
class FirstSMTextFConst extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onChange;
  final bool ? enable;
  final Widget? prefixWidget;
  final String? Function(String?)? validator;

  FirstSMTextFConst({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464), this.icon,  this.onChange, this.readOnly, this.enable,  this.validator, this.prefixWidget,
  }) : super(key: key);

  @override
  State<FirstSMTextFConst> createState() => _FirstSMTextFConstState();
}

class _FirstSMTextFConstState extends State<FirstSMTextFConst> {
  @override
  Widget build(BuildContext context) {
    String? errorText;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
            fontWeight: FontWeight.w700,
            color: widget.textColor,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 5,),
        Container(
          width: 354,
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
              prefixStyle: GoogleFonts.firaSans(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xff686464),
                decoration: TextDecoration.none,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: AppPadding.p18,left: AppPadding.p15),
            ),
            style: CustomTextStylesCommon.commonStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s12,
                color: ColorManager.mediumgrey
            ),
            //validator: widget.validator,
            onTap: widget.onChange,
            inputFormatters: [
              CapitalizeFirstLetterFormatter(),
            ],

          ),
        ),
      ],
    );
  }
}



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




///all capital letter
class CapitalSMTextFConst extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onChange;
  final bool ? enable;
  final Widget? prefixWidget;
  final String? Function(String?)? validator;

  CapitalSMTextFConst({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464), this.icon,  this.onChange, this.readOnly, this.enable,  this.validator, this.prefixWidget,
  }) : super(key: key);

  @override
  State<CapitalSMTextFConst> createState() => _CapitalSMTextFConstState();
}

class _CapitalSMTextFConstState extends State<CapitalSMTextFConst> {
  @override
  Widget build(BuildContext context) {
    String? errorText;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
            fontWeight: FontWeight.w700,
            color: widget.textColor,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 5,),
        Container(
          width: 354,
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
              prefixStyle: GoogleFonts.firaSans(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: const Color(0xff686464),
                decoration: TextDecoration.none,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: AppPadding.p18,left: AppPadding.p15),
            ),
            style: CustomTextStylesCommon.commonStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s12,
                color: ColorManager.mediumgrey
            ),

            inputFormatters: [UppercaseTextFormatter()],
            //validator: widget.validator,
            onTap: widget.onChange,
            //textCapitalization:  TextCapitalization.characters,
          ),
        ),
      ],
    );
  }
}
////////////////////////////////

class UppercaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Convert the new text to uppercase
    final String newText = newValue.text.toUpperCase();

    // Return the updated text value with the new uppercase text
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}


// TextField(
// controller: mytext,
// onChanged: (value) {
// mytext.value = TextEditingValue(
// text: value.toUpperCase(),
// selection: mytext.selection
// );
// }
// )













///
class EditTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final bool? enabled;
  final VoidCallback? onChange;


  EditTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464), this.icon,  this.onChange, this.readOnly, this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
            fontWeight: FontWeight.w700,
            color: textColor,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 5,),
        Container(
          width: MediaQuery.of(context).size.width/5,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            enabled: enabled,
            readOnly: true,
            autofocus: true,
            controller: controller,
            keyboardType: keyboardType,
            cursorHeight: 17,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              suffixIcon: icon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: AppPadding.p18,left: AppPadding.p15),
            ),
            style: CustomTextStylesCommon.commonStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s12,
                color: ColorManager.mediumgrey
            ),
            onTap: onChange,
          ),
        ),
      ],
    );
  }
}




///phone number in edit
///
class EditTextFieldPhone extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final bool? enabled;
  final VoidCallback? onChange;


  EditTextFieldPhone({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464), this.icon,  this.onChange, this.readOnly, this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.firaSans(
            fontSize: FontSize.s12,
            fontWeight: FontWeight.w700,
            color: textColor,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 5,),
        Container(
          width: MediaQuery.of(context).size.width/5,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            inputFormatters: [
              PhoneNumberInputFormatter(),
            ],
            readOnly: true,
            autofocus: true,
            enabled: enabled,
            controller: controller,
            keyboardType: keyboardType,
            cursorHeight: 17,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              suffixIcon: icon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: AppPadding.p18,left: AppPadding.p15),
            ),
            style: CustomTextStylesCommon.commonStyle(
                fontWeight: FontWeightManager.medium,
                fontSize: FontSize.s12,
                color: ColorManager.mediumgrey
            ),
            onTap: onChange,
          ),
        ),
      ],
    );
  }
}


