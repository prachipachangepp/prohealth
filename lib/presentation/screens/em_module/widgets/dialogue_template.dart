import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/color.dart';
import '../../../../app/resources/value_manager.dart';

class DialogueTemplate extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final List<Widget> body;
  final Widget bottomButtons;
  VoidCallback? onClear;
   DialogueTemplate(
      {super.key,
        this.onClear,
      required this.width,
      required this.height,
      required this.body,
      required this.bottomButtons,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      title,
                      style:PopupBlueBarText.customTextStyle(context),
                    ),
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: onClear == null? () {
                      Navigator.pop(context);
                    }:onClear,
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p18,
                horizontal: AppPadding.p18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: body,
              ),
            ),
            SizedBox(height: AppSize.s15),
            ///button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
              child: Center(
                child: bottomButtons,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


////HR POPUP template
//
// class HRDialogueTemplate extends StatelessWidget {
//   final double width;
//   final double height;
//   final String title;
//   final List<Widget> body;
//   final Widget bottomButtons;
//   const HRDialogueTemplate(
//       {super.key,
//         required this.width,
//         required this.height,
//         required this.body,
//         required this.bottomButtons,
//         required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: ColorManager.blueprime,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Text(
//                       title,
//                       style:PopupBlueBarText.customTextStyle(context),
//                     ),
//                   ),
//                   IconButton(
//                     splashColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.close,
//                       color: ColorManager.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppPadding.p18,
//                 horizontal: AppPadding.p18,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: body,
//               ),
//             ),
//             SizedBox(height: AppSize.s15),
//             ///button
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: AppPadding.p2),
//               child: Center(
//                 child: bottomButtons,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }









/// Termination template
class TerminationDialogueTemplate extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final List<Widget> body;
  final Widget bottomButtons;
  const TerminationDialogueTemplate(
      {super.key,
        required this.width,
        required this.height,
        required this.body,
        required this.bottomButtons,
        required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.bluebottom,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        title,
                        style:PopupBlueBarText.customTextStyle(context),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p18,
                  horizontal: AppPadding.p18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: body,
                ),
              ),
              SizedBox(height: AppSize.s15),
              ///button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
                child: Center(
                  child: bottomButtons,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
