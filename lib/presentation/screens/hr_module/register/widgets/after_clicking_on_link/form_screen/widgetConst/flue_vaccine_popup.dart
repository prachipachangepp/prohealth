import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
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
  TextEditingController OtherController = TextEditingController();
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
  // String? acknowledgeFactsError;
  // String? AllergisError;
   String? OtherError;
  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }

  bool allergies1 = false;
  bool allergies2 = false;
  bool allergies3 = false;
  bool fact1 = false;
  bool fact2 = false;
  bool fact3 = false;
  bool fact4 = false;
  bool fact5 = false;
  bool fact6 = false;
  bool fact7 = false;

  String factOne = '';
  String factTwo = '';
  String factThree = '';
  String factFour = '';
  String factFive = '';
  String factSix = '';
  String factSeven = '';
  String allergie1 = '';
  String allergie2 = '';
  String allergie3 = '';

  String allergies = "";
  String facts = "";

  Future<String> _joinAllergies() async {
    allergies = allergie1 + allergie2 + allergie3 ;
    return allergies;
  }

  Future<String> _joinFacts() async {
    facts = factOne + factTwo + factThree + factFour + factFive + factSix + factSeven ;
    return allergies;
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
      // acknowledgeFactsError = _validateTextField(acknowledgeFactsController.text, 'acknowledge facts');
      // AllergisError = _validateTextField(AllergisController.text, 'allergis');
      OtherError = _validateTextField(OtherController.text, 'other if not mention NA');
    });
  }


  List<String> _suggestions = [];
  @override
  void initState() {
    super.initState();
    address2Controller.addListener(_onCountyNameChanged);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onCountyNameChanged() async {
    if (address2Controller.text.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }
    final suggestions = await fetchSuggestions(address2Controller.text);
    if (suggestions[0] == address2Controller.text) {
      setState(() {
        _suggestions.clear();
      });
    } else if (address2Controller.text.isEmpty) {
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
    return TerminationDialogueTemplate(
      width: AppSize.s850,
      height: AppSize.s610,
      title: "Flu Vaccine",
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(children: [
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SMTextFConst(
                        controller: nameOfAdministeringController,
                        keyboardType: TextInputType.text,
                        text: 'Name of Person Administering the Vaccine',
                      ),
                      if (nameOfAdministeringError != null)
                        Text(
                          nameOfAdministeringError!,
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
                      SizedBox(height: AppSize.s6),
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
                        text: 'Reactions, if any',
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
                        text: 'Manufacturer and Lot ',
                      ),
                      if (manufacturerError != null)
                        Text(
                          manufacturerError!,
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
                      Stack(
                        children :[Column(
                          children: [
                            SMTextFConst(
                              controller: address2Controller,
                              keyboardType: TextInputType.text,
                              text: 'Provider Address',
                            ),
                          ],
                        ),
                  ]
                      ),
                      if (_suggestions.isNotEmpty)
                        Container(
                          height: 70,
                          width: 354,
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
                                  style: AllPopupHeadings.customTextStyle(context),
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .unfocus(); // Dismiss the keyboard
                                  String selectedSuggestion = _suggestions[index];
                                  address2Controller.text = selectedSuggestion;

                                  setState(() {
                                    _suggestions.clear();
                                    //_suggestions.removeWhere((suggestion) => suggestion == selectedSuggestion);
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      if (address2Error != null)
                        Text(
                          address2Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                  
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSize.s10),
                      Text( 'Acknowledge Facts', style: AllPopupHeadings.customTextStyle(context),
                      ),
                      SizedBox(height: AppSize.s3),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              value: fact1,
                              onChanged: (bool? value) {
                                setState(() {
                                  fact1 = value ?? false;
                                  factOne = 'Influenza is a serious respiratory disease that kills an average of 36,000 persons and hospitalizes  more than 200,000 persons in the United States each year';
                                });
                              },
                            ),

                            Expanded(
                              child: Container(
                                child: Text(
                                  'Influenza is a serious respiratory disease that kills an average of 36,000 persons and hospitalizes  more than 200,000 persons in the United States each year',
                                  style: NumberTExtFieldLegalDoc.customTextStyle(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s3),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              value: fact2,
                              onChanged: (bool? value) {
                                setState(() {
                                  fact2 = value ?? false;
                                  factTwo = 'Influenza vaccination is recommended for all healthcare workers to protect patients from influenza  disease, its complications, and death';
                                });
                              },
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Influenza vaccination is recommended for all healthcare workers to protect patients from influenza  disease, its complications, and death',
                                  style: NumberTExtFieldLegalDoc.customTextStyle(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s3),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              value: fact3,
                              onChanged: (bool? value) {
                                setState(() {
                                  fact3= value ?? false;
                                  factThree = 'If I contract influenza, I will shed the virus for 24-48 hours before influenza symptoms appear. My  shedding the virus can spread influenza disease to patients in this facility';
                                });
                              },
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'If I contract influenza, I will shed the virus for 24-48 hours before influenza symptoms appear. My  shedding the virus can spread influenza disease to patients in this facility',
                                  style: NumberTExtFieldLegalDoc.customTextStyle(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s3),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              value: fact4,
                              onChanged: (bool? value) {
                                setState(() {
                                  fact4 = value ?? false;
                                  factFour =  'If I become infected with influenza, even when my symptoms are mild or non-existent, I can spread  severe illness to others. I understand that I will have to use a N95 respirator or surgical mask during my  shift per facility policy';
                                });
                              },
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'If I become infected with influenza, even when my symptoms are mild or non-existent, I can spread  severe illness to others. I understand that I will have to use a N95 respirator or surgical mask during my  shift per facility policy',
                                  style: NumberTExtFieldLegalDoc.customTextStyle(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s3),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              value: fact5,
                              onChanged: (bool? value) {
                                setState(() {
                                  fact5 = value ?? false;
                                  factFive =  'I understand that the strains of virus that cause influenza infection change almost every year, which  is why a different influenza vaccine is recommended each year';
                                });
                              },
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'I understand that the strains of virus that cause influenza infection change almost every year, which  is why a different influenza vaccine is recommended each year',
                                  style: NumberTExtFieldLegalDoc.customTextStyle(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s3),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              value: fact6,
                              onChanged: (bool? value) {
                                setState(() {
                                  fact6 = value ?? false;
                                  factSix =  'I understand that I cannot get influenza from the influenza vaccine';
                                });
                              },
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'I understand that I cannot get influenza from the influenza vaccine',
                                  style: NumberTExtFieldLegalDoc.customTextStyle(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s3),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              value: fact7,
                              onChanged: (bool? value) {
                                setState(() {
                                  fact7 = value ?? false;
                                  factSeven = 'The consequences of my refusing to be vaccinated could have life-threatening consequences to  my health and the health of those with whom I have contact, including my patients and other patients  in this healthcare setting my coworkers, my family, and my community';
                                });
                              },
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  'The consequences of my refusing to be vaccinated could have life-threatening consequences to  my health and the health of those with whom I have contact, including my patients and other patients  in this healthcare setting my coworkers, my family, and my community',
                                  style: NumberTExtFieldLegalDoc.customTextStyle(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s4),
                      ///allergies
                      Text( 'Allergies', style: AllPopupHeadings.customTextStyle(context),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: allergies1,
                            onChanged: (bool? value) {
                              setState(() {
                                allergies1 = value ?? false;
                                allergie1 = 'Allergy to eggs, chickens or chicken feathers';
                              });
                            },
                          ),
                          Text(
                            'Allergy to eggs, chickens or chicken feathers',
                            style: NumberTExtFieldLegalDoc.customTextStyle(context),
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
                                allergie2 = 'Guillain-Barre Syndrome or persistent neurological illness';
                              });
                            },
                          ),
                          Text(
                            'Guillain-Barre Syndrome or persistent neurological illness',
                            style:NumberTExtFieldLegalDoc.customTextStyle(context),
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
                                allergie3 =  'Severe allergy to other vaccine component';
                              });
                            },
                          ),
                          Text(
                            'Severe allergy to other vaccine component',
                            style: NumberTExtFieldLegalDoc.customTextStyle(context),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s4),
                      Text('OR',style: AllPopupHeadings.customTextStyle(context),),
                      SizedBox(height: AppSize.s4),
                      SMTextFConst(
                        controller: OtherController,
                        keyboardType: TextInputType.text,
                        text: 'Other Allergies',
                      ),
                      if (OtherError != null)
                        Text(
                          OtherError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],)

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
           await _joinAllergies();
           await _joinFacts();
          if (_isFormValid) {
            setState(() {
              loading = true;
            });

            FluVaccineDocument fluVaccineDocument = await getFluVaccineDocument(context: context, templateId: widget.htmlFormTemplateId, employeeId: widget.employeeId,
                dateOfVaccine: dateOfvaccinationController.text, siteOfAdministration: siteOfAdministrationController.text,
                vaccineType: vaccineTypeController.text, dose: doseController.text, reactions: reactionsController.text,
                manufacturer: manufacturerController.text, dateofVaccination: dateOfvaccinationController.text,
                nameOfAdministering: nameOfAdministeringController.text, title: titleController.text,
                providerAddress: address2Controller.text,
                acknowledgeFacts: facts,
                Allergis: allergies, other: OtherController.text);

            if(fluVaccineDocument.statusCode == 200 || fluVaccineDocument.statusCode == 201){
              print(allergies);
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                documentName: fluVaccineDocument.name,
                onPressed: () {

                },
                htmlFormData: fluVaccineDocument.html,
                employeeId: widget.employeeId,//widget.employeeID,
                htmlFormTemplateId: fluVaccineDocument.fluVaccineDocumentId,)));
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
