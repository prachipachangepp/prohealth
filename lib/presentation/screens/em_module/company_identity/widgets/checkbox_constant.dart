///saloni
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../widgets/button_constant.dart';
import '../../widgets/text_form_field_const.dart';

///details screen checkbox constant
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
          side: BorderSide(
            color: ColorManager.blueprime,
            width: 2.0,
          ),
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

///details screen dropdown constant
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
  GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }
  void _showCustomDropdown() async {
    final RenderBox renderBox = _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy + size.height, offset.dx + size.width, 0),
      items: widget.items.map((DropdownMenuItem<String> item) {
        return PopupMenuItem<String>(
          value: item.value,
          child: Container(
           // color: ColorManager.white,
            width: size.width - 16, ///minus padding/margin
            child: Text(item.value ?? ''),
          ),
        );
      }).toList(),
      color: ColorManager.white,
    );

    if (result != null) {
      setState(() {
        _selectedValue = result;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      key: _dropdownKey,
      width: 300,
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
              size: 18,
              color: ColorManager.blueprime,
            ),
            onPressed: widget.onEditIconTap,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          GestureDetector(
            onTap: _showCustomDropdown,
            child: Icon(Icons.arrow_drop_down),
          ),
        ],
      ),
    );
  }
}

///details screen popup constant
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
