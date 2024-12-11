import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

class AddEmployeementPopup extends StatefulWidget {
  final TextEditingController positionTitleController;
  final TextEditingController leavingResonController;
  final TextEditingController startDateContoller;
  final TextEditingController endDateController;
  final TextEditingController lastSupervisorNameController;
  final TextEditingController supervisorMobileNumber;
  final TextEditingController cityNameController;
  final TextEditingController employeerController;
  final TextEditingController emergencyMobileNumber;
  final TextEditingController countryController;
  final String tite;
  final VoidCallback onpressedClose;
  final Future<void> Function() onpressedSave;
  final Widget checkBoxTile;

  AddEmployeementPopup({
    super.key,
    required this.positionTitleController,
    required this.leavingResonController,
    required this.startDateContoller,
    required this.endDateController,
    required this.lastSupervisorNameController,
    required this.supervisorMobileNumber,
    required this.cityNameController,
    required this.employeerController,
    required this.emergencyMobileNumber,
    required this.onpressedSave,
    required this.checkBoxTile,
    required this.tite,
    required this.onpressedClose,
    required this.countryController,
  });

  @override
  State<AddEmployeementPopup> createState() => _AddEmployeementPopupState();
}

class _AddEmployeementPopupState extends State<AddEmployeementPopup> {
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();
  bool isLoading = false;

  // Error states
  Map<String, bool> errorStates = {
    'positionTitle': false,
    'leavingReason': false,
    'startDate': false,
    'endDate': false,
    'lastSupervisorName': false,
    'supervisorMobileNumber': false,
    'cityName': false,
    'employer': false,
    'emergencyMobileNumber': false,
    'countryname': false,
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height:490,
        width: 900,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 44),
                    child: Text(
                      widget.tite,
                        style: PopupHeadingStyle.customTextStyle(context)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _clearControllers();
                      },

                      icon: Icon(
                          Icons.close,
                          color: IconColorManager.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: MediaQuery.of(context).size.height / 30),

