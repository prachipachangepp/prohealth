import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
import '../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import '../../../../../../../widgets/error_popups/failed_popup.dart';
import '../../../../../../../widgets/error_popups/four_not_four_popup.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/dialogue_template.dart';
import '../../../../../../em_module/widgets/header_content_const.dart';
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
  TextEditingController nameOfAdministeringController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController OtherController = TextEditingController();
  bool loading = false;
  bool _isFormValid = true;
  bool _isSubmitted = false;
  String? dateOfvaccinationError;
  String? siteOfAdministrationError;
  String? vaccineTypeError;
  String? doseError;
  String? reactionsError;
  String? manufacturerError;
  String? nameOfAdministeringError;
  String? address2Error;
  String? titleError;

  String? _addressDocError;
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
      manufacturerError = _validateTextField(manufacturerController.text, 'manufacturer');
      nameOfAdministeringError = _validateTextField(nameOfAdministeringController.text, 'name of administering');
      titleError = _validateTextField(titleController.text, 'title');
      address2Error = _validateTextField(address2Controller.text, 'provider address');
      if (dateOfvaccinationError != null || siteOfAdministrationError != null || vaccineTypeError != null ||
      doseError != null || manufacturerError != null || nameOfAdministeringError != null || address2Error != null || titleError != null ) {
        _isFormValid = false;
      }
     });
  }

  List<String> _suggestions = [];
  @override
  void initState() {
    super.initState();
    address2Controller.addListener(_onCountyNameChanged);

    dateOfvaccinationController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          dateOfvaccinationError = _validateTextField(dateOfvaccinationController.text, 'date of vaccine');
        });
      }
    });

    siteOfAdministrationController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          siteOfAdministrationError = _validateTextField(siteOfAdministrationController.text, 'site of administration');
        });
      }
    });

    vaccineTypeController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          vaccineTypeError = _validateTextField(vaccineTypeController.text, 'vaccine type');
        });
      }
    });

    doseController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          doseError = _validateTextField(doseController.text, 'dose');
        });
      }
    });

    manufacturerController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          manufacturerError = _validateTextField(manufacturerController.text, 'manufacturer name');
        });
      }
    });

    nameOfAdministeringController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          nameOfAdministeringError = _validateTextField(nameOfAdministeringController.text, 'name of administeringController');
        });
      }
    });

    titleController.addListener(() {
      if (_isSubmitted) {
        setState(() {
          titleError = _validateTextField(titleController.text, 'title');
        });
      }
    });
    address2Controller.addListener(() {
      if (_isSubmitted) {
        setState(() {
          address2Error = _validateTextField(address2Controller.text, 'address');
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  DateTime? datePicked;

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
                      SMTextfieldAsteric(
                        controller: nameOfAdministeringController,
                        keyboardType: TextInputType.text,
                        text: 'Name of Person Administering the Vaccine',
                      ),
                      nameOfAdministeringError != null ?
                        Text(
                          nameOfAdministeringError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ) : SizedBox(height: AppSize.s12,),
                      SizedBox(height: AppSize.s6),
                      HeaderContentConst(
                        heading: 'Date of Vaccination',
                        isAsterisk: true,
                        content: FormField<String>(
                          builder: (FormFieldState<String> field) {
                            return SizedBox(
                              width: 354,
                              height: 30,
                              child: TextFormField(
                                controller: dateOfvaccinationController,
                                cursorColor: ColorManager.black,
                                style: DocumentTypeDataStyle.customTextStyle(context),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.containerBorderGrey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.containerBorderGrey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  //hintText: 'yyyy-mm-dd',
                                  hintStyle: DocumentTypeDataStyle.customTextStyle(context),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: ColorManager.containerBorderGrey,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                  suffixIcon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: ColorManager.blueprime,
                                  ),
                                  errorText: field.errorText,
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1901),
                                    lastDate: DateTime(3101),
                                  );
                                  if (pickedDate != null) {
                                    datePicked = pickedDate;
                                    dateOfvaccinationController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a date';
                                  }
                                  return null;
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      dateOfvaccinationError != null ?
                        Text(
                          dateOfvaccinationError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ) : SizedBox(height: AppSize.s12,),
                      SizedBox(height: AppSize.s6),
                      SMTextfieldAsteric(
                        controller: siteOfAdministrationController,
                        keyboardType: TextInputType.text,
                        text: 'Site of Administration',
                      ),
                      siteOfAdministrationError != null ?
                        Text(
                          siteOfAdministrationError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ): SizedBox(height: AppSize.s12,),
                      SizedBox(height: AppSize.s6),
                      SMTextfieldAsteric(
                        controller: vaccineTypeController,
                        keyboardType: TextInputType.text,
                        text: 'Vaccine Type',
                      ),
                      vaccineTypeError != null ?
                        Text(
                          vaccineTypeError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ): SizedBox(height: AppSize.s12,),
                      SizedBox(height: AppSize.s6),
                      SMTextfieldAsteric(
                        controller: doseController,
                        keyboardType: TextInputType.text,
                        text: 'Dose',
                      ),
                      doseError != null ?
                        Text(
                          doseError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ): SizedBox(height: AppSize.s12,),
                      SizedBox(height: AppSize.s6),
                      SMTextFConst(
                        controller: reactionsController,
                        keyboardType: TextInputType.text,
                        text: 'Reactions, if any',
                      ),
                      SizedBox(height: AppSize.s6),
                      SMTextfieldAsteric(
                        controller: manufacturerController,
                        keyboardType: TextInputType.text,
                        text: 'Manufacturer and Lot ',
                      ),
                      manufacturerError != null ?
                        Text(
                          manufacturerError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ): SizedBox(height: AppSize.s12,),
                      SizedBox(height: AppSize.s6),
                      SMTextfieldAsteric(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        text: 'Title',
                      ),
                      titleError != null ?
                        Text(
                          titleError!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ): SizedBox(height: AppSize.s12,),
                      SizedBox(height: AppSize.s6),
                      // SMTextFConst(
                      //   controller: address2Controller,
                      //   keyboardType: TextInputType.text,
                      //   text: 'Provider Address',
                      // ),
                      AddressInput(
                        controller: address2Controller,
                        onSuggestionSelected: (selectedSuggestion) {
                          // Handle the selected suggestion here
                          print("Selected suggestion: $selectedSuggestion");
                        },
                        onChanged: (String value) {
                          // Validate when user types in the address field

                        },
                      ),

                      address2Error != null ?
                        Text(
                          address2Error!,
                          style: CommonErrorMsg.customTextStyle(context),
                        ): SizedBox(height: AppSize.s12,),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSize.s6),
                      RichText(
                        text: TextSpan(
                          text: 'Acknowledge Facts ', // Main text
                          style: AllPopupHeadings.customTextStyle(context), // Apply the custom text style
                          children: [
                            TextSpan(
                              text: '*', // Asterisk
                              style: AllPopupHeadings.customTextStyle(context).copyWith(
                                color: Colors.red, // Specify the color for the asterisk
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s2),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: ColorManager.bluebottom,
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
                      SizedBox(height: AppSize.s2),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: ColorManager.bluebottom,
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
                      SizedBox(height: AppSize.s2),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: ColorManager.bluebottom,
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
                      SizedBox(height: AppSize.s2),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: ColorManager.bluebottom,
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
                      SizedBox(height: AppSize.s2),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: ColorManager.bluebottom,
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
                      SizedBox(height: AppSize.s2),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: ColorManager.bluebottom,
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
                      SizedBox(height: AppSize.s2),
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: ColorManager.bluebottom,
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
                      RichText(
                        text: TextSpan(
                          text: 'Allergies ', // Main text
                          style: AllPopupHeadings.customTextStyle(context), // Apply the custom text style
                          children: [
                            TextSpan(
                              text: '*', // Asterisk
                              style: AllPopupHeadings.customTextStyle(context).copyWith(
                                color: Colors.red, // Specify the color for the asterisk
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s1),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: ColorManager.bluebottom,
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
                            activeColor: ColorManager.bluebottom,
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
                            activeColor: ColorManager.bluebottom,
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
                      SMTextFConst(
                        controller: OtherController,
                        keyboardType: TextInputType.text,
                        text: 'Other Allergies',
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
        height: AppSize.s30,
        width: AppSize.s30,
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
           await _joinAllergies();
           await _joinFacts();
            if (!_isFormValid) {
              setState(() {
                loading = false;
              });
              return;
            }
            try{
              FluVaccineDocument fluVaccineDocument = await getFluVaccineDocument(context: context, templateId: widget.htmlFormTemplateId, employeeId: widget.employeeId,
                  dateOfVaccine: dateOfvaccinationController.text, siteOfAdministration: siteOfAdministrationController.text,
                  vaccineType: vaccineTypeController.text, dose: doseController.text, reactions: reactionsController.text.isEmpty ? AppConfig.dash : reactionsController.text,
                  manufacturer: manufacturerController.text, dateofVaccination: dateOfvaccinationController.text,
                  nameOfAdministering: nameOfAdministeringController.text, title: titleController.text,
                  providerAddress: address2Controller.text,
                  acknowledgeFacts: facts.isEmpty ? AppConfig.dash : facts,
                  Allergis: allergies.isEmpty ? AppConfig.dash : allergies, other: OtherController.text.isEmpty ? AppConfig.dash : OtherController.text);

              if(fluVaccineDocument.statusCode == 200 || fluVaccineDocument.statusCode == 201){
                print(allergies);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                  isDisable:false,
                  documentName: fluVaccineDocument.name,
                  onPressed: () {

                  },
                  htmlFormData: fluVaccineDocument.html,
                  employeeId: widget.employeeId,//widget.employeeID,
                  htmlFormTemplateId: fluVaccineDocument.fluVaccineDocumentId,)));
              }
              else if(fluVaccineDocument.statusCode == 400 || fluVaccineDocument.statusCode == 404){
                // Navigator.pop(context);
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => const FourNotFourPopup(),
                );
              }
              else {
                // Navigator.pop(context);
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => const FailedPopup(text: "Something Went Wrong"),
                );
              }

            }

          finally {
          setState(() {
            loading = false;
            // Navigator.pop(context);
          });
            }
          }
      ),);
  }
}





class AddressInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String)? onSuggestionSelected;
  final Function(String) onChanged;// Callback to notify parent

  AddressInput({required this.controller, this.onSuggestionSelected, required this.onChanged});

  @override
  _AddressInputState createState() => _AddressInputState();
}

class _AddressInputState extends State<AddressInput> {
  List<String> _suggestions = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onCountyNameChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onCountyNameChanged);
    _removeOverlay();
    super.dispose();
  }

  void _onCountyNameChanged() async {
    final query = widget.controller.text;
    if (query.isEmpty) {
      _suggestions.clear();
      _removeOverlay();
      return;
    }

    final suggestions = await fetchSuggestions(query);
    setState(() {
      _suggestions = suggestions.isNotEmpty && suggestions[0] != query ? suggestions : [];
    });
    _showOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    if (_suggestions.isEmpty) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
          children:[
            GestureDetector(
              onTap: _removeOverlay,
              child: Container(
                color: Colors.transparent, // Make this transparent so it's invisible
              ),
            ),Positioned(
              left: position.dx,
              top: position.dy + renderBox.size.height,
              width: 354,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8),
                child: Container(
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: _suggestions.length > 5 ? 80.0 : double.infinity,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _suggestions[index],
                            style: TableSubHeading.customTextStyle(context),
                          ),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            widget.controller.text = _suggestions[index];
                            _suggestions.clear();
                            _removeOverlay();

                            // Call the callback with the selected suggestion
                            if (widget.onSuggestionSelected != null) {
                              widget.onSuggestionSelected!(_suggestions[index]);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return   SMTextfieldAsteric(
      controller:  widget.controller,
      keyboardType: TextInputType.text,
      text: 'Provider Address',
    );
    // return FirstSMTextFConst(
    //   controller: widget.controller,
    //   keyboardType: TextInputType.text,
    //   text: AppString.addresss,
    // );
  }
}