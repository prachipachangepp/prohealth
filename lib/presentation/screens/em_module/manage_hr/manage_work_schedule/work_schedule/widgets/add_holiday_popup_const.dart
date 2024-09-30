import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../widgets/dialogue_template.dart';

class AddHolidayPopup extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController calenderDateController;
  final Future<void> Function() onPressed;
  final String title;
  final String btnTitle;

  const AddHolidayPopup({
    super.key,
    required this.controller,
    required this.calenderDateController,
    required this.onPressed,
    required this.title,
    required this.btnTitle,
  });

  @override
  State<AddHolidayPopup> createState() => _AddHolidayPopupState();
}

class _AddHolidayPopupState extends State<AddHolidayPopup> {
  final _formKey = GlobalKey<FormState>();
  final DateTime _selectedDate = DateTime.now();
  bool isLoading = false;
  String? holidayNameError;
  String? holidayDateError;

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s350,
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p3,
            // horizontal: AppPadding.p20,
          ),
          child: Form(
            key:_formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FirstSMTextFConst(
                  controller: widget.controller,
                  keyboardType: TextInputType.text,
                  text: 'Holiday Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        holidayNameError = 'Please enter holiday name';
                      });
                      return null;
                    }
                    setState(() {
                      holidayNameError = null;
                    });
                    return null;
                  },
                ),
                if (holidayNameError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      holidayNameError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  ),
                SizedBox(height: 20),
                Text(
                  'Holiday Date',
                  style: AllPopupHeadings.customTextStyle(context),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: 354,
                  height: 30,
                  child: TextFormField(
                    controller: widget.calenderDateController,
                    style: DocumentTypeDataStyle.customTextStyle(context),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'mm-dd-yyyy',
                      hintStyle:DocumentTypeDataStyle.customTextStyle(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 1),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: Icon(Icons.calendar_month_outlined,
                          color: ColorManager.blueprime),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );
                      if (date != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(date);
                        widget.calenderDateController.text = formattedDate;
                        setState(() {
                          holidayDateError = null;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          holidayDateError = 'Please select a holiday date';
                        });
                        return null;
                      }
                      setState(() {
                        holidayDateError = null;
                      });
                      return null;
                    },
                  ),
                ),
                if (holidayDateError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      holidayDateError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
      bottomButtons: isLoading
          ? SizedBox(
        height: AppSize.s25,
        width: AppSize.s25,
        child: CircularProgressIndicator(
          color: ColorManager.blueprime,
        ),
      )
          : CustomElevatedButton(
              width: AppSize.s110,
              height: AppSize.s30,
              text: widget.btnTitle,
              onPressed: () async {
              if(_formKey.currentState!.validate()){
                if(holidayDateError == null){
                  setState(() {
                    isLoading = true;

                  });
                  try {
                    await widget.onPressed();
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddSuccessPopup(
                          message: 'Added Successfully',
                        );
                      },
                    );
                    widget.calenderDateController.clear();
                    widget.controller.clear();
                  }
                }else {
                  print('Validation error');
                }

              }

                }

            ),
      title: widget.title,
    );
  }
}
