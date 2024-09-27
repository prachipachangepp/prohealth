import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/manage_details_manager.dart';
import '../../../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../../../../../data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import '../../../../../../../data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import '../../../../widgets/dialogue_template.dart';

class EditVisitPopup extends StatefulWidget {
  final TextEditingController nameOfDocumentController;
  final TextEditingController idOfDocumentController;
  final TextEditingController serviceNameSelected;
  final bool? enable;
  //final Widget child1;
  final String title;
  final int visitId;
  final List<EligibleClinician> prefilledClinicians;
  //final Widget dropdownServices;
 // final Future<void> Function() onClosePressed;

  const EditVisitPopup({
    super.key,
    this.enable,
    required this.nameOfDocumentController,
    required this.idOfDocumentController,
    required this.title,
    required this.visitId,
    required this.prefilledClinicians, required this.serviceNameSelected,
   // required this.onClosePressed,
  });

  @override
  State<EditVisitPopup> createState() => _EditVisitPopupState();
}
class _EditVisitPopupState extends State<EditVisitPopup> {
  bool isLoading = false;
  bool _isNameOfDocumentValid = true;
  String _nameOfDocumentErrorText = '';

  List<Widget> selectedChips = [];
  List<Widget> chipsList = [];
  List<String> editChipValues = [];
  List<int> selectedChipsId = [];
  List<Widget> selectedEditChips = [];
  List<int> selectedEditChipsId = [];

  String? selectedServiceName;
  String? serviceId;
  int empTypeId = 0;
  late String originalName;

  bool _isClinicianSelectionValid = true;
  String _clinicianErrorText = '';

  @override
  void initState() {
    super.initState();
    originalName = widget.nameOfDocumentController.text;
    for (var clinician in widget.prefilledClinicians) {
      selectedEditChipsId.add(clinician.employeeTypeId);
      editChipValues.add(clinician.eligibleClinician);
      selectedEditChips.add(
        Chip(
          backgroundColor: ColorManager.white,
          shape: StadiumBorder(
            side: BorderSide(color: ColorManager.blueprime),
          ),
          deleteIcon: Icon(
            Icons.close,
            color: ColorManager.blueprime,
            size: 17,
          ),
          label: Text(
            clinician.eligibleClinician,
            style: CustomTextStylesCommon.commonStyle(
              fontWeight: FontWeight.w500,
              fontSize: FontSize.s10,
              color: ColorManager.mediumgrey,
            ),
          ),
          onDeleted: () {
            setState(() {
              editChipValues.remove(clinician.eligibleClinician);
              selectedEditChips.removeWhere((chip) {
                final chipText = (chip as Chip).label as Text;
                return chipText.data == clinician.eligibleClinician;
              });
              selectedEditChipsId.remove(clinician.employeeTypeId);
              _validateClinicianSelection();
            });
          },
        ),
      );
    }
  }

  void _validateClinicianSelection() {
    setState(() {
      if (selectedEditChips.isEmpty) {
        _isClinicianSelectionValid = false;
        _clinicianErrorText = 'Please select at least one clinician.';
      } else {
        _isClinicianSelectionValid = true;
        _clinicianErrorText = '';
      }
    });
  }

