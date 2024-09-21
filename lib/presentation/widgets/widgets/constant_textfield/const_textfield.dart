import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../../app/resources/value_manager.dart';

///textfield constant widget
///todo prachi
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? height;
  final double cursorHeight;
  final String labelText;
  final TextStyle labelStyle;
  final double labelFontSize;
  final Icon? suffixIcon;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTapSuffixIcon;
  final void Function(String)? onChanged;

  CustomTextField({
    this.width,
    this.height,
    required this.cursorHeight,
    required this.labelText,
    required this.labelStyle,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    this.focusNode,
    required this.labelFontSize,
    this.onTapSuffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s250,
      height: AppSize.s40,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p5),
        child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          textAlign: TextAlign.start,
          style: GoogleFonts.firaSans(
              fontSize: AppSize.s12,
              color: ColorManager.mediumgrey,
              fontWeight: FontWeightManager.regular),
          textAlignVertical: TextAlignVertical.center,
          cursorHeight: cursorHeight,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3, top: AppPadding.p5, left: 4),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
            ),
            labelText: labelText,
            labelStyle: labelStyle.copyWith(fontSize: labelFontSize),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p14),
              child: suffixIcon,
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

///drop down text field
///todo prachi
class CustomDropdownTextField extends StatefulWidget {
  final String? value;
  final List<String>? items;
  final List<DropdownMenuItem<String>>? dropDownMenuList;
  final String labelText;
  final String? hintText;
  final TextStyle? labelStyle;
  final double? labelFontSize;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;
  final String? initialValue;

  const CustomDropdownTextField({
    Key? key,
    this.dropDownMenuList,
    this.value,
    this.items,
    required this.labelText,
    this.labelStyle,
    this.labelFontSize,
    this.onChanged,
    this.width,
    this.height,
    this.initialValue,
    this.hintText,
  }) : super(key: key);

  @override
  _CustomDropdownTextFieldState createState() =>
      _CustomDropdownTextFieldState();
}

class _CustomDropdownTextFieldState extends State<CustomDropdownTextField> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s250,
      height: AppSize.s40,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p5),
        child: DropdownButtonFormField<String>(
          icon:
              Icon(Icons.arrow_drop_down_sharp, color: ColorManager.blueprime),
          value: _selectedValue,
          items: widget.dropDownMenuList == null
              ? widget.items!.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        color: Color(0xff575757),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList()
              : widget.dropDownMenuList,
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
          isExpanded: true,
          decoration: InputDecoration(
            hoverColor: ColorManager.white,
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3, top: AppPadding.p5, left: 4),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
            ),
            labelText: widget.labelText,
            labelStyle:
                widget.labelStyle?.copyWith(fontSize: widget.labelFontSize),
          ),
        ),
      ),
    );
  }
}

class CustomDropDown extends StatefulWidget {
  final String? value;
  final List<String> items;
  final String labelText;
  final String? hintText;
  final TextStyle? labelStyle;
  final double? labelFontSize;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;
  final String? initialValue;
  CustomDropDown({
    super.key,
    this.value,
    required this.items,
    required this.labelText,
    this.labelStyle,
    this.labelFontSize,
    this.onChanged,
    this.width,
    this.height,
    this.initialValue,
    this.hintText,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 354,
      height: AppSize.s40,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p5),
        child: DropdownButtonFormField<String>(
          icon:
              Icon(Icons.arrow_drop_down_sharp, color: ColorManager.blueprime),
          value: _selectedValue,
          items: widget.items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.firaSans(
                  fontSize: 12,
                  color: Color(0xff575757),
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3, top: AppPadding.p5, left: AppPadding.p2),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
            ),
            labelText: widget.labelText,
            labelStyle:
                widget.labelStyle?.copyWith(fontSize: widget.labelFontSize),
          ),
        ),
      ),
    );
  }
}

///todo prachi
///Human Resource screen textField email only
class HRManageTextFieldEmail extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onChange;
  final double? width;
  final double? height;
  final double cursorHeight;
  final String labelText;
  final TextStyle labelStyle;
  final double labelFontSize;
  final Icon? suffixIcon;
  final Widget? suffix;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final String? errorText;

  final String? Function(String?)? validator;
  // final bool Function(String)? validator;
  final ValueChanged<String>? onChanged;

  HRManageTextFieldEmail({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464),
    this.icon,
    this.onChange,
    this.readOnly,
    this.width,
    this.height,
    required this.cursorHeight,
    required this.labelText,
    required this.labelStyle,
    required this.labelFontSize,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.errorText,
    this.onChanged,
    this.validator,
    this.suffix,
    // this.validator,
  }) : super(key: key);

  @override
  State<HRManageTextFieldEmail> createState() => _HRManageTextFieldEmailState();
}

class _HRManageTextFieldEmailState extends State<HRManageTextFieldEmail> {
  late bool hasError;

