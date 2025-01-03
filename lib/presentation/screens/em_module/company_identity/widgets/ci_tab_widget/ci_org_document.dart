import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_corporate&compiliance_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_policies&procedure.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_vendor_contract.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/org_add_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../company_identity_screen.dart';

class CiOrgDocument extends StatefulWidget {
 // final String officeId;
  //final int? companyId;
  const CiOrgDocument({super.key,
  //  required this.officeId, this.companyId
  });

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
        return  AppStringEM.licenses;
      case AppConfig.subDocId2Adr:
        return AppStringEM.ard;
      case AppConfig.subDocId3CICCMedicalCR:
        return AppStringEM.mcr;
      case AppConfig.subDocId4CapReport:
        return AppStringEM.capReport;
      case AppConfig.subDocId5BalReport:
        return AppStringEM.qbr;
      case AppConfig.subDocId6Leases:
        return AppStringEM.leases;
      case AppConfig.subDocId7SNF:
        return AppStringEM.snf;
      case AppConfig.subDocId8DME:
        return AppStringEM.dme;
      case AppConfig.subDocId9MD:
        return AppStringEM.md;
      case AppConfig.subDocId10MISC:
        return AppStringEM.misc;
      default:
        return "Unknown Document Type";
    }
  }

  String getDocTypeText(int DocId) {
    switch (DocId) {
      case AppConfig.corporateAndCompliance:
        return AppStringEM.corporateAndComplianceDocuments;
      case AppConfig.policiesAndProcedure:
        return AppStringEM.policiesAndProcedures;
      case AppConfig.vendorContracts:
        return AppStringEM.vendorContracts;
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
          height: AppSize.s20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.s45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: AppSize.s20,
                width: AppSize.s150,
              ),
              Material(
                elevation: 4,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Container(
                  width: 840,
                  height: AppSize.s30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorManager.blueprime),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              _selectButton(0);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
                              height: AppSize.s30,
                              width: AppSize.s380,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: _selectedIndex == 0
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  AppStringEM.corporateAndComplianceDocuments,
                                  style: BlueBgTabbar.customTextStyle(0, _selectedIndex),
                                ),
                              ),
                            ),
                          )),
                      Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              _selectButton(1);
                            },
                            child: Container(
                              height: AppSize.s30,
                              width: AppSize.s210,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: _selectedIndex == 1
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  AppStringEM.vendorContracts,
                                  style: BlueBgTabbar.customTextStyle(1, _selectedIndex),
                                ),
                              ),
                            ),
                          )),
                      Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onTap: () {
                              _selectButton(2);
                            },
                            child: Container(
                              height: AppSize.s30,
                              width: AppSize.s210,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: _selectedIndex == 2
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  AppStringEM.policiesAndProcedures,
                                  style: BlueBgTabbar.customTextStyle(2, _selectedIndex),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              //SizedBox(width: MediaQuery.of(context).size.width/25),

              ///button
              _selectedIndex == 0
              ///Corporate
                  ? Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: AppSize.s30,
                  width: AppSize.s150,
                  child: CustomIconButton(
                    icon: Icons.add,
                    text: AddPopupString.addDocType,
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
                                title: AddPopupString.addCorporate,
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
                  height: AppSize.s30,
                  width: AppSize.s150,
                  child: CustomIconButton(
                    icon: Icons.add,
                    text: AddPopupString.addDocType,
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
                                title: AddPopupString.addVendor,
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
                    height: AppSize.s30,
                    width: AppSize.s150,
                    child: CustomIconButton(
                      icon: Icons.add,
                      text: AddPopupString.addDocType,
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
                                  title: AddPopupString.addPolicy,
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
        ),
        SizedBox(
          height: AppSize.s30,
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