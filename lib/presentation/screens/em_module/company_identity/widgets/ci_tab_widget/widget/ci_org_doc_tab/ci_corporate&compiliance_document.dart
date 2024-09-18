import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/company_identity_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_adr.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_cap_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_license.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_medical_cost_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_quarterly_balance_report.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';

class CICorporateCompilianceDocument extends StatefulWidget {
  final int docID;
  final Function(int) onSubDocIdSelected;
  String selectedSubDocType;

  CICorporateCompilianceDocument({
    super.key,
    required this.docID,
    required this.selectedSubDocType,
    required this.onSubDocIdSelected,
  });

  @override
  State<CICorporateCompilianceDocument> createState() =>
      _CICorporateCompilianceDocumentState();
}

class _CICorporateCompilianceDocumentState
    extends State<CICorporateCompilianceDocument> {
  final PageController _tabPageController = PageController();
  int _selectedIndex = 0;
  String selectedSubDocType = "";
 // int subDocId = 0; // Initialize subDocId

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
      selectedSubDocType = getSubDocTypeForIndex(index);
      widget.onSubDocIdSelected(getSubDocIdForIndex(index));
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  int getSubDocIdForIndex(int index) {
    switch (index) {
      case 0:
        return AppConfig.subDocId1Licenses;
      case 1:
        return AppConfig.subDocId2Adr;
      case 2:
        return AppConfig.subDocId3CICCMedicalCR;
      case 3:
        return AppConfig.subDocId4CapReport;
      case 4:
        return AppConfig.subDocId5BalReport;
      default:
        return 0;
    }
  }

  String getSubDocTypeForIndex(int index) {
    switch (index) {
      case 0:
        return AppStringEM.licenses;
      case 1:
        return AppStringEM.ard;
      case 2:
        return AppStringEM.mcr;
      case 3:
        return AppStringEM.capReport;
      case 4:
        return AppStringEM.qbr;
      default:
        return "";
    }
  }
  List<IdentityDocumentIdData> docSubTypeData = [];

  void loadData() async {
    docSubTypeData = await identityDocumentTypeGet(context, widget.docID);
  }

  @override
  void initState() {
    super.initState();
    selectedSubDocType = getSubDocTypeForIndex(_selectedIndex);
    // subDocId = getSubDocIdForIndex(
    //     _selectedIndex); // Initialize subDocId based on the default tab
    identityDocumentTypeGet(context, widget.docID);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Licenses tab
                InkWell(
                  highlightColor: Color(0xFFF2F9FC),
                  hoverColor: Color(0xFFF2F9FC),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 10,
                    child: Column(
                      children: [
                        Text(
                          AppStringEM.licenses,
                          style: TransparentBgTabbar.customTextStyle(0, _selectedIndex)
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
                  onTap: () {
                    _selectButton(0);
                  },
                ),
                // ADR tab
                InkWell(
                  highlightColor: Color(0xFFF2F9FC),
                  hoverColor: Color(0xFFF2F9FC),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 10,
                    child: Column(
                      children: [
                        Text(
                            AppStringEM.ard,
                          style: TransparentBgTabbar.customTextStyle(1, _selectedIndex)
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
                  onTap: () {
                    _selectButton(1);
                  },
                ),
                // Medical Cost Reports tab
                InkWell(
                  highlightColor: Color(0xFFF2F9FC),
                  hoverColor: Color(0xFFF2F9FC),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 10,
                    child: Column(
                      children: [
                        Text(
                            AppStringEM.mcr,
                          style: TransparentBgTabbar.customTextStyle(2, _selectedIndex)
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
                  onTap: () {
                    _selectButton(2);
                  },
                ),
                // Cap Reports tab
                InkWell(
                  highlightColor: Color(0xFFF2F9FC),
                  hoverColor: Color(0xFFF2F9FC),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 10,
                    child: Column(
                      children: [
                        Text(
                            AppStringEM.capReport,
                          style: TransparentBgTabbar.customTextStyle(3, _selectedIndex)
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
                  onTap: () {
                    _selectButton(3);
                  },
                ),
                // Quarterly Balance Reports tab
                InkWell(
                  highlightColor: Color(0xFFF2F9FC),
                  hoverColor: Color(0xFFF2F9FC),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 10,
                    child: Column(
                      children: [
                        Text(
                            AppStringEM.qbr,
                          style: TransparentBgTabbar.customTextStyle(4, _selectedIndex)
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
                  onTap: () {
                    _selectButton(4);
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                _selectedIndex = index;
                setState(() {
                  selectedSubDocType = getSubDocTypeForIndex(index);
                  //subDocId = getSubDocIdForIndex(index); // Update subDocId on page change
                });
              },
              children: [
                CICcdLicense(
                  subDocID: AppConfig.subDocId1Licenses,
                  docID: widget.docID,
                ),
                CICcdADR(
                  subDocID: AppConfig.subDocId2Adr,
                  docID: widget.docID,
                ),
                CiCcdMedicalCostReport(
                  subDocID: AppConfig.subDocId3CICCMedicalCR,
                  docID: widget.docID,
                ),
                CiCcdCapReports(
                  docID: widget.docID,
                  subDocId: AppConfig.subDocId4CapReport,
                ),
                CICcdQuarteryBalanceReport(
                  docId: widget.docID,
                  subDocID: AppConfig.subDocId5BalReport,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
