import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
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

class CICorporateCompilianceDocument extends StatefulWidget {
  final int docID;
  final String officeId;
  const CICorporateCompilianceDocument({super.key, required this.docID, required this.officeId});

  @override
  State<CICorporateCompilianceDocument> createState() =>
      _CICorporateCompilianceDocumentState();
}

class _CICorporateCompilianceDocumentState
    extends State<CICorporateCompilianceDocument> {
  final PageController _tabPageController = PageController();

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;

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

  List<IdentityDocumentIdData> docSubTypeData = [];
  void loadData() async {
    docSubTypeData = await identityDocumentTypeGet(context, widget.docID);
  }

  @override
  void initState() {
    super.initState();
    identityDocumentTypeGet(context, widget.docID);
    // currentPage = 1;
    // itemsPerPage = 5;
    // items = List.generate(20, (index) => 'Item ${index + 1}');
    //getOrgDocfetch(context, 2,1,_selectedIndex,1,15);
    //_companyManager = CompanyIdentityManager();
    // companyAllApi(context);
  }

  var subDocId = 11;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Center(
            child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                //splashColor: Colors.white,
                highlightColor: Color(0xFFF2F9FC),
                hoverColor: Color(0xFFF2F9FC),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 10,
                  child: Column(
                    children: [
                      Text(
                        'Licenses',
                        // textAlign: TextAlign.center,
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
                onTap: () {
                  _selectButton(0);
                  //subDocId = snapshot.data![index].subDocID;
                },
              ),
              InkWell(
                //splashColor: Colors.white,
                highlightColor: Color(0xFFF2F9FC),
                hoverColor: Color(0xFFF2F9FC),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 10,
                  child: Column(
                    children: [
                      Text(
                        'ADR',
                        // textAlign: TextAlign.center,
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
                onTap: () {
                  _selectButton(1);
                  //subDocId = snapshot.data![index].subDocID;
                },
              ),
              InkWell(
                //splashColor: Colors.white,
                highlightColor: Color(0xFFF2F9FC),
                hoverColor: Color(0xFFF2F9FC),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 10,
                  child: Column(
                    children: [
                      Text(
                        "Medical Cost Reports",
                        // textAlign: TextAlign.center,
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
                onTap: () {
                  _selectButton(2);
                  //subDocId = snapshot.data![index].subDocID;
                },
              ),
              InkWell(
                //splashColor: Colors.white,
                highlightColor: Color(0xFFF2F9FC),
                hoverColor: Color(0xFFF2F9FC),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 10,
                  child: Column(
                    children: [
                      Text(
                        "Cap Reports",
                        // textAlign: TextAlign.center,
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
                onTap: () {
                  _selectButton(3);
                  //subDocId = snapshot.data![index].subDocID;
                },
              ),
              InkWell(
                //splashColor: Colors.white,
                highlightColor: Color(0xFFF2F9FC),
                hoverColor: Color(0xFFF2F9FC),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 10,
                  child: Column(
                    children: [
                      Text(
                        "Quarterly Balance Reports",
                        // textAlign: TextAlign.center,
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
                onTap: () {
                  _selectButton(4);
                  //subDocId = snapshot.data![index].subDocID;
                },
              ),
            ],
          ),
        )),
        Expanded(
            child: Stack(children: [
          Container(
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
                ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                // setState(() {
                _selectedIndex = index;
                // });
              },
              children: [
                CICcdLicense(
                  subDocID: AppConfig.subDocId1,
                  docID: widget.docID,officeId: widget.officeId,
                ),
                CICcdADR(
                  subDocID: AppConfig.subDocId2,
                  docID: widget.docID,officeId: widget.officeId,
                ),
                CiCcdMedicalCostReport(
                  subDocID: AppConfig.subDocId3,
                  docID: widget.docID,officeId: widget.officeId,
                ),
                CiCcdCapReports(
                  docID: widget.docID,
                  subDocId: AppConfig.subDocId4,officeId: widget.officeId,
                ),
                CICcdQuarteryBalanceReport(
                  docId: widget.docID,
                  subDocID: AppConfig.subDocId5,officeId: widget.officeId,
                )
              ],
            ),
          ),
        ])),
      ],
    );
  }
}