  @override
  void initState() {
    super.initState();
    hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p5),
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          textAlign: TextAlign.start,
          style: DocumentTypeDataStyle.customTextStyle(context),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: ColorManager.black,
          textInputAction: TextInputAction.next,
          // cursorHeight: widget.cursorHeight,
          // validator: validator,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'This field cannot be empty';
          //   }
          //   return null;
          // },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3, top: AppPadding.p5, left: AppPadding.p5),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle.copyWith(
                fontSize: widget.labelFontSize, color: ColorManager.mediumgrey),
            errorText: hasError ? widget.errorText : null,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p14),
              child: widget.suffixIcon,
            ),
            suffix: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p20),
              child: widget.suffix,
            ),
          ),
        ),
      ),
    );
  }
}

///Human Resource screen textField normal
class HRManageTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onChange;
  final double? width;
  final double? height;
  final double cursorHeight;
  final String labelText;
  final TextStyle labelStyle;
  final double labelFontSize;
  final Icon? suffixIcon;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final String? errorText;
  final String? Function(String?)? validator;
  // final bool Function(String)? validator;
  final ValueChanged<String>? onChanged;
  bool? enabled;

  HRManageTextField({
    Key? key,
    this.enabled,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464),
    this.icon,
    this.onChange,
    this.readOnly,
    this.width,
    this.height,
    required this.cursorHeight,
    required this.labelText,
    required this.labelStyle,
    required this.labelFontSize,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.errorText,
    this.onChanged,
    this.validator,
    // this.validator,
  }) : super(key: key);

  @override
  State<HRManageTextField> createState() => _HRManageTextFieldState();
}

class _HRManageTextFieldState extends State<HRManageTextField> {
  late bool hasError;

  @override
  void initState() {
    super.initState();
    hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p5),
        child: TextFormField(
          enabled: widget.enabled == null ? true : false,
          focusNode: widget.focusNode,
          controller: widget.controller,
          textAlign: TextAlign.start,
          style: DocumentTypeDataStyle.customTextStyle(context),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: ColorManager.black,
          textInputAction: TextInputAction.next,
          // cursorHeight: widget.cursorHeight,
          // validator: validator,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'This field cannot be empty';
          //   }
          //   return null;
          // },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3, top: AppPadding.p5, left: AppPadding.p5),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle.copyWith(
                fontSize: widget.labelFontSize,
                color: ColorManager.mediumgrey),
            errorText: hasError ? widget.errorText : null,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p14),
              child: widget.suffixIcon,
            ),
          ),
          inputFormatters: [
            CapitalizeFirstLetterFormatter(),
          ],
        ),
      ),
    );
  }
}

///drop down User

class HRManageDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextStyle labelStyle;
  final double labelFontSize;
  final List<String> items;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  HRManageDropdown({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.labelStyle,
    required this.labelFontSize,
    required this.items,
    this.errorText,
    this.onChanged,
  }) : super(key: key);

  @override
  State<HRManageDropdown> createState() => _HRManageDropdownState();
}

class _HRManageDropdownState extends State<HRManageDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: DropdownButtonFormField<String>(
          value: widget.controller.text.isEmpty ? null : widget.controller.text,
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.firaSans(
                  fontSize: 10,
                  fontWeight: FontWeightManager.medium,
                  color: ColorManager.mediumgrey,
                ),

                // TextStyle(
                //   fontSize: MediaQuery.of(context).size.width / 130,
                //   color: Color(0xff686464),
                // ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.controller.text = value!;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value!);
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: 3.0, top: 5.0, left: 5.0), // Adjust padding
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle.copyWith(
                fontSize: widget.labelFontSize, color: ColorManager.mediumgrey),

            // errorText: widget.errorText,
            // validator: validator,
          ),
        ),
      ),
    );
  }
}

///
class PatientCustomDropDown extends StatefulWidget {
  final String? value;
  final List<String> items;
  final String labelText;
  final String? hintText;
  final TextStyle? labelStyle;
  final double? labelFontSize;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;
  final String? initialValue;
  PatientCustomDropDown({
    super.key,
    this.value,
    required this.items,
    required this.labelText,
    this.labelStyle,
    this.labelFontSize,
    this.onChanged,
    this.width,
    this.height,
    this.initialValue,
    this.hintText,
  });

  @override
  State<PatientCustomDropDown> createState() => _PatientCustomDropDownState();
}

class _PatientCustomDropDownState extends State<PatientCustomDropDown> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: const Color(0xff686464).withOpacity(0.5),
            width: 1), // Black border
        borderRadius: BorderRadius.circular(6), // Rounded corners
      ),
      height: 31,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      child: DropdownButtonFormField<String>(
          icon: Icon(Icons.arrow_drop_down_sharp, color: ColorManager.black),
          value: _selectedValue,
          items: widget.items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.firaSans(
                  fontSize: 12,
                  color: Color(0xff575757),
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
          style: GoogleFonts.firaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xff686464),
            decoration: TextDecoration.none,
          ),
          isExpanded: true,
          decoration: const InputDecoration.collapsed(hintText: '')),
    );
  }
}
