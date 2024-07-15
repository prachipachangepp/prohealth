import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../../../app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import '../../../../../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

class VendorContractLicense extends StatefulWidget {
  final int docId;
  final int subDocID;
  const VendorContractLicense({super.key, required this.docId, required this.subDocID});

  @override
  State<VendorContractLicense> createState() => _VendorContractLicenseState();
}

class _VendorContractLicenseState extends State<VendorContractLicense> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<CiOrgDocumentCC>> _controller = StreamController<List<CiOrgDocumentCC>>();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();
  int docTypeMetaId =0;
  int docSubTypeMetaId =0;
  String? expiryType;
  bool _isLoading = false;



  String? selectedValue;
  late List<Color> hrcontainerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    // orgDocumentGet(context);
    _loadColors();

  }
  void _loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < hrcontainerColors.length; i++) {
        int? colorValue = prefs.getInt('containerColor$i');
        if (colorValue != null) {
          hrcontainerColors[i] = Color(colorValue);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
    return Column(
      children: [
        Container(
          height: AppSize.s30,
          margin: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Center(
                    child: Text(
                        AppString.srNo,
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
              ),
              Expanded(
                child: Center(
                    child: Text(
                        AppString.name,
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
              ),
              Expanded(
                child: Center(
                    child: Text(
                        AppString.expiry,
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
              ),
              Expanded(
                child: Center(
                    child: Text(
                        AppString.reminderthershold,
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
              ),

              Expanded(
                child: Center(
                    child: Text(
                        AppString.actions,
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white
                        )
                      // style: RegisterTableHead.customTextStyle(context),
                    )),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSize.s10,),
        Expanded(
          child:StreamBuilder<List<CiOrgDocumentCC>>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                orgSubDocumentGet(context, 11, widget.docId, widget.subDocID, 1, 15).then((data) {
                  _controller.add(data);
                }).catchError((error) {
                  // Handle error
                });
                print('1111111');
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
                  List<CiOrgDocumentCC> currentPageItems = snapshot.data!.sublist(
                    (currentPage - 1) * itemsPerPage,
                    (currentPage * itemsPerPage) > totalItems
                        ? totalItems
                        : (currentPage * itemsPerPage),
                  );
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      int serialNumber =
                          index + 1 + (currentPage - 1) * itemsPerPage;
                      String formattedSerialNumber =
                      serialNumber.toString().padLeft(2, '0');
                      return Column(
                        children: [
                          SizedBox(height: AppSize.s5),
                          Container(
                            padding: EdgeInsets.only(bottom: AppPadding.p5),
                            margin: EdgeInsets.symmetric(horizontal: AppMargin.m50),
                            decoration: BoxDecoration(
                              color:ColorManager.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: AppSize.s56,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Center(
                                      child: Text(
                                        formattedSerialNumber,
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                        textAlign: TextAlign.start,
                                      )),
                                ),
                                Expanded(
                                  child: Center(
                                      child: Text(
                                        snapshot.data![index].name.toString(),
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      )),
                                ),
                                Expanded(
                                  child: Center(
                                      child: Text(
                                        snapshot.data![index].expiry.toString(),
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      )),
                                ),
                                Expanded(
                                  child: Center(
                                      child: Text(
                                        snapshot.data![index].reminderThreshold.toString(),
                                        style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xff686464)
                                          // color: isSelected ? Colors.white : Colors.black,
                                        ),
                                      )),
                                ),
                                Expanded(
                                  child: Row(
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
                                                      title: 'Edit Leases & Services',
                                                      id: documentPreId,
                                                      idDocController: docIdController,
                                                      nameDocController: docNameController,
                                                      calenderController: calenderController,
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
                                                            docCreated: DateTime.now().toString(),
                                                            url: "url",
                                                            expiryType: expiry == expiryType.toString() ? expiry.toString() : expiryType.toString(),
                                                            expiryDate: calender == calenderController.text ? calender.toString() : calenderController.text,
                                                            expiryReminder: "Schedule",
                                                            companyId: 11,
                                                            officeId: "Office 1",
                                                          );
                                                          setState(() async {
                                                            await orgSubDocumentGet(context, 11, widget.docId, widget.subDocID, 1, 15).then((data) {
                                                              _controller.add(data);
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
                                                      radioButton: Column(
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
                                                            snapshot.data![index].docId);
                                                        setState(() async {
                                                          await orgSubDocumentGet(context, 11, widget.docId, widget.subDocID, 1, 15).then((data) {
                                                            _controller.add(data);
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return Offstage();
              }
          ),
        ),
        // PaginationControlsWidget(
        //   currentPage: currentPage,
        //   items: items,
        //   itemsPerPage: itemsPerPage,
        //   onPreviousPagePressed: () {
        //     /// Handle previous page button press
        //     setState(() {
        //       currentPage = currentPage > 1 ? currentPage - 1 : 1;
        //     });
        //   },
        //   onPageNumberPressed: (pageNumber) {
        //     /// Handle page number tap
        //     setState(() {
        //       currentPage = pageNumber;
        //     });
        //   },
        //   onNextPagePressed: () {
        //     /// Handle next page button press
        //     setState(() {
        //       currentPage = currentPage < (items.length / itemsPerPage).ceil()
        //           ? currentPage + 1
        //           : (items.length / itemsPerPage).ceil();
        //     });
        //   },
        // ),
      ],
    );
  }
}
