import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/value_manager.dart';


class CustomTextFieldOfferScreen extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final double? height;

  CustomTextFieldOfferScreen({required this.controller, required this.labelText, this.height});

  @override
  State<CustomTextFieldOfferScreen> createState() => _CustomTextFieldOfferScreenState();
}

class _CustomTextFieldOfferScreenState extends State<CustomTextFieldOfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,//widget.height,
      width: MediaQuery.of(context).size.width / 5,
      child: TextFormField(
        readOnly: true,
        style: GoogleFonts.firaSans(
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            color: Color(0xff575757)) ,

        cursorColor: Colors.black,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20,bottom: 5),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          labelText: widget.labelText,
          labelStyle: GoogleFonts.firaSans(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
              color: Color(0xff575757)),
          suffixIcon: IconButton(
            icon: Icon(Icons.calendar_month, color: Color(0xff686464),size: 16,),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
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
              contentPadding: EdgeInsets.only(bottom: AppPadding.p3, top: AppPadding.p5, left: 4),

          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: GoogleFonts.firaSans(
            fontSize: 10.0,
            fontWeight: FontWeight.w400,
            color: Color(0xff686464),
          ),
          labelText: widget.labelText,
          labelStyle: GoogleFonts.firaSans(
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
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff575757)
            ),),
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
        icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
      ),
    );
  }
}

