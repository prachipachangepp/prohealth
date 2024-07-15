import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/manage_details_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class CICCMedicalCR extends StatefulWidget {
  final int docId;
  final int subDocId;
  const CICCMedicalCR({super.key, required this.docId, required this.subDocId});

  @override
  State<CICCMedicalCR> createState() => _CICCMedicalCRState();
}

class _CICCMedicalCRState extends State<CICCMedicalCR> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<CiOrgDocumentCC>> _ccAdrController = StreamController<List<CiOrgDocumentCC>>();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();

  String? selectedValue;
  late List<Color> hrcontainerColors;
  int docTypeMetaId =0;
  int docSubTypeMetaId =0;
  String? expiryType;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(60, (index) => 'Item ${index + 1}');


  }

  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // CustomIconButtonConst(
          //     icon: Icons.add,
          //     text: "Add Doctype", onPressed: (){
          //   showDialog(context: context, builder: (context){
          //     return CCScreensAddPopup(
          //         countynameController: docNamecontroller,
          //         zipcodeController: docIdController,
          //       onSavePressed: () {  },
          //     child:  CICCDropdown(
          //         initialValue: 'Corporate & Compliance Documents',
          //         items: [
          //           DropdownMenuItem(value: 'Corporate & Compliance Documents', child: Text('Corporate & Compliance Documents')),
          //           DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
          //           DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
          //           DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
          //         ],),
          //       child1:  CICCDropdown(
          //         initialValue: 'Licenses',
          //         items: [
          //           DropdownMenuItem(value: 'Licenses', child: Text('Licenses')),
          //           DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
          //           DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
          //           DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
          //         ],),);
          //   });
          // }),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child:
            StreamBuilder<List<CiOrgDocumentCC>>(
                stream : _ccAdrController.stream,
                builder: (context, snapshot) {
                  orgSubDocumentGet(context, 11, widget.docId, widget.subDocId, 1, 15).then((data) {
                    _ccAdrController.add(data);
                  }).catchError((error) {
                    // Handle error
                  });
                  print('55555555');
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
                  if (snapshot.hasData) {
                    int totalItems = snapshot.data!.length;
                    // int totalPages = (totalItems / itemsPerPage).ceil();
                    List<CiOrgDocumentCC> currentPageItems =
                    snapshot.data!.sublist(
                      (currentPage - 1) * itemsPerPage,
                      (currentPage * itemsPerPage) > totalItems
                          ? totalItems
                          : (currentPage * itemsPerPage),
                    );
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          // int serialNumber =
                          //     index + 1 + (currentPage - 1) * itemsPerPage;
                          // String formattedSerialNumber =
                          // serialNumber.toString().padLeft(2, '0');
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
                                          color: Color(0xff000000).withOpacity(0.25),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
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
                                              InkWell(
                                                onTap: () {
                                                },
                                                child: Image.asset(
                                                  'images/eye.png',
                                                  height: 15,
                                                  width: 22,
                                                ),
                                              ),
                                              //IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye_outlined,size:20,color: ColorManager.blueprime,)),
                                              SizedBox(width: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    snapshot.data![index].createdAt.toString(),textAlign:TextAlign.center,
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xff686464),
                                                      decoration: TextDecoration.none,
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data![index].name.toString(),textAlign:TextAlign.center,
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                      color: Color(0xff686464),
                                                      decoration: TextDecoration.none,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(onPressed: (){
                                                showDialog(context: context, builder: (context){
                                                  return  FutureBuilder<CorporatePrefillDocumentData>(
                                                      future: getPrefillCorporateDocument(context,snapshot.data![index].docId),
                                                      builder: (context,snapshotPrefill) {
                                                        if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                          return Center(
                                                            child: CircularProgressIndicator(color: ColorManager.blueprime,),
                                                          );
                                                        }
                                                        var documentPreId = snapshotPrefill.data!.documentId;
                                                        docIdController = TextEditingController(text: snapshotPrefill.data!.documentId.toString());

                                                        var createdAt = snapshotPrefill.data!.docCreated;

                                                        var documentTypePreId = snapshotPrefill.data!.documentTypeId;
                                                        docTypeMetaId = documentTypePreId;

                                                        var documentSubPreId = snapshotPrefill.data!.documentSubTypeId;
                                                        docSubTypeMetaId = documentSubPreId;

                                                        var name = snapshotPrefill.data!.docName;
                                                        docNameController = TextEditingController(text: snapshotPrefill.data!.docName);

                                                        var calender = snapshotPrefill.data!.expiryDate;
                                                        calenderController = TextEditingController(text: snapshotPrefill.data!.expiryDate);

                                                        var expiry = snapshotPrefill.data!.expiryType;
                                                        expiryType = expiry;
                                                        return StatefulBuilder(
                                                          builder: (BuildContext context, void Function(void Function()) setState) {
                                                            return CCScreenEditPopup(
                                                              height: AppSize.s350,
                                                              title: 'Edit Medical Cost Report',
                                                              id: documentPreId,
                                                              idDocController: docIdController,
                                                              nameDocController: docNameController,
                                                              loadingDuration: _isLoading,
                                                              onSavePressed: ()async{
                                                                setState(() {
                                                                  _isLoading = true;
                                                                });
                                                                try {
                                                                  await updateCorporateDocumentPost(
                                                                    context: context,
                                                                    docId: documentPreId,
                                                                    name: name == docNameController.text ? name.toString() : docNameController.text,
                                                                    docTypeID: documentTypePreId == docTypeMetaId ? documentTypePreId : docTypeMetaId,
                                                                    docSubTypeID: documentSubPreId == docSubTypeMetaId ? documentSubPreId : docSubTypeMetaId ,
                                                                    docCreated: createdAt.toString(),
                                                                    url: "url",
                                                                    expiryType:  expiry.toString(),
                                                                    expiryDate: calender.toString(),
                                                                    expiryReminder: "Schedule",
                                                                    companyId: 11,
                                                                    officeId: "Office 1",
                                                                  );
                                                                  setState(() async {
                                                                    await orgSubDocumentGet(context, 11, widget.docId, widget.subDocId, 1, 15).then((data) {
                                                                      _ccAdrController.add(data);
                                                                    }).catchError((error) {
                                                                      // Handle error
                                                                    });
                                                                    Navigator.pop(context);
                                                                  });
                                                                } finally {
                                                                  setState(() {
                                                                    _isLoading = false;
                                                                  });
                                                                }


                                                              },
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
                                                              ),);
                                                          },
                                                        );

                                                      }
                                                  );

                                                });
                                              }, icon: Icon(Icons.edit_outlined,size:18,color: ColorManager.bluebottom,)),
                                              IconButton(
                                                  onPressed: (){
                                                    showDialog(context: context,
                                                        builder: (context) => StatefulBuilder(
                                                          builder: (BuildContext context, void Function(void Function()) setState) {
                                                            return  DeletePopup(
                                                                loadingDuration: _isLoading,
                                                                onCancel: (){
                                                                  Navigator.pop(context);
                                                                }, onDelete: () async{
                                                              setState(() {
                                                                _isLoading = true;
                                                              });
                                                              try {
                                                                await deleteDocument(
                                                                    context,
                                                                    snapshot.data![index].docId!);
                                                                setState(() async {
                                                                  await orgSubDocumentGet(context, 11, widget.docId, widget.subDocId, 1, 15).then((data) {
                                                                    _ccAdrController.add(data);
                                                                  }).catchError((error) {
                                                                    // Handle error
                                                                  });
                                                                  Navigator.pop(context);
                                                                });
                                                              } finally {
                                                                setState(() {
                                                                  _isLoading = false;
                                                                });
                                                              }

                                                            });
                                                          },

                                                        ));
                                                  }, icon: Icon(Icons.delete_outline,size:18,color: ColorManager.red,)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          );
                        });
                  }
                  return Offstage();
                }
            ),
          ),
          SizedBox(
            height: 10,
          ),
          PaginationControlsWidget(
            currentPage: currentPage,
            items: items,
            itemsPerPage: itemsPerPage,
            onPreviousPagePressed: () {
              /// Handle previous page button press
              setState(() {
                currentPage = currentPage > 1 ? currentPage - 1 : 1;
              });
            },
            onPageNumberPressed: (pageNumber) {
              /// Handle page number tap
              setState(() {
                currentPage = pageNumber;
              });
            },
            onNextPagePressed: () {
              /// Handle next page button press
              setState(() {
                currentPage = currentPage < (items.length / itemsPerPage).ceil()
                    ? currentPage + 1
                    : (items.length / itemsPerPage).ceil();
              });
            },
          ),
        ],),
    );
  }
}