            Padding(
  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTextField(
            capitalIsSelect: true,
            controller: widget.positionTitleController,
            labelText: "Final Position Title",
            errorKey: 'positionTitle',
            errorMessage: 'Please enter title'
          ),
          _buildTextField(
            capitalIsSelect: true,
            controller: widget.leavingResonController,
            labelText: "Reason For Leaving",
            errorKey: 'leavingReason',
            errorMessage: 'Please enter leaving reason'
          ),
          _buildTextField(
            capitalIsSelect: false,
            controller: widget.startDateContoller,
            labelText: "Start Date",
            errorKey: 'startDate',
            errorMessage: 'Please enter start date',
            suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
            onTap: () => _selectDate(widget.startDateContoller, _selectedStartDate),
          ),
        ],
      ),
      // SizedBox(height: MediaQuery.of(context).size.height / 30),
      SizedBox(height: AppSize.s20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTextField(
            capitalIsSelect: false,
            controller: widget.endDateController,
            labelText: "End Date",
            errorKey: 'endDate',
            errorMessage: 'Please enter end date',
            suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
            onTap: () => _selectDate(widget.endDateController, _selectedEndDate),
          ),
          _buildTextField(
            capitalIsSelect: true,
            controller: widget.lastSupervisorNameController,
            labelText: "Last Supervisor's Name",
            errorKey: 'lastSupervisorName',
            errorMessage: 'Please enter supervisor name'
          ),
          _buildTextField(
            capitalIsSelect: false,
            controller: widget.supervisorMobileNumber,
            labelText: "Supervisor's Mobile Number",
            errorKey: 'supervisorMobileNumber',
            errorMessage: 'Please enter supervisor mobile number'
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.checkBoxTile,
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTextField(
            capitalIsSelect: true,
            controller: widget.cityNameController,
            labelText: AppString.city,
            errorKey: 'cityName',
            errorMessage: 'Please enter city name'
          ),
          _buildTextField(
            capitalIsSelect: true,
            controller: widget.employeerController,
            labelText: "Employer",
            errorKey: 'employer',
            errorMessage: 'Please enter employer'
          ),
          _buildTextField(
            capitalIsSelect: false,
            controller: widget.emergencyMobileNumber,
            labelText: "Emergency Mobile Number",
            errorKey: 'emergencyMobileNumber',
            errorMessage: 'Please enter mobile number.'
          ),
        ],
      ),
      SizedBox(height: AppSize.s20),
      // SizedBox(height: MediaQuery.of(context).size.height / 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTextField(
            capitalIsSelect: true,
            controller: widget.countryController,
            labelText: "Country Name",
            errorKey: 'countryname',
            errorMessage: 'Please enter Country'
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
          ),
        ],
      ),
    ],
  ),
),
            SizedBox(height: AppSize.s15),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonTransparent(
                    text: AppString.cancel,
                    onPressed: () {
                      Navigator.pop(context);
                      _clearControllers();
                    },
                  ),
                  SizedBox(width: AppSize.s10),
                  isLoading
                      ? SizedBox(
                    height: AppSize.s25,
                    width: AppSize.s25,
                    child: CircularProgressIndicator(color: ColorManager.blueprime),
                  )
                      : CustomElevatedButton(
                    width: AppSize.s100,
                    text: AppString.save,
                    onPressed: _handleSave,
                  ),
                ],
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
    required String errorKey,
    Widget? suffixIcon,
    required bool capitalIsSelect,
    VoidCallback? onTap,
    required String errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldRegister(
          capitalIsSelect: capitalIsSelect,
          phoneNumberField: errorKey == 'supervisorMobileNumber' || errorKey == 'emergencyMobileNumber',
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
          labelText: labelText,
          keyboardType: TextInputType.phone, // Ensure it's phone input for number fields
          padding: const EdgeInsets.only(bottom: AppPadding.p5, left: 10),
          suffixIcon: suffixIcon,
          onTap: onTap,
          onChanged: (value) {
            setState(() {
              if (errorKey == 'supervisorMobileNumber' || errorKey == 'emergencyMobileNumber') {
                // Validate phone number fields
                String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                errorStates[errorKey] = numericValue.length != 10;
              } else {
                // Validate other text fields
                errorStates[errorKey] = value.isEmpty;
              }
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorMessage;
            }
            if (errorKey == 'supervisorMobileNumber' || errorKey == 'emergencyMobileNumber') {
              String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
              if (numericValue.length != 10) {
                return 'Please enter a valid 10-digit phone number';
              }
            }
            return null;
          },

        ),
        if (errorStates[errorKey] == true)
          Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Text(
              errorMessage,
              style: CommonErrorMsg.customTextStyle(context),
            ),
          ),
      ],
    );
  }


  void _handleSave() {
    setState(() {
      isLoading = true;
    });

    bool hasError = false;

    // Check if any of the fields have errors
    errorStates.forEach((key, _) {
      TextEditingController controller = controllerByErrorKey(key);

      if (key == 'supervisorMobileNumber' || key == 'emergencyMobileNumber') {
        // Validate phone number fields
        String numericValue = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
        if (numericValue.length != 10) {
          errorStates[key] = true;
          hasError = true;
        } else {
          errorStates[key] = false;
        }
      } else {
        // Validate other text fields
        if (controller.text.isEmpty) {
          errorStates[key] = true;
          hasError = true;
        } else {
          errorStates[key] = false;
        }
      }
    });

    // If there's an error, stop the loading and don't proceed with saving
    if (hasError) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    // Proceed to save when no errors
    widget.onpressedSave();
  }



  TextEditingController controllerByErrorKey(String errorKey) {
    switch (errorKey) {
      case 'positionTitle':
        return widget.positionTitleController;
      case 'leavingReason':
        return widget.leavingResonController;
      case 'startDate':
        return widget.startDateContoller;
      case 'endDate':
        return widget.endDateController;
      case 'lastSupervisorName':
        return widget.lastSupervisorNameController;
      case 'supervisorMobileNumber':
        return widget.supervisorMobileNumber;
      case 'cityName':
        return widget.cityNameController;
      case 'employer':
        return widget.employeerController;
      case 'emergencyMobileNumber':
        return widget.emergencyMobileNumber;
      case 'countryname':
        return widget.countryController;
      default:
        return TextEditingController();
    }
  }

  void _clearControllers() {
    widget.positionTitleController.clear();
    widget.leavingResonController.clear();
    widget.startDateContoller.clear();
    widget.endDateController.clear();
    widget.lastSupervisorNameController.clear();
    widget.supervisorMobileNumber.clear();
    widget.cityNameController.clear();
    widget.employeerController.clear();
    widget.emergencyMobileNumber.clear();
    widget.countryController.clear();
  }

  Future<void> _selectDate(TextEditingController controller, DateTime selectedDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
