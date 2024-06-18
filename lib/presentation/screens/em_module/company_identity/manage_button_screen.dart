import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_details.dart';

import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import 'widgets/policies_procedures/document_detail_page_view.dart';

// class ManagePopUpScreen extends StatefulWidget {
//   const ManagePopUpScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ManagePopUpScreen> createState() => _ManagePopUpScreenState();
// }
//
// class _ManagePopUpScreenState extends State<ManagePopUpScreen> {
//   final PageController _managePageController = PageController();
//   int _selectedIndex = 1;
//
//   void _selectButton(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     _managePageController.animateToPage(
//       index,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ManageWidget(
//       managePageController: _managePageController,
//       selectedIndex: _selectedIndex,
//       selectButton: _selectButton,
//     );
//   }
// }

class ManageWidget extends StatefulWidget {
  // final PageController managePageController;
  // final int selectedIndex;
  // final Function(int) selectButton;

  ManageWidget({
    Key? key,
    // required this.managePageController,
    // required this.selectedIndex,
    // required this.selectButton,
  }) : super(key: key);

  @override
  State<ManageWidget> createState() => _ManageWidgetState();
}

class _ManageWidgetState extends State<ManageWidget> {
  // final List<String> _categories = [
  //
  //   'Details',
  //   'Zones',
  //   'Insurance',
  //   'Templates'
  // ];
  // final List<int> _categoriesInt = [
  //   0,
  //   1,
  //   2,
  //   3
  // ];

  final PageController _managePageController = PageController();

