import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../whitelabelling/success_popup.dart';

class ContractAddDialog extends StatefulWidget {
  final TextEditingController contractNmaeController;
  final TextEditingController contractIdController;
  final VoidCallback onSubmitPressed;
  final String title;
  final Widget radiobutton;
  Widget? child1;
  final Visibility? child2;

  ContractAddDialog({Key? key,
    required this.contractNmaeController,
    required this.onSubmitPressed,
    required this.contractIdController,
    required this.title, required this.radiobutton, this.child2,}) : super(key: key);

  @override
  State<ContractAddDialog> createState() => _ContractAddDialogState();
}
class _ContractAddDialogState extends State<ContractAddDialog> {
  TextEditingController birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s390,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              width: AppSize.s400,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: 13,
                      fontWeight:
                      FontWeightManager.semiBold,
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,
                      color: ColorManager.white,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p8,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.contractNmaeController,
                    keyboardType: TextInputType.text,
                    text: 'Contract Name',
                  ),
                  SizedBox(height: AppSize.s8),
                  SMTextFConst(
                    controller: widget.contractIdController,
                    keyboardType: TextInputType.text,
                    text: 'Contract ID',
                  ),
                  SizedBox(height: AppSize.s8),

                    widget.radiobutton


                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.submit,
                  onPressed: () {
                    widget.onSubmitPressed();
                    Navigator.pop(context);
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
