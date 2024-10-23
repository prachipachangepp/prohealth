import 'package:flutter/material.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';

class INineSignPopup extends StatefulWidget {
  final int employeeId;
  final int htmlFormTemplateId;
  const INineSignPopup({super.key, required this.employeeId, required this.htmlFormTemplateId});

  @override
  State<INineSignPopup> createState() => _INineSignPopupState();
}

class _INineSignPopupState extends State<INineSignPopup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController aptNumController = TextEditingController();
  TextEditingController alienInfoController = TextEditingController();
  TextEditingController citizenshipController = TextEditingController();

  bool loading = false;
  bool _isFormValid = true;
  String? citizenshipError;
  String? nameError;
  String? lastNameError;
  String? aptNumError;
  String? alienError;
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
      citizenshipError = _validateTextField(citizenshipController.text, 'citizenship');
      nameError = _validateTextField(nameController.text, 'name');
      lastNameError = _validateTextField(lastNameController.text, 'last name');
      aptNumError = _validateTextField(aptNumController.text, 'apt number');
      alienError = _validateTextField(alienInfoController.text, 'alien info');
 });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s540,
      title: "i-9 form",
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
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
                controller: lastNameController,
                keyboardType: TextInputType.text,
                text: 'Last Name',
              ),
              if (lastNameError != null)
                Text(
                  lastNameError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s6),
              SMTextFConst(
                controller: aptNumController,
                keyboardType: TextInputType.text,
                text: 'ATP Number',
              ),
              if (aptNumError != null)
                Text(
                  aptNumError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s6),
              SMTextFConst(
                controller: alienInfoController,
                keyboardType: TextInputType.text,
                text: 'Alien Info',
              ),
              if (alienError != null)
                Text(
                  alienError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s6),
              FirstSMTextFConst(
                controller: citizenshipController,
                keyboardType: TextInputType.text,
                text: 'Citizenship',
              ),
              if (citizenshipError != null)
                Text(
                  citizenshipError!,
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
          onPressed: () async {_validateForm(); // Validate the form on button press
          if (_isFormValid) {
            setState(() {
              loading = true;
            });

            // FluVaccineDocument fluVaccineDocument = await getFluVaccineDocument(context: context, templateId: widget.htmlFormTemplateId, employeeId: widget.employeeId,
            //     dateOfVaccine: dateOfvaccinationController.text, siteOfAdministration: siteOfAdministrationController.text,
            //     vaccineType: vaccineTypeController.text, dose: doseController.text, reactions: reactionsController.text,
            //     manufacturer: manufacturerController.text, dateofVaccination: dateOfvaccinationController.text,
            //     nameOfAdministering: nameOfAdministeringController.text, title: titleController.text,
            //     providerAddress: address2Controller.text, acknowledgeFacts: acknowledgeFactsController.text, Allergis: AllergisController.text);
            // if(fluVaccineDocument.statusCode == 200 || fluVaccineDocument.statusCode == 201){
            //   Navigator.pop(context);
            //   Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
            //     documentName: fluVaccineDocument.name,
            //     onPressed: () {
            //
            //     },
            //     htmlFormData: fluVaccineDocument.html,
            //     employeeId: widget.employeeId,//widget.employeeID,
            //     htmlFormTemplateId: fluVaccineDocument.fluVaccineDocumentId,)));
            // }


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
