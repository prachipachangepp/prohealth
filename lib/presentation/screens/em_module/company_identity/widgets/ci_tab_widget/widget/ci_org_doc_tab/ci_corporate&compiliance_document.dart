import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  const CICorporateCompilianceDocument({super.key, required this.docID});

  @override
  State<CICorporateCompilianceDocument> createState() => _CICorporateCompilianceDocumentState();
}

class _CICorporateCompilianceDocumentState extends State<CICorporateCompilianceDocument> {
  final PageController _tabPageController = PageController();

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;

  int _selectedIndex = 11;


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
  void loadData() async{
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
        SizedBox(height: 20,),
    FutureBuilder<List<IdentityDocumentIdData>>(
    future: identityDocumentTypeGet(context, widget.docID),
    builder: (context,snapshot) {
      if(snapshot.hasData){
        if(docSubTypeData.isEmpty){
          for(var a in snapshot.data!){
            docSubTypeData.add(
                a
            );
          }
        }
        return  Center(
          child: Container(
            width: 750,
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               Container(
              width: 750,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                  }
                  if(snapshot.hasData){

                    return InkWell(
                      //splashColor: Colors.white,
                      highlightColor: Color(0xFFF2F9FC),
                      hoverColor: Color(0xFFF2F9FC),
                      child: Container(
                        height: 50,
                         width: MediaQuery.of(context).size.width/10,
                        child: Column(
                          children: [
                            Text(
                              snapshot.data![index].subDocType,
                              // textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == snapshot.data![index].subDocID
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color:_selectedIndex == snapshot.data![index].subDocID
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == snapshot.data![index].subDocID?
                            Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                          ],
                        ),
                      ),
                      onTap: () {
                        _selectButton(snapshot.data![index].subDocID);
                        subDocId = snapshot.data![index].subDocID;},
                    );
                  }

                },
              ),
            ),

            ],
                        ),
        ));
      }else{
        return SizedBox(height:1,width:1);
      }}),
        Expanded(
          child:
          NonScrollablePageView(
            controller: _tabPageController,
            onPageChanged: (index) {
              // setState(() {
                _selectedIndex = index;
              // });
            },
            children: [
              CICcdLicense(subDocID: subDocId, docID: widget.docID,),
              CICcdLicense(subDocID: subDocId, docID: widget.docID,),
              CICcdLicense(subDocID: subDocId, docID: widget.docID,),
              CICcdLicense(subDocID: subDocId, docID: widget.docID,),
              CICcdLicense(subDocID: subDocId, docID: widget.docID,),
              CICcdLicense(subDocID: subDocId, docID: widget.docID,),
              // CICcdADR(),
              // CiCcdMedicalCostReport(),
              // CiCcdCapReports(),
              // CICcdQuarteryBalanceReport()
            ],
          ),
        ),
      ],
    );
  }
}
