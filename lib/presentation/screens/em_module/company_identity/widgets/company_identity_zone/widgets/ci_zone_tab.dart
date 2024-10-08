// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// import '../../../../../../../app/resources/color.dart';
// import '../../../company_identity_screen.dart';
//
// class CiZonePageView extends StatefulWidget {
//   const CiZonePageView({super.key});
//
//   @override
//   State<CiZonePageView> createState() => _CiZonePageViewState();
// }
//
// class _CiZonePageViewState extends State<CiZonePageView> {
//   final PageController _tabPageController = PageController();
//   int _selectedIndex = 0;
//
//   void _selectButton(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _tabPageController.animateToPage(
//       index,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 530,
//                 height: 30,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     InkWell(
//                       onTap: () => _selectButton(0),
//                       child: Column(
//                         children: [
//                           Text(
//                             "License",
//                             style: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               fontWeight: _selectedIndex == 0 ? FontWeight.w700 : FontWeight.normal,
//                               color: _selectedIndex == 0 ?  ColorManager.blueprime : Color(0xff686464),
//                             ),
//                           ),
//                           Container(
//                             height: 2,
//                             width: 45,
//                             color: _selectedIndex == 0 ?  ColorManager.blueprime : Colors.transparent,
//                           ),
//                         ],
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => _selectButton(1),
//                       child: Column(
//                         children: [
//                           Text(
//                             "ADR",
//                             style: GoogleFonts.firaSans(
//                                 fontSize: 12,
//                                 fontWeight: _selectedIndex == 1 ? FontWeight.w700 : FontWeight.normal,
//                                 color: _selectedIndex == 1 ?  ColorManager.blueprime :Color(0xff686464)
//                             ),
//                           ),
//                           Container(
//                             height: 2,
//                             width: 60,
//                             color: _selectedIndex == 1 ?  ColorManager.blueprime : Colors.transparent,
//                           ),
//                         ],
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => _selectButton(2),
//                       child: Column(
//                         children: [
//                           Text(
//                             "Medical Cost Reporter",
//                             style: GoogleFonts.firaSans(
//                                 fontSize: 12,
//                                 fontWeight: _selectedIndex == 2 ? FontWeight.w700 : FontWeight.normal,
//                                 color: _selectedIndex == 2 ? ColorManager.blueprime :Color(0xff686464)
//                             ),
//                           ),
//                           Container(
//                             height: 2,
//                             width: 130,
//                             color: _selectedIndex == 2 ? ColorManager.blueprime: Colors.transparent,
//                           ),
//                         ],
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => _selectButton(3),
//                       child: Column(
//                         children: [
//                           Text(
//                             "Cap Report",
//                             style: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               fontWeight: _selectedIndex == 3 ? FontWeight.w700 : FontWeight.normal,
//                               color: _selectedIndex == 3 ? ColorManager.blueprime : Color(0xff686464),
//                             ),
//                           ),
//                           Container(
//                             height: 2,
//                             width: 70,
//                             color: _selectedIndex == 3 ? ColorManager.blueprime : Colors.transparent,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     InkWell(
//                       onTap: () => _selectButton(4),
//                       child: Column(
//                         children: [
//                           Text(
//                             "Quarterly Balance Report",
//                             style: GoogleFonts.firaSans(
//                                 fontSize: 12,
//                                 fontWeight: _selectedIndex == 4 ? FontWeight.w700 : FontWeight.normal,
//                                 color: _selectedIndex == 4 ?  ColorManager.blueprime :Color(0xff686464)
//                             ),
//                           ),
//                           Container(
//                             height: 2,
//                             width: 150,
//                             color: _selectedIndex == 4 ?  ColorManager.blueprime: Colors.transparent,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
