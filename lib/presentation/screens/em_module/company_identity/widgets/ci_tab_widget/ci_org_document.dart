import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_corporate&compiliance_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_policies&procedure.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_vendor_contract.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

import '../../company_identity_screen.dart';

class CiOrgDocument extends StatefulWidget {
  const CiOrgDocument({super.key});

  @override
  State<CiOrgDocument> createState() => _CiOrgDocumentState();
}

class _CiOrgDocumentState extends State<CiOrgDocument> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();

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
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 150,
            ),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                width: 670,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorManager.blueprime),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => _selectButton(0),
                      child: Container(
                        height: 30,
                        width: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: _selectedIndex == 0
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "Corporate & Compilance Document",
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _selectedIndex == 0
                                  ? ColorManager.blueprime
                                  : ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _selectButton(1),
                      child: Container(
                        height: 30,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: _selectedIndex == 1
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "Vendor Contract",
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _selectedIndex == 1
                                  ? ColorManager.blueprime
                                  : ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _selectButton(2),
                      child: Container(
                        height: 30,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: _selectedIndex == 2
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "Policies & Procedure",
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _selectedIndex == 2
                                  ? ColorManager.blueprime
                                  : ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ///button
            Align(
                alignment: Alignment.bottomRight,
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 30,
                    width: 150,
                    child: CustomIconButton(
                        icon: CupertinoIcons.plus,
                        text: "Add Document",
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AddOrgDocButton(
                                  idDocController: docIdController,
                                  nameDocController: docNamecontroller,

                                  child: CICCDropdown(
                                    initialValue:
                                        'Corporate & Compliance Documents',
                                    items: [
                                      DropdownMenuItem(
                                          value:
                                              'Corporate & Compliance Documents',
                                          child: Text(
                                              'Corporate & Compliance Documents')),
                                      DropdownMenuItem(
                                          value: 'HCO Number      254612',
                                          child: Text('HCO Number  254612')),
                                      DropdownMenuItem(
                                          value: 'Medicare ID      MPID123',
                                          child: Text('Medicare ID  MPID123')),
                                      DropdownMenuItem(
                                          value: 'NPI Number     1234567890',
                                          child: Text('NPI Number 1234567890')),
                                    ],
                                  ),
                                  child1: CICCDropdown(
                                    initialValue: 'Licenses',
                                    items: [
                                      DropdownMenuItem(
                                          value: 'Licenses',
                                          child: Text('Licenses')),
                                      DropdownMenuItem(
                                          value: 'HCO Number      254612',
                                          child: Text('HCO Number  254612')),
                                      DropdownMenuItem(
                                          value: 'Medicare ID      MPID123',
                                          child: Text('Medicare ID  MPID123')),
                                      DropdownMenuItem(
                                          value: 'NPI Number     1234567890',
                                          child: Text('NPI Number 1234567890')),
                                    ],
                                  ),
                                );
                              });
                        }),
                  ),
                )),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: Stack(
            children: [
              _selectedIndex != 2
                  ? Container(
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
              )
                  : Offstage(),
              NonScrollablePageView(
                controller: _tabPageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  // Page 1
                  CICorporateCompilianceDocument(),
                  CIVendorContract(),
                  CIPoliciesProcedure()
                ],
              ),
            ],
          ),
        )
        // Expanded(
        //     child: Stack(
        //      children: [
        //        _selectedIndex != 2 ? Offstage():
        //       Container(
        //       height: MediaQuery.of(context).size.height / 3.5,
        //       decoration: BoxDecoration(
        //           color: Color(0xFFF2F9FC),
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(20),
        //               topRight: Radius.circular(20)),
        //           boxShadow: [
        //             BoxShadow(
        //               color: ColorManager.faintGrey,
        //               blurRadius: 2,
        //               spreadRadius: -2,
        //               offset: Offset(0, -4),
        //             ),
        //           ]),
        //     ),
        //     NonScrollablePageView(
        //       controller: _tabPageController,
        //       onPageChanged: (index) {
        //         setState(() {
        //           _selectedIndex = index;
        //         });
        //       },
        //       children: [
        //         // Page 1
        //         CICorporateCompilianceDocument(),
        //         CIVendorContract(),
        //         CIPoliciesProcedure()
        //       ],
        //     ),
        //   ],
        // )),
      ],
    );
  }
}
