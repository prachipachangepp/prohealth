import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_adr.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_cap_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_license.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_medical_cost_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/ci_corporate&compiliancedoc_tab/ci_ccd_quarterly_balance_report.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../company_identity_screen.dart';

class CIVendorContract extends StatefulWidget {
  const CIVendorContract({super.key});

  @override
  State<CIVendorContract> createState() => _CIVendorContractState();
}

class _CIVendorContractState extends State<CIVendorContract> {
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 450,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => _selectButton(0),
                    child: Column(
                      children: [
                        Text(
                          "License",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _selectedIndex == 0 ?  ColorManager.blueprime : Colors.grey,
                          ),
                        ),
                        Container(
                          height: 2,
                          width: 40,
                          color: _selectedIndex == 0 ?  ColorManager.blueprime : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _selectButton(1),
                    child: Column(
                      children: [
                        Text(
                          "ADR",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _selectedIndex == 1 ?  ColorManager.blueprime : Colors.grey,
                          ),
                        ),
                        Container(
                          height: 2,
                          width: 60,
                          color: _selectedIndex == 1 ?  ColorManager.blueprime : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _selectButton(2),
                    child: Column(
                      children: [
                        Text(
                          "Medical Cost Reporter",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _selectedIndex == 2 ? ColorManager.blueprime : Colors.grey,
                          ),
                        ),
                        Container(
                          height: 2,
                          width: 60,
                          color: _selectedIndex == 2 ? ColorManager.blueprime: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _selectButton(3),
                    child: Column(
                      children: [
                        Text(
                          "Cap Report",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _selectedIndex == 3 ?  ColorManager.blueprime : Colors.grey,
                          ),
                        ),
                        Container(
                          height: 2,
                          width: 40,
                          color: _selectedIndex == 3 ?  ColorManager.blueprime : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _selectButton(4),
                    child: Column(
                      children: [
                        Text(
                          "Quarterly Balance Report",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _selectedIndex == 4 ?  ColorManager.blueprime : Colors.grey,
                          ),
                        ),
                        Container(
                          height: 2,
                          width: 60,
                          color: _selectedIndex == 4 ?  ColorManager.blueprime: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Expanded(
          child: NonScrollablePageView(
            controller: _tabPageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              CICcdLicense(),
              CICcdADR(),
              CiCcdMedicalCostReport(),
              CiCcdCapReports(),
              CICcdQuarteryBalanceReport()
            ],
          ),
        ),
      ],
    );
  }
}