  void _validateInputs() {
    setState(() {
      final nameOfDocumentText = widget.nameOfDocumentController.text;

      if (nameOfDocumentText.isEmpty) {
        _isNameOfDocumentValid = false;
        _nameOfDocumentErrorText = 'Please Enter Type of Visit';
      } else if (nameOfDocumentText.isNotEmpty &&
          nameOfDocumentText[0] != nameOfDocumentText[0].toUpperCase())
      {
        _isNameOfDocumentValid = false;
        _nameOfDocumentErrorText = 'First letter must be capitalized';
      }
      else {
        _isNameOfDocumentValid = true;
        _nameOfDocumentErrorText = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
        width: AppSize.s400,
        height: AppSize.s420,
          body: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p10,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FirstSMTextFConst(
                          enable: widget.enable,
                          controller: widget.nameOfDocumentController,
                          keyboardType: TextInputType.text,
                          text: 'Type of Visit',
                        ),
                        if (!_isNameOfDocumentValid)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              _nameOfDocumentErrorText,
                              style: CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: AppSize.s10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                           FirstSMTextFConst(
                          enable: false,
                          controller: widget.serviceNameSelected,
                          keyboardType: TextInputType.text,
                          text: 'Service Name',
                        ),
                        ],
                    ),
                    SizedBox(height: AppSize.s14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Eligible Clinician',
                          style: AllPopupHeadings.customTextStyle(context),
                        ),
                        SizedBox(height: AppSize.s5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<List<HRAllData>>(
                              future: getAllHrDeptWise(context, 1),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CICCDropdown(
                                    items: [],
                                  );
                                }
                                if (snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      AppString.dataNotFound,
                                      style: AllNoDataAvailable.customTextStyle(context),
                                    ),
                                  );
                                }
                                if (snapshot.hasData) {
                                  int docType = 0;
                                  List<DropdownMenuItem<String>> dropDownTypesList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownTypesList.add(
                                      DropdownMenuItem<String>(
                                        child: Text(i.abbrivation!),
                                        value: i.abbrivation,
                                      ),
                                    );
                                  }
                                  return CICCDropdown(
                                    initialValue: dropDownTypesList[0].value,
                                    onChange: (val) {
                                      for (var a in snapshot.data!) {
                                        if (a.abbrivation == val) {
                                          docType = a.employeeTypesId;
                                          empTypeId = docType;

                                          setState(() {
                                            if (val.isNotEmpty && !editChipValues.contains(val)) { // Check if the value already exists
                                              // Add chip value if it's not already present
                                              editChipValues.add(val);

                                              // Add chip widget
                                              selectedEditChips.add(
                                                Chip(
                                                  backgroundColor: ColorManager.white,
                                                  shape: StadiumBorder(
                                                    side: BorderSide(color: ColorManager.blueprime),
                                                  ),
                                                  deleteIcon: Icon(
                                                    Icons.close,
                                                    color: ColorManager.blueprime,
                                                    size: IconSize.I16,
                                                  ),
                                                  label: Text(
                                                    val,
                                                    style: CustomTextStylesCommon.commonStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: FontSize.s10,
                                                      color: ColorManager.mediumgrey,
                                                    ),
                                                  ),
                                                  onDeleted: () {
                                                    setState(() {
                                                      editChipValues.remove(val);
                                                      selectedEditChips.removeWhere((chip) {
                                                        final chipText = (chip as Chip).label as Text;
                                                        return chipText.data == val;
                                                      });
                                                      selectedEditChipsId.remove(docType);
                                                      _validateClinicianSelection();
                                                    });
                                                  },
                                                ),
                                              );

                                              // Add selected chip ID
                                              selectedEditChipsId.add(docType);

                                              _validateClinicianSelection();
                                            }
                                          });
                                        }
                                      }
                                    },

                                    items: dropDownTypesList,
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                            SizedBox(height: AppSize.s5),
                            Wrap(
                              spacing: 8.0,
                              children: selectedEditChips,
                            ),
                            if (!_isClinicianSelectionValid)
                              Text(
                                _clinicianErrorText,
                                style: CommonErrorMsg.customTextStyle(context),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],

      bottomButtons: isLoading
          ? CircularProgressIndicator(
        color: ColorManager.blueprime,
      )
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.save,
        onPressed: () async {
          _validateInputs();
          _validateClinicianSelection();
          if (_isNameOfDocumentValid) {
            setState(() {
              isLoading = true;
            });
            try {
              if (selectedEditChips.isEmpty) {
                for (var i in widget.prefilledClinicians) {
                  selectedEditChipsId.add(i.employeeTypeId);
                  editChipValues.add(i.eligibleClinician);
                  selectedEditChips.add(
                    Chip(
                      backgroundColor: ColorManager.white,
                      shape: StadiumBorder(
                        side: BorderSide(color: ColorManager.blueprime),
                      ),
                      deleteIcon: Icon(
                        Icons.close,
                        color: ColorManager.blueprime,
                        size: 17,
                      ),
                      label: Text(
                        i.eligibleClinician,
                        style: CustomTextStylesCommon.commonStyle(
                          fontWeight:FontWeight.w500,
                          fontSize: FontSize.s10,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                      onDeleted: () {
                        setState(() {
                          // Remove chip data
                          editChipValues.remove(i.eligibleClinician);
                          selectedEditChips.removeWhere((chip) {
                            final chipText = (chip as Chip).label as Text;
                            return chipText.data == i.eligibleClinician;
                          });
                          selectedEditChipsId.remove(i.employeeTypeId);
                        });
                      },
                    ),
                  );
                }
              }
              String finalVisitName = widget.nameOfDocumentController.text == originalName
                  ? originalName
                  : widget.nameOfDocumentController.text;
              await updateVisitPatch(
                context:context,
                typeVisist: widget.visitId,//paginatedData[index].visitId,
                visitType: finalVisitName,
                eligibleClinical: selectedEditChipsId,
                serviceId: widget.serviceNameSelected.text,
              );
            } finally {
              setState(() {
                isLoading = false;
              });
              Navigator.pop(context);
              widget.idOfDocumentController.clear();
              widget.nameOfDocumentController.clear();
              editChipValues.clear();
              selectedEditChipsId.clear();
              selectedEditChips.clear();
            }
          }
        },
      ),
      title: widget.title,


    );
  }
}

