import 'package:flutter/material.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';
import 'form_screen_const.dart';

class DirectDepositeSignPopup extends StatefulWidget {
  final String documentName;
  final int employeeId;
  final int htmlFormTemplateId;
  final String htmlFormData;
  const DirectDepositeSignPopup({super.key, required this.documentName, required this.employeeId, required this.htmlFormTemplateId, required this.htmlFormData});

  @override
  State<DirectDepositeSignPopup> createState() => _DirectDepositeSignPopupState();
}

class _DirectDepositeSignPopupState extends State<DirectDepositeSignPopup> {
  TextEditingController actionController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController rountingController = TextEditingController();
  TextEditingController accOneController = TextEditingController();
  TextEditingController accTwoController = TextEditingController();
  bool loading = false;
  bool _isFormValid = true;
  String? actionError;
  String? typeError;
  String? addressError;
  String? bankNameError;
  String? routingError;
  String? accOneError;
  String? accTwoError;
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
      actionError = _validateTextField(actionController.text, 'action');
      typeError = _validateTextField(typeController.text, 'type');
      addressError = _validateTextField(addressController.text, 'address');
      bankNameError = _validateTextField(bankNameController.text, 'bank name');
      routingError = _validateTextField(rountingController.text, 'routing or transit');
      accOneError = _validateTextField(accOneController.text, 'account');
      accTwoError = _validateTextField(accTwoController.text, 'account');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s650,
      title: "Direct Deposite",
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FirstSMTextFConst(
                controller: actionController,
                keyboardType: TextInputType.text,
                text: 'Action 1',
              ),
              if (actionError != null) // Display error if any
                Text(
                  actionError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),

              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: typeController,
                keyboardType: TextInputType.text,
                text: 'Type 1',
              ),
              if (typeError != null)
                Text(
                  typeError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: bankNameController,
                keyboardType: TextInputType.text,
                text: 'Bank Name',
              ),
              if (bankNameError != null)
                Text(
                  bankNameError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: addressController,
                keyboardType: TextInputType.text,
                text: 'Address 1',
              ),
              if (addressError != null)
                Text(
                  addressError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: rountingController,
                keyboardType: TextInputType.text,
                text: 'Routing or Transit 1',
              ),
              if (routingError != null)
                Text(
                  routingError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: accOneController,
                keyboardType: TextInputType.text,
                text: 'Account 1',
              ),
              if (accOneError != null)
                Text(
                  accOneError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),

              SizedBox(height: AppSize.s8),
              SMTextFConst(
                controller: accTwoController,
                keyboardType: TextInputType.text,
                text: 'Account 1',
              ),
              if (accTwoError != null)
                Text(
                  accTwoError!,
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
