import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/manage_insurance_manager/manage_corporate_compliance.dart';
import '../../../../../../app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class CICCADR extends StatefulWidget {
  final int docId;
  final int subDocId;
  final String officeId;
  const CICCADR({super.key, required this.docId, required this.subDocId, required this.officeId});

  @override
  State<CICCADR> createState() => _CICCADRState();
}

class _CICCADRState extends State<CICCADR> {
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<ManageCCDoc>> _ccAdrController = StreamController<List<ManageCCDoc>>();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();

  String? selectedValue;
  late List<Color> hrcontainerColors;
  int docTypeMetaId =0;
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
    return  Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: AppSize.s5,
          ),
          Expanded(
            child:
            StreamBuilder<List<ManageCCDoc>>(
                stream : _ccAdrController.stream,
                builder: (context, snapshot) {
                  getManageCorporate(context, widget.officeId, widget.docId, widget.subDocId, 1, 20).then((data) {
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
                                ManageCCDoc manageCCADR = paginatedData[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorManager.white,
                                            borderRadius: BorderRadius.circular(4),
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorManager.black.withOpacity(0.25),
                                                spreadRadius: 0,
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          height: AppSize.s50,
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
                                                        height: AppSize.s15,
                                                        width: AppSize.s22,
                                                      ),
                                                    ),
                                                    //IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye_outlined,size:20,color: ColorManager.blueprime,)),
                                                    SizedBox(width: AppSize.s10),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "ID : ${ manageCCADR.docId.toString()}",
                                                         // manageCCADR.doccreatedAt.toString(),textAlign:TextAlign.center,
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: FontSize.s10,
                                                            fontWeight: FontWeightManager.regular,
                                                            color: ColorManager.granitegray,
                                                            decoration: TextDecoration.none,
                                                          ),
                                                        ),
                                                        Text(
                                                          manageCCADR.docname.toString(),textAlign:TextAlign.center,
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: FontSize.s10,
                                                            fontWeight: FontWeight.bold,
                                                            color: ColorManager.granitegray,
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
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return FutureBuilder<CorporatePrefillCCVVPP>(
                                                              future: getManageCCPrefill(context, manageCCADR.docId),
                                                              builder: (context, snapshotPrefill) {
                                                                if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                                                  return Center(
                                                                    child: CircularProgressIndicator(
                                                                      color: ColorManager.blueprime,
                                                                    ),
                                                                  );
                                                                }

                                                                // Prefill values from API
                                                                var documentPreId = snapshotPrefill.data!.documentId;
                                                                docIdController = TextEditingController(
                                                                  text: snapshotPrefill.data!.documentId.toString(),
                                                                );

                                                                var documentTypePreId = snapshotPrefill.data!.documentTypeId;
                                                                docTypeMetaId = documentTypePreId;

                                                                var documentSubPreId = snapshotPrefill.data!.documentSubTypeId;
                                                                docSubTypeMetaId = documentSubPreId;

                                                                var name = snapshotPrefill.data!.docName;
                                                                docNameController = TextEditingController(
                                                                  text: snapshotPrefill.data!.docName,
                                                                );

                                                                var calender = snapshotPrefill.data!.expiryDate;
                                                                calenderController = TextEditingController(
                                                                  text: snapshotPrefill.data!.expiryDate,
                                                                );

                                                                var expiry = snapshotPrefill.data!.expiryType;
                                                                expiryType = expiry;

                                                                // Fetch sub-document types based on the document type
                                                                identityDocumentTypeGet(context, documentTypePreId).then((data) {
                                                                  _identityDataController.add(data);
                                                                }).catchError((error) {
                                                                  // Handle error
                                                                });

                                                                return StatefulBuilder(
                                                                  builder: (BuildContext context,
                                                                      void Function(void Function()) setState) {
                                                                    return CCScreenEditPopup(
                                                                      height: AppSize.s350,
                                                                      title: 'Edit Leases & Services',
                                                                      id: documentPreId,
                                                                      idDocController: docIdController,
                                                                      nameDocController: docNameController,
                                                                      loadingDuration: _isLoading,
                                                                      onSavePressed: () async {
                                                                        setState(() {
                                                                          _isLoading = true;
                                                                        });
                                                                        try {
                                                                          await updateManageCCVVPP(
                                                                            context: context,
                                                                            docId: documentPreId,
                                                                            name: docNameController.text,
                                                                            docTypeID: docTypeMetaId,
                                                                            docSubTypeID: docSubTypeMetaId,
                                                                            docCreated: snapshotPrefill.data!.docCreated.toString(),
                                                                            url: "url",
                                                                            expiryType: expiry.toString(),
                                                                            expiryDate: calender.toString(),
                                                                            expiryReminder: "Schedule",
                                                                            officeId: widget.officeId,
                                                                          );
                                                                        } finally {
                                                                          setState(() {
                                                                            _isLoading = false;
                                                                          });
                                                                          Navigator.pop(context);
                                                                        }
                                                                      },

                                                                      // Document Type Dropdown
                                                                      child: FutureBuilder<List<DocumentTypeData>>(
                                                                        future: documentTypeGet(context),
                                                                        builder: (context, snapshot) {
                                                                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                                                            List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                                                            for (var i in snapshot.data!) {
                                                                              dropDownMenuItems.add(
                                                                                DropdownMenuItem<String>(
                                                                                  child: Text(i.docType),
                                                                                  value: i.docType,
                                                                                ),
                                                                              );
                                                                            }
                                                                            return CICCDropdown(
                                                                              initialValue: snapshot.data!
                                                                                  .firstWhere((item) => item.docID == documentTypePreId)
                                                                                  .docType,
                                                                              onChange: (val) {
                                                                                for (var a in snapshot.data!) {
                                                                                  if (a.docType == val) {
                                                                                    docTypeMetaId = a.docID;
                                                                                  }
                                                                                }
                                                                                identityDocumentTypeGet(context, docTypeMetaId)
                                                                                    .then((data) {
                                                                                  _identityDataController.add(data);
                                                                                }).catchError((error) {
                                                                                  // Handle error
                                                                                });
                                                                              },
                                                                              items: dropDownMenuItems,
                                                                            );
                                                                          } else if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return SizedBox(); // Optional placeholder
                                                                          } else {
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
                                                                        },
                                                                      ),

                                                                      // Sub-Document Type Dropdown
                                                                      child1: StreamBuilder<List<IdentityDocumentIdData>>(
                                                                        stream: _identityDataController.stream,
                                                                        builder: (context, snapshot) {
                                                                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                                                            List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                                                            for (var i in snapshot.data!) {
                                                                              dropDownMenuItems.add(
                                                                                DropdownMenuItem<String>(
                                                                                  child: Text(i.subDocType),
                                                                                  value: i.subDocType,
                                                                                ),
                                                                              );
                                                                            }
                                                                            return CICCDropdown(
                                                                              initialValue: snapshot.data!
                                                                                  .firstWhere((item) => item.subDocID == documentSubPreId)
                                                                                  .subDocType, // Set initial value from API data
                                                                              onChange: (val) {
                                                                                for (var a in snapshot.data!) {
                                                                                  if (a.subDocType == val) {
                                                                                    docSubTypeMetaId = a.subDocID;
                                                                                  }
                                                                                }
                                                                              },
                                                                              items: dropDownMenuItems,
                                                                            );
                                                                          } else if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return SizedBox(); // Optional placeholder
                                                                          } else {
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
                                                                        },
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.edit_outlined,
                                                        size: 18,
                                                        color: ColorManager.bluebottom,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: (){
                                                          showDialog(context: context,
                                                              builder: (context) => StatefulBuilder(
                                                                builder: (BuildContext context, void Function(void Function()) setState) {
                                                                  return  DeletePopup(
                                                                      title: 'Delete ADR',
                                                                      loadingDuration: _isLoading,
                                                                      onCancel: (){
                                                                        Navigator.pop(context);
                                                                      }, onDelete: () async{
                                                                    setState(() {
                                                                      _isLoading = true;
                                                                    });
                                                                    try {
                                                                      await deleteManageCorporate(
                                                                          context,
                                                                          manageCCADR.docId);
                                                                      setState(() async {
                                                                        await  getManageCorporate(context, widget.officeId, widget.docId, widget.subDocId, 1, 20).then((data) {
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
                              }),
                        ),
                        // Pagination Controls
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
                  return Offstage();
                }
            ),
          ),
        ],),
    );
  }
}
