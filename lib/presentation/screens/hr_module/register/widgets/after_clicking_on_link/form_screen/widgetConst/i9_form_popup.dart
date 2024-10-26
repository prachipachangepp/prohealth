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
      height: AppSize.s575,
      title: "i-9 form",
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( AppStringLegalDocument.popupMsgHead,
                style:  LegalDocumentPopupMessage.customTextStyle(context),),
              SizedBox(height: AppSize.s25),
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
              SizedBox(height: AppSize.s8),
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
              SizedBox(height: AppSize.s8),
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
              SizedBox(height: AppSize.s8),
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
              SizedBox(height: AppSize.s8),
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

            INineDocument iNineDocument = await getI9Document(context: context, i9FormhtmlId: widget.htmlFormTemplateId, employeeId: widget.employeeId,
                middleName: nameController.text, otherLastName: lastNameController.text, aptNumber: aptNumController.text, alienInfo: alienInfoController.text,
                citizenship: citizenshipController.text);
            if(iNineDocument.statusCode == 200 || iNineDocument.statusCode == 201){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                documentName: iNineDocument.name,
                onPressed: () {

                },
                htmlFormData: iNineDocument.html,
                employeeId: widget.employeeId,//widget.employeeID,
                htmlFormTemplateId: iNineDocument.iNineDocumentId,)));
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
