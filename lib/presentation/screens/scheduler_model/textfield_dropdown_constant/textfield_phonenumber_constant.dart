// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
//
// import '../../../../app/resources/color.dart';
//
//
// class TextfieldPhonenumberConstant extends StatefulWidget {
//   final String labelText;
//   final String? initialValue;
//   final TextEditingController? controller;
//   final Icon? suffixIcon;
//   final FormFieldValidator<String>? validator;
//
//   const TextfieldPhonenumberConstant({
//     Key? key,
//     required this.labelText,
//     this.initialValue,
//     this.controller,
//     this.suffixIcon, this.validator,
//   }) : super(key: key);
//
//   @override
//   _TextfieldPhonenumberConstantState createState() => _TextfieldPhonenumberConstantState();
// }
//
// class _TextfieldPhonenumberConstantState extends State<TextfieldPhonenumberConstant> {
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 25.38,
//         child: TextFormField(
//           textCapitalization: TextCapitalization.sentences,
//           controller: _controller,
//           style: GoogleFonts.firaSans(
//             fontSize: FontSize.s12,
//             fontWeight: FontWeightManager.regular,
//             color: ColorManager.black,
//           ),
//           cursorColor: ColorManager.black,
//           decoration: InputDecoration(
//             labelText: widget.labelText,
//             labelStyle: GoogleFonts.firaSans(
//               fontSize: FontSize.s10,
//               color: ColorManager.greylight,
//             ),
//             border: const OutlineInputBorder(),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: ColorManager.containerBorderGrey),
//             ),
//             suffixIcon: widget.suffixIcon != null
//                 ? GestureDetector(
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
//                   _controller.text = formattedDate;
//                 }
//               },
//               child: widget.suffixIcon,
//             )
//                 : null,
//             // Do not show any icon if suffixIcon is null
//           ),
//           validator: widget.validator,
//         )
//     );
//   }
// }


//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import '../../../../app/resources/color.dart';
//
// class TextfieldPhonenumberConstant extends StatefulWidget {
//   final String labelText;
//   final String? initialValue;
//   final TextEditingController? controller;
//   final Icon? suffixIcon;
//   final FormFieldValidator<String>? validator;
//
//   const TextfieldPhonenumberConstant({
//     Key? key,
//     required this.labelText,
//     this.initialValue,
//     this.controller,
//     this.suffixIcon,
//     this.validator,
//   }) : super(key: key);
//
//   @override
//   _TextfieldPhonenumberConstantState createState() =>
//       _TextfieldPhonenumberConstantState();
// }
//
// class _TextfieldPhonenumberConstantState
//     extends State<TextfieldPhonenumberConstant> {
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         widget.controller ?? TextEditingController(text: widget.initialValue);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60, // Increase height to accommodate error message
//       child: TextFormField(
//         keyboardType: TextInputType.phone, // Set keyboard type to phone
//         controller: _controller,
//         style: GoogleFonts.firaSans(
//           fontSize: FontSize.s12,
//           fontWeight: FontWeightManager.regular,
//           color: ColorManager.black,
//         ),
//         cursorColor: ColorManager.black,
//         decoration: InputDecoration(
//           labelText: widget.labelText,
//           labelStyle: GoogleFonts.firaSans(
//             fontSize: FontSize.s10,
//             color: ColorManager.greylight,
//           ),
//           border: const OutlineInputBorder(),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: ColorManager.containerBorderGrey),
//           ),
//           suffixIcon: widget.suffixIcon != null
//               ? GestureDetector(
//             onTap: () async {
//               // Open the date picker when the calendar icon is tapped
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(1900),
//                 lastDate: DateTime(2101),
//               );
//
//               if (pickedDate != null) {
//                 // Format the date and set it into the text field
//                 String formattedDate =
//                 DateFormat('yyyy-MM-dd').format(pickedDate);
//                 _controller.text = formattedDate;
//               }
//             },
//             child: widget.suffixIcon,
//           )
//               : null,
//         ),
//         validator: widget.validator ?? (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter ${widget.labelText}';
//           } else if (value.length != 10) {
//             return 'Please Enter Valid Number';
//           } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//             return 'Please Enter Valid Number';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
