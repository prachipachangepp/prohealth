// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/theme_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/const_field.dart';
// import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
//
// class CustomPopupConst extends StatelessWidget {
//   const CustomPopupConst({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//           width: AppSize.s900,
//           height: AppSize.s460,
//           decoration: BoxDecoration(
//             color: ColorManager.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Add Employee',
//                         style: PopupHeadingStyle.customTextStyle(context)
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(
//                           Icons.close,
//                           color: ColorManager.black,
//                         ))
//                   ],
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: CustomIconButtonConst(
//                     text: "Add Employement",
//                     onPressed: () {},
//                     icon: Icons.add,
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Wrap(
//                 //     children: [
//                 //       Column(
//                 //         children: [
//                 //           Row(
//                 //             children: [
//                 //               HrConstTextField(labelName: 'Final Position Title',),
//                 //               HrConstTextField(labelName: 'Final Position Title',),
//                 //             ],
//                 //           ),
//                 //         ],
//                 //       ),
//                 //       Column(
//                 //         children: [
//                 //           Row(
//                 //             children: [
//                 //               HrConstTextField(labelName: 'Final Position Title',),
//                 //               HrConstTextField(labelName: 'Final Position Title',),
//                 //             ],
//                 //           ),
//                 //         ],
//                 //       ),
//                 //       Column(
//                 //         children: [
//                 //           Row(
//                 //             children: [
//                 //               HrConstTextField(labelName: 'Final Position Title',),
//                 //               HrConstTextField(labelName: 'Final Position Title',),
//                 //             ],
//                 //           ),
//                 //         ],
//                 //       ),
//                 //     ],
//                 //   ),
//                 // )
//               ],
//             ),
//           )),
//     );
//   }
// }
