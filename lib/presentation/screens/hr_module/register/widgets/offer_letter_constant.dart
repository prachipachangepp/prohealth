import 'package:flutter/material.dart';


import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';


class CustomTextFieldOfferScreen extends StatefulWidget {
  final TextEditingController controller;
  //final String labelText;
  final double? height;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  CustomTextFieldOfferScreen({required this.controller,
    //required this.labelText,
    this.height,this.validator,this.onChanged, this.hintText});

  @override
  State<CustomTextFieldOfferScreen> createState() => _CustomTextFieldOfferScreenState();
}

class _CustomTextFieldOfferScreenState extends State<CustomTextFieldOfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30, //widget.height,
      width: MediaQuery.of(context).size.width / 5,
      child: TextFormField(
        readOnly: true,
        style: DocumentTypeDataStyle.customTextStyle(context),
        onChanged: widget.onChanged,
        cursorColor: Colors.black,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, bottom: 5),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          hintText: widget.hintText, // Add your hint text here
          hintStyle: onlyFormDataStyle.customTextStyle(context), // Optional: customize hint text style
          labelStyle: DocumentTypeDataStyle.customTextStyle(context),
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashRadius: 1,
            icon: Icon(Icons.calendar_month, color: ColorManager.blueprime, size: 16),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(3000),
              );
              if (pickedDate != null) {
                widget.controller.text = "${pickedDate.toLocal()}".split(' ')[0];
              }
            },
          ),
        ),
      ),
    );

  }
}



///

class CustomDropdownFormField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final double? height;

  const CustomDropdownFormField({
    Key? key,
    required this.hintText,
    this.labelText,
    required this.items,
    this.value,
    this.height,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropdownFormField> createState() => _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String? selectedValue;
  @override
  void initState() {

    super.initState();
    selectedValue = widget
        .value;
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: widget.height,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: AppPadding.p3, top: AppPadding.p5, left: 4),

          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle:DocumentTypeDataStyle.customTextStyle(context),
          labelText: widget.labelText,
          labelStyle:const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xff686464),
          ),
        ),
        value: widget.value,
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item,
            style:DocumentTypeDataStyle.customTextStyle(context),),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        icon: Icon(Icons.arrow_drop_down, color: ColorManager.mediumgrey),
      ),
    );
  }
}






////

class CustomDropdownTextFieldpadding extends StatefulWidget {
  final String? value;
  final List<String>? items;
  final List<DropdownMenuItem<String>>? dropDownMenuList;
  final String? hintText;

  final void Function(String?)? onChanged;
  final double? width;
  final double? widthone;
  final double? height;
  final String? initialValue;

  const CustomDropdownTextFieldpadding({
    Key? key,
    this.dropDownMenuList,

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
  _CustomDropdownTextFieldpaddingState createState() =>
      _CustomDropdownTextFieldpaddingState();
}

class _CustomDropdownTextFieldpaddingState extends State<CustomDropdownTextFieldpadding> {
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
        SizedBox(
          // width: widget.widthone,
          height:widget.height ?? AppSize.s30,
          child: GestureDetector(
            onTap: _showDropdownDialog,
            child: Container(
              padding: const EdgeInsets.only(bottom: 3, top: 5, left: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      _selectedValue ?? widget.hintText ?? 'Select',
                      style: DocumentTypeDataStyle.customTextStyle(context),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down_sharp, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
///
///
///