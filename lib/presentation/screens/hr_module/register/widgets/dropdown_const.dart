// import 'package:flutter/material.dart';
//
// import 'package:prohealth/app/resources/color.dart';
//
// import '../../../../../app/resources/font_manager.dart';
// import '../../../../../app/resources/value_manager.dart';
//
// class MyDropdownTextField extends StatefulWidget {
//   final List<String> items;
//   final String? value;
//   final ValueChanged<String?>? onChanged;
//   final double? width;
//   final double? height;
//   final String? hint;
//
//   const MyDropdownTextField({
//     Key? key,
//     required this.items,
//     this.value,
//     this.onChanged,
//     this.width,
//     this.height,
//     this.hint,
//   }) : super(key: key);
//
//   @override
//   MyDropdownTextFieldState createState() => MyDropdownTextFieldState();
// }
//
// class MyDropdownTextFieldState extends State<MyDropdownTextField> {
//   String? selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedValue = widget
//         .value; // Initialize selectedValue with the initial value passed in
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//
//         borderRadius: BorderRadius.all(Radius.circular(4.0)),
//         border: Border.all(color: Color(0xffB1B1B1)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//         child: InputDecorator(
//           decoration: InputDecoration(
//             contentPadding:
//                 EdgeInsets.only(bottom: AppPadding.p15, left: AppPadding.p10),
//             border: InputBorder.none,
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               iconEnabledColor: Color(0xff50B5E5),
//               value: selectedValue,
//               hint: Text(
//                 widget.hint!,
//                 style: GoogleFonts.firaSans(
//                   fontSize: 12,
//                   // fontWeight: FontWeightManager.bold,
//                   //color: Color(0xff50B5E5),
//                   decoration: TextDecoration.none,
//                 ),
//               ),
//               isExpanded: true,
//               items: widget.items.map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(
//                     value,
//                     style: GoogleFonts.firaSans(
//                       fontSize: 12,
//                       //fontWeight: FontWeightManager.bold,
//                       //color: Color(0xff50B5E5),
//                       decoration: TextDecoration.none,
//                     ),
//                   ),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedValue = newValue;
//                 });
//                 if (widget.onChanged != null) {
//                   widget.onChanged!(newValue);
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
