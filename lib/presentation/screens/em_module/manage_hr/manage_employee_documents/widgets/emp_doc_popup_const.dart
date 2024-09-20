import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../../../app/constants/app_config.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import '../../../../../../app/services/api/repository/establishment_manager/employee_doc_repository.dart';
import '../../../widgets/dialogue_template.dart';
import '../../../widgets/header_content_const.dart';

class EmpDocADDPopup extends StatefulWidget {
  final bool? isSaving;
  String? expiryType;
  final String title;
  bool? enable;
  final int Subdocid;

  EmpDocADDPopup({
    Key? key,
    this.enable,
    this.expiryType,
    this.isSaving,
    required this.title,
    required this.Subdocid,
  }) : super(key: key);

  @override
  State<EmpDocADDPopup> createState() => _EmpDocADDPopupState();
}

class _EmpDocADDPopupState extends State<EmpDocADDPopup> {
  final DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  String? _idError;
  String? _nameError;
  bool _isFormValid = true;

  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }

  void _validateFields() {
    setState(() {
      _isFormValid = true;
      _idError = _validateTextField(
          idDocController.text, 'Please Enter ID of Document');
      _nameError = _validateTextField(
          nameDocController.text, 'Please Enter Name of thr Document ');
    });
  }

  TextEditingController daysController = TextEditingController(text: "1");
  String selectedExpiryType = "";
  String? selectedYear = AppConfig.year;

  TextEditingController nameDocController = TextEditingController();
  TextEditingController idDocController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s460,
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SMTextFConst(
                controller: idDocController,
                keyboardType: TextInputType.text,
                text: 'ID of the Document',
              ),
              if (_idError != null)
                Text(
                  _idError!,
                  style: TextStyle(color: Colors.red, fontSize: 10),
                ),
              SizedBox(height: AppSize.s8),
              FirstSMTextFConst(
                controller: nameDocController,
                keyboardType: TextInputType.text,
                text: 'Name of the Document',
              ),
              if (_nameError != null)
                Text(
                  _nameError!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              SizedBox(height: AppSize.s8),
              // Text(
              //   'Type of the Document',
              //   style: GoogleFonts.firaSans(
              //     fontSize: FontSize.s12,
              //     fontWeight: FontWeight.w700,
              //     color: ColorManager.mediumgrey,
              //   ),
              // ),
              // SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Row(
                  children: [
                    HeaderContentConst(
                      heading: AppString.expiry_type,
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRadioListTile(
                            value: AppConfig.notApplicable,
                            groupValue: selectedExpiryType,
                            onChanged: (value) {
                              setState(() {
                                selectedExpiryType = value!;
                              });
                            },
                            title: AppConfig.notApplicable,
                          ),
                          CustomRadioListTile(
                            value: AppConfig.scheduled,
                            groupValue: selectedExpiryType,
                            onChanged: (value) {
                              setState(() {
                                selectedExpiryType = value!;
                              });
                            },
                            title: AppConfig.scheduled,
                          ),
                          CustomRadioListTile(
                            value: AppConfig.issuer,
                            groupValue: selectedExpiryType,
                            onChanged: (value) {
                              setState(() {
                                selectedExpiryType = value!;
                              });
                            },
                            title: AppConfig.issuer,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: AppPadding.p20,
                        right: AppPadding.p20,
                      ),
                      child: Visibility(
                        visible: selectedExpiryType == AppConfig.scheduled,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 50,
                                  //color: ColorManager.red,
                                  child: TextFormField(
                                    controller:
                                        daysController, // Use the controller initialized with "1"
                                    cursorColor: ColorManager.black,
                                    cursorWidth: 1,
                                    style:AllHRTableData.customTextStyle(context),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorManager.fmediumgrey,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorManager.fmediumgrey,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // This ensures only digits are accepted
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 30,
                                  width: 80,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: ColorManager.fmediumgrey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value:
                                        selectedYear, // Initial value (you should define this variable)
                                    items: [
                                      DropdownMenuItem(
                                        value: AppConfig.year,
                                        child: Text(
                                          AppConfig.year,
                                          style: AllHRTableData.customTextStyle(context),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: AppConfig.month,
                                        child: Text(
                                          AppConfig.month,
                                          style: AllHRTableData.customTextStyle(context),
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedYear =
                                            value; // Update the selected option (Year/Month)
                                      });
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: AppConfig.year,
                                      hintStyle: AllHRTableData.customTextStyle(context),
                                      contentPadding: EdgeInsets.only(bottom: 20),
                                    ),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: ColorManager.black,
                                      size: IconSize.I16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      bottomButtons: _isLoading
          ? SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomElevatedButton(
                    width: AppSize.s105,
                    height: AppSize.s30,
                    text: AppStringEM.save,
                    onPressed: () async {
                      _validateFields();
                      setState(() {
                        _isLoading = true;
                      });

                      int threshold = 0;
                      if (selectedExpiryType == AppConfig.scheduled &&
                          daysController.text.isNotEmpty) {
                        int enteredValue = int.parse(daysController.text);
                        if (selectedYear == AppConfig.year) {
                          threshold = enteredValue * 365;
                        } else if (selectedYear == AppConfig.month) {
                          threshold = enteredValue * 30;
                        }
                      }
                      await addEmployeeDocSetup(
                        context: context,
                        docName: nameDocController.text,
                        expiryDate: "", //expiryDate,
                        remainderThreshold: selectedExpiryType.toString(),
                        empDocMetaDataId: widget.Subdocid,
                        idOfDoc: idDocController.text,
                        expiryType: selectedExpiryType.toString(),
                        threshold: threshold, // Pass calculated or 0
                      );

                      print(nameDocController.text);
                      print(idDocController.text);
                      print(widget.Subdocid);
                      print(selectedExpiryType.toString());

                      Navigator.pop(context);
                      nameDocController.clear();
                      dateController.clear();


                    }),
              ),
            ),
      title: widget.title,
    );
  }
}




///edit popup
class EmpDocEditPopup extends StatefulWidget {
  final TextEditingController idOfDocController;
  final TextEditingController nameDocController;
  final TextEditingController calenderController;

  final bool? isSaving;
  String? expiryType;
  final String empdoctype;
  final bool? loadingDuration;
  final String title;
  bool? enable;
  final int empsetupId;
  final String docname;
  final int employeeDocTypeMetaDataId;

  EmpDocEditPopup({
    Key? key,
    this.enable,
    required this.idOfDocController,
    required this.nameDocController,
    required this.calenderController,
    this.expiryType,
    this.isSaving,
    this.loadingDuration,
    required this.title,
    required this.empsetupId,
    required this.docname,
    required this.empdoctype,
    required this.employeeDocTypeMetaDataId,
  }) : super(key: key);

  @override
  State<EmpDocEditPopup> createState() => _EmpDocEditPopupState();
}

class _EmpDocEditPopupState extends State<EmpDocEditPopup> {
  bool _isLoading = false;
  String? _idError;
  String? _nameError;

  late final TextEditingController idOfDocController;
  late final TextEditingController nameDocController;
  late final TextEditingController daysController;


  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      return "Please Enter $fieldName";
    }
    return null;
  }

  bool _isFormValid = true;

  void _validateFields() {
    setState(() {
      _isFormValid = true;
      _idError = _validateTextField(idOfDocController.text, 'ID of Document');
      _nameError = _validateTextField(nameDocController.text, 'Name of the Document');
    });
  }

  String selectedExpiryType = "";
  String? selectedYear = AppConfig.year;

  @override
  void initState() {
    super.initState();
    idOfDocController = widget.idOfDocController;
    nameDocController = widget.nameDocController;
    daysController = TextEditingController(text: "1");

    _validateFields();
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s390,
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SMTextFConst(
                enable: widget.enable ?? true,
                controller: idOfDocController,
                keyboardType: TextInputType.text,
                text: 'ID of the Document',
              ),
              if (_idError != null)
                Text(
                  _idError!,
                  style: TextStyle(color: Colors.red, fontSize: 10),
                ),
              SizedBox(height: AppSize.s8),
              FirstSMTextFConst(
                controller: nameDocController,
                keyboardType: TextInputType.text,
                text: 'Name of the Document',
              ),
              if (_nameError != null)
                Text(
                  _nameError!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              SizedBox(height: AppSize.s8),
              HeaderContentConst(
                heading: AppString.type_of_the_document,
                content: Container(
                  width: 354,
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: ColorManager.fmediumgrey, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.empdoctype,
                        style: DocumentTypeDataStyle.customTextStyle(context)
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Row(
              //   children: [
              //     HeaderContentConst(
              //       heading: AppString.expiry_type,
              //       content: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           CustomRadioListTile(
              //             value: AppConfig.notApplicable,
              //             groupValue: selectedExpiryType,
              //             onChanged: (value) {
              //               setState(() {
              //                 selectedExpiryType = value!;
              //               });
              //             },
              //             title: AppConfig.notApplicable,
              //           ),
              //           CustomRadioListTile(
              //             value: AppConfig.scheduled,
              //             groupValue: selectedExpiryType,
              //             onChanged: (value) {
              //               setState(() {
              //                 selectedExpiryType = value!;
              //               });
              //             },
              //             title: AppConfig.scheduled,
              //           ),
              //           CustomRadioListTile(
              //             value: AppConfig.issuer,
              //             groupValue: selectedExpiryType,
              //             onChanged: (value) {
              //               setState(() {
              //                 selectedExpiryType = value!;
              //               });
              //             },
              //             title: AppConfig.issuer,
              //           ),
              //         ],
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(left: AppPadding.p20, right: AppPadding.p20),
              //       child: Visibility(
              //         visible: selectedExpiryType == AppConfig.scheduled,
              //         child: Column(
              //           children: [
              //             SizedBox(height: 10),
              //             Row(
              //               children: [
              //                 Container(
              //                   height: 30,
              //                   width: 50,
              //                   child: TextFormField(
              //                     controller: daysController,
              //                     cursorColor: ColorManager.black,
              //                     cursorWidth: 1,
              //                     style: GoogleFonts.firaSans(
              //                       fontSize: FontSize.s10,
              //                       fontWeight: FontWeightManager.medium,
              //                       color: ColorManager.mediumgrey,
              //                     ),
              //                     decoration: InputDecoration(
              //                       enabledBorder: OutlineInputBorder(
              //                         borderSide: BorderSide(
              //                             color: ColorManager.fmediumgrey,
              //                             width: 2),
              //                         borderRadius: BorderRadius.circular(8),
              //                       ),
              //                       focusedBorder: OutlineInputBorder(
              //                         borderSide: BorderSide(
              //                             color: ColorManager.fmediumgrey,
              //                             width: 2),
              //                         borderRadius: BorderRadius.circular(8),
              //                       ),
              //                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
              //                     ),
              //                     keyboardType: TextInputType.number,
              //                     inputFormatters: [
              //                       FilteringTextInputFormatter.digitsOnly,
              //                     ],
              //                   ),
              //                 ),
              //                 SizedBox(width: 10),
              //                 Container(
              //                   height: 30,
              //                   width: 80,
              //                   padding: EdgeInsets.symmetric(horizontal: 5),
              //                   decoration: BoxDecoration(
              //                     border: Border.all(color: ColorManager.fmediumgrey),
              //                     borderRadius: BorderRadius.circular(8),
              //                   ),
              //                   child: DropdownButtonFormField<String>(
              //                     value: selectedYear,
              //                     items: [
              //                       DropdownMenuItem(
              //                         value: AppConfig.year,
              //                         child: Text(
              //                           AppConfig.year,
              //                           style: GoogleFonts.firaSans(
              //                             fontSize: FontSize.s10,
              //                             fontWeight: FontWeightManager.medium,
              //                             color: ColorManager.mediumgrey,
              //                           ),
              //                         ),
              //                       ),
              //                       DropdownMenuItem(
              //                         value: AppConfig.month,
              //                         child: Text(
              //                           AppConfig.month,
              //                           style: GoogleFonts.firaSans(
              //                             fontSize: FontSize.s10,
              //                             fontWeight: FontWeightManager.medium,
              //                             color: ColorManager.mediumgrey,
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                     onChanged: (value) {
              //                       setState(() {
              //                         selectedYear = value;
              //                       });
              //                     },
              //                     decoration: InputDecoration(
              //                       enabledBorder: InputBorder.none,
              //                       focusedBorder: InputBorder.none,
              //                       hintText: AppConfig.year,
              //                       hintStyle: GoogleFonts.firaSans(
              //                         fontSize: FontSize.s10,
              //                         fontWeight: FontWeightManager.medium,
              //                         color: ColorManager.mediumgrey,
              //                       ),
              //                       contentPadding: EdgeInsets.only(bottom: 20),
              //                     ),
              //                     icon: Icon(
              //                       Icons.arrow_drop_down,
              //                       color: ColorManager.black,
              //                       size: 16,
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ],
      bottomButtons: _isLoading
          ? SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(
          color: ColorManager.blueprime,
        ),
      )
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton(
            width: AppSize.s105,
            height: AppSize.s30,
            text: AppStringEM.save,
            onPressed: () async {
              _validateFields();
              if (_idError == null && _nameError == null) {
                setState(() {
                  _isLoading = true;
                });

                try {
                  // String expiryTypeToSend = selectedExpiryType == AppConfig.notApplicable
                  //     ? AppConfig.notApplicable
                  //     : daysController.text;

                  int threshold = 0;
                  String? expiryDateToSend = "";
                  if (selectedExpiryType == AppConfig.scheduled && daysController.text.isNotEmpty) {
                    int enteredValue = int.parse(daysController.text);
                    if (selectedYear == AppConfig.year) {
                      threshold = enteredValue * 365;
                    } else if (selectedYear == AppConfig.month) {
                      threshold = enteredValue * 30;
                    }
                    expiryDateToSend = widget.calenderController.text;
                  } else if (selectedExpiryType == AppConfig.notApplicable ||
                      selectedExpiryType == AppConfig.issuer) {
                    threshold = 0;
                    expiryDateToSend = null;
                  }

                  await editEmployeeDocTypeSetupId(
                    // context,
                    // widget.empsetupId,
                    // widget.docname,
                    // widget.empdoctype,
                    // selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString(): widget.expiryType!,
                    // widget.employeeDocTypeMetaDataId,
                    // idOfDocController.text,
                    // selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString(): widget.expiryType!,
                    // threshold,
                    context: context,
                    employeeDoctypeSetupId: widget.empsetupId,
                    docName: nameDocController.text,
                    // expiry: '',
                    // employeeDocTypeMetaDataId: widget.employeeDocTypeMetaDataId,
                    // idOfDocument:  idOfDocController.text, expiryType: selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString(): widget.expiryType!,
                    threshold: threshold,
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.pop(context);
                }
              }
            },
          ),
        ),
      ),
      title: widget.title,
    );
  }
}
