import 'package:flutter/material.dart';

import '../../../../../../../../app/resources/theme_manager.dart';
class AcknowledgementsChildBar extends StatelessWidget {
  const AcknowledgementsChildBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child:
    //Material(
      //  elevation: 4,
      //  child:
      Container(
          height: 181,
          padding: EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 5),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ // Adding top padding
          Row(
            children: [
              Container(
                width: 62,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 2,color: Color(0xffF6928A)),
                ),
                child: IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.remove_red_eye,color: Color(0xff50B5E5),),
                  iconSize: 24,) ),
              SizedBox(width: 10),
              Text('Candidate Release Authorization Form',
              style: AknowledgementStyleConst.customTextStyle(context))
            ],
          ),
                SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 62,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 2,color: Color(0xffF6928A)),
                ),
                child: IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.remove_red_eye,color: Color(0xff50B5E5),),
                  iconSize: 24,) ),
              SizedBox(width: 10),
              Text('Confidentiality Statement',
              style: AknowledgementStyleConst.customTextStyle(context))
            ],
          ),
              ],),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ // Adding top padding
          Row(
            children: [
              Container(
                width: 62,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 2,color: Color(0xffF6928A)),
                ),
                child: IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.remove_red_eye,color: Color(0xff50B5E5),),
                  iconSize: 24,) ),
              SizedBox(width: 10),
              Text('On call',
              style: AknowledgementStyleConst.customTextStyle(context))
            ],
          ),
                SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 62,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 2,color: Color(0xffF6928A)),
                ),
                child: IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.remove_red_eye,color: Color(0xff50B5E5),),
                  iconSize: 24,) ),
              SizedBox(width: 10),
              Text('Policy Concerning 3rd Party',
              style:AknowledgementStyleConst.customTextStyle(context))
            ],
          ),
              ],),
            ],
          ),
        ),
     // ),
    );
  }
}
