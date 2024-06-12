import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/company_identity_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_adr.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_cap_reports.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_licence.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_medical_cost_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_quaterly_bal_report.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_vendor.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_templates/ci_tempalets.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_details.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_country.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_zone.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/dme.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/leasas_services.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/md.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/misc.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/snf.dart';
import 'package:prohealth/presentation/screens/em_module/em_desktop_screen.dart';

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
    'Details',
    'Zones',
    'Corporate & Compliance Documents',
    'Insurance',
    'Vendor Contracts',
    'Policies & Procedures',
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
      color: Colors.white,
      child: Column(
        children: [
          widget.selectedIndex !=0
              ? Container(height: 57) :
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p160,vertical: AppPadding.p20),
            child:  Row(
              children: [
                Text('ProHealth San Jose',
                  style: CompanyIdentityManageHeadings.customTextStyle(context),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(children: [
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SMDesktop()));
                      },
                      child: Icon(Icons.arrow_back,size: 15,color: ColorManager.mediumgrey,)),
                  // IconButton(icon: Icon(Icons.arrow_back_outlined,size: 15),color: ColorManager.mediumgrey, onPressed: () {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=> SMDesktop()));
                  // }, ),
                  Text(
                    'Go Back',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.underline, // Remove underline from the text
                    ),
                  ),
                ],),
                SizedBox(width: MediaQuery.of(context).size.width/24,),
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 28,
                    width: MediaQuery.of(context).size.width / 1.23,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorManager.blueprime,
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
                            width: MediaQuery.of(context).size.width / 8.62,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: widget.selectedIndex == entry.key
                                  ? Colors.white
                                  : null,
                            ),
                            child: Text(
                              entry.value,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
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
              ],
            ),
          ),
          SizedBox(height: 30,),
          Expanded(
            flex: 10,
            child: Stack(
                children:[
                  widget.selectedIndex == 0 ? Offstage():  Container(height: MediaQuery.of(context).size.height/3,
                    decoration: BoxDecoration(color: Color(0xFFF2F9FC),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                        boxShadow: [ BoxShadow(
                          color: ColorManager.mediumgrey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: -3,
                          offset: Offset(0, -6),
                        ),]
                    ),),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 45,vertical: 5),
                    child: PageView(
                        controller: widget.managePageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          CIDetailsScreen(),
                          CiPageview(
                              managePageController: _managePageController,
                              selectedIndex: _selectedIndex,
                              selectButton: _selectButton,
                              nameList: ['County', 'Zone'],
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
                          CiTempalets()
                        ]),
                  ),]
            ),
          ),
        ],
      ),
    );
  }
}