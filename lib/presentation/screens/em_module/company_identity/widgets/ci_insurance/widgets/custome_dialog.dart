import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../widgets/button_constant.dart';
import '../../../../widgets/dialogue_template.dart';
import '../../../../widgets/text_form_field_const.dart';
import '../../whitelabelling/success_popup.dart';

class CustomPopup extends StatefulWidget {
  final TextEditingController namecontroller;
  // final TextEditingController? addressController;
  // final TextEditingController? emailController;
  // final TextEditingController? workemailController;
  // final TextEditingController? phoneController;
  // final TextEditingController? workPhoneController;
  // final Widget? childZone;
  // final Widget? childCity;
  final VoidCallback onPressed;
  final String title;
  final String buttontxt;
  final String successpopuptext;
  CustomPopup({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.namecontroller,
    required this.buttontxt,
    required this.successpopuptext,
    // this.addressController,
    // this.emailController, this.workemailController,
    // this.phoneController, this.workPhoneController,
    // this.childZone, this.childCity
  }) : super(key: key);

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(


        width: AppSize.s400,
        height: AppSize.s250,


          body: [


            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FirstSMTextFConst(
                    controller: widget.namecontroller,
                    keyboardType: TextInputType.text,
                    text: 'Vendor Name',
                  ),
                ],
              ),
            ),

          ],
        bottomButtons: CustomElevatedButton(
          width: AppSize.s105,
          height: AppSize.s30,
          text: widget.buttontxt,
          onPressed: () {
            widget.onPressed();
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CountySuccessPopup(
                  message: 'Save Successfully',
                );
              },
            );
          },
        ), title:widget.title,

    );
  }
}
