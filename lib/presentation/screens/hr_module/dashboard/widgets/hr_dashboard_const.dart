import 'package:flutter/material.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/theme_manager.dart';

class HrDashboardContainerConst extends StatefulWidget {
  final String headText;
  final Color headSubTextColor;
  final String subText;
  final String imageTile;
  final Color imageTileColor;

  const HrDashboardContainerConst({super.key,
    required this.headText, required this.headSubTextColor,
    required this.subText, required this.imageTile, required this.imageTileColor,});

  @override
  State<HrDashboardContainerConst> createState() => _HrDashboardContainerConstState();
}

class _HrDashboardContainerConstState extends State<HrDashboardContainerConst> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.mediumgrey.withOpacity(0.2),
            blurRadius: 1,
            spreadRadius: 2,
            offset: const Offset(0, -3), // Upward shadow
          ),
          BoxShadow(
            color: ColorManager.fmediumgrey.withOpacity(0.1),
            blurRadius: 3,
            spreadRadius: 0,
            offset: const Offset(0, 6), // Downward shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.headText,
                style: CustomTextStylesCommon.commonStyle(fontSize: 16,
                    color: widget.headSubTextColor,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(widget.subText,
                      style: CustomTextStylesCommon.commonStyle(fontSize: 32,
                          color: widget.headSubTextColor,fontWeight: FontWeight.w600),),
                  )),
              Expanded(child: Center(
                child: Container(
                    child:Image.asset(widget.imageTile,fit: BoxFit.cover,color: widget.imageTileColor,
                    height: 80,)),))
            ],)
        ],
      ),
    );
  }
}
