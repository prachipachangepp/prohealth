import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import '../../widgets/button_constant.dart';
import '../../widgets/text_form_field_const.dart';

class EditPopupWidget extends StatelessWidget {
  final TextEditingController typeController;
  final TextEditingController shorthandController;
  final TextEditingController emailController;
  final VoidCallback onSavePressed;
  final Color containerColor;

  EditPopupWidget({
    required this.typeController,
    required this.shorthandController,
    required this.emailController,
    required this.containerColor,
    required this.onSavePressed,
  });

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
                  vertical: AppPadding.p3,horizontal: AppPadding.p20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Color',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff686464),
                          decoration: TextDecoration.none,
                        ),),
                      SizedBox(width: AppSize.s25,),
                      Container(
                        padding: EdgeInsets.all(2),
                        width: 61,
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(width: 1, color: Color(0xffE9E9E9),
                          ),
                        ),
                        child: Container(
                          width: 57,
                          height: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: containerColor,
                          ),
                        ),
                      )

                    ],
                  ),
                  SizedBox(height: AppSize.s16,),
                  SMTextFConst(controller: typeController, keyboardType: TextInputType.text, text: 'Type',),
                  SizedBox(height: AppSize.s16,),
                  SMTextFConst(controller: shorthandController, keyboardType: TextInputType.streetAddress, text: 'Shorthand',),
                  SizedBox(height: AppSize.s16,),
                  SMTextFConst(controller: emailController, keyboardType: TextInputType.emailAddress, text: 'Type of Employee',),
                  SizedBox(height: MediaQuery.of(context).size.width/27,),
                  Center(
                    child: CustomElevatedButton(
                        width: AppSize.s105,
                        height: AppSize.s30,
                        text: 'Save',
                        onPressed: onSavePressed),
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