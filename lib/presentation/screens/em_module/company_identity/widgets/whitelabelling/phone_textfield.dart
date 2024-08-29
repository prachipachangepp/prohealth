import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:google_fonts/google_fonts.dart';


class PhoneNumberInput extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController countryCodeController;
  final String labelText;
  final Color textColor;
  final Icon? icon;
  final bool? enable;
  final Widget? prefixWidget;
  final String? Function(String?)? validator;

  PhoneNumberInput({
    Key? key,
    required this.phoneController,
    required this.countryCodeController,
    required this.labelText,
    this.textColor = const Color(0xff686464),
    this.icon,
    this.enable,
    this.prefixWidget,
    this.validator,
  }) : super(key: key);

  @override
  State<PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
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
          height: 60, // Increased height for better UI
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFB1B1B1), width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              setState(() {
                widget.phoneController.text = number.phoneNumber ?? '';
                widget.countryCodeController.text = number.isoCode ?? '';
              });
            },
            onInputValidated: (bool isValid) {
              print(isValid ? 'Valid' : 'Invalid');
            },
            selectorConfig: SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            initialValue: PhoneNumber(isoCode: 'US'), // Default country code
            textFieldController: widget.phoneController,
            formatInput: true,
            keyboardType: TextInputType.number,
            inputBorder: OutlineInputBorder(),
            selectorTextStyle: TextStyle(color: Colors.black),
            textStyle: TextStyle(color: Colors.black),
            inputDecoration: InputDecoration(
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
          ),
        ),
      ],
    );
  }
}