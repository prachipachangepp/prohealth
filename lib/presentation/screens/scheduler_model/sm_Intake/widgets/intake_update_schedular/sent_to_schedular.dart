import 'package:flutter/material.dart';

import '../../../../../../app/resources/color.dart';

class SentToSchedularScreen extends StatelessWidget {
  const SentToSchedularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: Column(
        children: [
          ///button
          Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(color: ColorManager.red,width: 500,height: 33,),
              Container(color: ColorManager.bluelight,width: 500,height: 33,),
            ],
          ),
        ],
      ),
    );
  }
}
