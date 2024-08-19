import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_insurance_manager/manage_corporate_compliance.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'widgets/add_policies_popup.dart';

class CiPoliciesAndProcedures extends StatefulWidget {
  final int docID;
  final int subDocID;
  final int companyID;
  final String officeId;
  const CiPoliciesAndProcedures({super.key, required this.docID, required this.subDocID, required this.companyID, required this.officeId});

  @override
  State<CiPoliciesAndProcedures> createState() => _CiPoliciesAndProceduresState();
}

class _CiPoliciesAndProceduresState extends State<CiPoliciesAndProcedures> {
  TextEditingController nameOfDocController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  final StreamController<List<ManageCCDoc>> _controller = StreamController<List<ManageCCDoc>>();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();

  int _selectedIndex = 0;
  int docTypeMetaId = 8;
  int docSubTypeMetaId =0;
  String? expiryType;
  bool _isLoading = false;

  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomIconButton(
                    icon: CupertinoIcons.plus,
                    text: "Add Doctype",
                    onPressed: () async{
                      showDialog(
                          context: context,
                          builder: (context) {
                            return  StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return AddOrgDocButton(
                                  height: AppSize.s400,
                                  calenderController: calenderController,
                                  idDocController: docIdController,
                                  nameDocController: docNamecontroller,
                                  loadingDuration: _isLoading,
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
                                        expiryType: expiryType.toString(),
                                        expiryDate: calenderController.text,
                                        expiryReminder: "Schedule",
                                        officeId: widget.officeId,
                                      );
                                      setState(() async {
                                        await getManageCorporate(context,
                                            widget.officeId,
                                            widget.docID,
                                            widget.subDocID,
                                            1, 20);
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
                                                identityDocumentTypeGet(context,docTypeMetaId).then((data) {
                                                  _identityDataController.add(data);
                                                }).catchError((error) {
                                                  // Handle error
                                                });

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
                                  child1: StreamBuilder<List<IdentityDocumentIdData>>(
                                      stream: _identityDataController.stream,
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
                                                value: i.subDocType,
                                                child: Text(i.subDocType),
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
                                  title: 'Add Policies',
                                );
                              },

                            );
                          });
                    }),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child:
            StreamBuilder<List<ManageCCDoc>>(
              stream: _controller.stream,
              builder: (context,snapshot) {
                getManageCorporate(context, widget.officeId, widget.docID, widget.subDocID, 1, 20).then((data) {
                  _controller.add(data);
                }).catchError((error) {
                  // Handle error
                });
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.blueprime,
                    ),
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
                  int totalItems = snapshot.data!.length;
                  int totalPages = (totalItems / itemsPerPage).ceil();
                  List<ManageCCDoc> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: paginatedData.length,
                            itemBuilder: (context, index) {
                              int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                              String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                              ManageCCDoc policiesdata = paginatedData[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff000000).withOpacity(0.25),
                                              spreadRadius: 0,
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye_outlined,color: ColorManager.blueprime,)),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                       policiesdata.doccreatedAt.toString(),textAlign:TextAlign.center,
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w400,
                                                          color: const Color(0xff686464),
                                                          decoration: TextDecoration.none,
                                                        ),
                                                      ),
                                                      Text(
                                                        policiesdata.docname.toString(),textAlign:TextAlign.center,
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.bold,
                                                          color: const Color(0xff686464),
                                                          decoration: TextDecoration.none,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              //  Text(''),
                                              Row(
                                                children: [
                                                  IconButton(onPressed: (){
                                                    showDialog(context: context, builder: (context){
                                                      return CCScreenEditPopup(
                                                        height: 350,
                                                        title: "Edit Policies & Procedures",
                                                        idDocController: docIdController,
                                                        nameDocController: docNamecontroller,
                                                        child:  const CICCDropdown(
                                                          initialValue: 'Corporate & Compliance Documents',
                                                          items: [
                                                            DropdownMenuItem(value: 'Corporate & Compliance Documents', child: Text('Corporate & Compliance Documents')),
                                                            DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                                                            DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                                                            DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                                                          ],),
                                                        child1:   const CICCDropdown(
                                                          initialValue: 'Policies and Procedures',
                                                          items: [
                                                            DropdownMenuItem(value: 'Policies and Procedures', child: Text('Licenses')),
                                                            DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                                                            DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                                                            DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                                                          ],),
                                                          );
                                                    });
                                                  }, icon: Icon(Icons.edit_outlined,size:18,color: ColorManager.blueprime,)),
                                                  IconButton(onPressed: (){
                                                    showDialog(context: context, builder: (context) => DeletePopup(
                                                        title: 'Delete Policies Procedure',
                                                        onCancel: (){
                                                      Navigator.pop(context);
                                                    }, onDelete: (){
                                                      Navigator.pop(context);
                                                          setState(() async{
                                                      await deleteDocument(
                                                          context,
                                                          policiesdata.docId);
                                                      getManageCorporate(context, widget.officeId, widget.docID, widget.subDocID, 1, 20).then((data) {
                                                        _controller.add(data);
                                                      }).catchError((error) {
                                                        // Handle error
                                                      });
                                                    });
                                                        }));
                                                  }, icon: Icon(Icons.delete_outline,size:18,color: ColorManager.red,)),
                                                ],
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              );
                            }),
                      ),
                      PaginationControlsWidget(
                        currentPage: currentPage,
                        items: snapshot.data!,
                        itemsPerPage: itemsPerPage,
                        onPreviousPagePressed: () {
                          setState(() {
                            currentPage = currentPage > 1 ? currentPage - 1 : 1;
                          });
                        },
                        onPageNumberPressed: (pageNumber) {
                          setState(() {
                            currentPage = pageNumber;
                          });
                        },
                        onNextPagePressed: () {
                          setState(() {
                            currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                          });
                        },
                      ),
                    ],
                  );
                }
                return const Offstage();
              }
            ),
          ),
        ],),
      ),
    );
  }
}
