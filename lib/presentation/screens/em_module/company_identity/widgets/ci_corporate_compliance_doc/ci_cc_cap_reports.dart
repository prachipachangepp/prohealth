import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/base64/download_file_base64.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/manage_history_version.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';

import '../../../../../../app/constants/app_config.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../upload_edit_popup.dart';

class CICCCAPReports extends StatefulWidget {
  final int docId;
  final int subDocId;
  final String officeId;
  const CICCCAPReports(
      {super.key,
      required this.docId,
      required this.subDocId,
      required this.officeId});

  @override
  State<CICCCAPReports> createState() => _CICCCAPReportsState();
}

class _CICCCAPReportsState extends State<CICCCAPReports> {
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int docTypeMetaIdCCCap = AppConfig.subDocId4CapReport;
  final StreamController<List<MCorporateComplianceModal>> _ccCapController =
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
            height: AppSize.s5,
          ),
          Expanded(
            child: StreamBuilder<List<MCorporateComplianceModal>>(
                // future:
                // getListMCorporateCompliancefetch(context,
                //     AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 20
                // ),
                stream: _ccCapController.stream,
                builder: (context, snapshot) {
                  getListMCorporateCompliancefetch(
                          context,
                          AppConfig.corporateAndCompliance,
                          AppConfig.subDocId4CapReport,
                          1,
                          20)
                      .then((data) {
                    _ccCapController.add(data);
                  }).catchError((error) {
                    // Handle error
                  });
                  // StreamBuilder<List<ManageCCDoc>>(
                  //     stream : _ccCapController.stream,
                  //     builder: (context, snapshot) {
                  //       getManageCorporate(context, widget.officeId, widget.docId, widget.subDocId, 1, 20).then((data) {
                  //         _ccCapController.add(data);
                  //       }).catchError((error) {
                  //         // Handle error
                  //       });
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
                        ErrorMessageString.noCR,
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
                                MCorporateComplianceModal CapReports =
                                    paginatedData[index];
                                var ccCapReport = snapshot.data![index];
                                var fileUrl = ccCapReport.docurl;
                                final fileExtension = fileUrl.split('/').last;

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
                                          height: AppSize.s50,
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
                                                    //     height: AppSize.s15,
                                                    //     width: AppSize.s22,
                                                    //   ),
                                                    // ),
                                                    //IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye_outlined,size:20,color: ColorManager.blueprime,)),
                                                    SizedBox(
                                                        width: AppSize.s50),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "ID : ${CapReports.orgDocumentSetupid.toString()}",
                                                          //CapReports.doccreatedAt.toString(),textAlign:TextAlign.center,
                                                          style: GoogleFonts
                                                              .firaSans(
                                                            fontSize:
                                                                FontSize.s10,
                                                            fontWeight:
                                                                FontWeightManager
                                                                    .regular,
                                                            color: ColorManager
                                                                .granitegray,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                          ),
                                                        ),
                                                        Text(
                                                          CapReports.docName
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .firaSans(
                                                            fontSize:
                                                                FontSize.s10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: ColorManager
                                                                .granitegray,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                          ),
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
                                                            docHistory:
                                                                CapReports
                                                                    .docHistory,
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.history,
                                                        size: 18,
                                                        color: ColorManager
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
                                                                "Cap Report.pdf");
                                                        downloadFile(fileUrl);
                                                      },
                                                      icon: Icon(
                                                          Icons
                                                              .save_alt_outlined,
                                                          size: 18,
                                                          color: ColorManager
                                                              .blueprime),
                                                      splashColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                    ),

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
                                                                  CapReports
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
                                                                          'Edit CAP Reports',
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
                                                      icon: Icon(
                                                        Icons.edit_outlined,
                                                        size: 18,
                                                        color: ColorManager
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
                                                                              'Delete license',
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
                                                                                orgDocId: CapReports.orgOfficeDocumentId,
                                                                              );
                                                                              // await deleteManageCorporate(context, manageCCLicence.docId);
                                                                              setState(() async {
                                                                                await getListMCorporateCompliancefetch(context, AppConfig.corporateAndCompliance, AppConfig.subDocId4CapReport, 1, 20).then((data) {
                                                                                  _ccCapController.add(data);
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
                                                        icon: Icon(
                                                          Icons.delete_outline,
                                                          size: 18,
                                                          color:
                                                              ColorManager.red,
                                                        )),
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
          // SizedBox(
          //   height: 10,
          // ),
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
      ),
    );
  }
}

