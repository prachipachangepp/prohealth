import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../app/resources/color.dart';

// class SchedularTextField extends StatelessWidget {
//   final String labelText;
//   final String? initialValue;
//   final bool isDate;
//
//   const SchedularTextField({
//     Key? key,
//     required this.labelText,
//     this.initialValue,
//     this.isDate = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _controller = TextEditingController(text: initialValue);
//
//     Future<void> _selectDate(BuildContext context) async {
//       final DateTime? selectedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2101),
//       );
//
//       if (selectedDate != null) {
//         _controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//       }
//     }
//
//     return SizedBox(
//       height: 25.38,
//       child: TextFormField(
//         textCapitalization: TextCapitalization.sentences,
//         controller: _controller,
//         style: GoogleFonts.firaSans(
//           fontSize: 12,
//           fontWeight: FontWeight.w400,
//           color: ColorManager.black,
//         ),
//         cursorColor: ColorManager.black,
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: GoogleFonts.firaSans(
//             fontSize: 10,
//             color: ColorManager.greylight, // label text color
//           ),
//           border: const OutlineInputBorder(),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: ColorManager.containerBorderGrey), // border color
//           ),
//           suffixIcon: isDate
//               ? Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime) // calendar color
//               : null,
//         ),
//         readOnly: isDate,
//         onTap: isDate
//             ? () async {
//           await _selectDate(context);
//         }
//             : null,
//         onChanged: (text) {
//           if (!isDate && text.isNotEmpty && text[0] != text[0].toUpperCase()) {
//             _controller.value = _controller.value.copyWith(
//               text: text[0].toUpperCase() + text.substring(1),
//               selection: TextSelection.collapsed(offset: text.length),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
///
// class SchedularTextField extends StatefulWidget {
//   final String labelText;
//   final String? initialValue;
//   // final bool isDate;
//   final controller ;
//   final Icon? suffixIcon;
//   TextEditingController? Datecontroller;
//
//   const SchedularTextField({
//     Key? key,
//     required this.labelText,
//     this.initialValue,
//     // this.isDate = false,
//     this.controller,
//     this.suffixIcon, this.Datecontroller,
//   }) : super(key: key);
//
//   @override
//   _SchedularTextFieldState createState() => _SchedularTextFieldState();
// }
//
// class _SchedularTextFieldState extends State<SchedularTextField> {
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: widget.initialValue);
//   }
//
//   // Future<void> _selectDate(BuildContext context) async {
//   //   final DateTime? selectedDate = await showDatePicker(
//   //     context: context,
//   //     initialDate: DateTime.now(),
//   //     firstDate: DateTime(2000),
//   //     lastDate: DateTime(2101),
//   //   );
//   //
//   //   if (selectedDate != null) {
//   //     _controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 25.38,
//         child: TextFormField(
//           textCapitalization: TextCapitalization.sentences,
//           controller: _controller,
//           style: GoogleFonts.firaSans(
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//             color: ColorManager.black,
//           ),
//           cursorColor: ColorManager.black,
//           decoration: InputDecoration(
//             labelText: widget.labelText,
//             labelStyle: GoogleFonts.firaSans(
//               fontSize: 10,
//               color: ColorManager.greylight,
//             ),
//             border: OutlineInputBorder(),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: ColorManager.containerBorderGrey),
//             ),
//
//             suffixIcon:GestureDetector(
//               onTap: () async {
//                 // Open the date picker when the calendar icon is tapped
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime(2101),
//                 );
//
//                 if (pickedDate != null) {
//                   // Format the date and set it into the text field
//                   String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                   widget.Datecontroller = formattedDate;
//                 }
//               },
//               child: widget.suffixIcon,
//             ),
//           ),
//         ));
//
//
//     //         widget.isDate
//     //             ? Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime)
//     //             : null,
//     //       ),
//     //       readOnly: widget.isDate,
//     //       onTap: widget.isDate
//     //           ? () async {
//     //         await _selectDate(context);
//     //       }
//     //           : null,
//     //       onChanged: (text) {
//     //         if (!widget.isDate && text.isNotEmpty && text[0] != text[0].toUpperCase()) {
//     //           _controller.value = _controller.value.copyWith(
//     //             text: text[0].toUpperCase() + text.substring(1),
//     //             selection: TextSelection.collapsed(offset: text.length),
//     //           );
//     //         }
//     //       },
//     //     ),
//     //   );
//     // }
//
//   }
// }
class SchedularTextField extends StatefulWidget {
  final String labelText;
  final String? initialValue;
  final TextEditingController? controller;
  final Icon? suffixIcon;
  final FormFieldValidator<String>? validator;

  const SchedularTextField({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.controller,
    this.suffixIcon, this.validator,
  }) : super(key: key);

  @override
  _SchedularTextFieldState createState() => _SchedularTextFieldState();
}

class _SchedularTextFieldState extends State<SchedularTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: _controller,
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorManager.black,
        ),
        cursorColor: ColorManager.black,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
            color: ColorManager.greylight,
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.containerBorderGrey),
          ),
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
            onTap: () async {
              // Open the date picker when the calendar icon is tapped
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                // Format the date and set it into the text field
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                _controller.text = formattedDate;
              }
            },
            child: widget.suffixIcon,
          )
              : null,
          // Do not show any icon if suffixIcon is null
      ),
        validator: widget.validator,
      )
    );
  }
}
