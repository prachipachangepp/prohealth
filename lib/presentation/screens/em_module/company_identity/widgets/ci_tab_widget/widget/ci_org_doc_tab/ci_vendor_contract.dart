import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_adr.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_cap_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_license.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_medical_cost_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_quarterly_balance_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_vendor_contract_tab/ci_vc_leases_services.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_vendor_contract_tab/ci_vc_license.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_vendor_contract_tab/ci_vc_dme.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_vendor_contract_tab/ci_vc_misc.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_vendor_contract_tab/ci_vd_md.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import '../../../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../company_identity_screen.dart';

class CIVendorContract extends StatefulWidget {
  final int docId;
  final Function(int) onSubDocIdSelected;
  String selectedSubDocType;
  CIVendorContract({super.key, required this.docId,
    required this.onSubDocIdSelected,
    required this.selectedSubDocType,
  //  required this.officeId
  });

  @override
  State<CIVendorContract> createState() => _CIVendorContractState();
}

class _CIVendorContractState extends State<CIVendorContract> {
  final PageController _tabPageController = PageController();

  int _selectedIndex = 0;
  String selectedSubDocType = "";

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
        return AppConfig.subDocId6Leases;
      case 1:
        return AppConfig.subDocId7SNF;
      case 2:
        return AppConfig.subDocId8DME;
      case 3:
        return AppConfig.subDocId9MD;
      case 4:
        return AppConfig.subDocId10MISC;
      default:
        return 0;
    }
  }

  String getSubDocTypeForIndex(int index) {
    switch (index) {
      case 0:
        return "Leases & Services";
      case 1:
        return "SNF";
      case 2:
        return "DME";
      case 3:
        return "MD";
      case 4:
        return "MISC";
      default:
        return "";
    }
  }
  List<IdentityDocumentIdData> docSubTypeData = [];
  void loadData() async {
    docSubTypeData = await identityDocumentTypeGet(context, widget.docId);
  }

  @override
  void initState() {
    super.initState();
    selectedSubDocType = getSubDocTypeForIndex(_selectedIndex);
    // subDocId = getSubDocIdForIndex(
    //     _selectedIndex); // Initialize subDocId based on the default tab
    identityDocumentTypeGet(context, widget.docId);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
                            "Leases & Services",
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
                            "SNF",
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
                            "DME",
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
                            "MD",
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
                            "MISC",
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
            )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
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
                VendorContractLicense(
                  docId: widget.docId,
                  subDocID: AppConfig.subDocId6Leases,// officeId: widget.officeId,
                ),
                VendorContractADR(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId7SNF,
                  //officeId: widget.officeId,
                ),
                VendorContractMedicalCostReport(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId8DME,//officeId: widget.officeId,
                ),
                VendorContractCapReport(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId9MD,// officeId: widget.officeId,
                ),
                VendorContractQuarterlyBalanceReport(
                    docId: widget.docId, subDocId: AppConfig.subDocId10MISC,
                //  officeId: widget.officeId,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
