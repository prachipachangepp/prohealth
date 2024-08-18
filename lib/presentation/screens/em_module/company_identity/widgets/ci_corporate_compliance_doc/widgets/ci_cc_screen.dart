import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_insurance_manager/manage_corporate_compliance.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/ci_cc_licence.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../company_identity_screen.dart';
import '../ci_cc_adr.dart';
import '../ci_cc_cap_reports.dart';
import '../ci_cc_medical_cost_report.dart';
import '../ci_cc_quaterly_bal_report.dart';
import 'corporate_compliance_constants.dart';
class CiCorporateComplianceScreen extends StatefulWidget {
  final int docId;
  final String officeId;
  const CiCorporateComplianceScreen({super.key, required this.docId, required this.officeId});

  @override
  State<CiCorporateComplianceScreen> createState() => _CiCorporateComplianceScreenState();
}

class _CiCorporateComplianceScreenState extends State<CiCorporateComplianceScreen> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();

  int _selectedIndex = 0;
  int docTypeMetaId = 8;
  // int docTypeDropMetaId = 0;
  int docSubTypeMetaId =0;
  String? expiryType;
  bool _isLoading = false;

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
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //color: Colors.greenAccent,
                padding: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width/1.7,
                height: AppSize.s50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Container(
                        height: AppSize.s50,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 0
                              ? Colors.transparent
                              : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              AppString.licenses,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 0
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 0
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 0 ?
                            Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(0),
                    ),
                    InkWell(
                      child: Container(
                        height: AppSize.s50,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 1
                              ? Colors.transparent
                              : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'ADR',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 1
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 1
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 1 ?
                            Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(1),
                    ),
                    InkWell(
                      child: Container(
                        height: AppSize.s50,
                        width: MediaQuery.of(context).size.width / 8.62,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 2
                              ? Colors.transparent
                              : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Medical Cost Reports',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 2
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 2
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 2 ?
                            Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(2),
                    ),
                    InkWell(
                      child: Container(
                        height: AppSize.s50,
                        width: MediaQuery.of(context).size.width / 8.62,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 3
                              ? Colors.transparent
                              : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'CAP Reports',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 3
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 3
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 3 ?
                            Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(3),
                    ),
                    InkWell(
                      child: Container(
                        height: AppSize.s50,
                        width: MediaQuery.of(context).size.width / 8,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: _selectedIndex == 4
                              ? Colors.transparent
                              : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Quarterly Balance Reports',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: _selectedIndex == 4
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 4
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
                            ),
                            _selectedIndex == 4 ?
                            Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                          ],
                        ),
                      ),
                      onTap: () => _selectButton(4),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width/20,),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: CustomIconButton(
                    icon: Icons.add,
                    text: "Add Doctype",
                    onPressed: () async{
                      String? selectedDocType;
                      String? selectedSubDocType;
                      String? selectedExpiryType = expiryType;
                      showDialog(
                          context: context,
                          builder: (context) {
                            return  StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return CCScreenEditPopup(
                                  height: AppSize.s400,
                                  idDocController: docIdController,
                                  nameDocController: docNamecontroller,
                                  loadingDuration: _isLoading,
                                  onSavePressed: () async{
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    try {
                                      await addCorporateDocumentPost(
                                        context: context,
                                        name: docNamecontroller.text,
                                        docTypeID: docTypeMetaId,
                                        docSubTypeID: docTypeMetaId == 10 ?0:docSubTypeMetaId,
                                        docCreated: DateTime.now().toString(),
                                        url: "url",
                                        expiryType: expiryType.toString(),
                                        expiryDate: calenderController.text,
                                        expiryReminder: "Schedule",
                                        officeId: widget.officeId,
                                      );
                                      setState(() async {
                                        await getManageCorporate(context,
                                            widget.officeId,
                                            widget.docId, docSubTypeMetaId, 1, 15);
                                        // orgSubDocumentGet(
                                        //   context,
                                        //   docTypeMetaId,
                                        //   docSubTypeMetaId,
                                        //   1,
                                        //   15,
                                        // );
                                        Navigator.pop(context);
                                        expiryType = '';
                                        calenderController.clear();
                                        docIdController.clear();
                                        docNamecontroller.clear();
                                      });
                                    } finally {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                                  child:  FutureBuilder<List<DocumentTypeData>>(
                                      future: documentTypeGet(context),
                                      builder: (context,snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                          return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                width: AppSize.s350,
                                                height: AppSize.s30,
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
                                          List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
                                              .map((doc) => DropdownMenuItem<String>(
                                            value: doc.docType,
                                            child: Text(doc.docType),
                                          ))
                                              .toList();
                                          return CICCDropdown(
                                              initialValue: selectedDocType ?? dropDownMenuItems[0].value,
                                              onChange: (val){
                                                setState(() {
                                               selectedDocType = val;
                                                for(var doc in snapshot.data!){
                                                  if(doc.docType == val){
                                                   // docType = a.docID;
                                                    docTypeMetaId = doc.docID;

                                                  }
                                                }
                                                identityDocumentTypeGet(context,docTypeMetaId).then((data) {
                                                  _identityDataController.add(data);
                                                }).catchError((error) {
                                                  // Handle error
                                                });
                                                });
                                              },
                                              items:dropDownMenuItems
                                          );
                                        }else{
                                          return SizedBox();
                                        }
                                      }
                                  ),
                                  child1: StreamBuilder<List<IdentityDocumentIdData>>(
                                      stream: _identityDataController.stream,
                                      builder: (context,snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                          return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                width: AppSize.s350,
                                                height: AppSize.s30,
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
                                          List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
                                              .map((subDoc) => DropdownMenuItem<String>(
                                            value: subDoc.subDocType,
                                            child: Text(subDoc.subDocType),
                                          ))
                                              .toList();
                                          return CICCDropdown(
                                              initialValue: selectedSubDocType ?? dropDownMenuItems[0].value,
                                              onChange: (val){
                                               setState(() {
                                                 selectedSubDocType = val;
                                                 for (var subDoc in snapshot
                                                     .data!) {
                                                   if (subDoc.subDocType ==
                                                       val) {
                                                     //docType = subDoc.subDocID;
                                                     docSubTypeMetaId =
                                                         subDoc.subDocID;
                                                   }
                                                 }
                                               });
                                                // print(":::${docType}");
                                                // print(":::<>${docSubTypeMetaId}");
                                              },
                                              items:dropDownMenuItems
                                          );
                                        }else{
                                          return SizedBox(
                                            height:AppSize.s1,
                                            width: AppSize.s1);
                                        }
                                      }
                                  ),
                                  title: 'Add Corporate & Compliance',
                                );
                              },

                            );
                          });
                    }),
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppSize.s20,
        ),
        Expanded(
          child:
          Padding(
            padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width / 50),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                // Page 1
                CICCLicense(docId: widget.docId, subDocId: AppConfig.subDocId1,officeId: widget.officeId,),
                CICCADR(docId: widget.docId, subDocId: AppConfig.subDocId2,officeId: widget.officeId,),
                CICCMedicalCR(docId: widget.docId, subDocId: AppConfig.subDocId3,officeId: widget.officeId,),
                CICCCAPReports(docId: widget.docId, subDocId: AppConfig.subDocId4,officeId: widget.officeId,),
                CICCQuarterlyBalReport(docId: widget.docId, subDocId: AppConfig.subDocId5,officeId: widget.officeId,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
