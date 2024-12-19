import 'package:flutter/material.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../em_module/widgets/button_constant.dart';
import '../../../../../em_module/widgets/dialogue_template.dart';

class Completed_popup extends StatefulWidget {
  const Completed_popup({super.key});

  @override
  State<Completed_popup> createState() => _Completed_popupState();
}

class _Completed_popupState extends State<Completed_popup> {
  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(width: 400, height: 450,  title: 'View Patient ',
      body: [
        Column(

          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:   AssetImage('images/1.png'),
              //child: ClipOval(child: Image.asset('images/1.png',fit: BoxFit.cover,)),
            ),
            Text(
              'John Smith',
              style:AllPopupHeadings.customTextStyle(context),
            ),
            // SizedBox(height: AppSize.s3),
            Row(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Text("POC ",style: DocumentTypeDataStyle.customTextStyle(context),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Color(0xFF527FB9).withOpacity(0.5),
                    width: 19,
                    height: 19,
                    child: Center(
                      child: Text("ST",style: TextStyle(
                        // fontWeight: FontWeight.w600,
                        // fontSize: FontSize.s13,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Color(0xFFFEBD4D).withOpacity(0.5),
                    width: 19,
                    height: 19,
                    child: Center(
                      child: Text("OT",style: TextStyle(
                        // fontWeight: FontWeight.w600,
                        //     fontSize: FontSize.s13,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),),
                    ),
                  ),
                ),


              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Divider(),
            ),
SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.only(left: 50,top: 5),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Clinician Name :  ",style: AllHRTableData.customTextStyle(context),),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Row(
                    children: [
                      Text("Dr. George Washington",style: DocumentTypeDataStyle.customTextStyle(context),),
                    ],
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 2),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Start Date : ",style: AllHRTableData.customTextStyle(context),),
                  SizedBox(width: 43,),
                  Text("2023/25/05",style: DocumentTypeDataStyle.customTextStyle(context),),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 2),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Completed Date :  ",style: AllHRTableData.customTextStyle(context),),
                  Text("2023/25/05",style: DocumentTypeDataStyle.customTextStyle(context),),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 2),
              child: Divider(),
            ),

          ],
        )
      ],

      bottomButtons:CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: 'Continue',
        onPressed: () {
          Navigator.pop(context);
          // Execute the confirm action and navigate
         // widget.onConfirm();
        },
      ),
    );
  }
}
