import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../em_module/widgets/button_constant.dart';
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

///add popup
class AcknowledgementsAddPopup extends StatelessWidget {
  const AcknowledgementsAddPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: AppSize.s400,
        width: AppSize.s350,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p3,horizontal: AppPadding.p25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type of Employee',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff686464),
                          decoration: TextDecoration.none,
                        ),),
                      SizedBox(height: 2),
                      Container(
                        height: 30,
                        padding: EdgeInsets.only(top: 2,bottom: 1,left: 4),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Color(0xffB1B1B1)), // Black border
                          borderRadius: BorderRadius.circular(8), // Rounded corners
                        ),
                        child: DropdownButtonFormField<String>(
                          focusColor: Colors.transparent,
                          icon: Icon(Icons.arrow_drop_down_sharp,color: ColorManager.black,),
                          decoration: InputDecoration.collapsed(hintText: ''),
                          items: <String>['Clinical', 'A', 'B', 'C']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style: GoogleFonts.roboto(color: Color(0xff686464),fontSize: 12,fontWeight: FontWeightManager.bold),),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                          },
                          value: 'Clinical',style: GoogleFonts.roboto(color: Color(0xff686464),fontSize: 12,fontWeight: FontWeightManager.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width/22,),
                  Center(
                    child: CustomElevatedButton(
                        width: AppSize.s105,
                        height: AppSize.s30,
                        text: 'Add',
                        onPressed: (){}),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