  int _selectedIndex = 1;


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
  // void _listButton(int index) {
  //   setState(() {
  //     listIndex = index;
  //   });
  //
  //   _managePageController.animateToPage(
  //     index,
  //     duration: Duration(milliseconds: 500),
  //     curve: Curves.ease,
  //   );
  // }
  @override
  void initState() {
    super.initState();
    // currentPage = 1;
    // itemsPerPage = 5;
    // items = List.generate(20, (index) => 'Item ${index + 1}');
    documentTypeGet(context);
    //_companyManager = CompanyIdentityManager();
    // companyAllApi(context);
  }
  int docID=0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          _selectedIndex !=0
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
                        Navigator.pop(context);
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
                FutureBuilder<List<DocumentTypeData>>(
                    future: documentTypeGet(context),
                    builder: (context,snapshot) {
                      if(snapshot.hasData){
                        List<Widget> docList = [
                          CustomButtonList(buttonText: 'Details', isSelected: _selectedIndex,docID: 4,onTap: () {
                            _selectButton(4);
                            docID = 4;
                          },),
                          CustomButtonList(buttonText: 'Zones', isSelected: _selectedIndex,docID: 5,onTap: () {
                            _selectButton(5);
                            docID = 5;
                          },),
                          CustomButtonList(buttonText: 'Insurance', isSelected: _selectedIndex,docID: 6,onTap: () {
                            _selectButton(6);
                            docID = 6;
                          },),
                          CustomButtonList(buttonText: 'Templates', isSelected: _selectedIndex,docID: 7,onTap: () {
                            _selectButton(7);
                            docID = 7;
                          },)
                          // InkWell(
                          //     child: Container(
                          //       height: 30,
                          //       width: MediaQuery.of(context).size.width / 8.62,
                          //       padding: EdgeInsets.symmetric(vertical: 6),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(20),
                          //         color: widget.selectedIndex == snapshot.data![index].docID
                          //             ? Colors.white
                          //             : null,
                          //       ),
                          //       child: Text(
                          //         snapshot.data![index].docType,
                          //         textAlign: TextAlign.center,
                          //         style: GoogleFonts.firaSans(
                          //           fontSize: 12,
                          //           fontWeight: FontWeightManager.semiBold,
                          //           color: widget.selectedIndex == snapshot.data![index].docID
                          //               ? ColorManager.mediumgrey
                          //               : Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //     onTap: (){widget.selectButton(snapshot.data![index].docID);
                          //     docID = snapshot.data![index].docID;}
                          // );
                        ];

                        for(var a in snapshot.data!){
                          docList.add(
                              CustomButtonList(buttonText: a.docType, isSelected: _selectedIndex,docID: a.docID,onTap: () {
                                _selectButton(a.docID);
                                docID = a.docID;
                              },)
                          );
                        }
                        return Material(
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
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:docList.length,
                                        itemBuilder: (BuildContext context,index) {
                                          if(snapshot.hasData){

                                            return docList[index];
                                            //   InkWell(
                                            //     child: Container(
                                            //       height: 30,
                                            //       width: MediaQuery.of(context).size.width / 8.62,
                                            //       padding: EdgeInsets.symmetric(vertical: 6),
                                            //       decoration: BoxDecoration(
                                            //         borderRadius: BorderRadius.circular(20),
                                            //         color: widget.selectedIndex == snapshot.data![index].docID
                                            //             ? Colors.white
                                            //             : null,
                                            //       ),
                                            //       child: Text(
                                            //         snapshot.data![index].docType,
                                            //         textAlign: TextAlign.center,
                                            //         style: GoogleFonts.firaSans(
                                            //           fontSize: 12,
                                            //           fontWeight: FontWeightManager.semiBold,
                                            //           color: widget.selectedIndex == snapshot.data![index].docID
                                            //               ? ColorManager.mediumgrey
                                            //               : Colors.white,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     onTap: (){widget.selectButton(snapshot.data![index].docID);
                                            //     docID = snapshot.data![index].docID;}
                                            // );
                                          }

                                        },
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: ListView.builder(
                                    //     scrollDirection: Axis.horizontal,
                                    //     itemCount: _categories.length,
                                    //     itemBuilder: (BuildContext context, int index) {
                                    //       return InkWell(
                                    //         child: Container(
                                    //           height: 30,
                                    //           width: MediaQuery.of(context).size.width / 8.62,
                                    //           padding: EdgeInsets.symmetric(vertical: 6),
                                    //           decoration: BoxDecoration(
                                    //             borderRadius: BorderRadius.circular(20),
                                    //             color: listIndex == _categoriesInt[index]
                                    //                 ? Colors.white
                                    //                 : null,
                                    //           ),
                                    //           child: Text(
                                    //             _categories[index],
                                    //             textAlign: TextAlign.start,
                                    //             style: GoogleFonts.firaSans(
                                    //               fontSize: 12,
                                    //               fontWeight: FontWeightManager.semiBold,
                                    //               color: listIndex == _categoriesInt[index]
                                    //                   ? ColorManager.mediumgrey
                                    //                   : Colors.white,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         onTap: () => _listButton(_categoriesInt[index]),
                                    //       );
                                    //     },
                                    //
                                    //   ),
                                    // ),


                                  ]
                              )
                            // .toList(),
                          ),
                        );
                      }else{
                        return SizedBox(height: 1,width: 1,);
                      }
                    }
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Expanded(
            flex: 10,
            child: Stack(
                children:[
                  _selectedIndex == 1 ? Offstage():  Container(height: MediaQuery.of(context).size.height/3,
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
                      //horizontal: MediaQuery.of(context).size.width / 45,
                        vertical: 5),
                    child: PageView(
                        controller: _managePageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          // docID == 5 ?
                          //  CiZone():Offstage(),
                          // docID == 4 ?
                          DocumentPageView(docID: docID,),
                          DocumentPageView(docID: docID,),
                          DocumentPageView(docID: docID,),
                          CIDetailsScreen(),

                          // // CiPageview(
                          // //     managePageController: _managePageController,
                          // //     selectedIndex: _selectedIndex,
                          // //     selectButton: _selectButton,
                          // //     //child1: Container(color: Colors.grey,width: 200,height: 40,),
                          // //     nameList: ['County', 'Zone'],
                          // //     screenList: [CIZoneCountry(), CIZoneZone()],
                          // //     mediaQueryWidth: 3.5),
                          // CiPageview(
                          //     managePageController: _managePageController,
                          //     selectedIndex: _selectedIndex,
                          //     selectButton: _selectButton,
                          //     nameList: ['Licenses','ADR','Medical Cost Reports','CAP Reports','Quarterly Balance Reports'],
                          //     screenList: [CICCLicense(),CICCADR(),CICCMedicalCR(),CICCCAPReports(),CICCQuarterlyBalReport()],
                          //     mediaQueryWidth: 2),
                          // CIInsurance(),
                          // // CiPageview(
                          // //   managePageController: _managePageController,
                          // //   selectedIndex: _selectedIndex,
                          // //   selectButton: _selectButton,
                          // //   mediaQueryWidth: 3,
                          // //   nameList: ['Vendor', 'Contracts'],
                          // //   screenList: [CiInsuranceVendor(), CiInsuranceContract()],
                          // // ),
                          // CiPageview(
                          //   managePageController: _managePageController,
                          //   selectedIndex: _selectedIndex,
                          //   selectButton: _selectButton,
                          //   mediaQueryWidth: 2,
                          //   nameList: ['Leases & Services', 'SNF','DME','MD','MISC'],
                          //   screenList: [CiLeasesAndServices(),CiSnf(),CiDme(),CiMd(),CiMisc()],
                          // ),
                          // CiPoliciesAndProcedures(),
                          // CiTempalets()
                        ]),
                  ),]
            ),
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
    Key? key, required this.docID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: MediaQuery.of(context).size.width / 8.62,
        padding: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected == docID ? Colors.white : null,
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected == docID ? Colors.grey[600] : Colors.white,
          ),
        ),
      ),
    );
  }
}