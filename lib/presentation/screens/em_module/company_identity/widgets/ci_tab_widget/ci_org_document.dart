import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_corporate&compiliance_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_policies&procedure.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_vendor_contract.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/establishment_text_const/text_widget_const.dart';
import 'package:shimmer/shimmer.dart';
import '../../company_identity_screen.dart';

// class CiOrgDocument extends StatefulWidget {
//   final String officeId;
//   final int? companyId;
//   const CiOrgDocument({super.key, required this.officeId, this.companyId});
//
//   @override
//   State<CiOrgDocument> createState() => _CiOrgDocumentState();
// }
//
// class _CiOrgDocumentState extends State<CiOrgDocument> {
//   final PageController _tabPageController = PageController();
//   TextEditingController docNamecontroller = TextEditingController();
//   TextEditingController docIdController = TextEditingController();
//   TextEditingController calenderController = TextEditingController();
//   final StreamController<List<IdentityDocumentIdData>> _identityDataController =
//       StreamController<List<IdentityDocumentIdData>>.broadcast();
//
//   int _selectedIndex = 0;
//   void _selectButton(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _tabPageController.animateToPage(
//       index,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//   late Future<List<DocumentTypeData>> docTypeFuture;
//
//   List<DocumentTypeData> docTypeData = [];
//   void loadData() async {
//     docTypeData = await documentTypeGet(context);
//   }
//
//   late Future<List<IdentityDocumentIdData>> subDocTypeFuture;
//   @override
//   void initState() {
//     super.initState();
//     subDocTypeFuture = identityDocumentTypeGet(context, docTypeMetaIdVC).then((data) {
//       _identityDataController.add(data);
//       return data;
//     }).catchError((error) {
//       // Handle error
//     });
//   }
//
//   int docTypeMetaIdPP = AppConfig.policiesAndProcedure;
//   int docTypeMetaIdVC = AppConfig.vendorContracts;
//   int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
//   int docSubTypeMetaIdPP = AppConfig.subDocId0;
//   var docID = 8;
//  // int docTypeMetaId = 8;
//   int docSubTypeMetaId = 0;
//   String? selectedDocTypeValue;
//   String? selectedSubDocTypeValue;
//   String? expiryType;
//   bool _isLoading = false;
//   int selectedSubDocId = AppConfig.subDocId1Licenses; // Default value
//   String selectedSubDocType = "Licenses";
//   final AppConfig appConfig = AppConfig();
//
//   void _updateSelectedSubDocId(int subDocId) {
//     setState(() {
//       selectedSubDocId = subDocId;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 20,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SizedBox(
//               height: 20,
//               width: 150,
//             ),
//             Material(
//               elevation: 4,
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//               child: Container(
//                 width: 670,
//                 height: 30,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                     color: ColorManager.blueprime),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                         child: InkWell(
//                       onTap: () {
//                         _selectButton(0);
//                       },
//                       child: Container(
//                         height: 30,
//                         width: 210,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                           color: _selectedIndex == 0
//                               ? Colors.white
//                               : Colors.transparent,
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Corporate & Compliance Documents',
//                             style: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                               color: _selectedIndex == 0
//                                   ? ColorManager.mediumgrey
//                                   : ColorManager.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )),
//                     Expanded(
//                         child: InkWell(
//                       onTap: () {
//                         _selectButton(1);
//                       },
//                       child: Container(
//                         height: 30,
//                         width: 210,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                           color: _selectedIndex == 1
//                               ? Colors.white
//                               : Colors.transparent,
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Vendor Contracts',
//                             style: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                               color: _selectedIndex == 1
//                                   ? ColorManager.mediumgrey
//                                   : ColorManager.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )),
//                     Expanded(
//                         child: InkWell(
//                       onTap: () {
//                         _selectButton(2);
//                       },
//                       child: Container(
//                         height: 30,
//                         width: 210,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                           color: _selectedIndex == 2
//                               ? Colors.white
//                               : Colors.transparent,
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Policies & Procedures',
//                             style: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                               color: _selectedIndex == 2
//                                   ? ColorManager.mediumgrey
//                                   : ColorManager.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )),
//                   ],
//                 ),
//               ),
//             ),
//
//             ///button
//            _selectedIndex == 0
//            ///Corporate
//                ? Align(
//              alignment: Alignment.bottomRight,
//              child: Container(
//                height: 30,
//                width: 150,
//                child: CustomIconButton(
//                  icon: Icons.add,
//                  text: "Add Document",
//                  onPressed: () async {
//                    String? selectedExpiryType = expiryType;
//                    calenderController.clear();
//                    docIdController.clear();
//                    docNamecontroller.clear();
//                    selectedExpiryType = "";
//                    selectedSubDocTypeValue = "";
//                    showDialog(
//                      context: context,
//                      builder: (context) {
//                        return StatefulBuilder(
//                          builder: (BuildContext context, void Function(void Function()) setState) {
//                            return AddOrgDocButton(
//                              title: "Add Corporate & Compliance",
//                              calenderController: calenderController,
//                              idDocController: docIdController,
//                              nameDocController: docNamecontroller,
//                              loadingDuration: _isLoading,
//                              onPressed: () async {
//                                setState(() {
//                                  _isLoading = true;
//                                });
//                                int subDocId = _selectedIndex == 0 ? AppConfig.subDocId1Licenses :
//                                _selectedIndex == 1 ? AppConfig.subDocId2Adr :
//                                _selectedIndex == 2 ? AppConfig.subDocId3CICCMedicalCR :
//                                _selectedIndex == 3 ? AppConfig.subDocId4CapReport :
//                                AppConfig.subDocId5BalReport;
//
//                                String expiryTypeToSend = selectedExpiryType == "Not Applicable"
//                                    ? "Not Applicable"
//                                    : calenderController.text;
//                                try {
//                                  await addOrgCorporateDocumentPost(
//                                    context: context,
//                                    name: docNamecontroller.text,
//                                    docTypeID: docTypeMetaIdCC,
//                                    docSubTypeID: selectedSubDocId,//docSubTypeMetaId,
//                                    expiryType: selectedExpiryType.toString(),
//                                    expiryDate: expiryTypeToSend,
//                                    expiryReminder: selectedExpiryType.toString(),
//                                    idOfDoc: docIdController.text,
//                                  );
//                                  Navigator.pop(context);
//                                } finally {
//                                  setState(() {
//                                    _isLoading = false;
//                                  });
//                                }
//                              },
//                              // Document Type Dropdown (Disabled and Showing Vendor Contract)
//                              child:FutureBuilder<List<DocumentTypeData>>(
//                                future: documentTypeGet(context),
//                                builder: (context, snapshot) {
//                                  if (snapshot.connectionState == ConnectionState.waiting) {
//                                    return Container(
//                                      width: 300,
//                                      child:loadingText,
//                                    );
//                                  }
//                                  if (snapshot.data!.isEmpty) {
//                                    return Center(
//                                      child: Text(
//                                        AppString.dataNotFound,
//                                        style: CustomTextStylesCommon.commonStyle(
//                                          fontWeight: FontWeightManager.medium,
//                                          fontSize: FontSize.s12,
//                                          color: ColorManager.mediumgrey,
//                                        ),
//                                      ),
//                                    );
//                                  }
//                                  if (snapshot.hasData) {
//                                    String selectedDocType = "";
//                                    int docType = snapshot.data![0].docID;
//
//                                    for (var i in snapshot.data!) {
//                                      if (i.docID == AppConfig.corporateAndCompliance) {
//                                        selectedDocType = i.docType;
//                                        docType = i.docID;
//                                        break;
//                                      }
//                                    }
//                                    docTypeMetaIdCC = docType;
//                                    identityDocumentTypeGet(context, docTypeMetaIdCC).then((data) {
//                                      _identityDataController.add(data);
//                                    }).catchError((error) {
//                                      // Handle error
//                                    });
//                                    return Container(
//                                      width: 354,
//                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
//                                      decoration: BoxDecoration(
//                                        color: ColorManager.white,
//                                        borderRadius: BorderRadius.circular(8),
//                                        border: Border.all(color: ColorManager.fmediumgrey,width: 1),
//                                      ),
//                                      child: Row(
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                        children: [
//                                          Text(
//                                            selectedDocType,
//                                            style: CustomTextStylesCommon.commonStyle(
//                                              fontWeight: FontWeightManager.medium,
//                                              fontSize: FontSize.s12,
//                                              color: ColorManager.mediumgrey,
//                                            ),
//                                          ),
//                                          Icon(
//                                            Icons.arrow_drop_down,
//                                            color: Colors.transparent,
//                                          ),
//                                        ],
//                                      ),
//                                    );
//                                  } else {
//                                    return SizedBox();
//                                  }
//                                },
//                              ),
//                              selectedSubDocType: selectedSubDocType,
//                              child1: CICCDropDownExcel(
//                                isEnabled: false,
//                                initialValue: selectedSubDocType,
//                                onChange: (val) {
//                                  setState(() {
//                                    selectedSubDocTypeValue = val;
//                                  });
//                                },
//                                items: [DropdownMenuItem<String>(
//                                  value: selectedSubDocType,
//                                  child: Text(selectedSubDocType),
//                                )],
//                               // hintText: "Select Sub Document",
//                              ),
//                              radioButton: Padding(
//                                padding: const EdgeInsets.only(left: 10.0),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
//                                    Text(
//                                      "Expiry Type",
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: FontSize.s12,
//                                        fontWeight: FontWeight.w700,
//                                        color: ColorManager.mediumgrey,
//                                        decoration: TextDecoration.none,
//                                      ),
//                                    ),
//                                    CustomRadioListTile(
//                                      value: "Not Applicable",
//                                      groupValue: selectedExpiryType,
//                                      onChanged: (value) {
//                                        setState(() {
//                                          selectedExpiryType = value;
//                                        });
//                                      },
//                                      title: "Not Applicable",
//                                    ),
//                                    CustomRadioListTile(
//                                      value: 'Scheduled',
//                                      groupValue: selectedExpiryType,
//                                      onChanged: (value) {
//                                        setState(() {
//                                          selectedExpiryType = value;
//                                        });
//                                      },
//                                      title: 'Scheduled',
//                                    ),
//                                    CustomRadioListTile(
//                                      value: 'Issuer Expiry',
//                                      groupValue: selectedExpiryType,
//                                      onChanged: (value) {
//                                        setState(() {
//                                          selectedExpiryType = value;
//                                        });
//                                      },
//                                      title: 'Issuer Expiry',
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              child2: Visibility(
//                                visible: selectedExpiryType == "Scheduled" || selectedExpiryType == "Issuer Expiry",
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
//                                    Text(
//                                      "Expiry Date",
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: FontSize.s12,
//                                        fontWeight: FontWeight.w700,
//                                        color: ColorManager.mediumgrey,
//                                        decoration: TextDecoration.none,
//                                      ),
//                                    ),
//                                    SizedBox(height: AppSize.s5),
//                                    FormField<String>(
//                                      builder: (FormFieldState<String> field) {
//                                        return SizedBox(
//                                          width: 354,
//                                          height: 30,
//                                          child: TextFormField(
//                                            controller: calenderController,
//                                            cursorColor: ColorManager.black,
//                                            style: GoogleFonts.firaSans(
//                                              fontSize: FontSize.s12,
//                                              fontWeight: FontWeight.w700,
//                                              color: ColorManager.mediumgrey,
//                                            ),
//                                            decoration: InputDecoration(
//                                              enabledBorder: OutlineInputBorder(
//                                                borderSide: BorderSide(
//                                                  color: ColorManager.fmediumgrey,
//                                                  width: 1,
//                                                ),
//                                                borderRadius: BorderRadius.circular(8),
//                                              ),
//                                              focusedBorder: OutlineInputBorder(
//                                                borderSide: BorderSide(
//                                                  color: ColorManager.fmediumgrey,
//                                                  width: 1,
//                                                ),
//                                                borderRadius: BorderRadius.circular(8),
//                                              ),
//                                              hintText: 'mm-dd-yyyy',
//                                              hintStyle: GoogleFonts.firaSans(
//                                                fontSize: FontSize.s12,
//                                                fontWeight: FontWeight.w700,
//                                                color: ColorManager.mediumgrey,
//                                              ),
//                                              border: OutlineInputBorder(
//                                                borderRadius: BorderRadius.circular(8),
//                                                borderSide: BorderSide(
//                                                  width: 1,
//                                                  color: ColorManager.fmediumgrey,
//                                                ),
//                                              ),
//                                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                                              suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
//                                              errorText: field.errorText,
//                                            ),
//                                            onTap: () async {
//                                              FocusScope.of(context).requestFocus(FocusNode());
//                                              final date = await showDatePicker(
//                                                context: context,
//                                                initialDate: DateTime.now(),
//                                                firstDate: DateTime(1901),
//                                                lastDate: DateTime(3101),
//                                              );
//                                              calenderController.text = date != null ? DateFormat('MM-dd-yyyy').format(date) : '';
//                                            },
//                                          ),
//                                        );
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            );
//                          },
//                        );
//                      },
//                    );
//                  },
//                ),
//              ),
//            )
//                : _selectedIndex == 1
//            ///vendor
//             ?  Align(
//              alignment: Alignment.bottomRight,
//              child: Container(
//                height: 30,
//                width: 150,
//                child: CustomIconButton(
//                  icon: Icons.add,
//                  text: "Add Document",
//                  onPressed: () async {
//                    String? selectedExpiryType = expiryType;
//                    calenderController.clear();
//                    docIdController.clear();
//                    docNamecontroller.clear();
//                    selectedExpiryType = "";
//                    selectedSubDocTypeValue = "";
//                    showDialog(
//                      context: context,
//                      builder: (context) {
//                        return StatefulBuilder(
//                          builder: (BuildContext context, void Function(void Function()) setState) {
//                            return AddOrgDocButton(
//                              title: "Add Vendor Contract",
//                              calenderController: calenderController,
//                              idDocController: docIdController,
//                              nameDocController: docNamecontroller,
//                              loadingDuration: _isLoading,
//                              onPressed: () async {
//                                setState(() {
//                                  _isLoading = true;
//                                });
//                                String expiryTypeToSend = selectedExpiryType == "Not Applicable"
//                                    ? "Not Applicable"
//                                    : calenderController.text;
//                                try {
//                                  await addOrgCorporateDocumentPost(
//                                    context: context,
//                                    name: docNamecontroller.text,
//                                    docTypeID: docTypeMetaIdVC,
//                                    docSubTypeID: docSubTypeMetaId,
//                                    expiryType: selectedExpiryType.toString(),
//                                    expiryDate: expiryTypeToSend,
//                                    expiryReminder: selectedExpiryType.toString(),
//                                    idOfDoc: docIdController.text,
//                                  );
//                                  Navigator.pop(context);
//                                } finally {
//                                  setState(() {
//                                    _isLoading = false;
//                                  });
//                                }
//                              },
//                              // Document Type Dropdown (Disabled and Showing Vendor Contract)
//                              child:FutureBuilder<List<DocumentTypeData>>(
//                                future: documentTypeGet(context),
//                                builder: (context, snapshot) {
//                                  if (snapshot.connectionState == ConnectionState.waiting) {
//                                    return Container(
//                                      width: 300,
//                                      child: Text(
//                                        'Loading...',
//                                        style: CustomTextStylesCommon.commonStyle(
//                                          fontWeight: FontWeightManager.medium,
//                                          fontSize: FontSize.s12,
//                                          color: ColorManager.mediumgrey,
//                                        ),
//                                      ),
//                                    );
//                                  }
//                                  if (snapshot.data!.isEmpty) {
//                                    return Center(
//                                      child: Text(
//                                        AppString.dataNotFound,
//                                        style: CustomTextStylesCommon.commonStyle(
//                                          fontWeight: FontWeightManager.medium,
//                                          fontSize: FontSize.s12,
//                                          color: ColorManager.mediumgrey,
//                                        ),
//                                      ),
//                                    );
//                                  }
//                                  if (snapshot.hasData) {
//                                    String selectedDocType = "";
//                                    int docType = snapshot.data![0].docID;
//
//                                    for (var i in snapshot.data!) {
//                                      if (i.docID == AppConfig.vendorContracts) {
//                                        selectedDocType = i.docType;
//                                        docType = i.docID;
//                                        break;
//                                      }
//                                    }
//
//                                    docTypeMetaIdVC = docType;
//
//                                    identityDocumentTypeGet(context, docTypeMetaIdVC).then((data) {
//                                      _identityDataController.add(data);
//                                    }).catchError((error) {
//                                      // Handle error
//                                    });
//                                    return Container(
//                                      width: 354,
//                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
//                                      decoration: BoxDecoration(
//                                        color: ColorManager.white,
//                                        borderRadius: BorderRadius.circular(8),
//                                        border: Border.all(color: ColorManager.fmediumgrey,width: 1),
//                                      ),
//                                      child: Row(
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                        children: [
//                                          Text(
//                                            selectedDocType,
//                                            style: CustomTextStylesCommon.commonStyle(
//                                              fontWeight: FontWeightManager.medium,
//                                              fontSize: FontSize.s12,
//                                              color: ColorManager.mediumgrey,
//                                            ),
//                                          ),
//                                          Icon(
//                                            Icons.arrow_drop_down,
//                                            color: Colors.transparent,
//                                          ),
//                                        ],
//                                      ),
//                                    );
//                                  } else {
//                                    return SizedBox();
//                                  }
//                                },
//                              ),
//
//                              // Subdocument Type Dropdown
//                              child1: StreamBuilder<List<IdentityDocumentIdData>>(
//                                stream: _identityDataController.stream,
//                                builder: (context, snapshot) {
//                                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//                                    List<DropdownMenuItem<String>> dropDownMenuItems = [];
//
//                                    // Create dropdown items from the fetched data
//                                    for (var i in snapshot.data!) {
//                                      dropDownMenuItems.add(
//                                        DropdownMenuItem<String>(
//                                          value: i.subDocType,
//                                          child: Text(i.subDocType),
//                                        ),
//                                      );
//                                    }
//
//                                    // Return the CICCDropdown with "Select Sub Document" as the initial value
//                                    return CICCDropDownExcel(
//                                      initialValue: "Select Sub Document",
//                                      onChange: (val) {
//                                        if (val != "Select Sub Document") {
//                                          for (var a in snapshot.data!) {
//                                            if (a.subDocType == val) {
//                                              docSubTypeMetaId = a.subDocID;
//                                            }
//                                          }
//                                        }
//                                      },
//                                      items: dropDownMenuItems,
//                                      hintText: "Select Sub Document",
//                                    );
//                                  } else if (snapshot.connectionState == ConnectionState.waiting) {
//                                    return SizedBox();
//                                  } else {
//                                    return Center(
//                                      child: Text(
//                                        ErrorMessageString.noAvailableSubType,
//                                        //AppString.dataNotFound,
//                                        style: CustomTextStylesCommon.commonStyle(
//                                          fontWeight: FontWeightManager.medium,
//                                          fontSize: FontSize.s12,
//                                          color: ColorManager.mediumgrey,
//                                        ),
//                                      ),
//                                    );
//                                  }
//                                },
//                              ),
//
//                              // Expiry Type Radio Buttons and Expiry Date Selection
//                              radioButton: Padding(
//                                padding: const EdgeInsets.only(left: 10.0),
//                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
//                                    Text(
//                                      "Expiry Type",
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: FontSize.s12,
//                                        fontWeight: FontWeight.w700,
//                                        color: ColorManager.mediumgrey,
//                                        decoration: TextDecoration.none,
//                                      ),
//                                    ),
//                                    CustomRadioListTile(
//                                      value: "Not Applicable",
//                                      groupValue: selectedExpiryType,
//                                      onChanged: (value) {
//                                        setState(() {
//                                          selectedExpiryType = value;
//                                        });
//                                      },
//                                      title: "Not Applicable",
//                                    ),
//                                    CustomRadioListTile(
//                                      value: 'Scheduled',
//                                      groupValue: selectedExpiryType,
//                                      onChanged: (value) {
//                                        setState(() {
//                                          selectedExpiryType = value;
//                                        });
//                                      },
//                                      title: 'Scheduled',
//                                    ),
//                                    CustomRadioListTile(
//                                      value: 'Issuer Expiry',
//                                      groupValue: selectedExpiryType,
//                                      onChanged: (value) {
//                                        setState(() {
//                                          selectedExpiryType = value;
//                                        });
//                                      },
//                                      title: 'Issuer Expiry',
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              // Expiry Date Selection Visibility
//                              child2: Visibility(
//                                visible: selectedExpiryType == "Scheduled" || selectedExpiryType == "Issuer Expiry",
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: [
//                                    Text(
//                                      "Expiry Date",
//                                      style: GoogleFonts.firaSans(
//                                        fontSize: FontSize.s12,
//                                        fontWeight: FontWeight.w700,
//                                        color: ColorManager.mediumgrey,
//                                        decoration: TextDecoration.none,
//                                      ),
//                                    ),
//                                    SizedBox(height: AppSize.s5),
//                                    FormField<String>(
//                                      builder: (FormFieldState<String> field) {
//                                        return SizedBox(
//                                          width: 354,
//                                          height: 30,
//                                          child: TextFormField(
//                                            controller: calenderController,
//                                            cursorColor: ColorManager.black,
//                                            style: GoogleFonts.firaSans(
//                                              fontSize: FontSize.s12,
//                                              fontWeight: FontWeight.w700,
//                                              color: ColorManager.mediumgrey,
//                                            ),
//                                            decoration: InputDecoration(
//                                              enabledBorder: OutlineInputBorder(
//                                                borderSide: BorderSide(
//                                                  color: ColorManager.fmediumgrey,
//                                                  width: 1,
//                                                ),
//                                                borderRadius: BorderRadius.circular(8),
//                                              ),
//                                              focusedBorder: OutlineInputBorder(
//                                                borderSide: BorderSide(
//                                                  color: ColorManager.fmediumgrey,
//                                                  width: 1,
//                                                ),
//                                                borderRadius: BorderRadius.circular(8),
//                                              ),
//                                              hintText: 'mm-dd-yyyy',
//                                              hintStyle: GoogleFonts.firaSans(
//                                                fontSize: FontSize.s12,
//                                                fontWeight: FontWeight.w700,
//                                                color: ColorManager.mediumgrey,
//                                              ),
//                                              border: OutlineInputBorder(
//                                                borderRadius: BorderRadius.circular(8),
//                                                borderSide: BorderSide(
//                                                  width: 1,
//                                                  color: ColorManager.fmediumgrey,
//                                                ),
//                                              ),
//                                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                                              suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
//                                              errorText: field.errorText,
//                                            ),
//                                            onTap: () async {
//                                              FocusScope.of(context).requestFocus(FocusNode());
//                                              final date = await showDatePicker(
//                                                context: context,
//                                                initialDate: DateTime.now(),
//                                                firstDate: DateTime(1901),
//                                                lastDate: DateTime(3101),
//                                              );
//                                              calenderController.text = date != null ? DateFormat('MM-dd-yyyy').format(date) : '';
//                                            },
//                                          ),
//                                        );
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            );
//                          },
//                        );
//                      },
//                    );
//                  },
//                ),
//              ),
//            )
//            ///Policies
//                :Align(
//                alignment: Alignment.bottomRight,
//                child: Container(
//                  height: 30,
//                  width: 150,
//                  child: CustomIconButton(
//                    icon: Icons.add,
//                    text: "Add Document",
//                    onPressed: () async {
//                      String? selectedDocType;
//                      String? selectedSubDocType;
//                      String? selectedExpiryType = expiryType;
//                      calenderController.clear();
//                      docIdController.clear();
//                      docNamecontroller.clear();
//                      selectedExpiryType = "";
//                      selectedDocTypeValue = "";
//                      selectedSubDocTypeValue = "";
//
//                      showDialog(
//                        context: context,
//                        builder: (context) {
//                          return StatefulBuilder(
//                            builder: (BuildContext context,
//                                void Function(void Function()) setState) {
//                              return AddOrgDocButton(
//                                calenderController: calenderController,
//                                idDocController: docIdController,
//                                nameDocController: docNamecontroller,
//                                loadingDuration: _isLoading,
//                                onPressed: () async {
//                                  setState(() {
//                                    _isLoading = true;
//                                  });
//                                  String expiryTypeToSend = selectedExpiryType == "Not Applicable"
//                                      ? "Not Applicable"
//                                      : calenderController.text;
//                                  try {
//                                    await addOrgCorporateDocumentPost(
//                                      context: context,
//                                      name: docNamecontroller.text,
//                                      docTypeID: docTypeMetaIdPP,
//                                      docSubTypeID: docTypeMetaIdPP == AppConfig.policiesAndProcedure
//                                          ? 0
//                                          : docSubTypeMetaIdPP,
//                                      expiryType:
//                                      selectedExpiryType.toString(),
//                                      expiryDate: expiryTypeToSend,
//                                      expiryReminder:
//                                      selectedExpiryType.toString(),
//                                      idOfDoc: docIdController.text,
//                                    );
//                                    await getORGDoc(context, docTypeMetaIdPP,
//                                        docSubTypeMetaIdPP, 1, 20);
//                                    Navigator.pop(context);
//                                    setState(() {
//                                      expiryType = '';
//                                      calenderController.clear();
//                                      docIdController.clear();
//                                      docNamecontroller.clear();
//                                    });
//                                  } finally {
//                                    setState(() {
//                                      _isLoading = false;
//                                    });
//                                  }
//                                },
//                                child: FutureBuilder<List<DocumentTypeData>>(
//                                  future: documentTypeGet(context),
//                                  builder: (context, snapshot) {
//                                    if (snapshot.connectionState == ConnectionState.waiting) {
//                                      return Container(
//                                        width: 300,
//                                        child: Text(
//                                          'Loading...',
//                                          style: CustomTextStylesCommon.commonStyle(
//                                            fontWeight: FontWeightManager.medium,
//                                            fontSize: FontSize.s12,
//                                            color: ColorManager.mediumgrey,
//                                          ),
//                                        ),
//                                      );
//                                    }
//                                    if (snapshot.data!.isEmpty) {
//                                      return Center(
//                                        child: Text(
//                                          ErrorMessageString.noAvailableSubType,
//                                          //AppString.dataNotFound,
//                                          style: CustomTextStylesCommon.commonStyle(
//                                            fontWeight: FontWeightManager.medium,
//                                            fontSize: FontSize.s12,
//                                            color: ColorManager.mediumgrey,
//                                          ),
//                                        ),
//                                      );
//                                    }
//                                    if (snapshot.hasData) {
//                                      String selectedDocType = "";
//                                      int docType = snapshot.data![0].docID;
//
//                                      for (var i in snapshot.data!) {
//                                        if (i.docID == AppConfig.policiesAndProcedure) {
//                                          selectedDocType = i.docType;
//                                          docType = i.docID;
//                                          break;
//                                        }
//                                      }
//
//                                      docTypeMetaIdPP = docType;
//
//                                      identityDocumentTypeGet(context, docTypeMetaIdPP).then((data) {
//                                        _identityDataController.add(data);
//                                      }).catchError((error) {
//                                        // Handle error
//                                      });
//                                      return Container(
//                                        width: 354,
//                                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
//                                        decoration: BoxDecoration(
//                                          color: ColorManager.white,
//                                          borderRadius: BorderRadius.circular(8),
//                                          border: Border.all(color: ColorManager.fmediumgrey,width: 1),
//                                        ),
//                                        child: Row(
//                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                          children: [
//                                            Text(
//                                              selectedDocType,
//                                              style: CustomTextStylesCommon.commonStyle(
//                                                fontWeight: FontWeightManager.medium,
//                                                fontSize: FontSize.s12,
//                                                color: ColorManager.mediumgrey,
//                                              ),
//                                            ),
//                                            Icon(
//                                              Icons.arrow_drop_down,
//                                              color: Colors.transparent,
//                                            ),
//                                          ],
//                                        ),
//                                      );
//                                    } else {
//                                      return SizedBox();
//                                    }
//                                  },
//                                ),
//                                radioButton: Padding(
//                                  padding: const EdgeInsets.only(left: 10.0),
//                                  child: Column(
//                                    mainAxisAlignment:
//                                    MainAxisAlignment.start,
//                                    crossAxisAlignment:
//                                    CrossAxisAlignment.start,
//                                    children: [
//                                      Text(
//                                        "Expiry Type",
//                                        style: GoogleFonts.firaSans(
//                                          fontSize: FontSize.s12,
//                                          fontWeight: FontWeight.w700,
//                                          color: ColorManager.mediumgrey,
//                                          decoration: TextDecoration.none,
//                                        ),
//                                      ),
//                                      CustomRadioListTile(
//                                        value: "Not Applicable",
//                                        groupValue: selectedExpiryType,
//                                        onChanged: (value) {
//                                          setState(() {
//                                            selectedExpiryType = value;
//                                          });
//                                        },
//                                        title: "Not Applicable",
//                                      ),
//                                      CustomRadioListTile(
//                                        value: 'Scheduled',
//                                        groupValue: selectedExpiryType,
//                                        onChanged: (value) {
//                                          setState(() {
//                                            selectedExpiryType = value;
//                                          });
//                                        },
//                                        title: 'Scheduled',
//                                      ),
//                                      CustomRadioListTile(
//                                        value: 'Issuer Expiry',
//                                        groupValue: selectedExpiryType,
//                                        onChanged: (value) {
//                                          setState(() {
//                                            selectedExpiryType = value;
//                                          });
//                                        },
//                                        title: 'Issuer Expiry',
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                child2: Visibility(
//                                  visible: selectedExpiryType ==
//                                      "Scheduled" ||
//                                      selectedExpiryType == "Issuer Expiry",
//                                  child: Column(
//                                    crossAxisAlignment:
//                                    CrossAxisAlignment.start,
//                                    children: [
//                                      Text(
//                                        "Expiry Date",
//                                        style: GoogleFonts.firaSans(
//                                          fontSize: FontSize.s12,
//                                          fontWeight: FontWeight.w700,
//                                          color: ColorManager.mediumgrey,
//                                          decoration: TextDecoration.none,
//                                        ),
//                                      ),
//                                      SizedBox(height: AppSize.s5,),
//                                      FormField<String>(
//                                        builder:
//                                            (FormFieldState<String> field) {
//                                          return SizedBox(
//                                            width: 354,
//                                            height: 30,
//                                            child: TextFormField(
//                                              controller: calenderController,
//                                              cursorColor: ColorManager.black,
//                                              style: GoogleFonts.firaSans(
//                                                fontSize: FontSize.s12,
//                                                fontWeight: FontWeight.w700,
//                                                color:
//                                                ColorManager.mediumgrey,
//                                              ),
//                                              decoration: InputDecoration(
//                                                enabledBorder:
//                                                OutlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                      color: ColorManager
//                                                          .fmediumgrey,
//                                                      width: 1),
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      8),
//                                                ),
//                                                focusedBorder:
//                                                OutlineInputBorder(
//                                                  borderSide: BorderSide(
//                                                      color: ColorManager
//                                                          .fmediumgrey,
//                                                      width: 1),
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      8),
//                                                ),
//                                                hintText: 'mm-dd-yyyy',
//                                                hintStyle:
//                                                GoogleFonts.firaSans(
//                                                  fontSize: FontSize.s12,
//                                                  fontWeight: FontWeight.w700,
//                                                  color:
//                                                  ColorManager.mediumgrey,
//                                                ),
//                                                border: OutlineInputBorder(
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      8),
//                                                  borderSide: BorderSide(
//                                                      width: 1,
//                                                      color: ColorManager
//                                                          .fmediumgrey),
//                                                ),
//                                                contentPadding:
//                                                EdgeInsets.symmetric(
//                                                    horizontal: 16),
//                                                suffixIcon: Icon(
//                                                    Icons
//                                                        .calendar_month_outlined,
//                                                    color: ColorManager
//                                                        .blueprime),
//                                                errorText: field.errorText,
//                                              ),
//                                              onTap: () async {
//                                                DateTime? pickedDate =
//                                                await showDatePicker(
//                                                  context: context,
//                                                  initialDate: DateTime.now(),
//                                                  firstDate: DateTime(1901),
//                                                  lastDate: DateTime(3101),
//                                                );
//                                                if (pickedDate != null) {
//                                                  calenderController.text =
//                                                      DateFormat('MM-dd-yyyy')
//                                                          .format(pickedDate);
//                                                }
//                                              },
//                                              validator: (value) {
//                                                if (value == null ||
//                                                    value.isEmpty) {
//                                                  return 'Please select a date';
//                                                }
//                                                return null;
//                                              },
//                                            ),
//                                          );
//                                        },
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                                title: 'Add Document',
//                              );
//                            },
//                          );
//                        },
//                      );
//                    },
//                  ),
//                ))
//           ],
//         ),
//         SizedBox(
//           height: 30,
//         ),
//         Expanded(
//           child: Stack(
//             children: [
//               _selectedIndex != 5
//                   ? Container(
//                       height: MediaQuery.of(context).size.height / 3.5,
//                       decoration: BoxDecoration(
//                           color: Color(0xFFF2F9FC),
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: ColorManager.faintGrey,
//                               blurRadius: 2,
//                               spreadRadius: -2,
//                               offset: Offset(0, -4),
//                             ),
//                           ]),
//                     )
//                   : Offstage(),
//               NonScrollablePageView(
//                 controller: _tabPageController,
//                 onPageChanged: (index) {
//                   // setState(() {
//                   _selectedIndex = index;
//                   // });
//                 },
//                 children: [
//                   // Page 1
//                   CICorporateCompilianceDocument(
//                     docID: AppConfig.corporateAndCompliance, selectedSubDocType: selectedSubDocType, onSubDocIdSelected: _updateSelectedSubDocId, //officeId: widget.officeId,
//                   ),
//                   CIVendorContract(
//                     docId: AppConfig.vendorContracts, //officeId: widget.officeId
//                   ),
//                   CIPoliciesProcedure(
//                     docId: AppConfig.policiesAndProcedure, subDocId: AppConfig.subDocId0,
//                     //officeId: widget.officeId,
//                   )
//                 ],
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }


