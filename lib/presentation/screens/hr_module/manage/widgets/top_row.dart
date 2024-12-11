import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';

import '../../../../../app/resources/value_manager.dart';




class TopRowConstant extends StatelessWidget {
  const TopRowConstant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s60,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16), // Adjust padding as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment as needed
          children: [
            Image.asset(
              'images/powered_logo.png',
              height: AppSize.s27, // Specify height if needed
            ),
            SizedBox(width: AppSize.s12), // Adjust spacing as needed
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.semiBold,
                    color: ColorManager.granitegray,
                  ),
                  children: [
                    TextSpan(text: 'symmetry'),
                    TextSpan(text: '.'),
                    TextSpan(text: 'care'),
                  ],
                ),
              ),
            ),
            SizedBox(width: AppSize.s12), // Adjust spacing as needed
            SvgPicture.asset(
              'images/face_man.svg',
              height: AppSize.s30, // Specify height if needed
            ),
            SizedBox(width: AppSize.s12), // Adjust spacing as needed
            RichText(
              text: TextSpan(
                style: GoogleFonts.firaSans(
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManager.calandercolour,
                  decoration: TextDecoration.underline,
                ),
                children: [
                  TextSpan(text: '(4088) '),
                  TextSpan(text: '555'),
                  TextSpan(text: '-'),
                  TextSpan(text: '1234'),
                ],
              ),
            ),
            SizedBox(width: AppSize.s20), // Adjust spacing as needed
            Image.asset('images/logo.png',height: 27, ),
          ],
        ),
      ),
    );
  }
}







// class TopRowConstant extends StatelessWidget {
//   const TopRowConstant({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: double.maxFinite,
//       child: Padding(
//         padding: EdgeInsets.symmetric(),
//             //horizontal: MediaQuery.of(context).size.width / 120),
//         child: Row(
//           children: [
//             Image.asset(
//               'images/powered_logo.png',
//               //  height: 27,
//               width: MediaQuery.of(context).size.width/40,
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width/120),
//             Row(
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'symmetry',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xff686464),
//                         ),
//                       ),
//                       TextSpan(
//                         text: '.',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xff686464),
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'care',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xff686464),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width/1),
//             Row(
//               children: [
//                 SvgPicture.asset('images/face_man.svg')
//               ],
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width/160,),
//             RichText(
//               text: TextSpan(
//                 style: GoogleFonts.firaSans(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xff50B5E5),
//                   decoration: TextDecoration.underline,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: '(4088) ',
//                   ),
//                   TextSpan(
//                     text: '555',
//                   ),
//                   TextSpan(
//                     text: '-',
//                   ),
//                   TextSpan(
//                     text: '1234',
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width/50),
//             Image.asset('images/logo.png')
//           ],
//         ),
//       ),
//     );
//   }
// }