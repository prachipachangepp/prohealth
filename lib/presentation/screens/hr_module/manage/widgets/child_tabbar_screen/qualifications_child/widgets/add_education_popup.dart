import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

class AddEducationPopup extends StatefulWidget {
  final TextEditingController collegeUniversityController;
  final TextEditingController phoneController;
  final TextEditingController calenderController;
  final TextEditingController cityController;
  final TextEditingController degreeController;
  final TextEditingController stateController;
  final TextEditingController majorSubjectController;
  final TextEditingController countryNameController;
  final VoidCallback onpressedClose;
  final Future<void> Function() onpressedSave;
  final String title;
  final Widget? radioButton;

  AddEducationPopup({
    super.key,
    required this.collegeUniversityController,
    required this.phoneController,
    required this.calenderController,
    required this.cityController,
    required this.degreeController,
    required this.stateController,
    required this.majorSubjectController,
    required this.countryNameController,
    required this.onpressedClose,
    required this.onpressedSave,
    this.radioButton,
    required this.title,
  });

  @override
  State<AddEducationPopup> createState() => _AddEducationPopupState();
}

class _AddEducationPopupState extends State<AddEducationPopup> {
  final DateTime _selectedStartDate = DateTime.now();
  bool isLoading = false;
  bool _collegeUniversityError = false;
  bool _phoneError = false;
  bool _calendarError = false;
  bool _cityError = false;
  bool _degreeError = false;
  bool _stateError = false;
  bool _majorSubjectError = false;
  bool _countryNameError = false;
  bool _isRadioButtonSelected = false;
 // bool _radioButtonError = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 390,
        width: 932,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height:AppSize.s50,
              decoration: BoxDecoration(
                color: ColorManager.blueprime,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 51),
                    child: Text(
                      widget.title,
                      style: PopupHeadingStyle.customTextStyle(context)
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _clearControllers();
                    },
                    icon: Icon(
                      Icons.close,
                      color: IconColorManager.white
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            capitalIsSelect:true,
                            controller: widget.collegeUniversityController,
                            labelText: "College/University",
                            errorText: _collegeUniversityError ? 'Please enter College/University Name' : null,
                          ),
                        ),
                        SizedBox(width: AppSize.s20),
                        Expanded(
                          child: _buildTextField(
                            capitalIsSelect:false,
                            controller: widget.phoneController,
                            labelText: "Phone",
                            errorText: _phoneError ? 'Please enter valid phone number' : null,
                          ),
                        ),
                        SizedBox(width: AppSize.s20),
                        Expanded(
                          child: _buildTextField(
                            capitalIsSelect: false,
                            controller: widget.calenderController,
                            labelText: "Start Date",
                            errorText: _calendarError ? 'Please Enter Start Date' : null,
                            suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: _selectedStartDate,
                                firstDate: DateTime(1100),
                                lastDate: DateTime(2025),
                              );
                              if (date != null) {
                                String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                                widget.calenderController.text = formattedDate;
                                setState(() {
                                  _calendarError = formattedDate.isEmpty;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Graduate', style: TextStyle(fontSize: FontSize.s12)),
                              widget.radioButton ?? SizedBox.shrink(),
                             // if (_radioButtonError)
                               // Text('Please select an option', style: TextStyle(color: Colors.red, fontSize: 10)),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                            capitalIsSelect:true,
                            controller: widget.cityController,
                            labelText: AppString.city,
                            errorText: _cityError ? 'Please Enter City' : null,
                          ),
                        ),
                        SizedBox(width: AppSize.s20),
                        Expanded(
                          child: _buildTextField(
                            controller: widget.degreeController,
                            labelText: "Degree",
                            errorText: _degreeError ? 'Please Enter Degree' : null, capitalIsSelect: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            capitalIsSelect:true,
                            controller: widget.stateController,
                            labelText: AppString.state,
                            errorText: _stateError ? 'Please Enter State' : null,
                          ),
                        ),
                        SizedBox(width: AppSize.s20),
                        Expanded(
                          child: _buildTextField(
                            capitalIsSelect:true,
                            controller: widget.majorSubjectController,
                            labelText: "Major Subject",
                            errorText: _majorSubjectError ? 'Please Enter Major Subject' : null,
                          ),
                        ),
                        SizedBox(width: AppSize.s20),
                        Expanded(
                          child: _buildTextField(
                            capitalIsSelect:true,
                            controller: widget.countryNameController,
                            labelText: "Country Name",
                            errorText: _countryNameError ? 'Please Enter Country Name' : null,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSize.s35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButtonTransparent(
                          text: AppString.cancel,
                          onPressed: widget.onpressedClose,
                        ),
                        SizedBox(width: AppSize.s10),
                        isLoading
                            ? SizedBox(
                          height: AppSize.s25,
                          width: AppSize.s25,
                          child: CircularProgressIndicator(
                            color: ColorManager.blueprime,
                          ),
                        )
                            : CustomElevatedButton(
                          width: AppSize.s100,
                          text: AppString.save,
                          onPressed: _handleSave,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? errorText,
    Widget? suffixIcon,
    required bool capitalIsSelect,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldRegister(
          capitalIsSelect: capitalIsSelect,
          phoneNumberField: labelText == "Phone", // Specify if this is the phone field
          height: AppSize.s30,
          controller: controller,
          labelText: labelText,
          keyboardType: labelText == "Phone" ? TextInputType.phone : TextInputType.text,
          padding: EdgeInsets.only(bottom: AppPadding.p1, left: 2),
          suffixIcon: suffixIcon,
          onTap: onTap,
          onChanged: (value) {
            setState(() {
              // Update error state based on the field
              if (labelText == "College/University") _collegeUniversityError = value.isEmpty;
              if (labelText == "City") _cityError = value.isEmpty;
              if (labelText == "Phone") _phoneError = !_isPhoneValid(value); // Use custom phone validation
              if (labelText == "State") _stateError = value.isEmpty;
              if (labelText == "Major Subject") _majorSubjectError = value.isEmpty;
              if (labelText == "Country Name") _countryNameError = value.isEmpty;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppString.enterText;
            }
            return null;
          },
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              errorText,
              style: CommonErrorMsg.customTextStyle(context),
            ),
          ),
      ],
    );
  }

  // Method to validate phone number with the USA phone mask
  bool _isPhoneValid(String phoneNumber) {
    // Define the regex pattern for (###) ###-####
    final RegExp phoneRegex = RegExp(r'^\(\d{3}\) \d{3}-\d{4}$');
    return phoneRegex.hasMatch(phoneNumber); // Checks if the phone number matches the pattern
  }

  void _handleSave() async {
    setState(() {
      isLoading = true;
      _collegeUniversityError = widget.collegeUniversityController.text.isEmpty;
      _phoneError = !_isPhoneValid(widget.phoneController.text); // Update phone validation logic
      _calendarError = widget.calenderController.text.isEmpty;
      _cityError = widget.cityController.text.isEmpty;
      _degreeError = widget.degreeController.text.isEmpty;
      _stateError = widget.stateController.text.isEmpty;
      _majorSubjectError = widget.majorSubjectController.text.isEmpty;
      _countryNameError = widget.countryNameController.text.isEmpty;
     // _radioButtonError = !_isRadioButtonSelected;
    });

    if (!_collegeUniversityError &&
        !_phoneError && // Make sure phone error is included
        !_calendarError &&
        !_cityError &&
        !_stateError &&
        !_majorSubjectError &&
        !_countryNameError
       // !_radioButtonError
    ) {
      try {
        await widget.onpressedSave();
      } finally {
        setState(() {
          isLoading = false;
        });
        _clearControllers();
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }


  void _clearControllers() {
    widget.countryNameController.clear();
    widget.degreeController.clear();
    widget.majorSubjectController.clear();
    widget.stateController.clear();
    widget.cityController.clear();
    widget.phoneController.clear();
    widget.collegeUniversityController.clear();
    widget.calenderController.clear();
  }
}
