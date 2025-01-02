import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/work_schedule_manager.dart';
import '../../../../../../widgets/error_popups/failed_popup.dart';
import '../../../../../../widgets/error_popups/four_not_four_popup.dart';
import '../../../../company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../widgets/dialogue_template.dart';
///add popup
class AddHolidayPopup extends StatefulWidget {

  const AddHolidayPopup({
    super.key,
  });

  @override
  State<AddHolidayPopup> createState() => _AddHolidayPopupState();
}
class _AddHolidayPopupState extends State<AddHolidayPopup> {
  TextEditingController holidayNameController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();
  bool isLoading = false;

  String? holidayNameError;
  String? holidayDateError;
  bool _isFormValid = true;

  @override
  void initState() {
    super.initState();
    holidayNameController.addListener(() {
      if (holidayNameError != null && holidayNameController.text.isNotEmpty) {
        setState(() {
          holidayNameError = null;
        });
      }
    });
  }

  @override
  void dispose() {
    holidayNameController.dispose();
    calenderController.dispose();
    super.dispose();
  }

  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please enter $fieldName";
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid = true;
      holidayNameError =
          _validateTextField(holidayNameController.text, 'holiday name');
      holidayDateError =
          _validateTextField(calenderController.text, 'holiday date');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s350,
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p3,
            horizontal: AppPadding.p15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Holiday Name Field
              SMTextfieldAsteric(
                controller: holidayNameController,
                keyboardType: TextInputType.text,
                text: AddPopupString.holidayName,
              ),
              if (holidayNameError != null)
                Text(
                  holidayNameError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              const SizedBox(height: AppSize.s20),

              // Holiday Date Field
              RichText(
                text: TextSpan(
                  text:AddPopupString.holidayDate, // Main text
                  style: AllPopupHeadings.customTextStyle(context), // Main style
                  children: [
                    TextSpan(
                      text: ' *', // Asterisk
                      style: AllPopupHeadings.customTextStyle(context).copyWith(
                        color: ColorManager.red, // Asterisk color
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
                child: SizedBox(
                  width: AppSize.s354,
                  height: AppSize.s30,
                  child: TextFormField(
                    controller: calenderController,
                    style: DocumentTypeDataStyle.customTextStyle(context),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorManager.fmediumgrey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'yyyy-mm-dd',
                      hintStyle: DocumentTypeDataStyle.customTextStyle(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(width: 1),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                      suffixIcon:  Icon(Icons.calendar_month_outlined,
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
                        calenderController.text = formattedDate;
                        setState(() {
                          holidayDateError = null;
                        });
                      }
                    },
                  ),
                ),
              ),
              if (holidayDateError != null)
                Text(
                  holidayDateError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
            ],
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
        width: AppSize.s120,
        height: AppSize.s30,
        text: AddPopupString.addHoliday,
        onPressed: () async {
          _validateForm();
          if (_isFormValid) {
            setState(() {
              isLoading = true;
            });

            try {
              String selectedDate = calenderController.text;
              int year = int.parse(selectedDate.split('-')[0]);
              var response = await addHolidaysPost(
                context,
                holidayNameController.text,
                calenderController.text,
                year,
              );
              if (response.statusCode == 200 || response.statusCode == 201) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddSuccessPopup(
                      message: 'Holiday Added Successfully',
                    );
                  },
                );
              }
              else if (response.statusCode == 400 || response.statusCode == 404) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                  const FourNotFourPopup(),
                );
              }
              else {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      FailedPopup(text: response.message),
                );
              }
            } finally {
              setState(() {
                isLoading = false;
              });
              calenderController.clear();
              holidayNameController.clear();
            }
          }
        },
      ),
      title: AddPopupString.addNewHoliday,
    );
  }
}

///edit
class EditHolidayPopup extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController calenderDateController;
  final int holidayId;

  const EditHolidayPopup({
    super.key,
    required this.controller,
    required this.calenderDateController,
    required this.holidayId,
  });

  @override
  State<EditHolidayPopup> createState() => _EditHolidayPopupState();
}
class _EditHolidayPopupState extends State<EditHolidayPopup> {
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
            horizontal: AppPadding.p15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Holiday Name Field
              SMTextfieldAsteric(
                controller: widget.controller,
                keyboardType: TextInputType.text,
                text: AddPopupString.holidayName,
              ),
              if (holidayNameError != null)
                Text(
                  holidayNameError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s20),
              RichText(
                text: TextSpan(
                  text:AddPopupString.holidayDate, // Main text
                  style: AllPopupHeadings.customTextStyle(context), // Main style
                  children: [
                    TextSpan(
                      text: ' *', // Asterisk
                      style: AllPopupHeadings.customTextStyle(context).copyWith(
                        color: ColorManager.red, // Asterisk color
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.s5),
              SizedBox(
                width: AppSize.s354,
                height: AppSize.s30,
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
                    hintText: 'yyyy-mm-dd',
                    hintStyle: DocumentTypeDataStyle.customTextStyle(context),
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
                      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                      widget.calenderDateController.text = formattedDate;
                      setState(() {
                        holidayDateError = null;
                      });
                    }
                  },
                ),
              ),
              if (holidayDateError != null)
                Text(
                  holidayDateError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
            ],
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
        width: AppSize.s130,
        height: AppSize.s30,
        text: AppStringEM.save,
        onPressed: () async {
          if (widget.controller.text.isEmpty) {
            setState(() {
              holidayNameError = 'Please enter holiday name';
            });
          } else if (widget.calenderDateController.text.isEmpty) {
            setState(() {
              holidayDateError = 'Please select a holiday date';
            });
          } else {
            // Proceed if no errors
            setState(() {
              isLoading = true;
            });
            try{
              var holidayName = widget.controller.text;
              var date = widget.calenderDateController.text;

          var response = await updateHolidays(context, widget.holidayId,
                holidayName == widget.controller.text ? holidayName.toString() : widget.controller.text,
                date == widget.calenderDateController.text ? date! : widget.calenderDateController.text, 2024,);
              if(response.statusCode == 200 || response.statusCode == 201){
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddSuccessPopup(
                      message: 'Holiday Edited Successfully',
                    );
                  },
                );
              }
              else if(response.statusCode == 400 || response.statusCode == 404){
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const FourNotFourPopup(),
                );
              }
              else {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => FailedPopup(text: response.message),
                );
              }
              widget.controller.clear();
              widget.calenderDateController.clear();
            }
            finally {
              setState(() {
                isLoading = false;
              });

              widget.calenderDateController.clear();
              widget.controller.clear();
            }
          }
        },
      ),
      title: EditPopupString.editholiday,
    );
  }
}