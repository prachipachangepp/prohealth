import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';

class CustomPopupConst extends StatefulWidget {
  const CustomPopupConst({super.key});

  @override
  State<CustomPopupConst> createState() => _CustomPopupConstState();
}

class _CustomPopupConstState extends State<CustomPopupConst> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s950,
        height: AppSize.s460,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child:Column()
      ),
    );
  }
}
