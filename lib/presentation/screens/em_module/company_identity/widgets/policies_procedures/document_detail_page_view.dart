import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/company_identity_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/policies_procedures/policies_procedures.dart';

class DocumentPageView extends StatefulWidget {
  final int docID;
  const DocumentPageView({super.key, required this.docID});

  @override
  State<DocumentPageView> createState() => _DocumentPageViewState();
}

class _DocumentPageViewState extends State<DocumentPageView> {
  final PageController _tabPageController = PageController();

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;

  int _selectedIndex = 1;


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
    // currentPage = 1;
    // itemsPerPage = 5;
    // items = List.generate(20, (index) => 'Item ${index + 1}');
    //getOrgDocfetch(context, 2,1,_selectedIndex,1,15);
    //_companyManager = CompanyIdentityManager();
    // companyAllApi(context);
  }
  var subDocId = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        FutureBuilder<List<IdentityDocumentIdData>>(
            future: identityDocumentTypeGet(context, widget.docID),
            builder: (context,snapshot) {
              if(snapshot.hasData){
                return  Center(
                    child: Container(
                      width: 600,
                      height: 45,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 600,
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
                                        height: 40,
                                        width: MediaQuery.of(context).size.width / 10,
                                        child: Column(
                                          children: [
                                            Text(
                                              snapshot.data![index].subDocType,
                                              textAlign: TextAlign.center,
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

                            // InkWell(
                            //   onTap: () => _selectButton(2),
                            //   child: Column(
                            //     children: [
                            //       Text(
                            //         "Medical Cost Reporter",
                            //         style: GoogleFonts.firaSans(
                            //           fontSize: 12,
                            //             fontWeight: _selectedIndex == 2 ? FontWeight.w700 : FontWeight.normal,
                            //           color: _selectedIndex == 2 ? ColorManager.blueprime :Color(0xff686464)
                            //         ),
                            //       ),
                            //       Container(
                            //         height: 2,
                            //         width: 130,
                            //         color: _selectedIndex == 2 ? ColorManager.blueprime: Colors.transparent,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // InkWell(
                            //   onTap: () => _selectButton(3),
                            //   child: Column(
                            //     children: [
                            //       Text(
                            //         "CAP Report",
                            //         style: GoogleFonts.firaSans(
                            //           fontSize: 12,
                            //           fontWeight: _selectedIndex == 3 ? FontWeight.w700 : FontWeight.normal,
                            //           color: _selectedIndex == 3 ? ColorManager.blueprime : Color(0xff686464),
                            //         ),
                            //       ),
                            //       Container(
                            //         height: 2,
                            //         width: 70,
                            //         color: _selectedIndex == 3 ? ColorManager.blueprime : Colors.transparent,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // InkWell(
                            //   onTap: () => _selectButton(4),
                            //   child: Column(
                            //     children: [
                            //       Text(
                            //         "Quarterly Balance Report",
                            //         style: GoogleFonts.firaSans(
                            //           fontSize: 12,
                            //             fontWeight: _selectedIndex == 4 ? FontWeight.w700 : FontWeight.normal,
                            //           color: _selectedIndex == 4 ?  ColorManager.blueprime :Color(0xff686464)
                            //         ),
                            //       ),
                            //       Container(
                            //         height: 2,
                            //         width: 150,
                            //         color: _selectedIndex == 4 ?  ColorManager.blueprime: Colors.transparent,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
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
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              CiPoliciesAndProcedures(docID: widget.docID, subDocID: subDocId,),
              CiPoliciesAndProcedures(docID: widget.docID, subDocID: subDocId,),
              CiPoliciesAndProcedures(docID: widget.docID, subDocID: subDocId,),
              CiPoliciesAndProcedures(docID: widget.docID, subDocID: subDocId,),
              CiPoliciesAndProcedures(docID: widget.docID, subDocID: subDocId,)

            ],
          ),
        ),
      ],
    );
  }
}
