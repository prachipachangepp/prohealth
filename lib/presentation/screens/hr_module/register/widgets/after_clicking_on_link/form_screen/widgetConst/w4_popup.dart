import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import '../../../../../../../../data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
import '../../../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';
import 'form_screen_const.dart';

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
     // statusError = _validateTextField(statusController.text, 'married status');
      step3aError = _validateTextField(step3aController.text, 'step 3a');
      step3bError = _validateTextField(step3bController.text, 'step 3b');
      step3cError = _validateTextField(step3cController.text, 'step 3c');
      // step4aError = _validateTextField(step4aController.text, 'step 4a');
      // step4bError = _validateTextField(step4bController.text, 'step 4b');
      // step4cError = _validateTextField(step4cController.text, 'step 4c');
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

  bool allergies1 = false;
  bool allergies2 = false;
  bool allergies3 = false;

  int _getIntValue(TextEditingController controller) {
    return int.tryParse(controller.text.trim()) ?? 0;
  }

  String _getMarriedStatus() {
    if (allergies1) return "Single or Married filing separately";
    if (allergies2) return "Married filing jointly or Qualifying surviving spouse";
    if (allergies3) return "Head of household";
    return "Not specified"; // Default value if none selected
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text( AppStringLegalDocument.popupMsgHead,
                    style:  LegalDocumentPopupMessage.customTextStyle(context),),
                ],
              ),
              SizedBox(height: AppSize.s25),
              Row(
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
                      SizedBox(height: AppSize.s9),
                      Text(
                        'Married Status',style: AllPopupHeadings.customTextStyle(context),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: allergies1,
                            onChanged: (bool? value) {
                              setState(() {
                                allergies1 = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Single or Married filing separately',
                            style: AllNoDataAvailable.customTextStyle(context),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: allergies2,
                            onChanged: (bool? value) {
                              setState(() {
                                allergies2 = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Married filing jointly or Qualifying surviving spouse',
                            style: AllNoDataAvailable.customTextStyle(context),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: allergies3,
                            onChanged: (bool? value) {
                              setState(() {
                                allergies3 = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Head of household',
                            style: AllNoDataAvailable.customTextStyle(context),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s9),
                      Text('Step 3: Claim  Dependent  and Other  Credits',
                      style: AllPopupHeadings.customTextStyle(context),),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: step3aController, text: 'Step 3a - If your total income will be \$200,000 or less (\$400,000 or less if married filing jointly): Multiply the number of qualifying children under age 17 by \$2,000'),
                      if (step3aError != null)
                        Text(
                          step3aError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: step3bController, text: 'Step3b- Multiply the number of other dependents by \$500'),
                      if (step3bError != null)
                        Text(
                          step3bError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: step3cController, text: 'Step 3c- Add the amounts above for qualifying children and other dependents. You may add to  this the amount of any other credits. Enter the total here'),
                      if (step3cError != null)
                        Text(
                          step3cError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      Text('Step 4  (optional):  Other  Adjustments',
                        style: AllPopupHeadings.customTextStyle(context),),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: step4aController, text: 'Step 4a- Other income (not from jobs). If you want tax withheld for other income you expect  this year that won’t have withholding, enter the amount of other income here. This  may include interest, dividends, and retirement income'),
                      // if (step4aError != null)
                      //   Text(
                      //     step4aError!,
                      //     style: CommonErrorMsg.customTextStyle(context),
                      //   ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: step4bController, text: 'Step 4b – Deductions. If you expect to claim deductions other than the standard deduction  and want to reduce your withholding, use the Deductions Worksheet on page 3 and  enter the result here'),
                      // if (step4bError != null)
                      //   Text(
                      //     step4bError!,
                      //     style: CommonErrorMsg.customTextStyle(context),
                      //   ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: step4cController, text: 'Step 4c- Extra withholding. Enter any additional tax you want withheld each pay period'),
                      // if (step4cError != null)
                      //   Text(
                      //     step4cError!,
                      //     style: CommonErrorMsg.customTextStyle(context),
                      //   ),
                      SizedBox(height: AppSize.s9),
                      Text('Multiple Jobs Worksheet',
                        style: AllPopupHeadings.customTextStyle(context),),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: multipleJW1Controller, text: 'Multiple JW1- Two jobs. If you have two jobs or you’re married filing jointly and your spouse each have one job,  find the amount from the appropriate table on page 4. Using the “Higher Paying Job” row and the  “Lower Paying Job” column, find the value at the intersection of the two household salaries and  enter that value on line 1. Then, skip to line 3'),
                      if (multipleJW1Error != null)
                        Text(
                          multipleJW1Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      Container(
                        width: 354,
                        child: Text('Three jobs. If you and/or your spouse have three jobs at the same time, complete lines 2a, 2b, and  2c below. Otherwise, skip to line 3',
                          style: SearchDropdownConst.customTextStyle(context),),
                      ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: multipleJW12aController, text: 'Multiple JW2a-If you have two jobs or you’re married filing jointly and your spouse each have one job,  find the amount from the appropriate table on page 4. Using the “Higher Paying Job” row and the  “Lower Paying Job” column, find the value at the intersection of the two household salaries and  enter that value on line 1. Then, skip to line 3'),
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
                      SizedBox(height: AppSize.s15),
                      SMNumberTextFConst(
                          controller: multipleJW12bController, text: 'Multiple JW2b- Add the annual wages of the two highest paying jobs from line 2a together and use the total  as the wages in the “Higher Paying Job” row and use the annual wages for your third job in the  “Lower Paying Job” column to find the amount from the appropriate table on page 4 and enter  this amount on line 2b'),
                      if (multipleJW12bError != null)
                        Text(
                          multipleJW12bError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                       SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: multipleJW12cController, text: 'Multiple JW2c- Add the amounts from lines 2a and 2b and enter the result on line 2c'),
                      if (multipleJW12cError != null)
                        Text(
                          multipleJW12cError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: multipleJW13Controller, text: 'Multiple JW3- Enter the number of pay periods per year for the highest paying job. For example, if that job pays  weekly, enter 52; if it pays every other week, enter 26; if it pays monthly, enter 12, etc'),
                      if (multipleJW13Error != null)
                        Text(
                          multipleJW13Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: multipleJW14Controller, text: 'Multiple JW4- Divide the annual amount on line 1 or line 2c by the number of pay periods on line 3. Enter this  amount here and in Step 4(c) of Form W-4 for the highest paying job (along with any other  additional amount you want withheld)'),
                      if (multipleJW14Error != null)
                        Text(
                          multipleJW14Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: dw1Controller, text: 'Deductions Worksheet 1- Enter an estimate of your 2023 itemized deductions (from Schedule A (Form 1040)). Such  deductions may include qualifying home mortgage interest, charitable contributions, state and  local taxes (up to \$10,000), and medical expenses in excess of 7.5% of your income'),
                      if (dw1Error != null)
                        Text(
                          dw1Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: dw2Controller, text: 'Deductions Worksheet 2- Enter: • \$27,700 if you’re married filing jointly or a qualifying surviving spouse • \$20,000 if you’re head of household • \$13,850 if you’re single or married filing separately'),
                      if (dw2Error != null)
                        Text(
                          dw2Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: dw3Controller, text: 'Deductions Worksheet 3- If line 1 is greater than line 2, subtract line 2 from line 1 and enter the result here. If line 2 is greater  than line 1, enter “-0-”'),
                      if (dw3Error != null)
                        Text(
                          dw3Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: dw4Controller, text: 'Deductions Worksheet 4- Enter an estimate of your student loan interest, deductible IRA contributions, and certain other  adjustments (from Part II of Schedule 1 (Form 1040)). See Pub. 505 for more information'),
                      if (dw4Error != null)
                        Text(
                          dw4Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                      SizedBox(height: AppSize.s9),
                      SMNumberTextFConst(
                          controller: dw5Controller, text: 'Deductions Worksheet 5- Add lines 3 and 4. Enter the result here and in Step 4(b) of Form W-4'),
                      if (dw5Error != null)
                        Text(
                          dw5Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                    ],
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
          onPressed: () async {_validateForm(); // Validate the form on button press
          if (_isFormValid) {
            setState(() {
              loading = true;
            });
            WFourDocument wfourDocument = await getW4Document(context: context, templateId: widget.htmlFormTemplateId, employeeId: widget.employeeId,
                middleName: nameController.text,
                marriedstatus: _getMarriedStatus(), step3a: int.parse(step3aController.text),
                step3b: int.parse(step3bController.text), step3c: int.parse(step3cController.text),
                step4a: _getIntValue(step4aController), // No validation, pass 0 if empty
                step4b: _getIntValue(step4bController), // No validation, pass 0 if empty
                step4c: _getIntValue(step4cController),
                multipleJW1: int.parse(multipleJW1Controller.text),
                multipleJW12a: int.parse(multipleJW12aController.text), multipleJW12b: int.parse(multipleJW12bController.text),
                multipleJW12c: int.parse(multipleJW12cController.text), multipleJW13: int.parse(multipleJW13Controller.text),
                multipleJW14: int.parse(multipleJW14Controller.text), deductionsWorksheet1: int.parse(dw1Controller.text),
                deductionsWorksheet2: int.parse(dw2Controller.text), deductionsWorksheet3: int.parse(dw3Controller.text),
                deductionsWorksheet4: int.parse(dw4Controller.text), deductionsWorksheet5: int.parse(dw5Controller.text));
            if(wfourDocument.statusCode == 200 || wfourDocument.statusCode == 201){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                documentName: wfourDocument.name,
                onPressed: () {

                },
                htmlFormData: wfourDocument.html,
                employeeId: widget.employeeId,//widget.employeeID,
                htmlFormTemplateId: wfourDocument.wFourDocumentId,)));
            }

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
