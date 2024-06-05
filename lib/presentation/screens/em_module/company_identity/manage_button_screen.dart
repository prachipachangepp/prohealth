import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_adr.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_cap_reports.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_licence.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_medical_cost_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_quaterly_bal_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_vendor.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_details.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_country.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_zone.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/dme.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/leasas_services.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/md.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/misc.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/snf.dart';

import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import 'widgets/ci_insurance/ci_insurance_contract.dart';
import 'widgets/ci_insurance/ci_insurance_pageview.dart';
import 'widgets/policies_procedures/policies_procedures.dart';

class ManagePopUpScreen extends StatefulWidget {
  const ManagePopUpScreen({Key? key}) : super(key: key);

  @override
  State<ManagePopUpScreen> createState() => _ManagePopUpScreenState();
}

class _ManagePopUpScreenState extends State<ManagePopUpScreen> {
  final PageController _managePageController = PageController();
  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _managePageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ManageWidget(
      managePageController: _managePageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
    );
  }
}

class ManageWidget extends StatefulWidget {
  final PageController managePageController;
  final int selectedIndex;
  final Function(int) selectButton;

  ManageWidget({
    Key? key,
    required this.managePageController,
    required this.selectedIndex,
    required this.selectButton,
  }) : super(key: key);

  @override
  State<ManageWidget> createState() => _ManageWidgetState();
}

class _ManageWidgetState extends State<ManageWidget> {
  final List<String> _categories = [
    'Detail',
    'Zone',
    'Corporate & Compliance document',
    'Insurance',
    'Vendor Contract',
    'Policies & Procedure',
    'Templates'
  ];

  final PageController _managePageController = PageController();

  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _managePageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p150,vertical: AppPadding.p16),
            child: Expanded(
              flex: 1,
              child: Row(
                children: [
                  Text('ProHealth San Jose',
                    style: CompanyIdentityManageHeadings.customTextStyle(context),),
                ],
              ),
            ),
          ),
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 28,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff50B5E5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _categories
                    .asMap()
                    .entries
                    .map(
                      (entry) => InkWell(
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 8.47,
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widget.selectedIndex == entry.key
                                ? Colors.white
                                : null,
                          ),
                          child: Text(
                            entry.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeightManager.semiBold,
                              color: widget.selectedIndex == entry.key
                                  ? ColorManager.mediumgrey
                                  : Colors.white,
                            ),
                          ),
                        ),
                        onTap: () => widget.selectButton(entry.key),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 14),
              child: PageView(
                  controller: widget.managePageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CIDetailsScreen(),
                    CiPageview(
                        managePageController: _managePageController,
                        selectedIndex: _selectedIndex,
                        selectButton: _selectButton,
                        nameList: ['County', 'Zome'],
                        screenList: [CIZoneCountry(), CIZoneZone()],
                        mediaQueryWidth: 3.5),
                   CiPageview(
                       managePageController: _managePageController,
                       selectedIndex: _selectedIndex,
                       selectButton: _selectButton,
                       nameList: ['Licenses','ADR','Medical Cost Reports','CAP Reports','Quarterly Balance Reports'],
                       screenList: [CICCLicense(),CICCADR(),CICCMedicalCR(),CICCCAPReports(),CICCQuarterlyBalReport()],
                       mediaQueryWidth: 2),
                    CiPageview(
                      managePageController: _managePageController,
                      selectedIndex: _selectedIndex,
                      selectButton: _selectButton,
                      mediaQueryWidth: 3,
                      nameList: ['Vendor', 'Contract'],
                      screenList: [CiInsuranceVendor(), CiInsuranceContract()],
                    ),
                    CiPageview(
                      managePageController: _managePageController,
                      selectedIndex: _selectedIndex,
                      selectButton: _selectButton,
                      mediaQueryWidth: 2,
                      nameList: ['Leases & Services', 'SNF','DME','MD','MISC'],
                      screenList: [CiLeasesAndServices(),CiSnf(),CiDme(),CiMd(),CiMisc()],
                    ),
                    CiPoliciesAndProcedures(),
                    Container(
                      color: Colors.green,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
