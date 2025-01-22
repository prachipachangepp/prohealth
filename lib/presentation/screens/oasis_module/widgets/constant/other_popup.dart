import 'package:flutter/material.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import 'green_container_constant.dart';

class OtherPopup extends StatefulWidget {
  const OtherPopup({super.key});

  @override
  State<OtherPopup> createState() => _OtherPopupState();
}

class _OtherPopupState extends State<OtherPopup> {

  TextEditingController othertextcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 250,
        width: 500,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed:() {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                ],),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EMRTextFConst(
                        //width: MediaQuery.of(context).size.width /5,
                        width:AppSize.s354,
                        controller: othertextcontroller, keyboardType: TextInputType.text, ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      //color: Colors.white,
                      width: 117,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: (){

                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            // side: BorderSide(
                            //   color: ColorManager.bluebottom,
                            //   width: 1,
                            // ),
                          ),),
                        child: Text('Close',
                          style: DefineWorkWeekStyle.customTextStyle(context),
                        ),),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      //color: Colors.white,
                      width: 117,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: (){

                        },
                        style: ElevatedButton.styleFrom(backgroundColor: ColorManager.bluebottom,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            // side: BorderSide(
                            //   color: ColorManager.bluebottom,
                            //   width: 1,
                            // ),
                          ),),
                        child: Text('Save',
                          style:TextStyle(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.white,
                            decoration: TextDecoration.none,
                          ),
                        ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        ,
      ),
    );
  }
}
