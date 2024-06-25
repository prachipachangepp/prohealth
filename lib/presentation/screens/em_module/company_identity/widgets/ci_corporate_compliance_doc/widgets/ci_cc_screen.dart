import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_licence.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../company_identity_screen.dart';
import '../ci_cc_adr.dart';
import '../ci_cc_cap_reports.dart';
import '../ci_cc_medical_cost_report.dart';
import '../ci_cc_quaterly_bal_report.dart';

class CiCorporateComplianceScreen extends StatefulWidget {
  const CiCorporateComplianceScreen({super.key});

  @override
  State<CiCorporateComplianceScreen> createState() => _CiCorporateComplianceScreenState();
}

class _CiCorporateComplianceScreenState extends State<CiCorporateComplianceScreen> {
  final PageController _tabPageController = PageController();

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
        Row(
          children: [
            Container(
             // color: Colors.greenAccent,
              width: MediaQuery.of(context).size.width/1.8,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 12,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _selectedIndex == 0
                            ? Colors.white
                            : null,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Licenses',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeightManager.semiBold,
                              color: _selectedIndex == 1
                                  ? ColorManager.blueprime
                                  : ColorManager.mediumgrey,
                            ),
                          ),
                          _selectedIndex == 0 ?
                          Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                        ],
                      ),
                    ),
                    onTap: () => _selectButton(0),
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 12,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _selectedIndex == 1
                            ? Colors.white
                            : null,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'ADR',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeightManager.semiBold,
                              color: _selectedIndex == 1
                                  ? ColorManager.blueprime
                                  : ColorManager.mediumgrey,
                            ),
                          ),
                          _selectedIndex == 1 ?
                          Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                        ],
                      ),
                    ),
                    onTap: () => _selectButton(1),
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 8.62,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _selectedIndex == 2
                            ? Colors.white
                            : null,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Medical Cost Reports',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeightManager.semiBold,
                              color: _selectedIndex == 2
                                  ? ColorManager.blueprime
                                  : ColorManager.mediumgrey,
                            ),
                          ),
                          _selectedIndex == 2 ?
                          Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                        ],
                      ),
                    ),
                    onTap: () => _selectButton(2),
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 8.62,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _selectedIndex == 3
                            ? Colors.white
                            : null,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'CAP Reports',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeightManager.semiBold,
                              color: _selectedIndex == 3
                                  ? ColorManager.blueprime
                                  : ColorManager.mediumgrey,
                            ),
                          ),
                          _selectedIndex == 3 ?
                          Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                        ],
                      ),
                    ),
                    onTap: () => _selectButton(3),
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 8.62,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _selectedIndex == 4
                            ? Colors.white
                            : null,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Quarterly Balance Reports',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeightManager.semiBold,
                              color: _selectedIndex == 1
                                  ? ColorManager.blueprime
                                  : ColorManager.mediumgrey,
                            ),
                          ),
                          _selectedIndex == 4 ?
                          Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                        ],
                      ),
                    ),
                    onTap: () => _selectButton(4),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child:
          Padding(
            padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width / 50),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                // Page 1
                CICCLicense(),
                CICCADR(),
                CICCMedicalCR(),
                CICCCAPReports(),
                CICCQuarterlyBalReport()
              ],
            ),
          ),
        )
      ],
    );
  }
}
