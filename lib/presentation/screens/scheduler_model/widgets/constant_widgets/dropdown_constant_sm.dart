import 'package:flutter/material.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';

class CustomDropdownTextFieldsm extends StatefulWidget {
  final String? value;
  final List<String>? items;
  final List<DropdownMenuItem<String>>? dropDownMenuList;
  final String? hintText;
  final String headText;
  final void Function(String?)? onChanged;
  final double? width;
  final double? widthone;
  final double? height;
  final String? initialValue;

  const CustomDropdownTextFieldsm({
    Key? key,
    this.dropDownMenuList,
    required this.headText,
    this.value,
    this.items,
    this.onChanged,
    this.width,
    this.widthone,
    this.height,
    this.initialValue,
    this.hintText,
  }) : super(key: key);

  @override
  _CustomDropdownTextFieldsmState createState() =>
      _CustomDropdownTextFieldsmState();
}

class _CustomDropdownTextFieldsmState extends State<CustomDropdownTextFieldsm> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value ?? widget.initialValue;
  }

  void _showDropdownDialog() async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final result = await showDialog<String>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: widget.width ?? size.width,
                  constraints: BoxConstraints(
                    maxHeight: 250, // Restrict height for scroll
                  ),
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.items?.length ?? widget.dropDownMenuList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = widget.items != null
                            ? widget.items![index]
                            : widget.dropDownMenuList![index].value;
                        return ListTile(
                          title: Text(
                            item!,
                            style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(item);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedValue = result;
        widget.onChanged?.call(result);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.headText,
            style: AllPopupHeadings.customTextStyle(context),
          ),
        ),
        SizedBox(
          // width: widget.widthone,
          height:widget.height ?? AppSize.s30,
          child: GestureDetector(
            onTap: _showDropdownDialog,
            child: Container(
              padding: const EdgeInsets.only(bottom: 3, top: 4, left: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedValue ?? widget.hintText ?? 'Select',
                    style: DocumentTypeDataStyle.customTextStyle(context),
                  ),
                  Icon(Icons.arrow_drop_down_sharp, color: ColorManager.blueprime,),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}