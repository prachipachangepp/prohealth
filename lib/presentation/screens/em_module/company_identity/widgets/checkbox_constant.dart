import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../widgets/button_constant.dart';
import '../../widgets/text_form_field_const.dart';

class CheckboxConstant extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String text;

  const CheckboxConstant({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  _CheckboxConstantState createState() => _CheckboxConstantState();
}

class _CheckboxConstantState extends State<CheckboxConstant> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: ColorManager.blueprime,
          value: _value,
          onChanged: (newValue) {
            setState(() {
              _value = newValue!;
            });
            widget.onChanged(newValue);
          },
        ),
        Text(widget.text),
      ],
    );
  }
}

///
class CIDetailsDropdown extends StatefulWidget {
  final List<DropdownMenuItem<String>> items;
  final String? initialValue;
  final VoidCallback onEditIconTap;

  const CIDetailsDropdown({
    Key? key,
    required this.items,
    this.initialValue,
    required this.onEditIconTap,
  }) : super(key: key);

  @override
  _CIDetailsDropdownState createState() => _CIDetailsDropdownState();
}

class _CIDetailsDropdownState extends State<CIDetailsDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFB1B1B1), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(
            child: Text(
              _selectedValue ?? '',
              style: GoogleFonts.firaSans(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w700,
                color: ColorManager.mediumgrey,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              size: 20,
            ),
            onPressed: widget.onEditIconTap,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              style:  GoogleFonts.firaSans(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.mediumgrey,
                  decoration: TextDecoration.none,
                ),
              value: _selectedValue,
              icon: Icon(Icons.arrow_drop_down),
              onChanged: (newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
              },
              items: widget.items,
              selectedItemBuilder: (BuildContext context) {
                return widget.items
                    .map<Widget>((DropdownMenuItem<String> item) {
                  return Container(); // This makes the dropdown button show empty space for the selected value
                }).toList();
              },
            ),
          ),

          ///menu icon
          // PopupMenuButton<String>(
          //   offset: Offset(0, 30), // Adjust the offset as needed
          //   itemBuilder: (BuildContext context) {
          //     return widget.items.map((item) {
          //       return PopupMenuItem<String>(
          //         value: item.value,
          //         child: SizedBox(
          //           width: 200, // Set your desired width here
          //           child: Text(item.value ?? ''),
          //         ),
          //       );
          //     }).toList();
          //   },
          //   onSelected: (String? value) {
          //     setState(() {
          //       _selectedValue = value;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}

class CIDetailsDropdownPopup extends StatefulWidget {
  final TextEditingController hcoNumController;
  final TextEditingController medicareController;
  final TextEditingController npiNumController;
  final VoidCallback onSavePressed;

  CIDetailsDropdownPopup({
    required this.onSavePressed,
    required this.hcoNumController,
    required this.medicareController,
    required this.npiNumController,
  });

  @override
  State<CIDetailsDropdownPopup> createState() => _CIDetailsDropdownPopupState();
}

class _CIDetailsDropdownPopupState extends State<CIDetailsDropdownPopup> {
  bool checkboxValue1 = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: AppSize.s400,
          width: AppSize.s350,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p3, horizontal: AppPadding.p20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SMTextFConst(
                        controller: widget.hcoNumController,
                        keyboardType: TextInputType.text,
                        text: AppStringEM.hcoNumber),
                    SizedBox(
                      height: AppSize.s16,
                    ),
                    SMTextFConst(
                        controller: widget.hcoNumController,
                        keyboardType: TextInputType.text,
                        text: AppStringEM.medicareid),
                    SizedBox(
                      height: AppSize.s16,
                    ),
                    SMTextFConst(
                        controller: widget.hcoNumController,
                        keyboardType: TextInputType.text,
                        text: AppStringEM.npinum),
                    SizedBox(
                      height: AppSize.s16,
                    ),
                    Row(
                      children: [
                        Text(
                          AppStringEM.emabled,
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        CheckboxConstant(value: checkboxValue1,
                            onChanged: (newValue){
                          setState(() {
                            checkboxValue1 = newValue!;
                          });
                            }, text: ''),
                      ],
                    ),

                  ]),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p40),
              child: Center(
                child: CustomElevatedButton(
                    width: AppSize.s105,
                    height: AppSize.s30,
                    text: AppStringEM.save,
                    onPressed: () {
                      widget.onSavePressed;
                      Navigator.pop(context);
                    }),
              ),
            )
          ]),
        ));
  }
}
