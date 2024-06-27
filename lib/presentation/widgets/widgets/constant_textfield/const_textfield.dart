import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:prohealth/app/resources/color.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: AppSize.s250,
        height: AppSize.s40,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p5),
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 130),
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: cursorHeight,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: AppPadding.p3, top: AppPadding.p5, left: AppPadding.p2),
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
          ),
        ),
      ),
    );
  }
}

///drop down text field
///todo prachi
class CustomDropdownTextField extends StatefulWidget {
  final String? value;
  final List<String> items;
  final String labelText;
  final TextStyle? labelStyle;
  final double? labelFontSize;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;

  const CustomDropdownTextField({
    Key? key,
    this.value,
    required this.items,
    required this.labelText,
    this.labelStyle,
    this.labelFontSize,
    this.onChanged,
    this.width,
    this.height,
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
    return Flexible(
      child: SizedBox(
        width: AppSize.s250,
        height: AppSize.s40,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p5),
          child: DropdownButtonFormField<String>(
            icon: Icon(Icons.arrow_drop_down_sharp, color: ColorManager.blueprime),
            value: _selectedValue,
            items: widget.items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
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
              contentPadding: EdgeInsets.only(bottom: AppPadding.p3, top: AppPadding.p5, left: AppPadding.p2),
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
      ),
    );
  }
}
///todo prachi
///Human Resource screen textField
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

  HRManageTextField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464), this.icon,
    this.onChange, this.readOnly, this.width, this.height,
    required this.cursorHeight, required this.labelText,
    required this.labelStyle, required this.labelFontSize, this.suffixIcon,
    this.prefixIcon, this.focusNode, this.errorText, this.onChanged, this.validator,
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
      width: 250,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p5),
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 130),
          textAlignVertical: TextAlignVertical.center,
          cursorHeight: widget.cursorHeight,
          // validator: validator,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'This field cannot be empty';
          //   }
          //   return null;
          // },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: AppPadding.p3,
                top: AppPadding.p5, left: AppPadding.p2),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle.copyWith(fontSize: widget.labelFontSize),
            errorText: hasError ? widget.errorText : null,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p14),
              child: widget.suffixIcon,
            ),
          ),
        )
        ,
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
      width: 250,
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
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 130,
                  color: Color(0xff686464),
                ),
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
                bottom: 3.0, top: 5.0, left: 2.0), // Adjust padding
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle.copyWith(
              fontSize: widget.labelFontSize,
            ),

            // errorText: widget.errorText,
            // validator: validator,
          ),
        ),
      ),
    );
  }
}
