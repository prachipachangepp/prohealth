import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_corporate&compiliance_document.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../../../hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../../../hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../../../hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
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
  int docTypeMetaId = 1;
  int docSubTypeMetaId =0;
  String? expiryType;

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
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
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    try {
                                      await addCorporateDocumentPost(
                                        context: context,
                                        name: docNamecontroller.text,
                                        docTypeID: docTypeMetaId,
                                        docSubTypeID: docSubTypeMetaId,
                                        docCreated: DateTime.now().toString(),
                                        url: "url",
                                        expiryType: expiryType.toString(),
                                        expiryDate: calenderController.text,
                                        expiryReminder: "Schedule",
                                        companyId: 11,
                                        officeId: "1",
                                      );
                                      setState(() async {
                                        await orgSubDocumentGet(
                                          context,
                                          11,
                                          docID,
                                          1,
                                          1,
                                          6,
                                        );
                                        Navigator.pop(context);
                                         calenderController.clear();
                                        docIdController.clear();
                                        docNamecontroller.clear();
                                      });
                                    } finally {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }


///
                                    // await addCorporateDocumentPost(context: context,
                                    //     name: docNamecontroller.text,
                                    //     docTypeID: docTypeMetaId,
                                    //     docSubTypeID: docSubTypeMetaId,
                                    //     docCreated: DateTime.now().toString(),
                                    //     url: "url",
                                    //     expiryType: expiryType.toString(),
                                    //     expiryDate: calenderController.text,
                                    //     expiryReminder: "Schedule",
                                    //     companyId: 11,
                                    //     officeId: "1");
                                    // setState(() async {
                                    // await  orgSubDocumentGet(context, 11, docID, 1, 1, 6);
                                    // Navigator.pop(context);
                                    // calenderController.clear();
                                    //   docIdController.clear();
                                    //   docNamecontroller.clear();
                                    // });
                                  },
                                  child1: FutureBuilder<List<IdentityDocumentIdData>>(
                                      future: identityDocumentTypeGet(context,docTypeMetaId),
                                      builder: (context,snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                          return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                width: 350,
                                                height: 30,
                                                decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                              )
                                          );
                                        }
                                        if (snapshot.data!.isEmpty) {
                                          return Center(
                                            child: Text(
                                              AppString.dataNotFound,
                                              style: CustomTextStylesCommon.commonStyle(
                                                fontWeight: FontWeightManager.medium,
                                                fontSize: FontSize.s12,
                                                color: ColorManager.mediumgrey,
                                              ),
                                            ),
                                          );
                                        }
                                        if(snapshot.hasData){
                                          List dropDown = [];
                                          int docType = 0;
                                          List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                          for(var i in snapshot.data!){
                                            dropDownMenuItems.add(
                                              DropdownMenuItem<String>(
                                                child: Text(i.subDocType),
                                                value: i.subDocType,
                                              ),
                                            );
                                          }
                                          return CICCDropdown(
                                              initialValue: dropDownMenuItems[0].value,
                                              onChange: (val){
                                                for(var a in snapshot.data!){
                                                  if(a.subDocType == val){
                                                    docType = a.subDocID;
                                                    docSubTypeMetaId = docType;
                                                  }
                                                }
                                                print(":::${docType}");
                                                print(":::<>${docSubTypeMetaId}");
                                              },
                                              items:dropDownMenuItems
                                          );
                                        }else{
                                          return SizedBox(height:1,width: 1,);
                                        }
                                      }
                                  ),
                                  child:  FutureBuilder<List<DocumentTypeData>>(
                                      future: documentTypeGet(context),
                                      builder: (context,snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                          return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                width: 350,
                                                height: 30,
                                                decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                              )
                                          );
                                        }
                                        if (snapshot.data!.isEmpty) {
                                          return Center(
                                            child: Text(
                                              AppString.dataNotFound,
                                              style: CustomTextStylesCommon.commonStyle(
                                                fontWeight: FontWeightManager.medium,
                                                fontSize: FontSize.s12,
                                                color: ColorManager.mediumgrey,
                                              ),
                                            ),
                                          );
                                        }
                                        if(snapshot.hasData){
                                          List dropDown = [];
                                          int docType = 0;
                                          List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                          for(var i in snapshot.data!){
                                            dropDownMenuItems.add(
                                              DropdownMenuItem<String>(
                                                child: Text(i.docType),
                                                value: i.docType,
                                              ),
                                            );
                                          }
                                          return CICCDropdown(
                                              initialValue: dropDownMenuItems[0].value,
                                              onChange: (val){
                                                for(var a in snapshot.data!){
                                                  if(a.docType == val){
                                                    docType = a.docID;
                                                    docTypeMetaId = docType;
                                                  }
                                                }
                                                identityDocumentTypeGet(context,docTypeMetaId);
                                                print(":::${docType}");
                                                print(":::<>${docTypeMetaId}");
                                              },
                                              items:dropDownMenuItems
                                          );
                                        }else{
                                          return SizedBox();
                                        }
                                      }
                                  ),
                                  radioButton: StatefulBuilder(
                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomRadioListTile(
                                            value: "Not Applicable",
                                            groupValue: expiryType.toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                expiryType = value!;
                                              });
                                            },
                                            title: "Not Applicable",
                                          ),
                                          CustomRadioListTile(
                                            value: 'Scheduled',
                                            groupValue: expiryType.toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                expiryType = value!;
                                              });
                                            },
                                            title: 'Scheduled',
                                          ),
                                          CustomRadioListTile(
                                            value: 'Issuer Expiry',
                                            groupValue: expiryType.toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                expiryType = value!;
                                              });
                                            },
                                            title: 'Issuer Expiry',
                                          ),
                                        ],
                                      );
                                    },
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
      ],
    );
  }
}
