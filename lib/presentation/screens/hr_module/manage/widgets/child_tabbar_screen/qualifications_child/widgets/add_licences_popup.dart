import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';


class AddLicencesPopup extends StatefulWidget {
  final TextEditingController LivensureController;
  final TextEditingController issueDateController;
  final TextEditingController expiryDateController;
  final TextEditingController issuingOrganizationController;
  final TextEditingController countryController;
  final TextEditingController numberIDController;
  final String title;
  final Widget child;
  final VoidCallback onpressedClose;
  final Future<void> Function() onpressedSave;

  AddLicencesPopup({
    super.key,
    required this.LivensureController,
    required this.issueDateController,
    required this.expiryDateController,
    required this.issuingOrganizationController,
    required this.countryController,
    required this.numberIDController,
    required this.onpressedClose,
    required this.onpressedSave,
    required this.title,
    required this.child,
  });

  @override
  State<AddLicencesPopup> createState() => _AddLicencesPopupState();
}

class _AddLicencesPopupState extends State<AddLicencesPopup> {
  final DateTime _selectedIssueDate = DateTime.now();
  final DateTime _selectedExpDate = DateTime.now();
  dynamic pickedFile;
  String? pickedFileName;
  bool isLoading = false;

  // Error states for validations
  Map<String, bool> errorStates = {
    'Livensure': false,
    'issueDate': false,
    'expiryDate': false,
    'issuingOrganization': false,
    'country': false,
    'numberID': false,
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.7,
        height: MediaQuery.of(context).size.height / 1.7,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height:AppSize.s50,
              decoration:  BoxDecoration(
                color: ColorManager.blueprime,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 21),
                      child: Text(
                          widget.title,
                          style: PopupHeadingStyle.customTextStyle(context)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
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
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.child,
                  const SizedBox(
                    width: 20,
                  ),
                  ///upload
                  CustomIconButton(
                    icon: Icons.file_upload_outlined,
                    text: 'Upload License',
                    onPressed: () async {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                      );
                      if (result != null) {
                        setState(() {
                          pickedFileName = result.files.first.name;
                          pickedFile = result.files.first.bytes;
                        });

                        print('File picked: $pickedFileName');
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            pickedFileName == null
                ? const Offstage()
                : Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text(
                  pickedFileName!,
                  style: GoogleFonts.firaSans(
                      fontSize: FontSize.s10,
                      color: ColorManager.mediumgrey),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  capitalIsSelect: true,
                  controller: widget.LivensureController,
                  labelText: "Livensure/Certification",
                  errorKey: 'Livensure',
                ),
                _buildDateField(
                  controller: widget.issueDateController,
                  labelText: "Issue Date",
                  errorKey: 'issueDate',
                  initialDate: _selectedIssueDate,
                ),
                _buildDateField(
                  controller: widget.expiryDateController,
                  labelText: "Expiry Date",
                  errorKey: 'expiryDate',
                  initialDate: _selectedExpDate,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  capitalIsSelect:true,
                  controller: widget.issuingOrganizationController,
                  labelText: "Issuing Organization",
                  errorKey: 'issuingOrganization',
                ),
                _buildTextField(
                  capitalIsSelect: true,
                  controller: widget.countryController,
                  labelText: "Country",
                  errorKey: 'country',
                ),
                _buildTextField(
                  capitalIsSelect:false,
                  controller: widget.numberIDController,
                  labelText: "Number/ID",
                  errorKey: 'numberID',
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButtonTransparent(
                      text: AppString.cancel,
                      onPressed: () async {
                        widget.onpressedClose();
                      }),
                  const SizedBox(
                    width:  AppSize.s10,
                  ),
                  isLoading
                      ? SizedBox(
                      width:  AppSize.s25,
                      height:  AppSize.s25,
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ))
                      : CustomElevatedButton(
                    width: AppSize.s100,
                    text: AppString.save,
                    onPressed: () async {
                      setState(() {
                        _validateFields();
                      });

                      if (!_hasErrors()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await widget.onpressedSave();
                          _clearControllers();
                        } finally {
                          setState(() {
                            isLoading = false;
                          });

                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String errorKey,
    required bool capitalIsSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldRegister(
          capitalIsSelect: capitalIsSelect,
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
          labelText: labelText,
          keyboardType: TextInputType.text,
          padding: const EdgeInsets.only(
              bottom: AppPadding.p5, left: AppPadding.p20),
          onChanged: (value) {
            setState(() {
              errorStates[errorKey] = value.isEmpty;
            });
          },
        ),
        if (errorStates[errorKey]!)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Please Enter $labelText',
              style: TextStyle(
                color: ColorManager.red,
                fontSize: FontSize.s10,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String labelText,
    required String errorKey,
    required DateTime initialDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldRegister(
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
          labelText: labelText,
          keyboardType: TextInputType.text,
          suffixIcon: Icon(
            Icons.calendar_month_outlined,
            color: ColorManager.blueprime,
          ),
          padding: const EdgeInsets.only(
              bottom: AppPadding.p5, left: AppPadding.p20),
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(1100),
              lastDate: DateTime(2025),
            );
            if (date != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(date);
              setState(() {
                controller.text = formattedDate;
                errorStates[errorKey] = controller.text.isEmpty;
              });
            }
          },
          onChanged: (value) {
            setState(() {
              errorStates[errorKey] = value.isEmpty;
            });
          },
        ),
        if (errorStates[errorKey]!)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Please select a valid $labelText',
              style: TextStyle(
                color: ColorManager.red,
                fontSize: FontSize.s10,
              ),
            ),
          ),
      ],
    );
  }

  void _validateFields() {
    errorStates.forEach((key, value) {
      setState(() {
        if (key == 'Livensure' && widget.LivensureController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'issueDate' && widget.issueDateController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'expiryDate' && widget.expiryDateController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'issuingOrganization' &&
            widget.issuingOrganizationController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'country' && widget.countryController.text.isEmpty) {
          errorStates[key] = true;
        }
        if (key == 'numberID' && widget.numberIDController.text.isEmpty) {
          errorStates[key] = true;
        }
      });
    });
  }

  bool _hasErrors() {
    return errorStates.containsValue(true);
  }

  void _clearControllers() {
    widget.LivensureController.clear();
    widget.issuingOrganizationController.clear();
    widget.issueDateController.clear();
    widget.expiryDateController.clear();
    widget.countryController.clear();
    widget.numberIDController.clear();
    setState(() {
      pickedFileName = null;
      errorStates.updateAll((key, value) => false);
    });
  }
}
