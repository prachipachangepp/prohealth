import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_corporate&compiliance_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_policies&procedure.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_vendor_contract.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/org_add_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

import '../../company_identity_screen.dart';

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
  TextEditingController daysController = TextEditingController(text: "1");
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

  @override
  void initState() {
    super.initState();
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
  String? selectedYear;

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

  String getDocTypeText(int DocId) {
    switch (DocId) {
      case AppConfig.corporateAndCompliance:
        return AppString.corporateAndComplianceDocuments;
      case AppConfig.policiesAndProcedure:
        return AppString.policiesAndProcedures;
      case AppConfig.vendorContracts:
        return AppString.vendorContracts;
      default:
        return "Unknown Document Type";
    }
  }

  void _updateSelectedSubDocIdVC(int subDocIdVC) {
    setState(() {
      selectedSubDocIdVC = subDocIdVC;
      selectedSubDocType = getSubDocTypeText(subDocIdVC);
    });
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
                                AppString.corporateAndComplianceDocuments,
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
                                AppString.vendorContracts,
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
                                AppString.policiesAndProcedures,
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
                  text: "Add Doctype",
                  onPressed: () async {
                    String? selectedExpiryType = expiryType;
                    calenderController.clear();
                    docIdController.clear();
                    docNamecontroller.clear();
                    selectedExpiryType = "";
                    selectedSubDocTypeValue = "";
                    selectedYear = AppConfig.year;
                    daysController.text = "1";
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return AddNewOrgDocButton(
                              title: "Add Corporate & Compliance",
                              selectedSubDocType: selectedSubDocType,
                              docTypeText:  getDocTypeText(docTypeMetaIdCC),
                              docTypeId: docTypeMetaIdCC,
                              subDocTypeId: selectedSubDocId,
                              subDocTypeText: getSubDocTypeText(selectedSubDocId),
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
                ? Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 30,
                width: 150,
                child: CustomIconButton(
                  icon: Icons.add,
                  text: "Add Doctype",
                  onPressed: () async {
                    String? selectedExpiryType = expiryType;
                    calenderController.clear();
                    docIdController.clear();
                    docNamecontroller.clear();
                    selectedExpiryType = "";
                    selectedSubDocTypeValue = "";
                    selectedYear = AppConfig.year;
                    daysController.text = "1";
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function())
                              setState) {
                            return AddNewOrgDocButton(
                              title: "Add Vendor Contract",
                              selectedSubDocType: selectedSubDocType,
                              docTypeText: getDocTypeText(docTypeMetaIdVC),
                              docTypeId: docTypeMetaIdVC,
                              subDocTypeId: selectedSubDocIdVC,
                              subDocTypeText: getSubDocTypeText(
                                  selectedSubDocIdVC),
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
                : Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 30,
                  width: 150,
                  child: CustomIconButton(
                    icon: Icons.add,
                    text: "Add Doctype",
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
                      daysController.clear();
                      selectedYear = AppConfig.year;
                      daysController.text = "1";
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function())
                                setState) {
                              return AddNewOrgDocButton(
                                title: 'Add Policies & Procedures',
                                docTypeText: getDocTypeText(docTypeMetaIdPP),
                                docTypeId: docTypeMetaIdPP,
                                subDocTypeId: 0,
                                subDocTypeText: '',
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
                // height: MediaQuery.of(context).size.height / 3.5,
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
                    onSubDocIdSelected:
                    _updateSelectedSubDocId, //officeId: widget.officeId,
                  ),
                  CIVendorContract(
                    docId: AppConfig.vendorContracts,
                    onSubDocIdSelected: _updateSelectedSubDocIdVC,
                    selectedSubDocType:
                    selectedSubDocType, //officeId: widget.officeId
                  ),
                  CIPoliciesProcedure(
                    docId: AppConfig.policiesAndProcedure,
                    subDocId: AppConfig.subDocId0,
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