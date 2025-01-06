import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../app/resources/color.dart';
typedef void OnManuButtonTapCallBack(int index);

class PageViewMenuButtonConst extends StatelessWidget {
  const PageViewMenuButtonConst({
    super.key,
    required this.onTap,
    required this.index,
    required this.grpIndex,
    required this.heading,
    this.enabled = true,  // Added enabled parameter with default value true
  });

  final OnManuButtonTapCallBack onTap;
  final int index;
  final int grpIndex;
  final String heading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => onTap(index) : null,  // Only trigger onTap if enabled
      child: Opacity(
        opacity: enabled ? 1.0 : 0.5,  // Dim the button if disabled
        child: Column(
          children: [
            Text(
              heading,
              style: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w700,
                color: grpIndex == index
                    ? ColorManager.blueprime
                    : const Color(0xff686464),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: AppSize.s6,
              width: AppSize.s120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.0),
                color: grpIndex == index
                    ? ColorManager.blueprime
                    : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// typedef void OnManuButtonTapCallBack(int index);
//
// class PageViewMenuButtonConst extends StatelessWidget {
//   const PageViewMenuButtonConst(
//       {super.key,
//         required this.onTap,
//         required this.index,
//         required this.grpIndex,
//         required this.heading});
//   final OnManuButtonTapCallBack onTap;
//   final int index;
//   final int grpIndex;
//   final String heading;
//
//   @override
//   Widget build(BuildContext context) {
//     return MenuClickableWidget(
//       onTap: () {
//         onTap(index);
//       },
//       onHover: (bool val) {},
//       child: Column(
//         children: [
//           Text(
//             heading,
//             style: GoogleFonts.firaSans(
//               fontSize: FontSize.s12,
//               fontWeight: FontWeightManager.bold,
//               color: grpIndex == index
//                   ? ColorManager.blueprime
//                   : const Color(0xff686464),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 10),
//             height: AppSize.s6,
//             width: AppSize.s120,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(13.0),
//               color: grpIndex == index ? ColorManager.blueprime : Colors.transparent,
//               // boxShadow: [
//               //   BoxShadow(
//               //     color: Colors.black.withOpacity(0.5),
//               //     offset: Offset(0, 4),
//               //     blurRadius: 4,
//               //     spreadRadius: 0,
//               //   ),
//               // ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
////


typedef OnClickableTap = Function();
typedef OnClickableHover = Function(bool val);

class MenuClickableWidget extends StatelessWidget {
  MenuClickableWidget(
      {super.key,
        required this.onTap,
        required this.child,
        required this.onHover});
  final OnClickableTap onTap;
  final OnClickableHover onHover;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onTap();
        },
        onHover: (value) {
          onHover(value);
        },
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: child);
  }
}
