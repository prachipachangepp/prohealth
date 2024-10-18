import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';

class AddReferencePopup extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController titlePositionController;
  final TextEditingController knowPersonController;
  final TextEditingController companyNameController;
  final TextEditingController associationLengthController;
  final TextEditingController mobileNumberController;
  final TextEditingController referredBy;
  final String title;
  VoidCallback onpressedClose;
  Future<void> Function() onpressedSave;
  AddReferencePopup(
      {super.key,
      required this.nameController,
      required this.emailController,
      required this.titlePositionController,
      required this.knowPersonController,
      required this.companyNameController,
      required this.associationLengthController,
      required this.mobileNumberController,
      required this.onpressedClose,
      required this.onpressedSave,
      required this.title,
      required this.referredBy});

  @override
  State<AddReferencePopup> createState() => _AddReferencePopupState();
}



class _AddReferencePopupState extends State<AddReferencePopup> {
  bool isLoading = false;

  // Error states
  Map<String, bool> errorStates = {
    'name': false,
    'email': false,
    'titlePosition': false,
    'knowPerson': false,
    'companyName': false,
    'associationLength': false,
    'mobileNumber': false,
    'referredBy': false,
  };

  // Email validation
  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.8 ,
        height: 480,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: AppSize.s50,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    child: Text(
                      widget.title,
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
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  controller: widget.nameController,
                  labelText: "Name",
                  errorKey: 'name',
                  capitalIsSelect: true,
                ),
                _buildTextField(
                  controller: widget.emailController,
                  labelText: "Email",
                  errorKey: 'email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => !_isEmailValid(value)
                      ? 'Please enter a valid email'
                      : null,
                  capitalIsSelect: false,
                  phoneNumberField: false,
                ),
                _buildTextField(
                  controller: widget.titlePositionController,
                  labelText: "Title/Position",
                  errorKey: 'titlePosition',
                  capitalIsSelect: true,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  controller: widget.knowPersonController,
                  labelText: "How do you know this person?",
                  errorKey: 'knowPerson',
                  capitalIsSelect: true,
                ),
                _buildTextField(
                  controller: widget.companyNameController,
                  labelText: "Company",
                  errorKey: 'companyName',
                  capitalIsSelect: true,
                ),
                _buildTextField(
                  controller: widget.associationLengthController,
                  labelText: "Length of Association",
                  errorKey: 'associationLength',
                  capitalIsSelect: true,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextField(
                  controller: widget.mobileNumberController,
                  labelText: "Mobile Number",
                   errorKey: 'mobileNumber',
                  keyboardType: TextInputType.number,
                  capitalIsSelect: false,
                  phoneNumberField:true,
                ),

                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 6,
                ),
                // _buildTextField(
                //   controller: widget.referredBy,
                //   labelText: "Referred By",
                //   errorKey: 'referredBy',
                //   capitalIsSelect: true,
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtonTransparent(text: AppString.cancel, onPressed: () {_clearControllers();}),
                const SizedBox(
                  width: AppSize.s10,
                ),
                isLoading
                    ? SizedBox(
                    height: AppSize.s25,
                    width: AppSize.s25,
                    child: CircularProgressIndicator(
                      color: ColorManager.blueprime,
                    ))
                    : CustomElevatedButton(
                  width: AppSize.s100,
                  text: AppString.save,
                  onPressed: _handleSave,
                ),
              ],
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
    TextInputType? keyboardType,
    String? Function(String)? validator,
    bool capitalIsSelect = false,
    bool phoneNumberField = false,// Add this parameter with a default value
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,style: AllPopupHeadings.customTextStyle(context),),
        SizedBox(height: 4,),
        CustomTextFieldRegister(
          phoneNumberField:  phoneNumberField,
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,

          keyboardType: keyboardType ?? TextInputType.text,
          padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
          capitalIsSelect: capitalIsSelect, // Pass the parameter here
          onChanged: (value) {
            setState(() {
              if (validator != null) {
                errorStates[errorKey] = validator(value) != null;
              } else {
                errorStates[errorKey] = value.isEmpty;
              }
              if (errorKey == 'mobileNumber') {
                // Validate phone number fields
                String numericValue = value.replaceAll(RegExp(r'^\(\d{4}\) \d{3}-\d{4}$'), '');
                errorStates[errorKey] = numericValue.length != 14;
              }
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter $labelText';
            }
            if (errorKey == 'mobileNumber') {
              String numericValue = value.replaceAll(RegExp(r'^\(\d{4}\) \d{3}-\d{4}$'), '');
              if (numericValue.length != 14) {
                return 'Please enter a valid mobile number';
              }
            }
            return null;
          },
        ),
        if (errorStates[errorKey]!)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              // errorKey == 'mobileNumber'
              //     ? 'Please Enter a valid mobile number'
              //     :
              errorKey == 'email'
                  ? 'Please Enter a valid email'
                  : 'Please Enter $labelText',
              style: TextStyle(
                color: ColorManager.red,
                fontSize: FontSize.s10,
              ),
            ),
          ),
      ],
    );
  }
  void _handleSave() async {
    setState(() {
      errorStates['name'] = widget.nameController.text.isEmpty;
      errorStates['email'] = !_isEmailValid(widget.emailController.text);
      errorStates['titlePosition'] = widget.titlePositionController.text.isEmpty;
      errorStates['knowPerson'] = widget.knowPersonController.text.isEmpty;
      errorStates['companyName'] = widget.companyNameController.text.isEmpty;
      errorStates['associationLength'] = widget.associationLengthController.text.isEmpty;
      errorStates['mobileNumber'] = widget.mobileNumberController.text.isEmpty;
      // errorStates['referredBy'] = widget.referredBy.text.isEmpty;
    });

    if (!errorStates.values.contains(true)) {
      try {
        setState(() {
          isLoading = true;
        });
        await widget.onpressedSave();
      } finally {
        setState(() {
          isLoading = false;
        });
        _clearControllers();
      }
     }
  }

  void _clearControllers() {
    widget.nameController.clear();
    widget.emailController.clear();
    widget.companyNameController.clear();
    widget.titlePositionController.clear();
    widget.mobileNumberController.clear();
    widget.associationLengthController.clear();
    widget.knowPersonController.clear();
    widget.referredBy.clear();
  }
}

