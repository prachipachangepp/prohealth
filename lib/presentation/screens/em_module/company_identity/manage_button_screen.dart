import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/ci_cc_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/widgets/ci_insurance.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_templates/ci_tempalets.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_details.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/zone.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/policies_procedures/policies_procedures.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/widgets/ci_cc_vendor_contract_screen.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/value_manager.dart';

typedef BackButtonCallBack = void Function(bool val);

class ManageWidget extends StatefulWidget {
  final String officeID;
  final int companyID;
  final int companyOfficeId;
  final String officeName;
  final BackButtonCallBack backButtonCallBack;
  ManageWidget({
    Key? key,
    required this.officeID,
    required this.officeName,
    required this.backButtonCallBack,
    required this.companyID, required this.companyOfficeId,
    // required this.selectedIndex,
    // required this.selectButton,
  }) : super(key: key);

  @override
  State<ManageWidget> createState() => _ManageWidgetState();
}

class _ManageWidgetState extends State<ManageWidget> {
  final List<String> _categories = [
    'Details',
    'Zones',
    'Insurance',
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
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
int listIndex = 0 ;
  void _listButton(int index) {
    setState(() {
      listIndex = index;
    });

    _managePageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  @override
  void initState() {
    super.initState();
    documentTypeGet(context);
  }


  int docID = 1;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          _selectedIndex != 0
              ? Container(height: 15)
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p160, vertical: AppPadding.p10),
                  child: Row(
                    children: [
                      Text(
                        widget.officeName,
                        style: CompanyIdentityManageHeadings.customTextStyle(
                            context),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          widget.backButtonCallBack(true);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 15,
                          color: ColorManager.mediumgrey,
                        )),
                    Text(
                      'Go Back',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.mediumgrey,
                        decoration: TextDecoration
                            .underline, // Remove underline from the text
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 50,
                ),
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.1814,
                    height: AppSize.s30,
                  decoration: BoxDecoration(
                      color: ColorManager.blueprime,
                    borderRadius: BorderRadius.circular(14)
                  ),
                    child: Row(
                      children: [
                        InkWell(
                          child: Container(
                                        height: 30,
                                        width: MediaQuery.of(context).size.width / 8.4,
                                        padding: EdgeInsets.symmetric(vertical: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: _selectedIndex == 0
                                              ? Colors.white
                                              : null,
                                        ),
                                        child: Text(
                                          'Details',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.firaSans(
                                            fontSize: AppSize.s12,
                                            fontWeight: FontWeightManager.semiBold,
                                            color: _selectedIndex == 0
                                                ? ColorManager.mediumgrey
                                                : ColorManager.white,
                                          ),
                                        ),
                                      ),
                          onTap: () => _selectButton(0),
                                  ),
                        InkWell(
                                      child: Container(
                                        height: AppSize.s30,
                                        width: MediaQuery.of(context).size.width / 8.9,
                                        padding: EdgeInsets.symmetric(vertical: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: _selectedIndex == 1
                                              ? ColorManager.white
                                              : null,
                                        ),
                                        child: Text(
                                          'Zones',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeightManager.semiBold,
                                            color: _selectedIndex == 1
                                                ? ColorManager.mediumgrey
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                          onTap: () => _selectButton(1),
                                  ),
                        InkWell(
                          child: Container(
                            height: AppSize.s30,
                            width: MediaQuery.of(context).size.width / 7,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _selectedIndex == 2
                                  ? ColorManager.white
                                  : null,
                            ),
                            child: Text(
                              'Corporate & Compliance',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.semiBold,
                                color: _selectedIndex == 2
                                    ? ColorManager.mediumgrey
                                    : Colors.white,
                              ),
                            ),
                          ),
                          onTap: () => _selectButton(2),
                        ),
                        InkWell(
                          child: Container(
                            height: AppSize.s30,
                            width: MediaQuery.of(context).size.width / 8.7,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _selectedIndex == 3
                                  ? ColorManager.white
                                  : null,
                            ),
                            child: Text(
                              'Insurance',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.semiBold,
                                color: _selectedIndex == 3
                                    ? ColorManager.mediumgrey
                                    : ColorManager.white,
                              ),
                            ),
                          ),
                          onTap: () => _selectButton(3),
                        ),
                        InkWell(
                          child: Container(
                            height: AppSize.s30,
                            width: MediaQuery.of(context).size.width / 8.4,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _selectedIndex == 4
                                  ? ColorManager.white
                                  : null,
                            ),
                            child: Text(
                              'Vendor Contracts',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.semiBold,
                                color: _selectedIndex == 4
                                    ? ColorManager.mediumgrey
                                    : ColorManager.white,
                              ),
                            ),
                          ),
                          onTap: () => _selectButton(4),
                        ),
                        InkWell(
                          child: Container(
                            height: AppSize.s30,
                            width: MediaQuery.of(context).size.width / 8.4,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _selectedIndex == 5
                                  ? ColorManager.white
                                  : null,
                            ),
                            child: Text(
                              'Policies & Procedures',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.semiBold,
                                color: _selectedIndex == 5
                                    ? ColorManager.mediumgrey
                                    : ColorManager.white,
                              ),
                            ),
                          ),
                          onTap: () => _selectButton(5),
                        ),
                        InkWell(
                          child: Container(
                            height: AppSize.s30,
                            width: MediaQuery.of(context).size.width / 8.4,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _selectedIndex == 6
                                  ? ColorManager.white
                                  : null,
                            ),
                            child: Text(
                              'Templates',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.semiBold,
                                color: _selectedIndex == 6
                                    ? ColorManager.mediumgrey
                                    : ColorManager.white,
                              ),
                            ),
                          ),
                          onTap: () => _selectButton(6),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
          Expanded(
            flex: 10,
            child: Stack(children: [
              _selectedIndex == 0
                  ? const Offstage()
                  : Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF2F9FC),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.mediumgrey.withOpacity(0.5),
                              blurRadius: 2,
                              spreadRadius: -3,
                              offset: const Offset(0, -6),
                            ),
                          ]),
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    //horizontal: MediaQuery.of(context).size.width / 45,
                    vertical: 5),
                child: PageView(
                    controller: _managePageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CIDetailsScreen(
                        companyID: widget.companyID,
                        officeId: widget.officeID, docTD: docID,
                        companyId: widget.companyID, companyOfficeid: widget.companyOfficeId,
                      ),
                      CiZone(companyID: widget.companyID, officeId: widget.officeID, docId: docID,),
                      // CiPageview(
                      //   docId: 5,
                      //     managePageController: _managePageController,
                      //     selectedIndex: _selectedIndex,
                      //     selectButton: _selectButton,
                      //     //child1: Container(color: Colors.grey,width: 200,height: 40,),
                      //     nameList: ['County', 'Zone'],
                      //     screenList: [CIZoneCountry(), CIZoneZone()],
                      //     mediaQueryWidth: 3.5,),
                      CiCorporateComplianceScreen(docId: AppConfig.docId8, officeId: widget.officeID,),
                      CIInsurance(officeId: widget.officeID,docID: AppConfig.docId10, subDocID: AppConfig.subDocId0, companyID: widget.companyID,),
                      CiCcVendorContractScreen(companyID: widget.companyID, officeId: widget.officeID, docId: AppConfig.docId9,),
                      CiPoliciesAndProcedures(docID: AppConfig.docId10, subDocID: AppConfig.subDocId0, companyID: widget.companyID, officeId: widget.officeID,),
                      CiTempalets()
                    ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class CustomButtonList extends StatelessWidget {
  final String buttonText;
  final int isSelected;
  final int docID;
  final Function() onTap;

  const CustomButtonList({
    required this.buttonText,
    required this.isSelected,
    required this.onTap,
    Key? key,
    required this.docID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppSize.s30,
        width: MediaQuery.of(context).size.width / 8.62,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected == docID ? ColorManager.white : null,
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: FontSize.s12,
            fontWeight: FontWeight.bold,
            color: isSelected == docID ?
            Colors.grey[600] :
            ColorManager.white,
          ),
        ),
      ),
    );
  }
}
/////