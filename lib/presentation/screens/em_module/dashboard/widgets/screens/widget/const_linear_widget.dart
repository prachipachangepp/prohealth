import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';

class LinearCardWidget extends StatelessWidget {
  final String headingText;
  final String totalCount;
  final int totalValue;
   LinearCardWidget({super.key, required this.headingText, required this.totalCount, required this.totalValue});

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
                radius: 25,
                child: Icon(Icons.file_copy_sharp,color: ColorManager.blueprime.withOpacity(0.2),),
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
