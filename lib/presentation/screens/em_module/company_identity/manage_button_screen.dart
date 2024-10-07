import 'package:flutter/material.dart';
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
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/value_manager.dart';

typedef BackButtonCallBack = void Function(bool val);

class ManageWidget extends StatefulWidget {
  final String officeID;
  final int companyID;
  final int companyOfficeId;
  final String officeName;
  final String stateName;
  final String countryName;
  final BackButtonCallBack backButtonCallBack;
  ManageWidget({
    Key? key,
    required this.officeID,
    required this.officeName,
    required this.backButtonCallBack,
    required this.companyID,
    required this.companyOfficeId, required this.stateName, required this.countryName,
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

  int listIndex = 0;

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
          // _selectedIndex != 0
          //     ? Container(height: AppSize.s15)
          //     :
          Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 130, vertical: AppPadding.p20),
                  child: Row(
                    children: [
                      Text(
                        widget.officeName,
                        style: CompanyIdentityManageHeadings.customTextStyle(context),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: EdgeInsets.only(left: AppPadding.p35),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          widget.backButtonCallBack(true);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 15,
                              color: ColorManager.mediumgrey,

                            ),

                            SizedBox(width: 1,),
                            Text(
                              'Go Back',
                              style: DefineWorkWeekStyle.customTextStyle(context),
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 50,),
                Container(
                  width: MediaQuery.of(context).size.width / 1.17,
                  height: AppSize.s30,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: ColorManager.blueprime,
                      borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width / 9.5,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: _selectedIndex == 0 ? Colors.white : null,
                          ),
                          child: Text(
                              ManagaeButtonheading.details,
                            textAlign: TextAlign.center,
                              style: BlueBgTabbar.customTextStyle(0, _selectedIndex)
                          ),
                        ),
                        onTap: () => _selectButton(0),
                      ),
                      InkWell(
                        child: Container(
                          height: AppSize.s30,
                          width: MediaQuery.of(context).size.width / 9.4,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: _selectedIndex == 1
                                ? ColorManager.white
                                : null,
                          ),
                          child: Text(
                              ManagaeButtonheading.zones,
                            textAlign: TextAlign.center,
                              style: BlueBgTabbar.customTextStyle(1, _selectedIndex)

                          ),
                        ),
                        onTap: () => _selectButton(1),
                      ),
                      InkWell(
                        child: Container(
                          height: AppSize.s30,
                          width: MediaQuery.of(context).size.width / 6,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: _selectedIndex == 2
                                ? ColorManager.white
                                : null,
                          ),
                          child: Text(
                              ManagaeButtonheading.cc,
                            textAlign: TextAlign.center,
                              style: BlueBgTabbar.customTextStyle(2, _selectedIndex)
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
                            borderRadius: BorderRadius.circular(14),
                            color: _selectedIndex == 3
                                ? ColorManager.white
                                : null,
                          ),
                          child: Text(
                              ManagaeButtonheading.insurance,
                            textAlign: TextAlign.center,
                              style: BlueBgTabbar.customTextStyle(3, _selectedIndex)
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
                            borderRadius: BorderRadius.circular(14),
                            color: _selectedIndex == 4
                                ? ColorManager.white
                                : null,
                          ),
                          child: Text(
                              ManagaeButtonheading.vc,
                            textAlign: TextAlign.center,
                              style: BlueBgTabbar.customTextStyle(4, _selectedIndex)
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
                            borderRadius: BorderRadius.circular(14),
                            color: _selectedIndex == 5
                                ? ColorManager.white
                                : null,
                          ),
                          child: Text(
                              ManagaeButtonheading.pp,
                            textAlign: TextAlign.center,
                              style: BlueBgTabbar.customTextStyle(5, _selectedIndex)
                          ),
                        ),
                        onTap: () => _selectButton(5),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: Container(
                          height: AppSize.s30,
                          width: MediaQuery.of(context).size.width / 8.11,
                          padding: EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: _selectedIndex == 6
                                ? ColorManager.white
                                : null,
                          ),
                          child: Text(
                              ManagaeButtonheading.templates,
                            textAlign: TextAlign.center,
                              style: BlueBgTabbar.customTextStyle(6, _selectedIndex)
                          ),
                        ),
                        onTap: () => _selectButton(6),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: AppSize.s30,),
          Expanded(
            flex: 10,
            child: Stack(children: [
              _selectedIndex == 0
                  ? const Offstage()
                  : Container(
                      //height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F9FC),
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
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p5),
                child: PageView(
                    controller: _managePageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      CIDetailsScreen(
                        companyID: widget.companyID,
                        officeId: widget.officeID,
                        docTD: docID,
                        companyId: widget.companyID,
                        companyOfficeid: widget.companyOfficeId, stateName: widget.stateName, countryName: widget.countryName,
                      ),
                      CiZone(
                        companyID: widget.companyID,
                        officeId: widget.officeID,
                        docId: docID, stateName: widget.stateName, countryName: widget.countryName,
                      ),
                      CiCorporateComplianceScreen(
                        docId: AppConfig.corporateAndCompliance,
                        officeId: widget.officeID,
                        companyID: widget.companyID,
                      ),
                      CIInsurance(
                        officeId: widget.officeID,
                        docID: AppConfig.corporateAndCompliance,
                        subDocID: AppConfig.subDocId0,
                        companyID: widget.companyID,
                      ),
                      CiCcVendorContractScreen(
                        companyID: widget.companyID,
                        officeId: widget.officeID,
                        docId: AppConfig.vendorContracts,
                      ),
                      CiPoliciesAndProcedures(
                        docID: AppConfig.policiesAndProcedure,
                        subDocID: AppConfig.subDocId0,
                        companyID: widget.companyID,
                        officeId: widget.officeID,
                      ),
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
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected == docID ? ColorManager.white : null,
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeight.bold,
            color: isSelected == docID ? Colors.grey[600] : ColorManager.white,
          ),
        ),
      ),
    );
  }
}