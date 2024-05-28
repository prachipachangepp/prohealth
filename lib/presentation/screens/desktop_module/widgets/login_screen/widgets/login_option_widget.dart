// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
//
// import '../../../../../../app/resources/color.dart';
//
// class LoginOptionWidget extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) handleSelected;
//
//   const LoginOptionWidget({
//     Key? key,
//     required this.selectedIndex,
//     required this.handleSelected,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: MediaQuery.of(context).size.width / 120,
//         vertical: MediaQuery.of(context).size.width / 150,
//       ),
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(MediaQuery.of(context).size.width / 120),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildOption(
//               context,
//               AppString.loginemail,
//               0,
//               selectedIndex,
//               handleSelected,
//             ),
//             _buildOption(
//               context,
//               AppString.loginauth,
//               1,
//               selectedIndex,
//               handleSelected,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOption(
//     BuildContext context,
//     String text,
//     int index,
//     int selectedIndex,
//     Function(int) handleSelected,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         handleSelected(index);
//       },
//       child: Column(
//         children: [
//           Text(
//             text,
//             style: GoogleFonts.firaSans(
//               color: selectedIndex == index
//                   ? ColorManager.blueprime
//                   : const Color(0xff686464),
//               fontSize: MediaQuery.of(context).size.width / 90,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: AppSize.s5),
//           Container(
//             width: MediaQuery.of(context).size.width / (index == 0 ? 10.5 : 7),
//             height: 3,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(13),
//               boxShadow: selectedIndex == index
//                   ? [
//                       BoxShadow(
//                         color: Color(0xff000000).withOpacity(0.4),
//                         offset: Offset(1, 3),
//                         blurRadius: 4,
//                       ),
//                     ]
//                   : [],
//               color: selectedIndex == index
//                   ? ColorManager.blueprime
//                   : Colors.transparent,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
