
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
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
    required this.onpressedClose,
    required this.onpressedSave,
    required this.checkBoxTile,
    required this.tite,
  });

  @override
  State<AddEmployeementPopup> createState() => _AddEmployeementPopupState();
}

class _AddEmployeementPopupState extends State<AddEmployeementPopup> {
  final DateTime _selectedStartDate = DateTime.now();
  final DateTime _selectedEndDate = DateTime.now();
  bool isLoading = false;

  // Error states
  bool _positionTitleError = false;
  bool _leavingReasonError = false;
  bool _startDateError = false;
  bool _endDateError = false;
  bool _lastSupervisorNameError = false;
  bool _supervisorMobileNumberError = false;
  bool _cityNameError = false;
  bool _employerError = false;
  bool _emergencyMobileNumberError = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: AppSize.s500,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 50,
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
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Text(
                        widget.tite,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.positionTitleController,
                        labelText: "Final Position Title",
                        keyboardType: TextInputType.text,
                        padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _positionTitleError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_positionTitleError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.leavingResonController,
                        labelText: "Reason For Leaving",
                        keyboardType: TextInputType.text,
                        padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _leavingReasonError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_leavingReasonError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.startDateContoller,
                        labelText: "Start Date",
                        keyboardType: TextInputType.text,
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: ColorManager.blueprime,
                        ),
                        padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: _selectedStartDate,
                            firstDate: DateTime(1100),
                            lastDate: DateTime(2025),
                          );
                          if (date != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                            widget.startDateContoller.text = formattedDate;
                            setState(() {
                              _startDateError = formattedDate.isEmpty;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_startDateError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.endDateController,
                        labelText: "End Date",
                        keyboardType: TextInputType.text,
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: ColorManager.blueprime,
                        ),
                        padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: _selectedEndDate,
                            firstDate: DateTime(1100),
                            lastDate: DateTime(2025),
                          );
                          if (date != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                            widget.endDateController.text = formattedDate;
                            setState(() {
                              _endDateError = formattedDate.isEmpty;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_endDateError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.lastSupervisorNameController,
                        labelText: "Last Supervisor’s Name",
                        keyboardType: TextInputType.text,
                        padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _lastSupervisorNameError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_lastSupervisorNameError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.supervisorMobileNumber,
                        labelText: "Supervisor’s Mobile Number",
                        keyboardType: TextInputType.text,
                        padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _supervisorMobileNumberError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_supervisorMobileNumberError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.checkBoxTile,
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.cityNameController,
                        labelText: "City",
                        keyboardType: TextInputType.text,
                        padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _cityNameError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_cityNameError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.employeerController,
                        labelText: "Employer",
                        keyboardType: TextInputType.text,
                        padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _employerError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_employerError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.emergencyMobileNumber,
                        labelText: "Emergency Mobile Number",
                        keyboardType: TextInputType.text,
                        padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _emergencyMobileNumberError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_emergencyMobileNumberError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonTransparent(
                      text: "Cancel",
                      onPressed: () {
                        widget.onpressedClose();
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    isLoading
                        ? SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(color: ColorManager.blueprime))
                        : CustomElevatedButton(
                      text: "Save",
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                          _positionTitleError = widget.positionTitleController.text.isEmpty;
                          _leavingReasonError = widget.leavingResonController.text.isEmpty;
                          _startDateError = widget.startDateContoller.text.isEmpty;
                          _endDateError = widget.endDateController.text.isEmpty;
                          _lastSupervisorNameError = widget.lastSupervisorNameController.text.isEmpty;
                          _supervisorMobileNumberError = widget.supervisorMobileNumber.text.isEmpty;
                          _cityNameError = widget.cityNameController.text.isEmpty;
                          _employerError = widget.employeerController.text.isEmpty;
                          _emergencyMobileNumberError = widget.emergencyMobileNumber.text.isEmpty;
                        });
                        if (!_positionTitleError &&
                            !_leavingReasonError &&
                            !_startDateError &&
                            !_endDateError &&
                            !_lastSupervisorNameError &&
                            !_supervisorMobileNumberError &&
                            !_cityNameError &&
                            !_employerError &&
                            !_emergencyMobileNumberError) {
                          try {
                            await widget.onpressedSave();
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                            widget.startDateContoller.clear();
                            widget.endDateController.clear();
                            widget.leavingResonController.clear();
                            widget.cityNameController.clear();
                            widget.lastSupervisorNameController.clear();
                            widget.supervisorMobileNumber.clear();
                            widget.employeerController.clear();
                            widget.positionTitleController.clear();
                            widget.emergencyMobileNumber.clear();
                          }
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
