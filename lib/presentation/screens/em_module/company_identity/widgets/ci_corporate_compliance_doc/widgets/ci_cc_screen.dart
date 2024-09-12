import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_insurance_manager/manage_corporate_compliance.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/newpopup_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_licence.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/newpopup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../company_identity_screen.dart';
import '../ci_cc_adr.dart';
import '../ci_cc_cap_reports.dart';
import '../ci_cc_medical_cost_report.dart';
import '../ci_cc_quaterly_bal_report.dart';
import 'corporate_compliance_constants.dart';

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
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (BuildContext context,
                                  void Function(void Function()) setState) {
                                return UploadDocumentAddPopup(
                                  loadingDuration: _isLoading,
                                  onPressed: () async {
                                    //  print('File path on pressed ${filePath}');
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    ///Add Doctype API on save button
                                    try {

                                      String? expiryDate;
                                      if (expiryDateController.text.isEmpty) {
                                        expiryDate = null;
                                      } else {
                                        expiryDate = expiryDateController.text;
                                      }
                                      ApiData response = await addOrgDocPPPost(
                                        context: context,
                                        orgDocumentSetupid: docTypeId,
                                        idOfDocument: "PPP",
                                        expiryDate: expiryDate,
                                        docCreated: DateTime.now().toIso8601String()+"Z",
                                        url: "url",
                                        officeId: widget.officeId,
                                      );
                                      expiryDateController.clear();
                                      if (response.statusCode == 200 ||
                                          response.statusCode == 201) {
                                        await uploadDocumentsoffice(
                                            context: context,
                                            documentFile: filePath,
                                            orgOfficeDocumentId:
                                            response.orgOfficeDocumentId!);
                                      }
                                    }

                                    finally {
                                      setState(() {
                                        _isLoading = false;
                                        Navigator.pop(context);
                                      });
                                    }

                                  },
                                  child: FutureBuilder<List<TypeofDocpopup>>(
                                    future: getTypeofDoc(context,
                                        docTypeMetaIdCC, selectedSubDocId) ,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          width: 350,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                        );
                                      }

                                      if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Center(
                                          child: Text(
                                            AppString.dataNotFound,
                                            style: CustomTextStylesCommon
                                                .commonStyle(
                                              fontWeight:
                                              FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                        );
                                      }

                                      if (snapshot.hasData) {
                                        List<DropdownMenuItem<String>>
                                        dropDownMenuItems = snapshot.data!
                                            .map((doc) =>
                                            DropdownMenuItem<String>(
                                              value: doc.docname,
                                              child: Text(doc.docname!),
                                            ))
                                            .toList();

                                        return

                                          StatefulBuilder(
                                            builder: (context, setState) {
                                              return Column(
                                                children: [
                                                  CICCDropdown(
                                                    initialValue: "Select",
                                                    onChange: (val) {
                                                      setState(() {
                                                        // Always reset the expiry field visibility to false initially
                                                        showExpiryDateField =
                                                        false;

                                                        // Loop through the documents and check the selected value
                                                        for (var doc
                                                        in snapshot.data!) {
                                                          if (doc.docname ==
                                                              val) {
                                                            docTypeId = doc
                                                                .orgDocumentSetupid!;

                                                            // Show expiry date field only if expirytype is "issuer expiry"
                                                            if (doc.expirytype ==
                                                                AppConfig
                                                                    .issuer) {
                                                              showExpiryDateField =
                                                              true;
                                                            }
                                                          }
                                                        }
                                                      });
                                                    },
                                                    items: dropDownMenuItems,
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Visibility(
                                                    visible: showExpiryDateField,

                                                    /// Conditionally display expiry date field
                                                    child:   Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 2),
                                                          child: Text(
                                                            "Expiry Date",
                                                            style: GoogleFonts.firaSans(
                                                              fontSize: FontSize.s12,
                                                              fontWeight: FontWeight.w700,
                                                              color: ColorManager.mediumgrey,
                                                              decoration: TextDecoration.none,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        FormField<String>(
                                                          builder: (FormFieldState<String> field) {
                                                            return SizedBox(
                                                              width: 354,
                                                              height: 30,
                                                              child: TextFormField(
                                                                controller: expiryDateController,
                                                                cursorColor: ColorManager.black,
                                                                style: GoogleFonts.firaSans(
                                                                  fontSize: FontSize.s12,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: ColorManager.mediumgrey,
                                                                ),
                                                                decoration: InputDecoration(
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                  hintText: 'mm-dd-yyyy',
                                                                  hintStyle: GoogleFonts.firaSans(
                                                                    fontSize: FontSize.s12,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: ColorManager.mediumgrey,
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                    borderSide: BorderSide(width: 1, color: ColorManager.fmediumgrey),
                                                                  ),
                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                                                  suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
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
                                                                    expiryDateController.text = DateFormat('MM-dd-yyyy').format(pickedDate);
                                                                  }
                                                                },
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return 'please select date';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                      } else {
                                        return SizedBox();
                                      }
                                    },
                                  ),

                                  // uploadField: Container(
                                  //   height: AppSize.s30,
                                  //   width: AppSize.s354,
                                  //   // margin: EdgeInsets.symmetric(horizontal: 5),
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //       color: ColorManager.containerBorderGrey,
                                  //       width: 1,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(4),
                                  //   ),
                                  //   child: StatefulBuilder(
                                  //     builder: (BuildContext context,
                                  //         void Function(void Function())
                                  //             setState) {
                                  //       return Padding(
                                  //         padding: const EdgeInsets.all(0),
                                  //         child: Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //           children: [
                                  //             Text(
                                  //               fileName,
                                  //               style: GoogleFonts.firaSans(
                                  //                 fontSize: FontSize.s12,
                                  //                 fontWeight:
                                  //                     FontWeightManager.regular,
                                  //                 color: ColorManager
                                  //                     .lightgreyheading,
                                  //               ),
                                  //             ),
                                  //             IconButton(
                                  //               padding: EdgeInsets.all(4),
                                  //               onPressed: _pickFile,
                                  //               icon: Icon(
                                  //                 Icons.file_upload_outlined,
                                  //                 color: ColorManager.black,
                                  //                 size: 17,
                                  //               ),
                                  //               splashColor: Colors.transparent,
                                  //               highlightColor:
                                  //                   Colors.transparent,
                                  //               hoverColor: Colors.transparent,
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                  title: 'Upload Document',

                                );
                              },
                            );
                          });
                    }),
                ///Type Of the Document
                // child: FutureBuilder<List<TypeofDocpopup>>(
                //   future: getTypeofDoc(context,
                //       docTypeMetaIdCC, selectedSubDocId) ,
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState ==
                //         ConnectionState.waiting) {
                //       return Container(
                //         width: 350,
                //         height: 30,
                //         decoration: BoxDecoration(
                //           borderRadius:
                //               BorderRadius.circular(8),
                //         ),
                //       );
                //     }
                //
                //     if (!snapshot.hasData ||
                //         snapshot.data!.isEmpty) {
                //       return Center(
                //         child: Text(
                //           AppString.dataNotFound,
                //           style: CustomTextStylesCommon
                //               .commonStyle(
                //             fontWeight:
                //                 FontWeightManager.medium,
                //             fontSize: FontSize.s12,
                //             color: ColorManager.mediumgrey,
                //           ),
                //         ),
                //       );
                //     }
                //
                //     if (snapshot.hasData) {
                //       List<DropdownMenuItem<String>>
                //           dropDownMenuItems = snapshot.data!
                //               .map((doc) =>
                //                   DropdownMenuItem<String>(
                //                     value: doc.docname,
                //                     child: Text(doc.docname!),
                //                   ))
                //               .toList();
                //
                //       return
                //           // StatefulBuilder(
                //           //   builder: (context, setState) {
                //           //     return Column(
                //           //       children: [
                //           //         CICCDropdown(
                //           //           initialValue: "Select",
                //           //           onChange: (val) {
                //           //             setState(() {
                //           //               for (var doc in snapshot.data!) {
                //           //                 if (doc.docname == val) {
                //           //                   docTypeId = doc.orgDocumentSetupid!;
                //           //
                //           //                   // Show expiry date field only if expirytype is "issuer expiry"
                //           //                   showExpiryDateField = doc.expirytype == AppConfig.issuer;
                //           //                 }
                //           //               }
                //           //             });
                //           //           },
                //           //           items: dropDownMenuItems,
                //           //         ),
                //           //         Visibility(
                //           //           visible: showExpiryDateField, // Conditionally display expiry date field
                //           //           child: Padding(
                //           //             padding: const EdgeInsets.only(top: 8.0),
                //           //             child: Container(
                //           //               height: 30, // Set height to 30
                //           //               width: 175, // Set width to 175
                //           //               child: TextField(
                //           //                 controller: expiryDateController,
                //           //                 readOnly: true,
                //           //                 decoration: InputDecoration(
                //           //                   labelText: "Expiry Date",
                //           //                   labelStyle: TextStyle(fontSize: 14), // Adjust label font size
                //           //                   suffixIcon: IconButton(
                //           //                     icon: Icon(Icons.calendar_today, size: 16), // Adjust icon size
                //           //                     onPressed: () async {
                //           //                       DateTime? pickedDate = await showDatePicker(
                //           //                         context: context,
                //           //                         initialDate: DateTime.now(),
                //           //                         firstDate: DateTime(2000),
                //           //                         lastDate: DateTime(2101),
                //           //                       );
                //           //                       if (pickedDate != null) {
                //           //                         setState(() {
                //           //                           expiryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                //           //                         });
                //           //                       }
                //           //                     },
                //           //                   ),
                //           //                   border: OutlineInputBorder(),
                //           //                   contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Adjust padding
                //           //                   hintText: 'YYYY-MM-DD',
                //           //                 ),
                //           //               ),
                //           //             ),
                //           //           ),
                //           //         ),
                //           //       ],
                //           //     );
                //           //   },
                //           // );
                //           ///
                //
                //           StatefulBuilder(
                //         builder: (context, setState) {
                //           return Column(
                //             children: [
                //               CICCDropdown(
                //                 initialValue: "Select",
                //                 onChange: (val) {
                //                   setState(() {
                //                     // Always reset the expiry field visibility to false initially
                //                     showExpiryDateField =
                //                         false;
                //
                //                     // Loop through the documents and check the selected value
                //                     for (var doc
                //                         in snapshot.data!) {
                //                       if (doc.docname ==
                //                           val) {
                //                         docTypeId = doc
                //                             .orgDocumentSetupid!;
                //
                //                         // Show expiry date field only if expirytype is "issuer expiry"
                //                         if (doc.expirytype ==
                //                             AppConfig
                //                                 .issuer) {
                //                           showExpiryDateField =
                //                               true;
                //                         }
                //                       }
                //                     }
                //                   });
                //                 },
                //                 items: dropDownMenuItems,
                //               ),
                //               Visibility(
                //                 visible: showExpiryDateField,
                //
                //                 /// Conditionally display expiry date field
                //                 child: Padding(
                //                   padding:
                //                       const EdgeInsets.only(
                //                           top: 8.0),
                //                   child: Container(
                //                     height: 30,
                //                     width: 352,
                //                     child: TextField(
                //                       controller:
                //                           expiryDateController,
                //                       style: GoogleFonts
                //                           .firaSans(
                //                         fontSize:
                //                             FontSize.s12,
                //                         fontWeight:
                //                             FontWeightManager
                //                                 .bold,
                //                         color: ColorManager
                //                             .mediumgrey,
                //                       ),
                //                       readOnly: true,
                //                       decoration:
                //                           InputDecoration(
                //                         labelText:
                //                             "Expiry Date",
                //                         labelStyle:
                //                             GoogleFonts
                //                                 .firaSans(
                //                           fontSize:
                //                               FontSize.s12,
                //                           fontWeight:
                //                               FontWeightManager
                //                                   .semiBold,
                //                           color: ColorManager
                //                               .mediumgrey,
                //                         ),
                //                         suffixIcon:
                //                             IconButton(
                //                           icon: Icon(
                //                               Icons
                //                                   .calendar_today,
                //                               size: 16),
                //                           onPressed:
                //                               () async {
                //                             DateTime?
                //                                 pickedDate =
                //                                 await showDatePicker(
                //                               context:
                //                                   context,
                //                               initialDate:
                //                                   DateTime
                //                                       .now(),
                //                               firstDate:
                //                                   DateTime(
                //                                       2000),
                //                               lastDate:
                //                                   DateTime(
                //                                       2101),
                //                             );
                //                             if (pickedDate !=
                //                                 null) {
                //                               setState(() {
                //                                 expiryDateController
                //                                     .text = DateFormat(
                //                                         'yyyy-MM-dd')
                //                                     .format(
                //                                         pickedDate);
                //                               });
                //                             }
                //                           },
                //                         ),
                //                         border: OutlineInputBorder(
                //                             borderSide: BorderSide(
                //                                 color: ColorManager
                //                                     .fmediumgrey)),
                //                         contentPadding:
                //                             EdgeInsets.symmetric(
                //                                 vertical: 8.0,
                //                                 horizontal:
                //                                     10.0), // Adjust padding
                //                         hintText:
                //                             'YYYY-MM-DD',
                //                         hintStyle: GoogleFonts
                //                             .firaSans(
                //                           fontSize:
                //                               FontSize.s12,
                //                           fontWeight:
                //                               FontWeightManager
                //                                   .bold,
                //                           color: ColorManager
                //                               .mediumgrey,
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           );
                //         },
                //       );
                //     } else {
                //       return SizedBox();
                //     }
                //   },
                // ),
                //
                // uploadField: Container(
                //   height: AppSize.s30,
                //   width: AppSize.s354,
                //   // margin: EdgeInsets.symmetric(horizontal: 5),
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: ColorManager.containerBorderGrey,
                //       width: 1,
                //     ),
                //     borderRadius: BorderRadius.circular(4),
                //   ),
                //   child: StatefulBuilder(
                //     builder: (BuildContext context,
                //         void Function(void Function())
                //             setState) {
                //       return Padding(
                //         padding: const EdgeInsets.all(0),
                //         child: Row(
                //           mainAxisAlignment:
                //               MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               fileName,
                //               style: GoogleFonts.firaSans(
                //                 fontSize: FontSize.s12,
                //                 fontWeight:
                //                     FontWeightManager.regular,
                //                 color: ColorManager
                //                     .lightgreyheading,
                //               ),
                //             ),
                //             IconButton(
                //               padding: EdgeInsets.all(4),
                //               onPressed: _pickFile,
                //               icon: Icon(
                //                 Icons.file_upload_outlined,
                //                 color: ColorManager.black,
                //                 size: 17,
                //               ),
                //               splashColor: Colors.transparent,
                //               highlightColor:
                //                   Colors.transparent,
                //               hoverColor: Colors.transparent,
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),

                ///old
                // FutureBuilder<List<TypeofDocpopup>>(
                //   future: getTypeofDoc(context,
                //       docTypeMetaIdCC, selectedSubDocId),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState ==
                //         ConnectionState.waiting) {
                //       return Container(
                //         width: 350,
                //         height: 30,
                //         decoration: BoxDecoration(
                //           borderRadius:
                //           BorderRadius.circular(8),
                //         ),
                //       );
                //     }
                //     if (snapshot.data!.isEmpty) {
                //       return Center(
                //         child: Text(
                //           AppString.dataNotFound,
                //           style: CustomTextStylesCommon
                //               .commonStyle(
                //             fontWeight:
                //             FontWeightManager.medium,
                //             fontSize: FontSize.s12,
                //             color: ColorManager.mediumgrey,
                //           ),
                //         ),
                //       );
                //     }
                //     if (snapshot.hasData) {
                //       List<DropdownMenuItem<String>>
                //       dropDownMenuItems = snapshot.data!
                //           .map((doc) =>
                //           DropdownMenuItem<String>(
                //             value: doc.docname,
                //             child:
                //             Text(doc.docname!),
                //           ))
                //           .toList();
                //       return CICCDropdown(
                //         initialValue: "Select",
                //         onChange: (val) {
                //           //   setState(() {
                //           // selectedDocType = val;
                //           for (var doc in snapshot.data!) {
                //             if (doc.docname == val) {
                //               docTypeId =
                //               doc.orgDocumentSetupid!;
                //             }
                //           }
                //           // getTypeofDoc(context ,widget.docId,widget.subDocId).then((data) {
                //           //   _compliancePatientDataController
                //           //       .add(data!);
                //           // }).catchError((error) {
                //           //   // Handle error
                //           // });
                //           // });
                //         },
                //         items: dropDownMenuItems,
                //       );
                //     } else {
                //       return SizedBox();
                //     }
                //   },
                // ),
                ///
                //                                   FutureBuilder<List<TypeofDocpopup>>(
//                                     future: getTypeofDoc(context, docTypeMetaIdCC, selectedSubDocId),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.connectionState == ConnectionState.waiting) {
//                                         return Container(
//                                           width: 350,
//                                           height: 30,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(8),
//                                           ),
//                                         );
//                                       }
//
//                                       if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                                         return Center(
//                                           child: Text(
//                                             AppString.dataNotFound,
//                                             style: CustomTextStylesCommon.commonStyle(
//                                               fontWeight: FontWeightManager.medium,
//                                               fontSize: FontSize.s12,
//                                               color: ColorManager.mediumgrey,
//                                             ),
//                                           ),
//                                         );
//                                       }
//
//                                       if (snapshot.hasData) {
//                                         List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
//                                             .map((doc) => DropdownMenuItem<String>(
//                                           value: doc.docname,
//                                           child: Text(doc.docname!),
//                                         ))
//                                             .toList();
//
//                                         return StatefulBuilder(
//                                           builder: (context, setState) {
//                                             return Column(
//                                               children: [
//                                                 CICCDropdown(
//                                                   initialValue: "Select",
//                                                   onChange: (val) {
//                                                     setState(() {
//                                                       for (var doc in snapshot.data!) {
//                                                         if (doc.docname == val) {
//                                                           docTypeId = doc.orgDocumentSetupid!;
//                                                           // Check if the selected document has an expiry date
//                                                           showExpiryDateField = doc.hasIssuerExpiry ?? false;
//                                                         }
//                                                       }
//                                                     });
//                                                   },
//                                                   items: dropDownMenuItems,
//                                                 ),
//                                                 if (showExpiryDateField) // Conditionally display expiry date field
//                                                   Padding(
//                                                     padding: const EdgeInsets.only(top: 8.0),
//                                                     child: TextField(
//                                                       controller: expiryDateController,
//                                                       readOnly: true,
//                                                       decoration: InputDecoration(
//                                                         labelText: "Expiry Date",
//                                                         suffixIcon: IconButton(
//                                                           icon: Icon(Icons.calendar_today),
//                                                           onPressed: () async {
//                                                             DateTime? pickedDate = await showDatePicker(
//                                                               context: context,
//                                                               initialDate: DateTime.now(),
//                                                               firstDate: DateTime(2000),
//                                                               lastDate: DateTime(2101),
//                                                             );
//                                                             if (pickedDate != null) {
//                                                               setState(() {
//                                                                 expiryDateController?.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                                                               });
//                                                             }
//                                                           },
//                                                         ),
//                                                         border: OutlineInputBorder(),
//                                                         hintText: 'YYYY-MM-DD',
//                                                       ),
//                                                     ),
//                                                   ),
//                                               ],
//                                             );
//                                           },
//                                         );
//                                       } else {
//                                         return SizedBox();
//                                       }
//                                     },
//                                   ),
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