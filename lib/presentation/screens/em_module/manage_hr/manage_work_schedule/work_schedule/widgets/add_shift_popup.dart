import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class AddShiftPopup extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController shiftNameController;
  final VoidCallback onPressed;
  const AddShiftPopup({super.key, required this.controller1, required this.controller2, required this.onPressed, required this.shiftNameController});

  @override
  State<AddShiftPopup> createState() => _AddShiftPopupState();
}

class _AddShiftPopupState extends State<AddShiftPopup> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  // TextEditingController _timeController = TextEditingController();
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        widget.controller1.text = _selectedTime.format(context);
      });
    }else{
      setState(() {
        widget.controller1.text = _selectedTime.format(context);
      });
    }
  }
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        widget.controller2.text = _selectedTime.format(context);
      });
    }else{
      setState(() {
        widget.controller2.text = _selectedTime.format(context);
      });
    }
  }
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
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.shiftNameController,
                    keyboardType: TextInputType.text,
                    text: 'Shift Name',
                  ),
                  SizedBox(height: 20,),
                  SMTextFConst(
                    onChange:  ()=>_selectStartTime(context),
                    controller: widget.controller1,
                    keyboardType: TextInputType.text,
                    text: 'Start Time',
                    icon: Icon(Icons.timer_outlined,color: ColorManager.blueprime,size: 19,),

                  ),
                  SizedBox(height: 20,),

                  SMTextFConst(
                    onChange: ()=>_selectEndTime(context),
                    controller: widget.controller2,
                    keyboardType: TextInputType.text,
                    text: 'End Time',
                    icon: Icon(Icons.timer_outlined,color: ColorManager.blueprime,size: 19,),
                  ),
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
                  text: AppStringEM.addShift,
                  onPressed: () {
                    widget.onPressed();
                    Navigator.pop(context);
                    widget.controller1.clear();
                    widget.controller2.clear();
                    widget.shiftNameController.clear();
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
