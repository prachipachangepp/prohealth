import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import '../../../../../../../app/resources/font_manager.dart';

class AddBatchPopup extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  Future<void> Function() onPressed;
  final String title;

  AddBatchPopup({
    super.key,
    required this.title,
    required this.controller1,
    required this.controller2,
    required this.onPressed
  });

  @override
  State<AddBatchPopup> createState() => _AddBatchPopupState();
}

class _AddBatchPopupState extends State<AddBatchPopup> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool isLoading = false;

  // Error messages
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
      startTimeError = widget.controller1.text.isEmpty ? 'Please enter start time' : null;
      endTimeError = widget.controller2.text.isEmpty ? 'Please enter end time' : null;
    });

    if (startTimeError == null && endTimeError == null) {
      // If no errors, proceed with the onPressed action
      widget.onPressed();
      setState(() {
        isLoading = false;
      });
      // Navigator.pop(context);
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
        height: AppSize.s330,
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
                      widget.title,
                      style: PopupBlueBarText.customTextStyle(context),
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
                  SMTextFConst(
                    onChange: () => _selectStartTime(context),
                    controller: widget.controller1,
                    keyboardType: TextInputType.text,
                    text: 'Start Time',
                    icon: Icon(Icons.timer_outlined, color: ColorManager.blueprime, size: 17,),

                  ),
                  if (startTimeError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        startTimeError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  SizedBox(height: 20,),
                  SMTextFConst(
                    onChange: () => _selectEndTime(context),
                    controller: widget.controller2,
                    keyboardType: TextInputType.text,
                    text: 'End Time',
                    icon: Icon(Icons.timer_outlined, color: ColorManager.blueprime, size: 17,),
                  ),
                  if (endTimeError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        endTimeError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: isLoading
                    ? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: ColorManager.blueprime,)
                )
                    : CustomElevatedButton(
                    width: AppSize.s120,
                    height: AppSize.s30,
                    text: " Save ",
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      _validateAndSubmit();
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}