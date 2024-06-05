import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../widgets/button_constant.dart';
import '../../../../widgets/text_form_field_const.dart';

class CCScreensAddPopup extends StatefulWidget {
  final TextEditingController countynameController;
  final TextEditingController zipcodeController;
  final VoidCallback onSavePressed;
  final Widget child;
  final Widget child1;
  const CCScreensAddPopup(
      {super.key,
      required this.countynameController,
      required this.zipcodeController,
      required this.onSavePressed, required this.child, required this.child1});

  @override
  State<CCScreensAddPopup> createState() => _CCScreensAddPopusState();
}

class _CCScreensAddPopusState extends State<CCScreensAddPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s420,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
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
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.countynameController,
                    keyboardType: TextInputType.text,
                    text: 'Name of the Document',
                  ),
                  SizedBox(height: AppSize.s8),
                  SMTextFConst(
                    controller: widget.zipcodeController,
                    keyboardType: TextInputType.text,
                    text: 'ID of the Document',
                  ),
                  SizedBox(height: AppSize.s8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Type of the Document',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      //decoration: TextDecoration.none,
                    ),
                    ),
                    SizedBox(height: 5,),
                    widget.child
                  ],),
                  SizedBox(height: AppSize.s12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Sub Type of the Document',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.mediumgrey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: 5,),
                    widget.child1
                  ],),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.save,
                  onPressed: () {
                    widget.onSavePressed();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///dropdown constant
class CICCDropdown extends StatefulWidget {
  final List<DropdownMenuItem<String>> items;
  final String? initialValue;

  const CICCDropdown({
    Key? key,
    required this.items,
    this.initialValue,
  }) : super(key: key);

  @override
  _CIDetailsDropdownState createState() => _CIDetailsDropdownState();
}

class _CIDetailsDropdownState extends State<CICCDropdown> {
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
          GestureDetector(
            onTap: _showCustomDropdown,
            child: Icon(Icons.arrow_drop_down),
          ),
        ],
      ),
    );
  }
}
