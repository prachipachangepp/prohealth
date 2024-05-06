import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';

import '../../../app/resources/value_manager.dart';

///prachi to do textfield constant widget
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
  final FocusNode focusNode;

  CustomTextField({
    this.width,
    this.height,
    required this.cursorHeight,
    required this.labelText,
    required this.labelStyle,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    required this.focusNode,
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

///drop down text field prachi to do

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