import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/widgets/add_new_popup.dart';

import '../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';
import 'form_screen_const.dart';

class CandidateReleaseSignPopup extends StatefulWidget {
  final int employeeId;
  final int htmlFormTemplateId;

  const CandidateReleaseSignPopup({super.key, required this.employeeId, required this.htmlFormTemplateId,});

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
  bool _isSubmitted = false;
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
      middleError = _validateTextField(middleNameController.text, 'middle name');
      fullNameError = _validateTextField(fullNameController.text, 'full name');
      stateError = _validateTextField(stateLicenseController.text, 'state name');
      if (middleError != null || fullNameError != null || stateError != null) {
        _isFormValid = false;
      }
    });
  }




  List<String> _suggestions = [];
  @override
  void initState() {
    super.initState();
    addressController.addListener(_onCountyNameChanged);
    middleNameController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          middleError = _validateTextField(middleNameController.text, 'middle name');
        });
      }
    });

    fullNameController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          fullNameError = _validateTextField(fullNameController.text, 'full name');
        });
      }
    });
    stateLicenseController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          stateError = _validateTextField(stateLicenseController.text, 'state name');
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onCountyNameChanged() async {
    if (addressController.text.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }
    final suggestions = await fetchSuggestions(addressController.text);
    if (suggestions[0] == addressController.text) {
      setState(() {
        _suggestions.clear();
      });
    } else if (addressController.text.isEmpty) {
      setState(() {
        _suggestions = suggestions;
      });
    } else {
      setState(() {
        _suggestions = suggestions;
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: AppSize.s620,
      title: 'Candidate Release Form',
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( AppStringLegalDocument.popupMsgHead,
                style:  LegalDocumentPopupMessage.customTextStyle(context),),
              SizedBox(height: AppSize.s20),
              SMTextFConst(
                controller: fullNameController,
                keyboardType: TextInputType.text,
                text: 'Full Name as it appear on license',
              ),
              if (fullNameError != null)
                Text(
                  fullNameError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(height: AppSize.s7),
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

              SizedBox(height: AppSize.s7),
              SMTextFConst(
                controller: maidenSurnameController,
                keyboardType: TextInputType.text,
                text: 'Mainden Surname Alisa',
              ),
              SizedBox(height: AppSize.s7),
              Stack(
                children :[Column(
                  children: [
                    SMTextFConst(
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      text: 'Current Address',
                    ),
                  ],
                ),
          ]
              ),
              if (_suggestions.isNotEmpty)
                Container(
                  height: 70,
                  width: 520,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _suggestions[index],
                          style: TableSubHeading.customTextStyle(context),
                        ),
                        onTap: () {
                          FocusScope.of(context)
                              .unfocus(); // Dismiss the keyboard
                          String selectedSuggestion = _suggestions[index];
                          addressController.text = selectedSuggestion;

                          setState(() {
                            _suggestions.clear();
                            //_suggestions.removeWhere((suggestion) => suggestion == selectedSuggestion);
                          });
                        },
                      );
                    },
                  ),
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
            setState(() {
              _isSubmitted = true; // Mark form as submitted
              loading = true; // Start loading
            });
            _validateForm();
            if (!_isFormValid) {
              setState(() {
                loading = false;
              });
              return;
            }
            try{
              CandidateRealeaseDocument candidateRealeaseDocument = await getCandidateRealeaseDocument(context: context, employeeId: widget.employeeId,
                  candidateReleaseFormhtmlId: widget.htmlFormTemplateId, middleName: middleNameController.text,
                  maindenSurnameAlisa: maidenSurnameController.text.isEmpty ? AppConfig.dash : maidenSurnameController.text,
                  currentAddress: addressController.text.isEmpty ? AppConfig.dash : addressController.text,
                  stateIssuingLicense: stateLicenseController.text, fullName: fullNameController.text);
              if(candidateRealeaseDocument.statusCode == 200 || candidateRealeaseDocument.statusCode == 201){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                  isDisable:false,
                  documentName: candidateRealeaseDocument.name,
                  onPressed: () {
                  },
                  htmlFormData: candidateRealeaseDocument.html,
                  employeeId: widget.employeeId,//widget.employeeID,
                  htmlFormTemplateId: candidateRealeaseDocument.candidateRealeaseId,)
                ));
              }
            }
            finally {
            setState(() {
              loading = false;
            });
            }
          }
      ),);
  }
}
