import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class EditTimeOffPopup extends StatefulWidget {
  final TextEditingController ptoController;
  final TextEditingController durationController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final TextEditingController sickTimeController;
  final VoidCallback onPressed;
  final String labelName;
   EditTimeOffPopup({super.key, required this.ptoController, required this.durationController, required this.startTimeController, required this.endTimeController, required this.sickTimeController, required this.labelName, required this.onPressed});

  @override
  State<EditTimeOffPopup> createState() => _EditTimeOffPopupState();
}

class _EditTimeOffPopupState extends State<EditTimeOffPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: MediaQuery.of(context).size.height/1.5,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: 34,
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 10.0),
                    child: Text(widget.labelName,style:GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      //decoration: TextDecoration.none,
                    ),),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,color: Colors.white,),
                  ),
                ],
              ),
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
                  SMTextFConst(
                    controller: widget.ptoController,
                    keyboardType: TextInputType.text,
                    text: 'PTO',
                  ),
                  SizedBox(height: AppSize.s15),
                  SMTextFConst(
                    controller: widget.durationController,
                    keyboardType: TextInputType.text,
                    text: 'Duration',
                  ),
                  SizedBox(height: AppSize.s15),
                  SMTextFConst(
                    controller: widget.startTimeController,
                    keyboardType: TextInputType.text,
                    text: 'Start Time',
                  ),
                  SizedBox(height: AppSize.s15),
                  SMTextFConst(
                    controller: widget.endTimeController,
                    keyboardType: TextInputType.text,
                    text: 'End Time',
                  ),
                  SizedBox(height: AppSize.s15),
                  SMTextFConst(
                    controller: widget.sickTimeController,
                    keyboardType: TextInputType.text,
                    text: 'Sick Time',
                  ),
                  SizedBox(height: AppSize.s15),
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
                  text: 'Add',
                  onPressed: () {
                    widget.onPressed();
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