class CiOrgDocument extends StatefulWidget {
  final String officeId;
  final int? companyId;
  const CiOrgDocument({super.key, required this.officeId, this.companyId});

  @override
  State<CiOrgDocument> createState() => _CiOrgDocumentState();
}

class _CiOrgDocumentState extends State<CiOrgDocument> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
  StreamController<List<IdentityDocumentIdData>>.broadcast();

  int _selectedIndex = 0;
  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  late Future<List<DocumentTypeData>> docTypeFuture;

  List<DocumentTypeData> docTypeData = [];
  void loadData() async {
    docTypeData = await documentTypeGet(context);
  }

  //late Future<List<IdentityDocumentIdData>> subDocTypeFuture;
  @override
  void initState() {
    super.initState();
    // subDocTypeFuture = identityDocumentTypeGet(context, docTypeMetaIdVC).then((data) {
    //   _identityDataController.add(data);
    //   return data;
    // }).catchError((error) {
    //   // Handle error
    // });
  }

  int docTypeMetaIdPP = AppConfig.policiesAndProcedure;
  int docTypeMetaIdVC = AppConfig.vendorContracts;
  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int docSubTypeMetaIdPP = AppConfig.subDocId0;
  var docID = 8;
  int docSubTypeMetaId = 0;
  String? selectedDocTypeValue;
  String? selectedSubDocTypeValue;
  String? expiryType;
  bool _isLoading = false;
  int selectedSubDocId = AppConfig.subDocId1Licenses; // Default value
  String selectedSubDocType = "";
  int selectedSubDocIdVC = AppConfig.subDocId6Leases;
  final AppConfig appConfig = AppConfig();

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
        return "Cap Reports";
      case AppConfig.subDocId5BalReport:
        return "Quarterly Balance Reports";
      default:
        return "Unknown Document Type";
    }
  }

  void _updateSelectedSubDocIdVC(int subDocIdVC) {
    setState(() {
      selectedSubDocIdVC = subDocIdVC;
      selectedSubDocType = getSubDocTypeTextVC(subDocIdVC);
    });
  }

  String getSubDocTypeTextVC(int subDocIdVC) {
    switch (subDocIdVC) {
      case AppConfig.subDocId6Leases:
        return "Leases & Services";
      case AppConfig.subDocId7SNF:
        return "SNF";
      case AppConfig.subDocId8DME:
        return "DME";
      case AppConfig.subDocId9MD:
        return "MD";
      case AppConfig.subDocId10MISC:
        return "MISC";
      default:
        return "Unknown Document Type";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 150,
            ),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                width: 670,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorManager.blueprime),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            _selectButton(0);
                          },
                          child: Container(
                            height: 30,
                            width: 210,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: _selectedIndex == 0
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Corporate & Compliance Documents',
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _selectedIndex == 0
                                      ? ColorManager.mediumgrey
                                      : ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            _selectButton(1);
                          },
                          child: Container(
                            height: 30,
                            width: 210,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: _selectedIndex == 1
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Vendor Contracts',
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _selectedIndex == 1
                                      ? ColorManager.mediumgrey
                                      : ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        )),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            _selectButton(2);
                          },
                          child: Container(
                            height: 30,
                            width: 210,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: _selectedIndex == 2
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Policies & Procedures',
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _selectedIndex == 2
                                      ? ColorManager.mediumgrey
                                      : ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),

            ///button
            _selectedIndex == 0
            ///Corporate
                ? Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 30,
                width: 150,
                child: CustomIconButton(
                  icon: Icons.add,
                  text: "Add Document",
                  onPressed: () async {
                    String? selectedExpiryType = expiryType;
                    calenderController.clear();
                    docIdController.clear();
                    docNamecontroller.clear();
                    selectedExpiryType = "";
                    selectedSubDocTypeValue = "";
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return AddOrgDocButton(
                              title: "Add Corporate & Compliance",
                              calenderController: calenderController,
                              idDocController: docIdController,
                              nameDocController: docNamecontroller,
                              loadingDuration: _isLoading,
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                int subDocId = _selectedIndex == 0 ? AppConfig.subDocId1Licenses :
                                _selectedIndex == 1 ? AppConfig.subDocId2Adr :
                                _selectedIndex == 2 ? AppConfig.subDocId3CICCMedicalCR :
                                _selectedIndex == 3 ? AppConfig.subDocId4CapReport :
                                AppConfig.subDocId5BalReport;

                                String expiryTypeToSend = selectedExpiryType == "Not Applicable"
                                    ? "Not Applicable"
                                    : calenderController.text;
                                try {
                                  await addOrgCorporateDocumentPost(
                                    context: context,
                                    name: docNamecontroller.text,
                                    docTypeID: docTypeMetaIdCC,
                                    docSubTypeID: selectedSubDocId,//docSubTypeMetaId,
                                    expiryType: selectedExpiryType.toString(),
                                    expiryDate: expiryTypeToSend,
                                    expiryReminder: selectedExpiryType.toString(),
                                    idOfDoc: docIdController.text,
                                  );
                                  Navigator.pop(context);
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              // Document Type Dropdown (Disabled and Showing Vendor Contract)
                              child:FutureBuilder<List<DocumentTypeData>>(
                                future: documentTypeGet(context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Container(
                                      width: 300,
                                      child:loadingText,
                                    );
                                  }
                                  if (snapshot.data!.isEmpty) {
                                    return Center(
                                      child: Text(
                                        AppString.dataNotFound,
                                        style: CustomTextStylesCommon.commonStyle(
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: FontSize.s12,
                                          color: ColorManager.mediumgrey,
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    String selectedDocType = "";
                                    int docType = snapshot.data![0].docID;

                                    for (var i in snapshot.data!) {
                                      if (i.docID == AppConfig.corporateAndCompliance) {
                                        selectedDocType = i.docType;
                                        docType = i.docID;
                                        break;
                                      }
                                    }
                                    docTypeMetaIdCC = docType;
                                    identityDocumentTypeGet(context, docTypeMetaIdCC).then((data) {
                                      _identityDataController.add(data);
                                    }).catchError((error) {
                                      // Handle error
                                    });
                                    return Container(
                                      width: 354,
                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedDocType,
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontWeight: FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                              selectedSubDocType: selectedSubDocType,
                              child1: Container(
                                width: 354,
                                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedSubDocType,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontWeight: FontWeightManager.medium,
                                        fontSize: FontSize.s12,
                                        color: ColorManager.mediumgrey,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                              // CICCDropDownExcel(
                              //   isEnabled: false,
                              //   initialValue: selectedSubDocType, // Use the updated value
                              //   onChange: (val) {
                              //     setState(() {
                              //       selectedSubDocTypeValue = val;
                              //     });
                              //   },
                              //   items: [DropdownMenuItem<String>(
                              //     value: selectedSubDocType, // Display the current selection
                              //     child: Text("Selected Sub Document Type: $selectedSubDocType"),
                              //   )],
                              // ),
                              ///
                              // child1: CICCDropDownExcel(
                              //   isEnabled: false,
                              //   initialValue: selectedSubDocType,
                              //   onChange: (val) {
                              //     setState(() {
                              //       selectedSubDocTypeValue = val;
                              //     });
                              //   },
                              //   items: [DropdownMenuItem<String>(
                              //     value: selectedSubDocType,
                              //     child: Text(selectedSubDocType),
                              //   )],
                              //   // hintText: "Select Sub Document",
                              // ),
                              radioButton: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expiry Type",
                                      style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.mediumgrey,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    CustomRadioListTile(
                                      value: "Not Applicable",
                                      groupValue: selectedExpiryType,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedExpiryType = value;
                                        });
                                      },
                                      title: "Not Applicable",
                                    ),
                                    CustomRadioListTile(
                                      value: 'Scheduled',
                                      groupValue: selectedExpiryType,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedExpiryType = value;
                                        });
                                      },
                                      title: 'Scheduled',
                                    ),
                                    CustomRadioListTile(
                                      value: 'Issuer Expiry',
                                      groupValue: selectedExpiryType,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedExpiryType = value;
                                        });
                                      },
                                      title: 'Issuer Expiry',
                                    ),
                                  ],
                                ),
                              ),
                              child2: Visibility(
                                visible: selectedExpiryType == "Scheduled" || selectedExpiryType == "Issuer Expiry",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expiry Date",
                                      style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.mediumgrey,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    SizedBox(height: AppSize.s5),
                                    FormField<String>(
                                      builder: (FormFieldState<String> field) {
                                        return SizedBox(
                                          width: 354,
                                          height: 30,
                                          child: TextFormField(
                                            controller: calenderController,
                                            cursorColor: ColorManager.black,
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                            ),
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: ColorManager.fmediumgrey,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: ColorManager.fmediumgrey,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              hintText: 'mm-dd-yyyy',
                                              hintStyle: GoogleFonts.firaSans(
                                                fontSize: FontSize.s12,
                                                fontWeight: FontWeight.w700,
                                                color: ColorManager.mediumgrey,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: ColorManager.fmediumgrey,
                                                ),
                                              ),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                              suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
                                              errorText: field.errorText,
                                            ),
                                            onTap: () async {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              final date = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1901),
                                                lastDate: DateTime(3101),
                                              );
                                              calenderController.text = date != null ? DateFormat('MM-dd-yyyy').format(date) : '';
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            )
                : _selectedIndex == 1
            ///vendor
                ?  Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 30,
                width: 150,
                child: CustomIconButton(
                  icon: Icons.add,
                  text: "Add Document",
                  onPressed: () async {
                    String? selectedExpiryType = expiryType;
                    calenderController.clear();
                    docIdController.clear();
                    docNamecontroller.clear();
                    selectedExpiryType = "";
                    selectedSubDocTypeValue = "";
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return AddOrgDocButton(
                              title: "Add Vendor Contract",
                              calenderController: calenderController,
                              idDocController: docIdController,
                              nameDocController: docNamecontroller,
                              loadingDuration: _isLoading,
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });

                                int subDocId = _selectedIndex == 0 ? AppConfig.subDocId6Leases :
                                _selectedIndex == 1 ? AppConfig.subDocId7SNF :
                                _selectedIndex == 2 ? AppConfig.subDocId8DME :
                                _selectedIndex == 3 ? AppConfig.subDocId9MD :
                                AppConfig.subDocId10MISC;

                                String expiryTypeToSend = selectedExpiryType == "Not Applicable"
                                    ? "Not Applicable"
                                    : calenderController.text;
                                try {
                                  await addOrgCorporateDocumentPost(
                                    context: context,
                                    name: docNamecontroller.text,
                                    docTypeID: docTypeMetaIdVC,
                                    docSubTypeID: selectedSubDocIdVC,
                                    expiryType: selectedExpiryType.toString(),
                                    expiryDate: expiryTypeToSend,
                                    expiryReminder: selectedExpiryType.toString(),
                                    idOfDoc: docIdController.text,
                                  );
                                  Navigator.pop(context);
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              child:FutureBuilder<List<DocumentTypeData>>(
                                future: documentTypeGet(context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Container(
                                      width: 300,
                                      child: Text(
                                        'Loading...',
                                        style: CustomTextStylesCommon.commonStyle(
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: FontSize.s12,
                                          color: ColorManager.mediumgrey,
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.data!.isEmpty) {
                                    return Center(
                                      child: Text(
                                        AppString.dataNotFound,
                                        style: CustomTextStylesCommon.commonStyle(
                                          fontWeight: FontWeightManager.medium,
                                          fontSize: FontSize.s12,
                                          color: ColorManager.mediumgrey,
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    String selectedDocType = "";
                                    int docType = snapshot.data![0].docID;

                                    for (var i in snapshot.data!) {
                                      if (i.docID == AppConfig.vendorContracts) {
                                        selectedDocType = i.docType;
                                        docType = i.docID;
                                        break;
                                      }
                                    }

                                    docTypeMetaIdVC = docType;

                                    identityDocumentTypeGet(context, docTypeMetaIdVC).then((data) {
                                      _identityDataController.add(data);
                                    }).catchError((error) {
                                      // Handle error
                                    });
                                    return Container(
                                      width: 354,
                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedDocType,
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontWeight: FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                },
                              ),
                              selectedSubDocType: selectedSubDocType,
                              child1: Container(
                                width: 354,
                                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      selectedSubDocType,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontWeight: FontWeightManager.medium,
                                        fontSize: FontSize.s12,
                                        color: ColorManager.mediumgrey,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                              radioButton: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expiry Type",
                                      style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.mediumgrey,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    CustomRadioListTile(
                                      value: "Not Applicable",
                                      groupValue: selectedExpiryType,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedExpiryType = value;
                                        });
                                      },
                                      title: "Not Applicable",
                                    ),
                                    CustomRadioListTile(
                                      value: 'Scheduled',
                                      groupValue: selectedExpiryType,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedExpiryType = value;
                                        });
                                      },
                                      title: 'Scheduled',
                                    ),
                                    CustomRadioListTile(
                                      value: 'Issuer Expiry',
                                      groupValue: selectedExpiryType,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedExpiryType = value;
                                        });
                                      },
                                      title: 'Issuer Expiry',
                                    ),
                                  ],
                                ),
                              ),
                              child2: Visibility(
                                visible: selectedExpiryType == "Scheduled" || selectedExpiryType == "Issuer Expiry",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Expiry Date",
                                      style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.mediumgrey,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    SizedBox(height: AppSize.s5),
                                    FormField<String>(
                                      builder: (FormFieldState<String> field) {
                                        return SizedBox(
                                          width: 354,
                                          height: 30,
                                          child: TextFormField(
                                            controller: calenderController,
                                            cursorColor: ColorManager.black,
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                            ),
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: ColorManager.fmediumgrey,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: ColorManager.fmediumgrey,
                                                  width: 1,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              hintText: 'mm-dd-yyyy',
                                              hintStyle: GoogleFonts.firaSans(
                                                fontSize: FontSize.s12,
                                                fontWeight: FontWeight.w700,
                                                color: ColorManager.mediumgrey,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  color: ColorManager.fmediumgrey,
                                                ),
                                              ),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                              suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
                                              errorText: field.errorText,
                                            ),
                                            onTap: () async {
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              final date = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1901),
                                                lastDate: DateTime(3101),
                                              );
                                              calenderController.text = date != null ? DateFormat('MM-dd-yyyy').format(date) : '';
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            )
            ///Policies
                :Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 30,
                  width: 150,
                  child: CustomIconButton(
                    icon: Icons.add,
                    text: "Add Document",
                    onPressed: () async {
                      String? selectedDocType;
                      String? selectedSubDocType;
                      String? selectedExpiryType = expiryType;
                      calenderController.clear();
                      docIdController.clear();
                      docNamecontroller.clear();
                      selectedExpiryType = "";
                      selectedDocTypeValue = "";
                      selectedSubDocTypeValue = "";

                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return AddOrgDocButton(
                                calenderController: calenderController,
                                idDocController: docIdController,
                                nameDocController: docNamecontroller,
                                loadingDuration: _isLoading,
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  String expiryTypeToSend = selectedExpiryType == "Not Applicable"
                                      ? "Not Applicable"
                                      : calenderController.text;
                                  try {
                                    await addOrgCorporateDocumentPost(
                                      context: context,
                                      name: docNamecontroller.text,
                                      docTypeID: docTypeMetaIdPP,
                                      docSubTypeID: docTypeMetaIdPP == AppConfig.policiesAndProcedure
                                          ? 0
                                          : docSubTypeMetaIdPP,
                                      expiryType:
                                      selectedExpiryType.toString(),
                                      expiryDate: expiryTypeToSend,
                                      expiryReminder:
                                      selectedExpiryType.toString(),
                                      idOfDoc: docIdController.text,
                                    );
                                    await getORGDoc(context, docTypeMetaIdPP,
                                        docSubTypeMetaIdPP, 1, 20);
                                    Navigator.pop(context);
                                    setState(() {
                                      expiryType = '';
                                      calenderController.clear();
                                      docIdController.clear();
                                      docNamecontroller.clear();
                                    });
                                  } finally {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                                child: FutureBuilder<List<DocumentTypeData>>(
                                  future: documentTypeGet(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Container(
                                        width: 300,
                                        child: Text(
                                          'Loading...',
                                          style: CustomTextStylesCommon.commonStyle(
                                            fontWeight: FontWeightManager.medium,
                                            fontSize: FontSize.s12,
                                            color: ColorManager.mediumgrey,
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.data!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          ErrorMessageString.noAvailableSubType,
                                          //AppString.dataNotFound,
                                          style: CustomTextStylesCommon.commonStyle(
                                            fontWeight: FontWeightManager.medium,
                                            fontSize: FontSize.s12,
                                            color: ColorManager.mediumgrey,
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.hasData) {
                                      String selectedDocType = "";
                                      int docType = snapshot.data![0].docID;

                                      for (var i in snapshot.data!) {
                                        if (i.docID == AppConfig.policiesAndProcedure) {
                                          selectedDocType = i.docType;
                                          docType = i.docID;
                                          break;
                                        }
                                      }

                                      docTypeMetaIdPP = docType;

                                      identityDocumentTypeGet(context, docTypeMetaIdPP).then((data) {
                                        _identityDataController.add(data);
                                      }).catchError((error) {
                                        // Handle error
                                      });
                                      return Container(
                                        width: 354,
                                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: ColorManager.white,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              selectedDocType,
                                              style: CustomTextStylesCommon.commonStyle(
                                                fontWeight: FontWeightManager.medium,
                                                fontSize: FontSize.s12,
                                                color: ColorManager.mediumgrey,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.transparent,
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                                radioButton: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Expiry Type",
                                        style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeight.w700,
                                          color: ColorManager.mediumgrey,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      CustomRadioListTile(
                                        value: "Not Applicable",
                                        groupValue: selectedExpiryType,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedExpiryType = value;
                                          });
                                        },
                                        title: "Not Applicable",
                                      ),
                                      CustomRadioListTile(
                                        value: 'Scheduled',
                                        groupValue: selectedExpiryType,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedExpiryType = value;
                                          });
                                        },
                                        title: 'Scheduled',
                                      ),
                                      CustomRadioListTile(
                                        value: 'Issuer Expiry',
                                        groupValue: selectedExpiryType,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedExpiryType = value;
                                          });
                                        },
                                        title: 'Issuer Expiry',
                                      ),
                                    ],
                                  ),
                                ),
                                child2: Visibility(
                                  visible: selectedExpiryType ==
                                      "Scheduled" ||
                                      selectedExpiryType == "Issuer Expiry",
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Expiry Date",
                                        style: GoogleFonts.firaSans(
                                          fontSize: FontSize.s12,
                                          fontWeight: FontWeight.w700,
                                          color: ColorManager.mediumgrey,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      SizedBox(height: AppSize.s5,),
                                      FormField<String>(
                                        builder:
                                            (FormFieldState<String> field) {
                                          return SizedBox(
                                            width: 354,
                                            height: 30,
                                            child: TextFormField(
                                              controller: calenderController,
                                              cursorColor: ColorManager.black,
                                              style: GoogleFonts.firaSans(
                                                fontSize: FontSize.s12,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                ColorManager.mediumgrey,
                                              ),
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorManager
                                                          .fmediumgrey,
                                                      width: 1),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8),
                                                ),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorManager
                                                          .fmediumgrey,
                                                      width: 1),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8),
                                                ),
                                                hintText: 'mm-dd-yyyy',
                                                hintStyle:
                                                GoogleFonts.firaSans(
                                                  fontSize: FontSize.s12,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                  ColorManager.mediumgrey,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      8),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: ColorManager
                                                          .fmediumgrey),
                                                ),
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                suffixIcon: Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    color: ColorManager
                                                        .blueprime),
                                                errorText: field.errorText,
                                              ),
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1901),
                                                  lastDate: DateTime(3101),
                                                );
                                                if (pickedDate != null) {
                                                  calenderController.text =
                                                      DateFormat('MM-dd-yyyy')
                                                          .format(pickedDate);
                                                }
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please select a date';
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
                                title: 'Add Document',
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ))
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: Stack(
            children: [
              _selectedIndex != 5
                  ? Container(
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                    color: Color(0xFFF2F9FC),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.faintGrey,
                        blurRadius: 2,
                        spreadRadius: -2,
                        offset: Offset(0, -4),
                      ),
                    ]),
              )
                  : Offstage(),
              NonScrollablePageView(
                controller: _tabPageController,
                onPageChanged: (index) {
                  // setState(() {
                  _selectedIndex = index;
                  // });
                },
                children: [
                  // Page 1
                  CICorporateCompilianceDocument(
                    docID: AppConfig.corporateAndCompliance,
                    selectedSubDocType: selectedSubDocType,
                    onSubDocIdSelected: _updateSelectedSubDocId, //officeId: widget.officeId,
                  ),
                  CIVendorContract(
                    docId: AppConfig.vendorContracts,
                    onSubDocIdSelected: _updateSelectedSubDocIdVC,
                    selectedSubDocType: selectedSubDocType, //officeId: widget.officeId
                  ),
                  CIPoliciesProcedure(
                    docId: AppConfig.policiesAndProcedure, subDocId: AppConfig.subDocId0,
                    //officeId: widget.officeId,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
