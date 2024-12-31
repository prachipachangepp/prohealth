import 'package:flutter/material.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';

class Auto_Assign extends StatefulWidget {
  final VoidCallback? onGoBackAuto;
  const Auto_Assign({super.key, this.onGoBackAuto});

  @override
  State<Auto_Assign> createState() => _Auto_AssignState();
}

class _Auto_AssignState extends State<Auto_Assign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     body: Container(
      child:  Row(
        children: [
          SizedBox(width: AppSize.s25,),
          Icon(
            Icons.arrow_back,
            size: IconSize.I16,
            color: ColorManager.mediumgrey,

          ),
          SizedBox(width: 5,),
          InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              if (widget.onGoBackAuto != null) {
                widget.onGoBackAuto!(); // Trigger the callback to notify parent
              }},
            child: Text(
              'Go Back',
              style:TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w700,
                color: ColorManager.mediumgrey,
              ),
            ),
          ),
        ],
      )
     ),
    );
  }
}
