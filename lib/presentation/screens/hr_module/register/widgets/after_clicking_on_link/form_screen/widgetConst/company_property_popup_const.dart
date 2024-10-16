import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';
import 'form_screen_const.dart';


class CompanyPropertySignPopup extends StatefulWidget {
  final int employeeId;
  final int htmlFormTemplateId;
  CompanyPropertySignPopup({super.key,required this.employeeId, required this.htmlFormTemplateId,});

  @override
  State<CompanyPropertySignPopup> createState() => _CompanyPropertySignPopupState();
}

class _CompanyPropertySignPopupState extends State<CompanyPropertySignPopup> {

   TextEditingController companyController = TextEditingController();
   TextEditingController specificationController = TextEditingController();
   TextEditingController supervisorController = TextEditingController();
  bool loading = false;
  bool _isFormValid = true;
  String? companyError;
  String? specificationError;
  String? supervisorError;
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
      companyError =
          _validateTextField(companyController.text, 'company property');
      specificationError = _validateTextField(specificationController.text, 'specifications');
      supervisorError = _validateTextField(supervisorController.text, 'supervisors name');
    });
  }
  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
        width: AppSize.s400,
        height: AppSize.s400,
        title: 'Return of Company Property',
        body: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FirstSMTextFConst(
                  controller: companyController,
                  keyboardType: TextInputType.text,
                  text: 'Company Property',
                ),
                if (companyError != null) // Display error if any
                  Text(
                    companyError!,
                    style: CommonErrorMsg.customTextStyle(context),
                  ),

                SizedBox(height: AppSize.s8),
                SMTextFConst(
                  controller: specificationController,
                  keyboardType: TextInputType.text,
                  text: 'Specification',
                ),
                if (specificationError != null)
                  Text(
                    specificationError!,
                    style: CommonErrorMsg.customTextStyle(context),
                  ),
                SizedBox(height: AppSize.s8),
                SMTextFConst(
                  controller: supervisorController,
                  keyboardType: TextInputType.text,
                  text: 'Supervisor Name',
                ),
                if (supervisorError != null)
                  Text(
                    supervisorError!,
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
                ReturnOfCompanyProperty returnOfCompanyProperty = await getReturnOfCompanyPropertyDocument(context: context, employeeId: widget.employeeId,templateId: widget.htmlFormTemplateId);
                if(returnOfCompanyProperty.statusCode == 200 || returnOfCompanyProperty.statusCode == 201){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                    documentName: returnOfCompanyProperty.name,
                    onPressed: () {

                    },
                    htmlFormData: returnOfCompanyProperty.html,
                    employeeId: widget.employeeId,//widget.employeeID,
                    htmlFormTemplateId: returnOfCompanyProperty.returnOfCompanyPropertyId,)
                  ));
                }
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

