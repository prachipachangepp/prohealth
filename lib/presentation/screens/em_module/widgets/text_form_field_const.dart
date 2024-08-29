import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../app/resources/font_manager.dart';
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
  final VoidCallback? onChange;


  EditTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464), this.icon,  this.onChange, this.readOnly,
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
            readOnly: false,
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

