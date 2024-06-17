import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_corporate&compiliance_document.dart';
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
  TextEditingController calenderController = TextEditingController();

  int _selectedIndex = 1;
  String _selectedItem = 'Corporate & Compliance Documents';
  void _onDropdownItemSelected(String newValue) {
    setState(() {
      _selectedItem = newValue;
    });
  }
  String _selectedItem1 = 'Licenses';

  void _onDropdownItemSelected1(String newValue) {
    setState(() {
      _selectedItem1 = newValue;
    });
  }

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
  void initState() {
    super.initState();
    documentTypeGet(context);
    // currentPage = 1;
    // itemsPerPage = 5;
    // items = List.generate(20, (index) => 'Item ${index + 1}');
    //_companyManager = CompanyIdentityManager();
    // companyAllApi(context);
  }
  var docID = 1;
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
    FutureBuilder<List<DocumentTypeData>>(
    future: documentTypeGet(context),
    builder:(context,snapshot){
      if(snapshot.hasData){
        return Material(
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
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        // return
                        //   Center(
                        //   child: CircularProgressIndicator(
                        //     color: Colors.blue, // Change according to your theme
                        //   ),
                        // );
                      }
                      if (snapshot.hasData) {
                        return InkWell(
                          onTap: () {
                            _selectButton(
                                snapshot.data![index].docID);
                            identityDocumentTypeGet(
                                context, snapshot.data![index].docID);
                            docID = snapshot.data![index].docID;
                          },
                          child: Container(
                            height: 30,
                            width: 210,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)),
                              color: _selectedIndex ==
                                  snapshot.data![index].docID
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                snapshot.data![index].docType,
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _selectedIndex ==
                                      snapshot.data![index].docID
                                      ? ColorManager.mediumgrey
                                      : ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                //   }
                //
                // ),
                // InkWell(
                //   onTap: () => _selectButton(1),
                //   child: Container(
                //     height: 30,
                //     width: 180,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(20)),
                //       color: _selectedIndex == 1
                //           ? Colors.white
                //           : Colors.transparent,
                //     ),
                //     child: Center(
                //       child: Text(
                //         "Vendor Contract",
                //         style: GoogleFonts.firaSans(
                //           fontSize: 12,
                //           fontWeight: FontWeight.w700,
                //           color: _selectedIndex == 1
                //               ? ColorManager.blueprime
                //               : ColorManager.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // InkWell(
                //   onTap: () => _selectButton(2),
                //   child: Container(
                //     height: 30,
                //     width: 180,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(Radius.circular(20)),
                //       color: _selectedIndex == 2
                //           ? Colors.white
                //           : Colors.transparent,
                //     ),
                //     child: Center(
                //       child: Text(
                //         "Policies & Procedure",
                //         style: GoogleFonts.firaSans(
                //           fontSize: 12,
                //           fontWeight: FontWeight.w700,
                //           color: _selectedIndex == 2
                //               ? ColorManager.blueprime
                //               : ColorManager.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        );
      } else{
        return SizedBox(height: 1,width: 1,);
      }
    }),
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
                                  calenderController: calenderController,
                                  idDocController: docIdController,
                                  nameDocController: docNamecontroller,
                                  onPressed: () async{
                                    await addCorporateDocumentPost(context: context,
                                        name: docNamecontroller.text,
                                        docTypeID: int.parse(_selectedItem),
                                        docSubTypeID: int.parse(_selectedItem1)== null ? 0:int.parse(_selectedItem1),
                                        docCreated: DateTime.now().toString(),
                                        url: "url",
                                        expiryType: "Not Applicable",
                                        expiryDate: calenderController.text,
                                        expiryReminder: "Schedule",
                                        companyId: 11,
                                        officeId: "1");
                                    setState(() async {
                                    await  orgSubDocumentGet(context, 11, docID, 1, 1, 6);
                                    Navigator.pop(context);
                                    calenderController.clear();
                                      docIdController.clear();
                                      docNamecontroller.clear();
                                    });
                                  },


                                  child: CICCDropdown(
                                    initialValue:
                                        _selectedItem,
                                    onChange: _onDropdownItemSelected,
                                    items: [
                                      DropdownMenuItem(
                                          value:
                                              '1',
                                          child: Text(
                                              'Corporate & Compliance Documents')),
                                      DropdownMenuItem(
                                          value: '2',
                                          child: Text('Vendor Contract')),
                                      DropdownMenuItem(
                                          value: '3',
                                          child: Text('Medicare ID  MPID123')),
                                    ],
                                  ),
                                  child1: CICCDropdown(
                                    initialValue: _selectedItem1,
                                    onChange: _onDropdownItemSelected1,
                                    items: [
                                      DropdownMenuItem(
                                          value: '1',
                                          child: Text('Licenses')),
                                      DropdownMenuItem(
                                          value: '2',
                                          child: Text('ADR')),
                                      DropdownMenuItem(
                                          value: '3',
                                          child: Text('Medical Cost Report')),
                                      DropdownMenuItem(
                                          value: '4',
                                          child: Text('Cap Reports')),
                                      DropdownMenuItem(
                                          value: '5',
                                          child: Text('Quarterly Balance Reports')),
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
              _selectedIndex != 3
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
                  CICorporateCompilianceDocument(docID: docID,),
                  CICorporateCompilianceDocument(docID: docID,),
                  CICorporateCompilianceDocument(docID: docID,),
                  // CIVendorContract(),
                  // CIPoliciesProcedure()
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
