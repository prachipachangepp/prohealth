import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class PayRatesPopup extends StatefulWidget {
  final Widget child1;
  final Widget child2;
  final VoidCallback onPressed;
  final TextEditingController payRatesController;
  PayRatesPopup({super.key, required this.child1, required this.child2, required this.payRatesController, required this.onPressed});

  @override
  State<PayRatesPopup> createState() => _PayRatesPopupState();
}

class _PayRatesPopupState extends State<PayRatesPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s300,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
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
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type of Visit',
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.mediumgrey
                        ),),
                      SizedBox(height: 2,),
                       widget.child1,
                      SizedBox(
                        height: 17,
                      ),
                      Text('Zone',
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.mediumgrey
                        ),),
                      SizedBox(height: 2,),
                      widget.child2,

                      SizedBox(
                        height: 17,
                      ),
                      SMTextFConst(
                        controller: widget.payRatesController,
                        keyboardType: TextInputType.number,
                        text: 'Rate',
                      ),
                     // widget.child,
                    ],
                  ),
                ],
              ),
            ),
            ///radio
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p10),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.submit,
                  onPressed: (){
                    widget.onPressed();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
