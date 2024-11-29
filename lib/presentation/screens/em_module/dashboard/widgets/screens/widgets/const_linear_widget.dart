import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';

class LinearCardWidget extends StatelessWidget {
  final String headingText;
  final String totalCount;
  final IconData icon;
  final int totalValue;
   LinearCardWidget({super.key, required this.headingText, required this.totalCount, required this.totalValue, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(headingText,style: TextStyle(fontSize: 15,fontWeight:FontWeight.w500,color: ColorManager.mediumgrey,),),
                  SizedBox(height: 15,),
                  Text(totalCount,style: TextStyle(fontSize: 20,color: ColorManager.blueprime),)
                ],
              ),
              CircleAvatar(
                backgroundColor: ColorManager.white,
                radius: 30,
                child: Icon(icon,color: ColorManager.bluebottom,size: 34,),
              )
            ],

          ),
          LinearProgressIndicator(
            backgroundColor: ColorManager.white,
            color: ColorManager.blueprime,
            value: totalValue/100,
          )
        ],
      ),
    );
  }
}
