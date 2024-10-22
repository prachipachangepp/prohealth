import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';
import 'form_screen_const.dart';


class FlueVaccineSignPopup extends StatefulWidget {
  final int employeeId;
  final int htmlFormTemplateId;
  const FlueVaccineSignPopup({super.key, required this.employeeId, required this.htmlFormTemplateId});

  @override
  State<FlueVaccineSignPopup> createState() => _FlueVaccineSignPopupState();
}

class _FlueVaccineSignPopupState extends State<FlueVaccineSignPopup> {
  TextEditingController dateOfvaccinationController = TextEditingController();
  TextEditingController siteOfAdministrationController = TextEditingController();
  TextEditingController vaccineTypeController = TextEditingController();
  TextEditingController doseController = TextEditingController();
  TextEditingController reactionsController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();

 // TextEditingController dateofVaccinationController = TextEditingController();
  TextEditingController nameOfAdministeringController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController acknowledgeFactsController = TextEditingController();
  TextEditingController AllergisController = TextEditingController();
  bool loading = false;
  bool _isFormValid = true;
  String? dateOfvaccinationError;
  String? siteOfAdministrationError;
  String? vaccineTypeError;
  String? doseError;
  String? reactionsError;
  String? manufacturerError;

 // String? dateofVaccinationError;
  String? nameOfAdministeringError;
  String? address2Error;
  String? titleError;
  String? acknowledgeFactsError;
  String? AllergisError;
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
      dateOfvaccinationError = _validateTextField(dateOfvaccinationController.text, 'date of vaccination');
      siteOfAdministrationError = _validateTextField(siteOfAdministrationController.text, 'site of administration');
      vaccineTypeError = _validateTextField(vaccineTypeController.text, 'vaccine type');
      doseError = _validateTextField(doseController.text, 'dose');
      reactionsError = _validateTextField(reactionsController.text, 'reactions');
      manufacturerError = _validateTextField(manufacturerController.text, 'manufacturer');

    //dateofVaccinationError = _validateTextField(dateofVaccinationController.text, 'date of Vaccination');
      nameOfAdministeringError = _validateTextField(nameOfAdministeringController.text, 'name of administering');
      address2Error = _validateTextField(address2Controller.text, 'title');
      titleError = _validateTextField(titleController.text, 'provider address');
      acknowledgeFactsError = _validateTextField(acknowledgeFactsController.text, 'acknowledge facts');
      AllergisError = _validateTextField(AllergisController.text, 'allergis');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s800,
      height: AppSize.s610,
      title: "Flu Vaccine",
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
                    controller: siteOfAdministrationController,
                    keyboardType: TextInputType.text,
                    text: 'Site of Administration',
                  ),
                  if (siteOfAdministrationError != null)
                    Text(
                      siteOfAdministrationError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: vaccineTypeController,
                    keyboardType: TextInputType.text,
                    text: 'Vaccine Type',
                  ),
                  if (vaccineTypeError != null)
                    Text(
                      vaccineTypeError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: doseController,
                    keyboardType: TextInputType.text,
                    text: 'Dose',
                  ),
                  if (doseError != null)
                    Text(
                      doseError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: reactionsController,
                    keyboardType: TextInputType.text,
                    text: 'Reactions',
                  ),
                  if (reactionsError != null)
                    Text(
                      reactionsError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: manufacturerController,
                    keyboardType: TextInputType.text,
                    text: 'Manufacturer',
                  ),
                  if (manufacturerError != null)
                    Text(
                      manufacturerError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  FirstSMTextFConst(
                    controller: dateOfvaccinationController,
                    keyboardType: TextInputType.text,
                    text: 'Date of Vaccination',
                    showDatePicker: true,
                  ),
                  if (dateOfvaccinationError != null)
                    Text(
                      dateOfvaccinationError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FirstSMTextFConst(
                  //   controller: dateofVaccinationController,
                  //   keyboardType: TextInputType.text,
                  //   text: 'Date',
                  // ),
                  // if (dateofVaccinationError != null) // Display error if any
                  //   Text(
                  //     dateofVaccinationError!,
                  //     style: CommonErrorMsg.customTextStyle(context),
                  //   ),
                  //
                  // SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: nameOfAdministeringController,
                    keyboardType: TextInputType.text,
                    text: 'Name of Administering',
                  ),
                  if (nameOfAdministeringError != null)
                    Text(
                      nameOfAdministeringError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    text: 'Title',
                  ),
                  if (titleError != null)
                    Text(
                      titleError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: address2Controller,
                    keyboardType: TextInputType.text,
                    text: 'Provider Address',
                  ),
                  if (address2Error != null)
                    Text(
                      address2Error!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: acknowledgeFactsController,
                    keyboardType: TextInputType.text,
                    text: 'Acknowledge Facts',
                  ),
                  if (acknowledgeFactsError != null)
                    Text(
                      acknowledgeFactsError!,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: AppSize.s6),
                  SMTextFConst(
                    controller: AllergisController,
                    keyboardType: TextInputType.text,
                    text: 'Allergis',
                  ),
                  if (AllergisError != null)
                    Text(
                      AllergisError!,
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
