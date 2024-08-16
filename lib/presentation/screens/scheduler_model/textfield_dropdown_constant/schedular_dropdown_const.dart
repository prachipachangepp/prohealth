//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../app/resources/color.dart';
// import '../../../../app/resources/font_manager.dart';
// import '../../../../app/resources/value_manager.dart';
//
// class SchedularDropdown extends StatelessWidget {
//   final String labelText;
//   final List<String>? items;
//   final String? initialValue;
//
//   const SchedularDropdown({
//     super.key,
//     required this.labelText,
//     this.items,
//     this.initialValue,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 25.38,
//       child: DropdownButtonFormField<String>(
//         value: initialValue,
//         style: GoogleFonts.firaSans(
//           fontSize: AppSize.s12,
//           fontWeight: FontWeightManager.regular,
//           color: ColorManager.black,
//         ),
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: GoogleFonts.firaSans(
//             fontSize: 10,
//             fontWeight: FontWeightManager.regular,
//             color: ColorManager.greylight, // text color in dropdown
//           ),
//           border: OutlineInputBorder(),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0XFFB1B1B1)),                                   // border color
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
//         ),
//         items: items?.map((value) => DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         )).toList(),
//         onChanged: (value) {
//           // Handle dropdown change
//         },
//         icon: Padding(
//           padding:  EdgeInsets.only(right: 8),
//           child: Align(
//             alignment: Alignment.center,
//             child: Icon(
//               Icons.arrow_drop_down,
//               color: ColorManager.blueprime,                                                 // dropdown icon color
//               size: 24,                                                                      // size of icon
//             ),
//           ),
//         ),
//         isDense: true,
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/value_manager.dart';

class SchedularDropdown extends StatefulWidget {
  final String labelText;
  final List<String>? items;
  final String? initialValue;
  // final controller;

  const SchedularDropdown({
    super.key,
    required this.labelText,
    this.items,
    this.initialValue,
    // this.controller,
  });

  @override
  _SchedularDropdownState createState() => _SchedularDropdownState();
}

class _SchedularDropdownState extends State<SchedularDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize the selected value with the initial value if provided
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      child: DropdownButtonFormField<String>(
        value: _selectedValue,
        style: GoogleFonts.firaSans(
          fontSize: AppSize.s12,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.greylight, // text color in dropdown
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.containerBorderGrey), // border color
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        ),
        items: widget.items?.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
        },
        icon: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_drop_down,
              color: ColorManager.blueprime, // dropdown icon color
              size: AppSize.s24, // size of icon
            ),
          ),
        ),
        isDense: true,
      ),
    );
  }
}
