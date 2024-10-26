import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';
import 'form_screen_const.dart';

class EmploymentAppSignPopup extends StatefulWidget {
  final int employeeId;
  final int htmlFormTemplateId;
  const EmploymentAppSignPopup({super.key, required this.employeeId, required this.htmlFormTemplateId});

  @override
  State<EmploymentAppSignPopup> createState() => _EmploymentAppSignPopupState();
}

class _EmploymentAppSignPopupState extends State<EmploymentAppSignPopup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController faxNoController = TextEditingController();
  TextEditingController hiredController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController positionDesiredController = TextEditingController();

  TextEditingController dateAvailableController = TextEditingController();
  TextEditingController specifyWorkHrController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  bool loading = false;
  bool _isFormValid = true;
  String? nameError;
  String? faxError;
  String? hiredError;
  String? positionError;
  String? positionDesireError;

  String? dateError;
  String? specifyError;
  String? salaryError;
  String? sourceError;
  String? valueError;
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
      nameError = _validateTextField(nameController.text, 'middle name');
      faxError = _validateTextField(faxNoController.text, 'fax no');
      hiredError = _validateTextField(hiredController.text, 'hired status');
      positionError = _validateTextField(positionController.text, 'position applying');
      positionDesireError = _validateTextField(positionDesiredController.text, 'position desired');

      dateError = _validateTextField(dateAvailableController.text, 'date available');
      specifyError = _validateTextField(specifyWorkHrController.text, 'specify working hours');
      salaryError = _validateTextField(salaryController.text, 'salary');
      sourceError = _validateTextField(sourceController.text, 'referral source');
      valueError = _validateTextField(valueController.text, 'value');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s800,
      height: AppSize.s580,
      title: "Employment Application",
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( AppStringLegalDocument.popupMsgHead,
                    style:  LegalDocumentPopupMessage.customTextStyle(context),),
                  SizedBox(height: AppSize.s20),
                  FirstSMTextFConst(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    text: 'Middle Name',
                  ),
                  if (nameError != null) // Display error if any
                    Text(
                      nameError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),

                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: faxNoController,
                    keyboardType: TextInputType.text,
                    text: 'Fax No.',
                  ),
                  if (faxError != null)
                    Text(
                      faxError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: hiredController,
                    keyboardType: TextInputType.text,
                    text: 'Hired',
                  ),
                  if (hiredError != null)
                    Text(
                      hiredError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: positionController,
                    keyboardType: TextInputType.text,
                    text: 'Position Applying',
                  ),
                  if (positionError != null)
                    Text(
                      positionError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: positionDesiredController,
                    keyboardType: TextInputType.text,
                    text: 'Desired Position',
                  ),
                  if (positionDesireError != null)
                    Text(
                      positionDesireError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FirstSMTextFConst(
                    controller: dateAvailableController,
                    keyboardType: TextInputType.text,
                    text: 'Available Date',
                    showDatePicker: true,
                  ),
                  if (dateError != null) // Display error if any
                    Text(
                      dateError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),

                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: specifyWorkHrController,
                    keyboardType: TextInputType.text,
                    text: 'Specify Work Hours',
                  ),
                  if (specifyError != null)
                    Text(
                      specifyError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: sourceController,
                    keyboardType: TextInputType.text,
                    text: 'Salary',
                  ),
                  if (sourceError != null)
                    Text(
                      sourceError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: salaryController,
                    keyboardType: TextInputType.text,
                    text: 'Referral',
                  ),
                  if (salaryError != null)
                    Text(
                      salaryError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: valueController,
                    keyboardType: TextInputType.text,
                    text: 'Value',
                  ),
                  if (valueError != null)
                    Text(
                      valueError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                ],
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
              EmploymentAppDocument employmentAppDocument = await getEmployeeApplicationDocument(context: context, employmentAppFormhtmlId: widget.htmlFormTemplateId, employeeId: widget.employeeId,
                  middleName: nameController.text, faxNo: faxNoController.text, ifHired: hiredController.text, positionApplying: positionController.text,
                  positionDesired: positionDesiredController.text, dateAvailable: dateAvailableController.text, specifyWorkingHrs: specifyWorkHrController.text,
                  salary: salaryController.text, sourceReferral: sourceController.text, value: valueController.text);
              if(employmentAppDocument.statusCode == 200 || employmentAppDocument.statusCode == 201){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                  documentName: employmentAppDocument.name,
                  onPressed: () {

                  },
                  htmlFormData: employmentAppDocument.html,
                  employeeId: widget.employeeId,//widget.employeeID,
                  htmlFormTemplateId: employmentAppDocument.EmpAppDocumentId,)));
              }


            };
           // finally {
            setState(() {
              loading = false;
              // Navigator.pop(context);
            });
            // }
          }
      )
      );
  }
}
