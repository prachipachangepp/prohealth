import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../../../../app/resources/theme_manager.dart';

class EditTimeOffPopup extends StatefulWidget {
  final TextEditingController ptoController;
  final TextEditingController durationController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final TextEditingController sickTimeController;
  final VoidCallback onPressed;
  final String labelName;

  EditTimeOffPopup({
    super.key,
    required this.ptoController,
    required this.durationController,
    required this.startTimeController,
    required this.endTimeController,
    required this.sickTimeController,
    required this.labelName,
    required this.onPressed,
  });

  @override
  State<EditTimeOffPopup> createState() => _EditTimeOffPopupState();
}

class _EditTimeOffPopupState extends State<EditTimeOffPopup> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Error messages
  String? startTimeError;
  String? endTimeError;
  bool load = false;

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        widget.startTimeController.text = _selectedTime.format(context);
      });
    } else {
      setState(() {
        widget.startTimeController.text = _selectedTime.format(context);
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
        widget.endTimeController.text = _selectedTime.format(context);
      });
    } else {
      setState(() {
        widget.endTimeController.text = _selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s550,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildDialogTitle(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p15,
                horizontal: AppPadding.p20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextFormField(widget.ptoController, 'PTO'),
                    SizedBox(height: AppSize.s15),
                    _buildTextFormField(widget.durationController, 'Duration'),
                    SizedBox(height: AppSize.s15),
                    _buildTextFormField(widget.startTimeController, 'Start Time',onChange: () => _selectStartTime(context),
                    icon: Icon(Icons.timer_outlined, color: ColorManager.blueprime, size: 19,),),
                    SizedBox(height: AppSize.s15),
                    _buildTextFormField(widget.endTimeController, 'End Time',onChange: () => _selectEndTime(context),
                      icon: Icon(Icons.timer_outlined, color: ColorManager.blueprime, size: 19,),),
                    SizedBox(height: AppSize.s15),
                    _buildTextFormField(widget.sickTimeController, 'Sick Time'),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: load ? SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(color: ColorManager.blueprime,),
                ):CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: 'Add',
                  onPressed: () {
                   // if (_formKey.currentState!.validate()) {
                      setState(() {
                        load = true;
                      });
                      try{
                        widget.onPressed();
                      }finally{
                        setState(() {
                          load = false;
                        });

                      }
                    //}
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogTitle() {
    return Container(
      height: AppSize.s34,
      decoration: BoxDecoration(
        color: ColorManager.blueprime,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              widget.labelName,
              style: CustomTextStylesCommon.commonStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w700,
                color: ColorManager.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: ColorManager.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText, {VoidCallback? onChange,Icon? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SMTextFConst(
          icon: icon,
          onChange: onChange,
          controller: controller,
          keyboardType: TextInputType.text,
          text: labelText,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please Enter valid details';
          //   }
          //   return null;
          // },
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 4.0),
        //   child: Text(
        //     controller.text.isEmpty ? 'Please Enter some text' : '',
        //     style: TextStyle(
        //       color: ColorManager.red,
        //       fontSize: FontSize.s14,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
