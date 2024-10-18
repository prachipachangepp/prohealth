import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/manage_history_version.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';

import '../../../../../../app/constants/app_config.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../../app/services/base64/download_file_base64.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../../../hr_module/onboarding/download_doc_const.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../upload_edit_popup.dart';

class CiDme extends StatefulWidget {
  final int docId;
  final int subDocId;
  final int companyID;
  final String officeId;
  const CiDme(
      {super.key,
      required this.companyID,
      required this.officeId,
      required this.docId,
      required this.subDocId});

  @override
  State<CiDme> createState() => _CiDmeState();
}

class _CiDmeState extends State<CiDme> {
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  int docTypeMetaIdVC = AppConfig.vendorContracts;
  int docTypeMetaIdVCdme = AppConfig.subDocId8DME;
  final StreamController<List<MCorporateComplianceModal>> vendorDMEController =
      StreamController<List<MCorporateComplianceModal>>();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
      StreamController<List<IdentityDocumentIdData>>.broadcast();

  String? selectedValue;
  late List<Color> hrcontainerColors;
  int docTypeMetaId = 0;
  int docSubTypeMetaId = 0;
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

  int docTypeId = 0;
  String? documentTypeName;
  dynamic filePath;
  String? selectedDocType;
  String fileName = '';
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
        print('File path ${filePath}');
        print('File name ${fileName}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: StreamBuilder<List<MCorporateComplianceModal>>(
                // future:
                // getListMCorporateCompliancefetch(context,
                //     AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 20
                // ),
                stream: vendorDMEController.stream,
                builder: (context, snapshot) {
                  getListMCorporateCompliancefetch(
                          context,
                          AppConfig.vendorContracts, widget.officeId,
                          AppConfig.subDocId8DME,
                          1,
                          20)
                      .then((data) {
                    vendorDMEController.add(data);
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
                        ErrorMessageString.noDME,
                        style: CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: FontSize.s14,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    int totalItems = snapshot.data!.length;
                    int totalPages = (totalItems / itemsPerPage).ceil();
                    List<MCorporateComplianceModal> paginatedData = snapshot
                        .data!
                        .skip((currentPage - 1) * itemsPerPage)
                        .take(itemsPerPage)
                        .toList();

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: paginatedData.length,
                              itemBuilder: (context, index) {
                                int serialNumber = index +
                                    1 +
                                    (currentPage - 1) * itemsPerPage;
                                String formattedSerialNumber =
                                    serialNumber.toString().padLeft(2, '0');
                                var vcDME = snapshot.data![index];
                                var fileUrl = vcDME.docurl;
                                final fileExtension = fileUrl.split('/').last;

                                MCorporateComplianceModal dmeData =
                                    paginatedData[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.25),
                                                spreadRadius: 0,
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    // InkWell(
                                                    //   onTap: () {
                                                    //   },
                                                    //   child: Image.asset(
                                                    //     'images/eye.png',
                                                    //     height: 15,
                                                    //     width: 22,
                                                    //   ),
                                                    // ),
                                                    //IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye_outlined,size:20,color: ColorManager.blueprime,)),
                                                    SizedBox(width: AppSize.s10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "ID : ${dmeData.idOfDocument}",
                                                          //dmeData.doccreatedAt.toString(),textAlign:TextAlign.center,
                                                          // style: GoogleFonts
                                                          //     .firaSans(
                                                          //   fontSize: 10,
                                                          //   fontWeight:
                                                          //       FontWeight.w400,
                                                          //   color: Color(
                                                          //       0xff686464),
                                                          //   decoration:
                                                          //       TextDecoration
                                                          //           .none,
                                                          // ),
                                                          style:  DocumentTypeDataStyle.customTextStyle(context),
                                                        ),
                                                        Text(
                                                          dmeData.docName
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          // style: GoogleFonts
                                                          //     .firaSans(
                                                          //   fontSize: 10,
                                                          //   fontWeight:
                                                          //       FontWeight.bold,
                                                          //   color: Color(
                                                          //       0xff686464),
                                                          //   decoration:
                                                          //       TextDecoration
                                                          //           .none,
                                                          // ),
                                                          style:  DocumentTypeDataStyle.customTextStyle(context),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              ManageHistoryPopup(
                                                            docHistory: dmeData
                                                                .docHistory,
                                                          ),
                                                        );
                                                      },
                                                      icon:  Icon(
                                                        Icons.history,
                                                        size: IconSize.I18,
                                                        color: IconColorManager
                                                            .bluebottom,
                                                      ),
                                                      splashColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        print(
                                                            "FileExtension:${fileExtension}");
                                                        DowloadFile()
                                                            .downloadPdfFromBase64(
                                                                fileExtension,
                                                                "DME.pdf");
                                                        downloadFile(fileUrl);
                                                      },
                                                      icon:  Icon(
                                                          Icons
                                                              .print_outlined,
                                                          size: IconSize.I18,
                                                          color: IconColorManager
                                                              .bluebottom),
                                                      splashColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                    ),
                                                    PdfDownloadButton(apiUrl: dmeData.docurl,
                                                        documentName: dmeData.docName!),

                                                    IconButton(
                                                      onPressed: () {
                                                        String?
                                                            selectedExpiryType =
                                                            expiryType;
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return FutureBuilder<
                                                                MCorporateCompliancePreFillModal>(
                                                              future: getPrefillNewOrgOfficeDocument(
                                                                  context,
                                                                  dmeData
                                                                      .orgOfficeDocumentId),
                                                              builder: (context,
                                                                  snapshotPrefill) {
                                                                if (snapshotPrefill
                                                                        .connectionState ==
                                                                    ConnectionState
                                                                        .waiting) {
                                                                  return Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: ColorManager
                                                                          .blueprime,
                                                                    ),
                                                                  );
                                                                }

                                                                var calender =
                                                                    snapshotPrefill
                                                                        .data!
                                                                        .expiry_date;
                                                                calenderController =
                                                                    TextEditingController(
                                                                  text: snapshotPrefill
                                                                      .data!
                                                                      .expiry_date,
                                                                );

                                                                // fileName = snapshotPrefill.data!.url;

                                                                return StatefulBuilder(
                                                                  builder: (BuildContext
                                                                          context,
                                                                      void Function(
                                                                              void Function())
                                                                          setState) {
                                                                    return VCScreenPopupEditConst(
                                                                      url: snapshotPrefill
                                                                          .data!
                                                                          .url,
                                                                      expiryDate: snapshotPrefill
                                                                          .data!
                                                                          .expiry_date,
                                                                      title:
                                                                      EditPopupString.editDME ,
                                                                      loadingDuration:
                                                                          _isLoading,
                                                                      officeId:
                                                                          widget
                                                                              .officeId,
                                                                      docTypeMetaIdCC:
                                                                          widget
                                                                              .docId,
                                                                      selectedSubDocId:
                                                                          widget
                                                                              .subDocId,
                                                                      //orgDocId: manageCCADR.orgOfficeDocumentId,
                                                                      orgDocId: snapshotPrefill
                                                                          .data!
                                                                          .orgOfficeDocumentId,
                                                                      orgDocumentSetupid: snapshotPrefill
                                                                          .data!
                                                                          .documentSetupId,
                                                                      docName: snapshotPrefill
                                                                          .data!
                                                                          .docName,
                                                                      selectedExpiryType: snapshotPrefill
                                                                          .data!
                                                                          .expType,
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(Icons.edit_outlined,
                                                        size:IconSize.I18,color: IconColorManager.bluebottom,),
                                                      splashColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                    ),

                                                    IconButton(
                                                        splashColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  StatefulBuilder(
                                                                    builder: (BuildContext
                                                                            context,
                                                                        void Function(void Function())
                                                                            setState) {
                                                                      return DeletePopup(
                                                                          title:
                                                                          DeletePopupString.deleteDME  ,
                                                                          loadingDuration:
                                                                              _isLoading,
                                                                          onCancel:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          onDelete:
                                                                              () async {
                                                                            setState(() {
                                                                              _isLoading = true;
                                                                            });
                                                                            try {
                                                                              await deleteOrgDoc(
                                                                                context: context,
                                                                                orgDocId: dmeData.orgOfficeDocumentId,
                                                                              );
                                                                              // await deleteManageCorporate(context, manageCCLicence.docId);
                                                                              setState(() async {
                                                                                getListMCorporateCompliancefetch(context, AppConfig.vendorContracts, widget.officeId, AppConfig.subDocId8DME, 1, 20).then((data) {
                                                                                  vendorDMEController.add(data);
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
                                                        },
                                                        icon:  Icon(
                                                          Icons.delete_outline,
                                                          size:IconSize.I18,color: IconColorManager.red,
                                                        )),

                                                    // IconButton(
                                                    //   onPressed: () {
                                                    //     String? selectedExpiryType = expiryType;
                                                    //     showDialog(
                                                    //       context: context,
                                                    //       builder: (context) {
                                                    //         return FutureBuilder<CorporatePrefillCCVVPP>(
                                                    //           future: getManageCCPrefill(context, dmeData.docId),
                                                    //           builder: (context,
                                                    //               snapshotPrefill) {
                                                    //             if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                                    //               return Center(
                                                    //                 child: CircularProgressIndicator(
                                                    //                   color: ColorManager.blueprime,
                                                    //                 ),
                                                    //               );
                                                    //             }
                                                    //
                                                    //             // Prefill values from API
                                                    //             var documentPreId = snapshotPrefill.data!.documentId;
                                                    //             docIdController = TextEditingController(text: snapshotPrefill.data!.documentId.toString(),
                                                    //             );
                                                    //
                                                    //             // var documentTypePreId = snapshotPrefill.data!.documentTypeId;
                                                    //             // docTypeMetaId = documentTypePreId;
                                                    //
                                                    //             var documentSubPreId = snapshotPrefill.data!.documentSubTypeId;
                                                    //             docSubTypeMetaId = documentSubPreId;
                                                    //
                                                    //             var name = snapshotPrefill.data!.docName;
                                                    //             docNameController = TextEditingController(
                                                    //               text: snapshotPrefill.data!.docName,
                                                    //             );
                                                    //
                                                    //             var calender = snapshotPrefill.data!.expiryDate;
                                                    //             calenderController = TextEditingController(
                                                    //               text: snapshotPrefill.data!.expiryDate,
                                                    //             );
                                                    //
                                                    //             var expiry = snapshotPrefill.data!.expiryType;
                                                    //             expiryType = expiry;
                                                    //             var idOfDoc = snapshotPrefill.data!.idOfDoc;
                                                    //             idOfDocController = TextEditingController(text: snapshotPrefill.data!.idOfDoc.toString());
                                                    //
                                                    //             return StatefulBuilder(
                                                    //               builder: (BuildContextcontext,
                                                    //                   void Function(void Function())setState) {
                                                    //                 return CCScreenEditPopup(
                                                    //                   title: 'Edit DME',
                                                    //                   // id: documentPreId,
                                                    //                   idOfDocController: idOfDocController,
                                                    //                   nameDocController: docNameController,
                                                    //                   loadingDuration: _isLoading,
                                                    //                   onSavePressed: () async {
                                                    //                     setState(() {
                                                    //                       _isLoading = true;
                                                    //                     });
                                                    //                     try {
                                                    //                       String expiryTypeToSend = selectedExpiryType == "Not Applicable"
                                                    //                           ? "Not Applicable"
                                                    //                           : calenderController.text;
                                                    //                       await updateManageCCVVPP(
                                                    //                           context: context,
                                                    //                           docId: documentPreId,
                                                    //                           name: name == docNameController.text ? name.toString() : docNameController.text,
                                                    //                           docTypeID: AppConfig.vendorContracts,// documentTypePreId == docTypeMetaId ? documentTypePreId : docTypeMetaId,
                                                    //                           docSubTypeID: documentSubPreId == docSubTypeMetaId ? documentSubPreId : docSubTypeMetaId,
                                                    //                           docCreated: DateTime.now().toString(),
                                                    //                           url: "url",
                                                    //                           expiryType: selectedExpiryType ?? expiryType.toString(),
                                                    //                           expiryDate: expiryTypeToSend,//calender == calenderController.text ? calender.toString() : calenderController.text,
                                                    //                           expiryReminder: selectedExpiryType ?? expiryType.toString(),
                                                    //                           officeId: widget.officeId,
                                                    //                           idOfDoc: snapshotPrefill.data!.idOfDoc
                                                    //                       );
                                                    //                     } finally {
                                                    //                       setState(
                                                    //                               () {
                                                    //                             _isLoading =
                                                    //                             false;
                                                    //                           });
                                                    //                       Navigator.pop(
                                                    //                           context);
                                                    //                     }
                                                    //                   },
                                                    //                   child:FutureBuilder<List<DocumentTypeData>>(
                                                    //                     future: documentTypeGet(context),
                                                    //                     builder: (context, snapshot) {
                                                    //                       if (snapshot.connectionState == ConnectionState.waiting) {
                                                    //                         return Container(
                                                    //                           width: 300,
                                                    //                           child: Text(
                                                    //                             'Loading...',
                                                    //                             style: CustomTextStylesCommon.commonStyle(
                                                    //                               fontWeight: FontWeightManager.medium,
                                                    //                               fontSize: FontSize.s12,
                                                    //                               color: ColorManager.mediumgrey,
                                                    //                             ),
                                                    //                           ),
                                                    //                         );
                                                    //                       }
                                                    //                       if (snapshot.data!.isEmpty) {
                                                    //                         return Center(
                                                    //                           child: Text(
                                                    //                             AppString.dataNotFound,
                                                    //                             style: CustomTextStylesCommon.commonStyle(
                                                    //                               fontWeight: FontWeightManager.medium,
                                                    //                               fontSize: FontSize.s12,
                                                    //                               color: ColorManager.mediumgrey,
                                                    //                             ),
                                                    //                           ),
                                                    //                         );
                                                    //                       }
                                                    //                       if (snapshot.hasData) {
                                                    //                         String selectedDocType = "";
                                                    //                         int docType = snapshot.data![0].docID;
                                                    //
                                                    //                         for (var i in snapshot.data!) {
                                                    //                           if (i.docID == AppConfig.vendorContracts) {
                                                    //                             selectedDocType = i.docType;
                                                    //                             docType = i.docID;
                                                    //                             break;
                                                    //                           }
                                                    //                         }
                                                    //
                                                    //                         docTypeMetaIdVC = docType;
                                                    //
                                                    //                         identityDocumentTypeGet(context, docTypeMetaIdVC).then((data) {
                                                    //                           _identityDataController.add(data);
                                                    //                         }).catchError((error) {
                                                    //                           // Handle error
                                                    //                         });
                                                    //                         return Container(
                                                    //                           width: 354,
                                                    //                           padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                                    //                           decoration: BoxDecoration(
                                                    //                             color: ColorManager.white,
                                                    //                             borderRadius: BorderRadius.circular(8),
                                                    //                             border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                                    //                           ),
                                                    //                           child: Row(
                                                    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    //                             children: [
                                                    //                               Text(
                                                    //                                 selectedDocType,
                                                    //                                 style: CustomTextStylesCommon.commonStyle(
                                                    //                                   fontWeight: FontWeightManager.medium,
                                                    //                                   fontSize: FontSize.s12,
                                                    //                                   color: ColorManager.mediumgrey,
                                                    //                                 ),
                                                    //                               ),
                                                    //                               Icon(
                                                    //                                 Icons.arrow_drop_down,
                                                    //                                 color: Colors.transparent,
                                                    //                               ),
                                                    //                             ],
                                                    //                           ),
                                                    //                         );
                                                    //                       } else {
                                                    //                         return SizedBox();
                                                    //                       }
                                                    //                     },
                                                    //                   ),
                                                    //                   // Sub-Document Type Dropdown
                                                    //                   child1: FutureBuilder<List<DocumentTypeData>>(
                                                    //                     future: documentTypeGet(context),
                                                    //                     builder: (context, snapshot) {
                                                    //                       if (snapshot.connectionState == ConnectionState.waiting) {
                                                    //                         return Container(
                                                    //                           width: 300,
                                                    //                           child: Text(
                                                    //                             'Loading...',
                                                    //                             style: CustomTextStylesCommon.commonStyle(
                                                    //                               fontWeight: FontWeightManager.medium,
                                                    //                               fontSize: FontSize.s12,
                                                    //                               color: ColorManager.mediumgrey,
                                                    //                             ),
                                                    //                           ),
                                                    //                         );
                                                    //                       }
                                                    //                       if (snapshot.data!.isEmpty) {
                                                    //                         return Center(
                                                    //                           child: Text(
                                                    //                             AppString.dataNotFound,
                                                    //                             style: CustomTextStylesCommon.commonStyle(
                                                    //                               fontWeight: FontWeightManager.medium,
                                                    //                               fontSize: FontSize.s12,
                                                    //                               color: ColorManager.mediumgrey,
                                                    //                             ),
                                                    //                           ),
                                                    //                         );
                                                    //                       }
                                                    //                       if (snapshot.hasData) {
                                                    //                         String selectedDocType = "DME";
                                                    //                         int docType = snapshot.data![0].docID;
                                                    //
                                                    //                         for (var i in snapshot.data!) {
                                                    //                           if (i.docID == AppConfig.subDocId8DME) {
                                                    //                             selectedDocType = i.docType;
                                                    //                             docType = i.docID;
                                                    //                             break;
                                                    //                           }
                                                    //                         }
                                                    //
                                                    //                         docTypeMetaIdVCdme = docType;
                                                    //
                                                    //                         identityDocumentTypeGet(context, docTypeMetaIdVC).then((data) {
                                                    //                           _identityDataController.add(data);
                                                    //                         }).catchError((error) {
                                                    //                           // Handle error
                                                    //                         });
                                                    //                         return Container(
                                                    //                           width: 354,
                                                    //                           padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                                    //                           decoration: BoxDecoration(
                                                    //                             color: ColorManager.white,
                                                    //                             borderRadius: BorderRadius.circular(8),
                                                    //                             border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                                    //                           ),
                                                    //                           child: Row(
                                                    //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    //                             children: [
                                                    //                               Text(
                                                    //                                 selectedDocType,
                                                    //                                 style: CustomTextStylesCommon.commonStyle(
                                                    //                                   fontWeight: FontWeightManager.medium,
                                                    //                                   fontSize: FontSize.s12,
                                                    //                                   color: ColorManager.mediumgrey,
                                                    //                                 ),
                                                    //                               ),
                                                    //                               Icon(
                                                    //                                 Icons.arrow_drop_down,
                                                    //                                 color: Colors.transparent,
                                                    //                               ),
                                                    //                             ],
                                                    //                           ),
                                                    //                         );
                                                    //                       } else {
                                                    //                         return SizedBox();
                                                    //                       }
                                                    //                     },
                                                    //                   ),
                                                    //                   radioButton: Padding(padding: const EdgeInsets.only(left: 10.0),
                                                    //                     child: Column(
                                                    //                       mainAxisAlignment: MainAxisAlignment.start,
                                                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                    //                       children: [
                                                    //                         Text(
                                                    //                           "Expiry Type",
                                                    //                           style: GoogleFonts.firaSans(
                                                    //                             fontSize: FontSize.s12,
                                                    //                             fontWeight: FontWeight.w700,
                                                    //                             color: ColorManager.mediumgrey,
                                                    //                             decoration: TextDecoration.none,
                                                    //                           ),
                                                    //                         ),
                                                    //                         CustomRadioListTile(
                                                    //                           value: "Not Applicable",
                                                    //                           groupValue: selectedExpiryType,
                                                    //                           onChanged: (value) {
                                                    //                             setState(() {
                                                    //                               selectedExpiryType = value;
                                                    //                             });
                                                    //                           },
                                                    //                           title: "Not Applicable",
                                                    //                         ),
                                                    //                         CustomRadioListTile(
                                                    //                           value: 'Scheduled',
                                                    //                           groupValue: selectedExpiryType,
                                                    //                           onChanged: (value) {
                                                    //                             setState(() {
                                                    //                               selectedExpiryType = value;
                                                    //                             });
                                                    //                           },
                                                    //                           title: 'Scheduled',
                                                    //                         ),
                                                    //                         CustomRadioListTile(
                                                    //                           value: 'Issuer Expiry',
                                                    //                           groupValue: selectedExpiryType,
                                                    //                           onChanged: (value) {
                                                    //                             setState(() {
                                                    //                               selectedExpiryType = value;
                                                    //                             });
                                                    //                           },
                                                    //                           title: 'Issuer Expiry',
                                                    //                         ),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                   child2: Visibility(
                                                    //                     visible: selectedExpiryType == "Scheduled" || selectedExpiryType == "Issuer Expiry",
                                                    //                     child: Column(
                                                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                    //                       children: [
                                                    //                         Padding(
                                                    //                           padding: const EdgeInsets.only(left: 2),
                                                    //                           child: Text(
                                                    //                             "Expiry Date",
                                                    //                             style: GoogleFonts.firaSans(
                                                    //                               fontSize: FontSize.s12,
                                                    //                               fontWeight: FontWeight.w700,
                                                    //                               color: ColorManager.mediumgrey,
                                                    //                               decoration: TextDecoration.none,
                                                    //                             ),
                                                    //                           ),
                                                    //                         ),
                                                    //                         SizedBox(height: 5,),
                                                    //                         FormField<String>(
                                                    //                           builder: (FormFieldState<String> field) {
                                                    //                             return SizedBox(
                                                    //                               width: 354,
                                                    //                               height: 30,
                                                    //                               child: TextFormField(
                                                    //                                 controller: calenderController,
                                                    //                                 cursorColor: ColorManager.black,
                                                    //                                 style: GoogleFonts.firaSans(
                                                    //                                   fontSize: FontSize.s12,
                                                    //                                   fontWeight: FontWeight.w700,
                                                    //                                   color: ColorManager.mediumgrey,
                                                    //                                   //decoration: TextDecoration.none,
                                                    //                                 ),
                                                    //                                 decoration: InputDecoration(
                                                    //                                   enabledBorder: OutlineInputBorder(
                                                    //                                     borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                                    //                                     borderRadius: BorderRadius.circular(8),
                                                    //                                   ),
                                                    //                                   focusedBorder: OutlineInputBorder(
                                                    //                                     borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                                    //                                     borderRadius: BorderRadius.circular(8),
                                                    //                                   ),
                                                    //                                   hintText: 'mm-dd-yyyy',
                                                    //                                   hintStyle: GoogleFonts.firaSans(
                                                    //                                     fontSize: FontSize.s12,
                                                    //                                     fontWeight: FontWeight.w700,
                                                    //                                     color: ColorManager.mediumgrey,
                                                    //                                     //decoration: TextDecoration.none,
                                                    //                                   ),
                                                    //                                   border: OutlineInputBorder(
                                                    //                                     borderRadius: BorderRadius.circular(8),
                                                    //                                     borderSide: BorderSide(width: 1, color: ColorManager.fmediumgrey),
                                                    //                                   ),
                                                    //                                   contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                                    //                                   suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
                                                    //                                   errorText: field.errorText,
                                                    //                                 ),
                                                    //                                 onTap: () async {
                                                    //                                   DateTime? pickedDate = await showDatePicker(
                                                    //                                     context: context,
                                                    //                                     initialDate: DateTime.now(),
                                                    //                                     firstDate: DateTime(1901),
                                                    //                                     lastDate: DateTime(3101),
                                                    //                                   );
                                                    //                                   if (pickedDate != null) {
                                                    //                                     calenderController.text = DateFormat('MM-dd-yyyy').format(pickedDate);
                                                    //                                   }
                                                    //                                 },
                                                    //                                 validator: (value) {
                                                    //                                   if (value == null || value.isEmpty) {
                                                    //                                     return 'please select birth date';
                                                    //                                   }
                                                    //                                   return null;
                                                    //                                 },
                                                    //                               ),
                                                    //                             );
                                                    //                           },
                                                    //                         ),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                 );
                                                    //               },
                                                    //             );
                                                    //           },
                                                    //         );
                                                    //       },
                                                    //     );
                                                    //   },
                                                    //   icon: Icon(
                                                    //     Icons.edit_outlined,
                                                    //     size: 18,
                                                    //     color: ColorManager
                                                    //         .bluebottom,
                                                    //   ),
                                                    //   splashColor: Colors.transparent,
                                                    //   highlightColor: Colors.transparent,
                                                    //   hoverColor: Colors.transparent,
                                                    // ),
                                                    // IconButton(
                                                    //     splashColor: Colors.transparent,
                                                    //     highlightColor: Colors.transparent,
                                                    //     hoverColor: Colors.transparent,
                                                    //     onPressed: (){
                                                    //       showDialog(context: context,
                                                    //           builder: (context) => StatefulBuilder(
                                                    //             builder: (BuildContext context, void Function(void Function()) setState) {
                                                    //               return  DeletePopup(
                                                    //                   title: 'Delete DME',
                                                    //                   loadingDuration: _isLoading,
                                                    //                   onCancel: (){
                                                    //                     Navigator.pop(context);
                                                    //                   }, onDelete: () async{
                                                    //                 setState(() {
                                                    //                   _isLoading = true;
                                                    //                 });
                                                    //                 try {
                                                    //                   await deleteManageCorporate(
                                                    //                       context,
                                                    //                       dmeData.docId);
                                                    //                   setState(() async {
                                                    //                     await  getManageCorporate(context, widget.officeId, widget.docId, widget.subDocId, 1, 20).then((data) {
                                                    //                       vendorDMEController.add(data);
                                                    //                     }).catchError((error) {
                                                    //                       // Handle error
                                                    //                     });
                                                    //                     Navigator.pop(context);
                                                    //                   });
                                                    //                 } finally {
                                                    //                   setState(() {
                                                    //                     _isLoading = false;
                                                    //                   });
                                                    //                 }
                                                    //
                                                    //               });
                                                    //             },
                                                    //
                                                    //           ));
                                                    //     }, icon: Icon(Icons.delete_outline,size:18,color: ColorManager.red,)),
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
                        PaginationControlsWidget(
                          currentPage: currentPage,
                          items: snapshot.data!,
                          itemsPerPage: itemsPerPage,
                          onPreviousPagePressed: () {
                            setState(() {
                              currentPage =
                                  currentPage > 1 ? currentPage - 1 : 1;
                            });
                          },
                          onPageNumberPressed: (pageNumber) {
                            setState(() {
                              currentPage = pageNumber;
                            });
                          },
                          onNextPagePressed: () {
                            setState(() {
                              currentPage = currentPage < totalPages
                                  ? currentPage + 1
                                  : totalPages;
                            });
                          },
                        ),
                      ],
                    );
                  }
                  return Offstage();
                }),
          ),
        ],
      ),
    );
  }
}

