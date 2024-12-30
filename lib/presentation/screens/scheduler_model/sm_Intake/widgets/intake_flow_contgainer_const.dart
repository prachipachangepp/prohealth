import 'package:flutter/material.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/value_manager.dart';

class IntakeFlowContainerConst extends StatelessWidget {
  final double? height;
  final Widget child;
  const IntakeFlowContainerConst({super.key, this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30, vertical: AppPadding.p30),
      child: Container(
        height: height ?? AppSize.s500,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30, vertical: AppPadding.p15),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(5),
          // border: Border.symmetric(vertical: BorderSide(width: 0.2,color: ColorManager.grey),horizontal: BorderSide(width: 0.2,color: ColorManager.grey),),//all(width: 1, color: Color(0xFFBCBCBC)),
          border: Border.all(width: 1,color: ColorManager.lightGrey),//all(width: 1, color: Color(0xFFBCBCBC)),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
