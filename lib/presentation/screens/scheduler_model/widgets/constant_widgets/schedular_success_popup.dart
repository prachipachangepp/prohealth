import 'package:flutter/material.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';

class SchedularSuccessPopup extends StatelessWidget {
  final String title;
  const SchedularSuccessPopup({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s300,
        height: AppSize.s150,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: AppSize.s35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> WhitelabellingScreen()));
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close,
                      color: ColorManager.white,),
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: AppSize.s50,
                width: AppSize.s210,
                child: Text('Saved Successfully. \nThank You!',textAlign: TextAlign.center,
                  style:CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.s16,
                      color: ColorManager.mediumgrey
                  ),),
              ),
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }
}

// class EditSuccessPopup extends StatelessWidget {
//   final String message;
//
//   const EditSuccessPopup({super.key, required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s300,
//         height: AppSize.s150,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: ColorManager.bluebottom,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               height: 35,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       "Success",
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: ColorManager.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     icon: Icon(Icons.close, color: ColorManager.white),
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Center(
//               child: Container(
//                 height: AppSize.s50,
//                 width: AppSize.s210,
//                 child: Text('Submitted Successfully \nThank You.',textAlign: TextAlign.center,
//                   style:CustomTextStylesCommon.commonStyle(
//                       fontWeight: FontWeightManager.regular,
//                       fontSize: FontSize.s16,
//                       color: ColorManager.mediumgrey
//                   ),),
//               ),
//             ),
//             Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class AddSuccessPopup extends StatelessWidget {
//   final String message;
//
//   const AddSuccessPopup({super.key, required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s300,
//         height: AppSize.s150,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: ColorManager.bluebottom,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               height: 35,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       "Success",
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: ColorManager.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     icon: Icon(Icons.close, color: ColorManager.white),
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Center(
//               child: Container(
//                 height: AppSize.s50,
//                 width: AppSize.s210,
//                 child: Center(
//                   child: Text(message == ""?'Added Successfully \nThank You.':message,textAlign: TextAlign.center,
//                     style:GoogleFonts.firaSans(
//                         fontWeight: FontWeightManager.regular,
//                         fontSize: FontSize.s14,
//                         color: ColorManager.mediumgrey
//                     ),),
//                 ),
//               ),
//             ),
//             Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class CountySuccessPopup extends StatelessWidget {
//   final String message;
//
//   const CountySuccessPopup({super.key, required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s300,
//         height: AppSize.s150,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: ColorManager.bluebottom,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               height: 35,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Text(
//                       "Success",
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: ColorManager.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     icon: Icon(Icons.close, color: ColorManager.white),
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Center(
//               child: Container(
//                 height: AppSize.s50,
//                 width: AppSize.s210,
//                 child: Text('Save Successfully \nThank You.',textAlign: TextAlign.center,
//                   style:CustomTextStylesCommon.commonStyle(
//                       fontWeight: FontWeightManager.regular,
//                       fontSize: FontSize.s16,
//                       color: ColorManager.mediumgrey
//                   ),),
//               ),
//             ),
//             Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
