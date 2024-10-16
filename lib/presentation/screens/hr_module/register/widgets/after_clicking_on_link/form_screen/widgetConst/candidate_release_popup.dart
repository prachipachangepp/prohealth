import 'package:flutter/material.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';
import 'form_screen_const.dart';

class CandidateReleaseSignPopup extends StatefulWidget {
  final String documentName;
  final int employeeId;
  final int htmlFormTemplateId;
  final String htmlFormData;
  const CandidateReleaseSignPopup({super.key, required this.documentName, required this.employeeId, required this.htmlFormTemplateId, required this.htmlFormData});

  @override
  State<CandidateReleaseSignPopup> createState() => _CandidateReleaseSignPopupState();
}

class _CandidateReleaseSignPopupState extends State<CandidateReleaseSignPopup> {

  TextEditingController middleNameController = TextEditingController();
  TextEditingController maidenSurnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController stateLicenseController = TextEditingController();
  bool loading = false;
  bool _isFormValid = true;
  String? middleError;
  String? maidenError;
  String? addressError;
  String? fullNameError;
  String? stateError;
  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid = true;
      middleError =
          _validateTextField(middleNameController.text, 'middle name');
      maidenError = _validateTextField(maidenSurnameController.text, 'mainden surname');
      addressError = _validateTextField(addressController.text, 'address');
      fullNameError = _validateTextField(fullNameController.text, 'full name');
      stateError = _validateTextField(stateLicenseController.text, 'state name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s550,
      title: 'Candidate Release Form',
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FirstSMTextFConst(
                controller: middleNameController,
                keyboardType: TextInputType.text,
                text: 'Middle Name',
              ),
              if (middleError != null) // Display error if any
                Text(
                  middleError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),

              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: maidenSurnameController,
                keyboardType: TextInputType.text,
                text: 'Mainden Surname Alisa',
              ),
              if (maidenError != null)
                Text(
                  maidenError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: addressController,
                keyboardType: TextInputType.text,
                text: 'Current Address',
              ),
              if (addressError != null)
                Text(
                  addressError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: fullNameController,
                keyboardType: TextInputType.text,
                text: 'Full Name',
              ),
              if (fullNameError != null)
                Text(
                  fullNameError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: stateLicenseController,
                keyboardType: TextInputType.text,
                text: 'State Issuing License',
              ),
              if (stateError != null)
                Text(
                  stateError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
            ],
          ),
        )
      ],
      bottomButtons: loading == true
          ? SizedBox(
        height: AppSize.s25,
        width: AppSize.s25,
        child: CircularProgressIndicator(
          color: ColorManager.blueprime,
        ),
      )
          : CustomElevatedButton(
          width: AppSize.s105,
          height: AppSize.s30,
          text: AppStringEM.submit,
          onPressed: () async {
            _validateForm(); // Validate the form on button press
            if (_isFormValid) {
              setState(() {
                loading = true;
              });
              Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                documentName: widget.documentName,
                onPressed: () {

                },
                htmlFormData: widget.htmlFormData,
                employeeId: widget.employeeId,//widget.employeeID,
                htmlFormTemplateId: widget.htmlFormTemplateId,)
              ));

            };
            //finally {
            setState(() {
              loading = false;
            });
            // }
          }
      ),);
  }
}
