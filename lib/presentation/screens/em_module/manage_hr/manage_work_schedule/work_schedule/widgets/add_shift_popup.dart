import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import '../../../../../../../app/resources/font_manager.dart';

class AddShiftPopup extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController shiftNameController;
  final Future<void> Function() onPressed;

  AddShiftPopup({
    super.key,
    required this.controller1,
    required this.controller2,
    required this.onPressed,
    required this.shiftNameController,
  });

  @override
  State<AddShiftPopup> createState() => _AddShiftPopupState();
}

class _AddShiftPopupState extends State<AddShiftPopup> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool isLoading = false;

  // Error messages
  String? shiftNameError;
  String? startTimeError;
  String? endTimeError;

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
    } else {
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
    } else {
      setState(() {
        widget.controller2.text = _selectedTime.format(context);
      });
    }
  }

  void _validateAndSubmit() {
    setState(() {
      shiftNameError = widget.shiftNameController.text.isEmpty ? 'Please enter shift name' : null;
      startTimeError = widget.controller1.text.isEmpty ? 'Please enter start time' : null;
      endTimeError = widget.controller2.text.isEmpty ? 'Please enter end time' : null;
    });

    if (shiftNameError == null && startTimeError == null && endTimeError == null) {

      widget.onPressed().whenComplete(() {
        setState(() {
          isLoading = false;
        });

        widget.controller1.clear();
        widget.controller2.clear();
        widget.shiftNameController.clear();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s374,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 23.0),
                    child: Text(
                      'Add Shift',
                      style: BlueButtonTextConst.customTextStyle(context),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: ColorManager.white,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p20,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FirstSMTextFConst(
                    controller: widget.shiftNameController,
                    keyboardType: TextInputType.text,
                    text: 'Shift Name',
                  ),
                  if (shiftNameError != null)
                    Text(
                      shiftNameError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: 10,),
                  SMTextFConst(
                    onChange: () => _selectStartTime(context),
                    controller: widget.controller1,
                    keyboardType: TextInputType.text,
                    text: 'Start Time',
                    icon: Icon(Icons.timer_outlined, color: ColorManager.blueprime, size: IconSize.I18,),
                  ),
                  if (startTimeError != null)
                    Text(
                      startTimeError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: 10,),
                  SMTextFConst(
                    onChange: () => _selectEndTime(context),
                    controller: widget.controller2,
                    keyboardType: TextInputType.text,
                    text: 'End Time',
                    icon: Icon(Icons.timer_outlined, color: ColorManager.blueprime, size: IconSize.I18,),
                  ),
                  if (endTimeError != null)
                    Text(
                      endTimeError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p25),
              child: Center(
                child: isLoading
                    ? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: ColorManager.blueprime,)
                )
                    : CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.addShift,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    _validateAndSubmit();
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