///
// class EditVisitPopup extends StatefulWidget {
//   final TextEditingController nameOfDocumentController;
//   final TextEditingController idOfDocumentController;
//   final TextEditingController serviceNameSelected;
//   //final Future<void> Function() onSavePressed;
//   // final Widget child;
//   final bool? enable;
//   //final Widget child1;
//   final String title;
//   final int visitId;
//   final List<EligibleClinician> prefilledClinicians;
//   //final Widget dropdownServices;
//   // final Future<void> Function() onClosePressed;
//
//   const EditVisitPopup({
//     super.key,
//     this.enable,
//     required this.nameOfDocumentController,
//     required this.idOfDocumentController,
//     required this.title,
//     required this.visitId,
//     required this.prefilledClinicians, required this.serviceNameSelected,
//     // required this.onClosePressed,
//   });
//
//   @override
//   State<EditVisitPopup> createState() => _EditVisitPopupState();
// }
// class _EditVisitPopupState extends State<EditVisitPopup> {
//   bool isLoading = false;
//   bool _isNameOfDocumentValid = true;
//   String _nameOfDocumentErrorText = '';
//
//   List<Widget> selectedChips = [];
//   List<Widget> chipsList = [];
//   List<String> editChipValues = [];
//   List<int> selectedChipsId = [];
//   List<Widget> selectedEditChips = [];
//   List<int> selectedEditChipsId = [];
//
//   String? selectedServiceName;
//   String? serviceId;
//   int empTypeId = 0;
//   late String originalName;
//
//   bool _isClinicianSelectionValid = true;
//   String _clinicianErrorText = '';
//
//   @override
//   void initState() {
//     super.initState();
//     originalName = widget.nameOfDocumentController.text;
//     for (var clinician in widget.prefilledClinicians) {
//       selectedEditChipsId.add(clinician.employeeTypeId);
//       editChipValues.add(clinician.eligibleClinician);
//       selectedEditChips.add(
//         Chip(
//           backgroundColor: ColorManager.white,
//           shape: StadiumBorder(
//             side: BorderSide(color: ColorManager.blueprime),
//           ),
//           deleteIcon: Icon(
//             Icons.close,
//             color: ColorManager.blueprime,
//             size: 17,
//           ),
//           label: Text(
//             clinician.eligibleClinician,
//             style: CustomTextStylesCommon.commonStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: FontSize.s10,
//               color: ColorManager.mediumgrey,
//             ),
//           ),
//           onDeleted: () {
//             setState(() {
//               editChipValues.remove(clinician.eligibleClinician);
//               selectedEditChips.removeWhere((chip) {
//                 final chipText = (chip as Chip).label as Text;
//                 return chipText.data == clinician.eligibleClinician;
//               });
//               selectedEditChipsId.remove(clinician.employeeTypeId);
//               _validateClinicianSelection();
//             });
//           },
//         ),
//       );
//     }
//   }
//
//   void _validateClinicianSelection() {
//     setState(() {
//       if (selectedEditChips.isEmpty) {
//         _isClinicianSelectionValid = false;
//         _clinicianErrorText = 'Please select at least one clinician.';
//       } else {
//         _isClinicianSelectionValid = true;
//         _clinicianErrorText = '';
//       }
//     });
//   }
//
//   void _validateInputs() {
//     setState(() {
//       final nameOfDocumentText = widget.nameOfDocumentController.text;
//
//       if (nameOfDocumentText.isEmpty) {
//         _isNameOfDocumentValid = false;
//         _nameOfDocumentErrorText = 'Please Enter Type of Visit';
//       } else if (nameOfDocumentText.isNotEmpty &&
//           nameOfDocumentText[0] != nameOfDocumentText[0].toUpperCase())
//       {
//         _isNameOfDocumentValid = false;
//         _nameOfDocumentErrorText = 'First letter must be capitalized';
//       }
//       else {
//         _isNameOfDocumentValid = true;
//         _nameOfDocumentErrorText = '';
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DialogueTemplate(
//       width: AppSize.s400,
//       height: AppSize.s420,
//       body: [
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             // vertical: AppPadding.p5,
//             horizontal: AppPadding.p10,
//           ),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // TextField with Validation Message
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     FirstSMTextFConst(
//                       enable: widget.enable,
//                       controller: widget.nameOfDocumentController,
//                       keyboardType: TextInputType.text,
//                       text: 'Type of Visit',
//                     ),
//                     if (!_isNameOfDocumentValid)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 4.0),
//                         child: Text(
//                           _nameOfDocumentErrorText,
//                           style: CommonErrorMsg.customTextStyle(context),
//                         ),
//                       ),
//                   ],
//                 ),
//                 SizedBox(height: AppSize.s10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     FirstSMTextFConst(
//                       enable: false,
//                       controller: widget.serviceNameSelected,
//                       keyboardType: TextInputType.text,
//                       text: 'Service Name',
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: AppSize.s14),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Select Eligible Clinician',
//                       style: AllPopupHeadings.customTextStyle(context),
//                     ),
//                     SizedBox(height: AppSize.s5),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         FutureBuilder<List<HRAllData>>(
//                           future: getAllHrDeptWise(context, 1),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return CICCDropdown(
//                                 items: [],
//                               );
//                             }
//                             if (snapshot.data!.isEmpty) {
//                               return Center(
//                                 child: Text(
//                                   AppString.dataNotFound,
//                                   style: AllNoDataAvailable.customTextStyle(context),
//                                 ),
//                               );
//                             }
//                             if (snapshot.hasData) {
//                               int docType = 0;
//                               List<DropdownMenuItem<String>> dropDownTypesList = [];
//                               for (var i in snapshot.data!) {
//                                 dropDownTypesList.add(
//                                   DropdownMenuItem<String>(
//                                     child: Text(i.abbrivation!),
//                                     value: i.abbrivation,
//                                   ),
//                                 );
//                               }
//                               return CICCDropdown(
//                                 initialValue: dropDownTypesList[0].value,
//                                 onChange: (val) {
//                                   for (var a in snapshot.data!) {
//                                     if (a.abbrivation == val) {
//                                       docType = a.employeeTypesId;
//                                       empTypeId = docType;
//                                       setState(() {
//                                         if (val.isNotEmpty) {
//                                           editChipValues.add(val);
//                                           selectedEditChips.add(
//                                             Chip(
//                                               backgroundColor: ColorManager.white,
//                                               shape: StadiumBorder(
//                                                 side: BorderSide(color: ColorManager.blueprime),
//                                               ),
//                                               deleteIcon: Icon(
//                                                 Icons.close,
//                                                 color: ColorManager.blueprime,
//                                                 size: IconSize.I16,
//                                               ),
//                                               label: Text(
//                                                 val,
//                                                 style: CustomTextStylesCommon.commonStyle(
//                                                   fontWeight: FontWeight.w500,
//                                                   fontSize: FontSize.s10,
//                                                   color: ColorManager.mediumgrey,
//                                                 ),
//                                               ),
//                                               onDeleted: () {
//                                                 setState(() {
//                                                   editChipValues.remove(val);
//                                                   selectedEditChips.removeWhere((chip) {
//                                                     final chipText = (chip as Chip).label as Text;
//                                                     return chipText.data == val;
//                                                   });
//                                                   selectedEditChipsId.remove(docType);
//                                                   _validateClinicianSelection();
//                                                 });
//                                               },
//                                             ),
//                                           );
//                                           selectedEditChipsId.add(docType);
//                                           _validateClinicianSelection();
//                                         }
//                                       });
//                                     }
//                                   }
//                                 },
//                                 items: dropDownTypesList,
//                               );
//                             }
//                             return SizedBox();
//                           },
//                         ),
//                         SizedBox(height: AppSize.s5),
//                         Wrap(
//                           spacing: 8.0,
//                           children: selectedEditChips,
//                         ),
//                         if (!_isClinicianSelectionValid)
//                           Text(
//                             _clinicianErrorText,
//                             style: CommonErrorMsg.customTextStyle(context),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//
//
//       ],
//       bottomButtons: isLoading
//           ? CircularProgressIndicator(
//         color: ColorManager.blueprime,
//       )
//           : CustomElevatedButton(
//         width: AppSize.s105,
//         height: AppSize.s30,
//         text: AppStringEM.save,
//         onPressed: () async {
//           _validateInputs();
//           _validateClinicianSelection();
//           if (_isNameOfDocumentValid) {
//             setState(() {
//               isLoading = true;
//             });
//             try {
//               if (selectedEditChips.isEmpty) {
//                 for (var i in widget.prefilledClinicians) {
//                   selectedEditChipsId.add(i.employeeTypeId);
//                   editChipValues.add(i.eligibleClinician);
//                   selectedEditChips.add(
//                     Chip(
//                       backgroundColor: ColorManager.white,
//                       shape: StadiumBorder(
//                         side: BorderSide(color: ColorManager.blueprime),
//                       ),
//                       deleteIcon: Icon(
//                         Icons.close,
//                         color: ColorManager.blueprime,
//                         size: 17,
//                       ),
//                       label: Text(
//                         i.eligibleClinician,
//                         style: CustomTextStylesCommon.commonStyle(
//                           fontWeight:FontWeight.w500,
//                           fontSize: FontSize.s10,
//                           color: ColorManager.mediumgrey,
//                         ),
//                       ),
//                       onDeleted: () {
//                         setState(() {
//                           // Remove chip data
//                           editChipValues.remove(i.eligibleClinician);
//                           selectedEditChips.removeWhere((chip) {
//                             final chipText = (chip as Chip).label as Text;
//                             return chipText.data == i.eligibleClinician;
//                           });
//                           selectedEditChipsId.remove(i.employeeTypeId);
//                         });
//                       },
//                     ),
//                   );
//                 }
//               }
//               String finalVisitName = widget.nameOfDocumentController.text == originalName
//                   ? originalName
//                   : widget.nameOfDocumentController.text;
//               await updateVisitPatch(
//                 context:context,
//                 typeVisist: widget.visitId,//paginatedData[index].visitId,
//                 visitType: finalVisitName,
//                 eligibleClinical: selectedEditChipsId,
//                 serviceId: widget.serviceNameSelected.text,
//               );
//             } finally {
//               setState(() {
//                 isLoading = false;
//               });
//               Navigator.pop(context);
//               widget.idOfDocumentController.clear();
//               widget.nameOfDocumentController.clear();
//               editChipValues.clear();
//               selectedEditChipsId.clear();
//               selectedEditChips.clear();
//
//             }
//           }
//         },
//       ),
//
//       title: widget.title,
//
//
//     );
//   }
// }
///add popup
class AddVisitPopup extends StatefulWidget {
  final TextEditingController nameOfDocumentController;
  final TextEditingController idOfDocumentController;
  final bool? enable;
  final String title;

  const AddVisitPopup({
    super.key,
    this.enable,
    required this.nameOfDocumentController,
    required this.idOfDocumentController,
    required this.title,
  });

  @override
  State<AddVisitPopup> createState() => _AddVisitPopupState();
}

class _AddVisitPopupState extends State<AddVisitPopup> {
  bool isLoading = false;
  bool _isNameOfDocumentValid = true;
  String _nameOfDocumentErrorText = '';

  void _validateInputs() {
    setState(() {
      final nameOfDocumentText = widget.nameOfDocumentController.text;
      if (nameOfDocumentText.isEmpty) {
        _isNameOfDocumentValid = false;
        _nameOfDocumentErrorText = 'Please Enter Type of Visit';
      } else if (nameOfDocumentText.isNotEmpty &&
          nameOfDocumentText[0] != nameOfDocumentText[0].toUpperCase()) {
        _isNameOfDocumentValid = false;
        _nameOfDocumentErrorText = 'First letter must be capitalized';
      } else {
        _isNameOfDocumentValid = true;
        _nameOfDocumentErrorText = '';
      }
    });
  }

  String? selectedServiceName;
  String? serviceId;
  int empTypeId = 0;
  List<Widget> selectedChips = [];
  List<Widget> chipsList = [];
  List<String> editChipValues = [];
  List<int> selectedChipsId = [];
  List<Widget> selectedEditChips = [];
  List<int> selectedEditChipsId = [];

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s420,
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // TextField with Validation Message
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FirstSMTextFConst(
                    enable: widget.enable,
                    controller: widget.nameOfDocumentController,
                    keyboardType: TextInputType.text,
                    text: 'Type of Visit',
                  ),
                  if (!_isNameOfDocumentValid)
                    Text(
                      _nameOfDocumentErrorText,
                      style: CommonErrorMsg.customTextStyle(context),
                    ),
                ],
              ),
              SizedBox(height: AppSize.s14),
              ///service dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select services',
                    style: AllPopupHeadings.customTextStyle(context),
                  ),
                  SizedBox(height: AppSize.s5),
                  FutureBuilder<List<ServicesMetaData>>(
                    future: getServicesMetaData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: 354,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManager.containerBorderGrey,
                                width: AppSize.s1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: AppSize.s8),
                              Expanded(
                                child: Text(
                                  "Select",
                                  style: MobileMenuText.MenuTextConst(context),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                            ],
                          ),
                        );
                      }
                      if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return Container(
                          width: 354,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManager.containerBorderGrey,
                                width: AppSize.s1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              ErrorMessageString.noserviceAdded,
                              style: AllNoDataAvailable.customTextStyle(context),
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        // Only set the default values if they haven't been set yet.
                        if (selectedServiceName == null && serviceId == null) {
                          selectedServiceName = snapshot.data![0].serviceName;
                          serviceId = snapshot.data![0].serviceId;
                        }

                        List<DropdownMenuItem<String>> dropDownServiceList = [];
                        for (var service in snapshot.data!) {
                          dropDownServiceList.add(
                            DropdownMenuItem<String>(
                              value: service.serviceName,
                              child: Text(service.serviceName ?? ''),
                            ),
                          );
                        }

                        return StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return CICCDropdown(
                              initialValue: selectedServiceName,
                              onChange: (val) {
                                setState(() {
                                  selectedServiceName = val;
                                  for (var service in snapshot.data!) {
                                    if (service.serviceName == val) {
                                      serviceId = service.serviceId;
                                    }
                                  }
                                });
                              },
                              items: dropDownServiceList,
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  )
                ],
              ),

              SizedBox(height: AppSize.s20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Eligible Clinician',
                    style: AllPopupHeadings.customTextStyle(context),
                  ),
                  SizedBox(height: AppSize.s5),
                  //widget.child,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<List<HRAllData>>(
                        future: getAllHrDeptWise(context, 1),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CICCDropdown(
                              items: [],
                              hintText: 'Select Clinician',
                            );
                          }
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                AppString.dataNotFound,
                                style: AllNoDataAvailable.customTextStyle(context),
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            int docType = 0;
                            List<DropdownMenuItem<String>> dropDownTypesList = [];
                            for (var i in snapshot.data!) {
                              dropDownTypesList.add(
                                DropdownMenuItem<String>(
                                  child: Text(i.abbrivation!),
                                  value: i.abbrivation,
                                ),
                              );
                            }
                            return CICCDropdown(
                              initialValue: dropDownTypesList[0].value,
                              onChange: (val) {
                                for (var a in snapshot.data!) {
                                  if (a.abbrivation == val) {
                                    docType = a.employeeTypesId;
                                    empTypeId = docType;

                                    // Check if the clinician is already selected
                                    if (!editChipValues.contains(val)) {
                                      setState(() {
                                        editChipValues.add(val);
                                        selectedEditChips.add(
                                          Chip(
                                            backgroundColor: ColorManager.white,
                                            shape: StadiumBorder(
                                              side: BorderSide(
                                                  color: ColorManager.blueprime),
                                            ),
                                            deleteIcon: Icon(
                                              Icons.close,
                                              color: ColorManager.blueprime,
                                              size: IconSize.I16,
                                            ),
                                            label: Text(
                                              val,
                                              style: CustomTextStylesCommon.commonStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: FontSize.s10,
                                                color: ColorManager.mediumgrey,
                                              ),
                                            ),
                                            onDeleted: () {
                                              setState(() {
                                                editChipValues.remove(val);
                                                selectedEditChips.removeWhere((chip) {
                                                  final chipText = (chip as Chip).label as Text;
                                                  return chipText.data == val;
                                                });
                                                selectedEditChipsId.remove(docType);
                                              });
                                            },
                                          ),
                                        );
                                        selectedEditChipsId.add(docType);
                                      });
                                    }
                                  }
                                }
                              },
                              items: dropDownTypesList,
                            );
                          }
                          return SizedBox();
                        },
                      ),

                      SizedBox(height: AppSize.s5),
                      Wrap(
                        spacing: 8.0,
                        children: selectedEditChips,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
      bottomButtons: isLoading
          ? CircularProgressIndicator(
              color: ColorManager.blueprime,
            )
          : CustomElevatedButton(
              width: AppSize.s105,
              height: AppSize.s30,
              text: AppStringEM.save,
              onPressed: () async {
                //  Navigator.pop(context);
                  // editChipValues.clear();
                  // selectedEditChipsId.clear();
                  // selectedEditChips.clear();
                  _validateInputs();
                if (_isNameOfDocumentValid) {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    print(":::::${selectedEditChips}");
                    print(":::::${widget.nameOfDocumentController.text}");
                   // print(":::::${_selectedItem}");

                    await addVisitPost(context:context,
                        typeOfVisit: widget.nameOfDocumentController.text,
                        eligibleClinician: selectedEditChipsId,
                        serviceId: serviceId!);
                    selectedChipsId.clear();
                    selectedChips.clear();
                  //  nameOfDocumentController.clear();
                  }finally {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(context);
                    widget.idOfDocumentController.clear();
                    widget.nameOfDocumentController.clear();
                  }
                }
              },
            ),
      title: widget.title,
    );
  }
}
