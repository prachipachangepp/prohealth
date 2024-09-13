import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/error_pop_up.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../company_identity_screen.dart';
import '../../upload_add_popup.dart';
import '../ci_cc_adr.dart';
import '../ci_cc_cap_reports.dart';
import '../ci_cc_licence.dart';
import '../ci_cc_medical_cost_report.dart';
import '../ci_cc_quaterly_bal_report.dart';

class CiCorporateComplianceScreen extends StatefulWidget {
  final int docId;
  final String officeId;
  final int companyID;

  const CiCorporateComplianceScreen({
    super.key,
    required this.docId,
    required this.officeId,
    required this.companyID,
  });

  @override
  State<CiCorporateComplianceScreen> createState() =>
      _CiCorporateComplianceScreenState();
}

class _CiCorporateComplianceScreenState
    extends State<CiCorporateComplianceScreen> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
      StreamController<List<IdentityDocumentIdData>>.broadcast();

  int _selectedIndex = 0;
  //int docTypeMetaId = 8;
  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  // int docTypeDropMetaId = 0;
  int docSubTypeMetaId = 0;
  String? expiryType;
  bool _isLoading = false;
  int docTypeId = 0;
  DateTime? datePicked;
  String? selectedDocTypeValue;
  String? selectedSubDocTypeValue;
  int selectedSubDocId = AppConfig.subDocId1Licenses; // Default value
  String selectedSubDocType = "";
  dynamic filePath;
  late Future<List<DocumentTypeData>> docTypeFuture;
  bool showExpiryDateField = false; // Declare the state variable
  // showExpiryDateField = doc.expiryreminder.isNotEmpty;

  TextEditingController expiryDateController = TextEditingController();
  String fileName = '';
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
        print('File path ${filePath}');
        print('File name ${fileName}');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDocTypeValue = "Select Document Type";
    selectedSubDocTypeValue = "Select Sub Document";
    docTypeFuture = documentTypeGet(context);
    _updateSelectedSubDocId(selectedSubDocId);
    print("office id ::::::::${widget.officeId}");
  }

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;

      _updateSelectedSubDocId(index == 0
          ? AppConfig.subDocId1Licenses
          : index == 1
              ? AppConfig.subDocId2Adr
              : index == 2
                  ? AppConfig.subDocId3CICCMedicalCR
                  : index == 3
                      ? AppConfig.subDocId4CapReport
                      : AppConfig.subDocId5BalReport);
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _updateSelectedSubDocId(int subDocId) {
    setState(() {
      selectedSubDocId = subDocId;
      selectedSubDocType = getSubDocTypeText(subDocId);
    });
  }

  String getSubDocTypeText(int subDocId) {
    switch (subDocId) {
      case AppConfig.subDocId1Licenses:
        return "Licenses";
      case AppConfig.subDocId2Adr:
        return "ADR";
      case AppConfig.subDocId3CICCMedicalCR:
        return "Medical Cost Reports";
      case AppConfig.subDocId4CapReport:
        return "CAP Reports";
      case AppConfig.subDocId5BalReport:
        return "Quarterly Balance Reports";
      default:
        return "Unknown Document Type";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //color: Colors.greenAccent,
                padding: EdgeInsets.only(top: AppPadding.p6),
                width: MediaQuery.of(context).size.width / 1.7,
                height: AppSize.s60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Container(
                        height: AppSize.s56,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              _selectedIndex == 0 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              AppString.licenses,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 0
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 0
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 0
                                ? Divider(
                                    color: ColorManager.blueprime,
                                    thickness: 2,
                                  )
                                : Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(0),
                    ),
                    InkWell(
                      child: Container(
                        height: AppSize.s50,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              _selectedIndex == 1 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'ADR',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 1
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 1
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 1
                                ? Divider(
                                    color: ColorManager.blueprime,
                                    thickness: 2,
                                  )
                                : Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(1),
                    ),
                    InkWell(
                      child: Container(
                        height: AppSize.s50,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              _selectedIndex == 2 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Medical Cost Reports',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 2
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 2
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 2
                                ? Divider(
                                    color: ColorManager.blueprime,
                                    thickness: 2,
                                  )
                                : Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(2),
                    ),
                    InkWell(
                      child: Container(
                        height: AppSize.s50,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              _selectedIndex == 3 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'CAP Reports',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 3
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 3
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 3
                                ? Divider(
                                    color: ColorManager.blueprime,
                                    thickness: 2,
                                  )
                                : Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(3),
                    ),
                    InkWell(
                      child: Container(
                        height: AppSize.s50,
                        width: MediaQuery.of(context).size.width / 10,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              _selectedIndex == 4 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Quarterly Balance Reports',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 4
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 4
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 4
                                ? Divider(
                                    color: ColorManager.blueprime,
                                    thickness: 2,
                                  )
                                : Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(4),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 8,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, right: 5),
                child: CustomIconButton(
                    icon: CupertinoIcons.plus,
                    text: "Add Document",
                    onPressed: () async {
                      String? selectedExpiryType = expiryType;
                      calenderController.clear();
                      docIdController.clear();
                      docNamecontroller.clear();
                      selectedExpiryType = "";
                      datePicked = null;
                      showDialog(
                          context: context,
                          builder: (context) {
                            return FutureBuilder<List<TypeofDocpopup>>(
                                future: getTypeofDoc(
                                    context, docTypeMetaIdCC, selectedSubDocId),
                                builder: (contex, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasData) {
                                    return UploadDocumentAddPopup(
                                      loadingDuration: _isLoading,
                                      title: 'Upload Document',
                                      officeId: widget.officeId,
                                      docTypeMetaIdCC: docTypeMetaIdCC,
                                      selectedSubDocId: selectedSubDocId,
                                      dataList: snapshot.data!,
                                    );
                                  } else {
                                    return ErrorPopUp(
                                        title: "Received Error",
                                        text: snapshot.error.toString());
                                  }
                                });
                          });
                    }),
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppSize.s20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 50),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                // Page 1
                CICCLicense(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId1Licenses,
                  officeId: widget.officeId,
                ),
                CICCADR(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId2Adr,
                  officeId: widget.officeId,
                ),
                CICCMedicalCR(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId3CICCMedicalCR,
                  officeId: widget.officeId,
                ),
                CICCCAPReports(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId4CapReport,
                  officeId: widget.officeId,
                ),
                CICCQuarterlyBalReport(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId5BalReport,
                  officeId: widget.officeId,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

// calenderController: calenderController,
// idDocController: docIdController,
// nameDocController: docNamecontroller,
// String expiryTypeToSend =
//     selectedExpiryType == "Not Applicable"
//         ? "Not Applicable"
//         : calenderController.text;
// await addManageCCVCPPPost(
//   context: context,
//   name: docNamecontroller.text,
// docTypeID: docTypeMetaId,
//   docSubTypeID: docSubTypeMetaId,
//   expiryType: selectedExpiryType.toString(),
//   expiryDate: calenderController.text,//expiryTypeToSend,
//   expiryReminder: selectedExpiryType.toString(),
//   officeId: widget.officeId,
//   idOfDoc: docIdController.text
// );
// Navigator.pop(context);
// FutureBuilder<List<DocumentTypeData>>(
//   future: documentTypeGet(context),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Container(
//         width: 300,
//         child: Text(
//           'Loading...',
//           style: CustomTextStylesCommon.commonStyle(
//             fontWeight: FontWeightManager.medium,
//             fontSize: FontSize.s12,
//             color: ColorManager.mediumgrey,
//           ),
//         ),
//       );
//     }
//     if (snapshot.data!.isEmpty) {
//       return Center(
//         child: Text(
//           AppString.dataNotFound,
//           style: CustomTextStylesCommon.commonStyle(
//             fontWeight: FontWeightManager.medium,
//             fontSize: FontSize.s12,
//             color: ColorManager.mediumgrey,
//           ),
//         ),
//       );
//     }
//     if (snapshot.hasData) {
//       List<DropdownMenuItem<String>> dropDownMenuItems = [];
//       int docType = snapshot.data![0].docID;
//       docTypeMetaId = docType;
//
//       for (var i in snapshot.data!) {
//         dropDownMenuItems.add(
//           DropdownMenuItem<String>(
//             child: Text(i.docType),
//             value: i.docType,
//           ),
//         );
//       }
//       return CICCDropdown(
//         initialValue: dropDownMenuItems[0].value,
//         onChange: (val) {
//           for (var a in snapshot.data!) {
//             if (a.docType == val) {
//               docType = a.docID;
//               docTypeMetaId = docType;
//             }
//           }
//           identityDocumentTypeGet(context, docTypeMetaId).then((data) {
//             _identityDataController.add(data);
//           }).catchError((error) {
//             // Handle error
//           });
//         },
//         items: dropDownMenuItems,
//       );
//     } else {
//       return SizedBox();
//     }
//   },
// ),
/// doc sub type
// child1: StreamBuilder<List<IdentityDocumentIdData>>(
//   stream: _identityDataController.stream,
//   builder: (context, snapshot) {
//     if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//       List<DropdownMenuItem<String>> dropDownMenuItems = [];
//
//       // Add a placeholder item for "Select Subdocument"
//       dropDownMenuItems.add(
//         DropdownMenuItem<String>(
//           value: "Select Sub Document",
//           child: Text("Select Sub Document"),
//         ),
//       );
//
//       for (var i in snapshot.data!) {
//         dropDownMenuItems.add(
//           DropdownMenuItem<String>(
//             value: i.subDocType,
//             child: Text(i.subDocType),
//           ),
//         );
//       }
//
//       return CICCDropdown(
//         initialValue: "Select Sub Document",  // Set initial value to the placeholder
//         onChange: (val) {
//           if (val != "Select Sub Document") {
//             for (var a in snapshot.data!) {
//               if (a.subDocType == val) {
//                 docSubTypeMetaId = a.subDocID;
//               }
//             }
//           }
//         },
//         items: dropDownMenuItems,
//       );
//     } else if (snapshot.connectionState == ConnectionState.waiting) {
//       // Optionally, you can still show a placeholder or nothing here
//       return SizedBox();
//     } else {
//       return Center(
//         child: Text(
//           AppString.dataNotFound,
//           style: CustomTextStylesCommon.commonStyle(
//             fontWeight: FontWeightManager.medium,
//             fontSize: FontSize.s12,
//             color: ColorManager.mediumgrey,
//           ),
//         ),
//       );
//     }
//   },
// ),
// radioButton: Padding(
//   padding: const EdgeInsets.only(left: 10.0),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         "Expiry Type",
//         style: GoogleFonts.firaSans(
//           fontSize: FontSize.s12,
//           fontWeight: FontWeight.w700,
//           color: ColorManager.mediumgrey,
//           decoration: TextDecoration.none,
//         ),
//       ),
//       CustomRadioListTile(
//         value: "Not Applicable",
//         groupValue: selectedExpiryType,
//         onChanged: (value) {
//           setState(() {
//             selectedExpiryType = value;
//           });
//         },
//         title: "Not Applicable",
//       ),
//       CustomRadioListTile(
//         value: 'Scheduled',
//         groupValue: selectedExpiryType,
//         onChanged: (value) {
//           setState(() {
//             selectedExpiryType = value;
//           });
//         },
//         title: 'Scheduled',
//       ),
//       CustomRadioListTile(
//         value: 'Issuer Expiry',
//         groupValue: selectedExpiryType,
//         onChanged: (value) {
//           setState(() {
//             selectedExpiryType = value;
//           });
//         },
//         title: 'Issuer Expiry',
//       ),
//     ],
//   ),
// ),
// child2: Visibility(
//   visible: selectedExpiryType == "Scheduled" || selectedExpiryType == "Issuer Expiry",
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         "Expiry Date",
//         style: GoogleFonts.firaSans(
//           fontSize: FontSize.s12,
//           fontWeight: FontWeight.w700,
//           color: ColorManager.mediumgrey,
//           decoration: TextDecoration.none,
//         ),
//       ),
//       SizedBox(height: AppSize.s5,),
//       FormField<String>(
//         builder: (FormFieldState<String> field) {
//           return SizedBox (
//             width: 354,
//             height: 30,
//             child:   TextFormField(
//               controller: calenderController,
//               cursorColor: ColorManager.black,
//               style: GoogleFonts.firaSans(
//                 fontSize: FontSize.s12,
//                 fontWeight: FontWeight.w700,
//                 color: ColorManager.mediumgrey,
//                 //decoration: TextDecoration.none,
//               ),
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 hintText: 'mm-dd-yyyy',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: FontSize.s12,
//                   fontWeight: FontWeight.w700,
//                   color: ColorManager.mediumgrey,
//                   //decoration: TextDecoration.none,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(width: 1,color: ColorManager.fmediumgrey),
//                 ),
//                 contentPadding:
//                 EdgeInsets.symmetric(horizontal: 16),
//                 suffixIcon: Icon(Icons.calendar_month_outlined,
//                     color: ColorManager.blueprime),
//                 errorText: field.errorText,
//               ),
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1901),
//                   lastDate: DateTime(3101),
//                 );
//                 if (pickedDate != null) {
//                   calenderController.text =
//                       DateFormat('MM-dd-yyyy').format(pickedDate);
//                 }
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'please select birth date';
//                 }
//                 return null;
//               },
//             ),
//           );
//         },
//       ),
//     ],
//   ),
// ),

///old

// CustomIconButton(
//   icon: Icons.add,
//   text: "Add Doctype",
//   onPressed: () async {
//     String? selectedExpiryType = expiryType;
//     calenderController.clear();
//     docIdController.clear();
//     docNamecontroller.clear();
//     selectedExpiryType = "";
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (BuildContext context,
//               void Function(void Function()) setState) {
//             return AddOrgDocButton(
//               calenderController: calenderController,
//               idDocController: docIdController,
//               nameDocController: docNamecontroller,
//               loadingDuration: _isLoading,
//               onPressed: () async {
//                 setState(() {
//                   _isLoading = true;
//                 });
//                 int subDocId = _selectedIndex == 0 ? AppConfig.subDocId1Licenses :
//                 _selectedIndex == 1 ? AppConfig.subDocId2Adr :
//                 _selectedIndex == 2 ? AppConfig.subDocId3CICCMedicalCR :
//                 _selectedIndex == 3 ? AppConfig.subDocId4CapReport :
//                 AppConfig.subDocId5BalReport;
//
//                 String expiryTypeToSend =
//                     selectedExpiryType == "Not Applicable"
//                         ? "Not Applicable"
//                         : calenderController.text;
//                 try {
//                   await addManageCCVCPPPost(
//                     context: context,
//                     name: docNamecontroller.text,
//                     docTypeID: docTypeMetaIdCC,
//                     docSubTypeID: selectedSubDocId,//docSubTypeMetaId,
//                     expiryType: selectedExpiryType.toString(),
//                     expiryDate: calenderController.text,//expiryTypeToSend,
//                     expiryReminder: selectedExpiryType.toString(),
//                     officeId: widget.officeId,
//                     idOfDoc: docIdController.text,
//                   );
//                   Navigator.pop(context);
//                 } finally {
//                   setState(() {
//                     _isLoading = false;
//                   });
//                 }
//               },
//               child:FutureBuilder<List<DocumentTypeData>>(
//                 future: documentTypeGet(context),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Container(
//                       width: 300,
//                       child: Text(
//                         'Loading...',
//                         style: CustomTextStylesCommon.commonStyle(
//                           fontWeight: FontWeightManager.medium,
//                           fontSize: FontSize.s12,
//                           color: ColorManager.mediumgrey,
//                         ),
//                       ),
//                     );
//                   }
//                   if (snapshot.data!.isEmpty) {
//                     return Center(
//                       child: Text(
//                         AppString.dataNotFound,
//                         style: CustomTextStylesCommon.commonStyle(
//                           fontWeight: FontWeightManager.medium,
//                           fontSize: FontSize.s12,
//                           color: ColorManager.mediumgrey,
//                         ),
//                       ),
//                     );
//                   }
//                   if (snapshot.hasData) {
//                     String selectedDocType = "";
//                     int docType = snapshot.data![0].docID;
//
//                     for (var i in snapshot.data!) {
//                       if (i.docID == AppConfig.corporateAndCompliance) {
//                         selectedDocType = i.docType;
//                         docType = i.docID;
//                         break;
//                       }
//                     }
//
//                     docTypeMetaIdCC = docType;
//
//                     identityDocumentTypeGet(context, docTypeMetaIdCC).then((data) {
//                       _identityDataController.add(data);
//                     }).catchError((error) {
//                       // Handle error
//                     });
//                     return Container(
//                       width: 354,
//                       padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
//                       decoration: BoxDecoration(
//                         color: ColorManager.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: ColorManager.fmediumgrey,width: 1),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             selectedDocType,
//                             style: CustomTextStylesCommon.commonStyle(
//                               fontWeight: FontWeightManager.medium,
//                               fontSize: FontSize.s12,
//                               color: ColorManager.mediumgrey,
//                             ),
//                           ),
//                           Icon(
//                             Icons.arrow_drop_down,
//                             color: Colors.transparent
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     return SizedBox();
//                   }
//                 },
//               ),
//
//               selectedSubDocType: selectedSubDocType,
//               child1: Container(
//                 width: 354,
//                 padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
//                 decoration: BoxDecoration(
//                   color: ColorManager.white,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: ColorManager.fmediumgrey,width: 1),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       selectedSubDocType,
//                       style: CustomTextStylesCommon.commonStyle(
//                         fontWeight: FontWeightManager.medium,
//                         fontSize: FontSize.s12,
//                         color: ColorManager.mediumgrey,
//                       ),
//                     ),
//                     Icon(
//                       Icons.arrow_drop_down,
//                       color: Colors.transparent,
//                     ),
//                   ],
//                 ),
//               ),
//               radioButton: Padding(
//                 padding: const EdgeInsets.only(left: 10.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Expiry Type",
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeight.w700,
//                         color: ColorManager.mediumgrey,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                     CustomRadioListTile(
//                       value: "Not Applicable",
//                       groupValue: selectedExpiryType,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedExpiryType = value;
//                         });
//                       },
//                       title: "Not Applicable",
//                     ),
//                     CustomRadioListTile(
//                       value: 'Scheduled',
//                       groupValue: selectedExpiryType,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedExpiryType = value;
//                         });
//                       },
//                       title: 'Scheduled',
//                     ),
//                     CustomRadioListTile(
//                       value: 'Issuer Expiry',
//                       groupValue: selectedExpiryType,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedExpiryType = value;
//                         });
//                       },
//                       title: 'Issuer Expiry',
//                     ),
//                   ],
//                 ),
//               ),
//               child2: Visibility(
//                 visible: selectedExpiryType == "Scheduled" ||
//                     selectedExpiryType == "Issuer Expiry",
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Expiry Date",
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeight.w700,
//                         color: ColorManager.mediumgrey,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                     SizedBox(height: AppSize.s5,),
//                     FormField<String>(
//                       builder: (FormFieldState<String> field) {
//                         return SizedBox(
//                           width: 354,
//                           height: 30,
//                           child: TextFormField(
//                             controller: calenderController,
//                             cursorColor: ColorManager.black,
//                             style: GoogleFonts.firaSans(
//                               fontSize: FontSize.s12,
//                               fontWeight: FontWeight.w700,
//                               color: ColorManager.mediumgrey,
//                             ),
//                             decoration: InputDecoration(
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: ColorManager
//                                         .fmediumgrey,
//                                     width: 1),
//                                 borderRadius:
//                                     BorderRadius.circular(8),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                     color: ColorManager
//                                         .fmediumgrey,
//                                     width: 1),
//                                 borderRadius:
//                                     BorderRadius.circular(8),
//                               ),
//                               hintText: 'mm-dd-yyyy',
//                               hintStyle: GoogleFonts.firaSans(
//                                 fontSize: FontSize.s12,
//                                 fontWeight: FontWeight.w700,
//                                 color: ColorManager.mediumgrey,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.circular(8),
//                                 borderSide: BorderSide(
//                                     width: 1,
//                                     color: ColorManager
//                                         .fmediumgrey),
//                               ),
//                               contentPadding:
//                                   EdgeInsets.symmetric(
//                                       horizontal: 16),
//                               suffixIcon: Icon(
//                                   Icons.calendar_month_outlined,
//                                   color:
//                                       ColorManager.blueprime),
//                               errorText: field.errorText,
//                             ),
//                             onTap: () async {
//                               DateTime? pickedDate =
//                                   await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(1901),
//                                 lastDate: DateTime(3101),
//                               );
//                               if (pickedDate != null) {
//                                 calenderController.text =
//                                     DateFormat('MM-dd-yyyy')
//                                         .format(pickedDate);
//                               }
//                             },
//                             validator: (value) {
//                               if (value == null ||
//                                   value.isEmpty) {
//                                 return 'Please select an expiry date';
//                               }
//                               return null;
//                             },
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               title: 'Add Coporate & Compliance ',
//             );
//           },
//         );
//       },
//     );
//   },
// ),
