import 'package:flutter/material.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';

class WFourSignPopup extends StatefulWidget {
  final int employeeId;
  final int htmlFormTemplateId;
  const WFourSignPopup({super.key, required this.employeeId, required this.htmlFormTemplateId});

  @override
  State<WFourSignPopup> createState() => _WFourSignPopupState();
}

class _WFourSignPopupState extends State<WFourSignPopup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController step3aController = TextEditingController();
  TextEditingController step3bController = TextEditingController();
  TextEditingController step3cController = TextEditingController();
  TextEditingController step4aController = TextEditingController();
  TextEditingController step4bController = TextEditingController();
  TextEditingController step4cController = TextEditingController();
  TextEditingController multipleJW1Controller = TextEditingController();
  TextEditingController multipleJW12aController = TextEditingController();
  TextEditingController multipleJW12bController = TextEditingController();
  TextEditingController multipleJW12cController = TextEditingController();
  TextEditingController multipleJW13Controller = TextEditingController();
  TextEditingController multipleJW14Controller = TextEditingController();
  TextEditingController dw1Controller = TextEditingController();
  TextEditingController dw2Controller = TextEditingController();
  TextEditingController dw3Controller = TextEditingController();
  TextEditingController dw4Controller = TextEditingController();
  TextEditingController dw5Controller = TextEditingController();
  bool loading = false;
  bool _isFormValid = true;

  String? nameError;
  String? statusError;
  String? step3aError;
  String? step3bError;
  String? step3cError;
  String? step4aError;
  String? step4bError;
  String? step4cError;
  String? multipleJW1Error;
  String? multipleJW12aError;
  String? multipleJW12bError;
  String? multipleJW12cError;
  String? multipleJW13Error;
  String? multipleJW14Error;
  String? dw1Error;
  String? dw2Error;
  String? dw3Error;
  String? dw4Error;
  String? dw5Error;
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
      statusError = _validateTextField(statusController.text, 'married status');
      step3aError = _validateTextField(step3aController.text, 'step 3a');
      step3bError = _validateTextField(step3bController.text, 'step 3b');
      step3cError = _validateTextField(step3cController.text, 'step 3c');
      step4aError = _validateTextField(step4aController.text, 'step 4a');
      step4bError = _validateTextField(step4bController.text, 'step 4b');
      step4cError = _validateTextField(step4cController.text, 'step 4c');
      multipleJW1Error = _validateTextField(multipleJW1Controller.text, 'multiple jw1');
      multipleJW12aError = _validateTextField(multipleJW12aController.text, 'multiple jw12a');

      multipleJW12bError = _validateTextField(multipleJW12bController.text, 'multiple jw12b');
      multipleJW12cError = _validateTextField(multipleJW12cController.text, 'multiple jw12c');
      multipleJW13Error = _validateTextField(multipleJW13Controller.text, 'multiple jw13');
      multipleJW14Error = _validateTextField(multipleJW14Controller.text, 'multiple jw14');
      dw1Error = _validateTextField(dw1Controller.text, 'deduction worksheet 1');
      dw2Error = _validateTextField(dw2Controller.text, 'deduction worksheet 2');
      dw3Error = _validateTextField(dw3Controller.text, 'deduction worksheet 3');
      dw4Error = _validateTextField(dw4Controller.text, 'deduction worksheet 4');
      dw5Error = _validateTextField(dw5Controller.text, 'deduction worksheet 5');
    });
  }

  @override
  Widget build(BuildContext context) {
    return TerminationDialogueTemplate(
      width: AppSize.s800,
      height: AppSize.s610,
      title: "W4",
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
                  SMTextFConst(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    text: 'Middle Name',
                  ),
                  if (nameError != null)
                    Text(
                      nameError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: statusController,
                    keyboardType: TextInputType.text,
                    text: 'Married Status',
                  ),
                  if (statusError != null)
                    Text(
                      statusError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: step3aController,
                    keyboardType: TextInputType.text,
                    text: 'Step 3a',
                  ),
                  if (step3aError != null)
                    Text(
                      step3aError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: step3bController,
                    keyboardType: TextInputType.text,
                    text: 'Step 3b',
                  ),
                  if (step3bError != null)
                    Text(
                      step3bError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: step3cController,
                    keyboardType: TextInputType.text,
                    text: 'Step 3c',
                  ),
                  if (step3cError != null)
                    Text(
                      step3cError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: step4aController,
                    keyboardType: TextInputType.text,
                    text: 'Step 4a',
                  ),
                  if (step4aError != null)
                    Text(
                      step4aError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: step4bController,
                    keyboardType: TextInputType.text,
                    text: 'Step 4b',
                  ),
                  if (step4bError != null)
                    Text(
                      step4bError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: step4cController,
                    keyboardType: TextInputType.text,
                    text: 'Step 4c',
                  ),
                  if (step4cError != null)
                    Text(
                      step4cError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: multipleJW1Controller,
                    keyboardType: TextInputType.text,
                    text: 'Multiple JW1',
                  ),
                  if (multipleJW1Error != null)
                    Text(
                      multipleJW1Error!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: multipleJW12aController,
                    keyboardType: TextInputType.text,
                    text: 'Multiple JW12a',
                  ),
                  if (multipleJW12aError != null)
                    Text(
                      multipleJW12aError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SMTextFConst(
                    controller: multipleJW12bController,
                    keyboardType: TextInputType.text,
                    text: 'Multiple JW12b',
                  ),
                  if (multipleJW12bError != null)
                    Text(
                      multipleJW12bError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                   SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: multipleJW12cController,
                    keyboardType: TextInputType.text,
                    text: 'Multiple JW12c',
                  ),
                  if (multipleJW12cError != null)
                    Text(
                      multipleJW12cError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: multipleJW13Controller,
                    keyboardType: TextInputType.text,
                    text: 'Multiple JW13',
                  ),
                  if (multipleJW13Error != null)
                    Text(
                      multipleJW13Error!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: multipleJW14Controller,
                    keyboardType: TextInputType.text,
                    text: 'Multiple JW14',
                  ),
                  if (multipleJW14Error != null)
                    Text(
                      multipleJW14Error!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: dw1Controller,
                    keyboardType: TextInputType.text,
                    text: 'Deduction Worksheet 1',
                  ),
                  if (dw1Error != null)
                    Text(
                      dw1Error!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: dw2Controller,
                    keyboardType: TextInputType.text,
                    text: 'Deduction Worksheet 2',
                  ),
                  if (dw2Error != null)
                    Text(
                      dw2Error!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: dw3Controller,
                    keyboardType: TextInputType.text,
                    text: 'Deduction Worksheet 3',
                  ),
                  if (dw3Error != null)
                    Text(
                      dw3Error!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: dw4Controller,
                    keyboardType: TextInputType.text,
                    text: 'Deduction Worksheet 4',
                  ),
                  if (dw4Error != null)
                    Text(
                      dw4Error!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: dw5Controller,
                    keyboardType: TextInputType.text,
                    text: 'Deduction Worksheet 5',
                  ),
                  if (dw5Error != null)
                    Text(
                      dw5Error!,
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
          onPressed: () {_validateForm(); // Validate the form on button press
          if (_isFormValid) {
            setState(() {
              loading = true;
            });
            // DirectDepositDocuemnt directDepositDocuemnt = await getDirectDepositDocument(context: context, employeeId: widget.employeeId, templateId: widget.htmlFormTemplateId, action1:actionController.text, type1: typeController.text,
            //   bankNameAndAddress: bankNameController.text, routingOrtransit1: rountingController.text, account1: accountController.text, amount1: amountController.text, action2: action2Controller.text, type2: type2Controller.text, bankNameAndaddress2: bankName2Controller.text,
            //   routingOrtransit2: rounting2Controller.text, account2: account2Controller.text, amount2: amount2Controller.text, );
            // if(directDepositDocuemnt.statusCode == 200 || directDepositDocuemnt.statusCode == 201){
            //   Navigator.pop(context);
            //   Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
            //     documentName: directDepositDocuemnt.name,
            //     onPressed: () {
            //
            //     },
            //     htmlFormData: directDepositDocuemnt.html,
            //     employeeId: widget.employeeId,//widget.employeeID,
            //     htmlFormTemplateId: directDepositDocuemnt.directDepositDocuemntId,)));
            // }
            //

          };
          //finally {
          setState(() {
            loading = false;
            // Navigator.pop(context);
          });
            // }
          }
      ),);
  }
}
