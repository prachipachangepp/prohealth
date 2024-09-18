import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/newpopup_manager.dart';
import 'package:prohealth/app/services/base64/download_file_base64.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/manage_history_version.dart';

import '../../../../../../app/constants/app_config.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../hr_module/onboarding/download_doc_const.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../upload_edit_popup.dart';

class CICCLicense extends StatefulWidget {
  final int docId;
  final int subDocId;
  final String officeId;
  const CICCLicense(
      {super.key,
      required this.docId,
      required this.subDocId,
      required this.officeId});

  @override
  State<CICCLicense> createState() => _CICCLicenseState();
}

class _CICCLicenseState extends State<CICCLicense> {
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int docTypeMetaIdCCL = AppConfig.subDocId1Licenses;
  final StreamController<List<MCorporateComplianceModal>> lisenceController =
      StreamController<List<MCorporateComplianceModal>>();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
      StreamController<List<IdentityDocumentIdData>>.broadcast();

  String? selectedValue;
  //int docTypeMetaId =0;
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

  @override
  void initState() {
    getListMCorporateCompliancefetch(context, AppConfig.corporateAndCompliance,
            AppConfig.subDocId1Licenses, 1, 20)
        .then((data) {
      lisenceController.add(data);
    }).catchError((error) {
      // Handle error
    });
    print("prachi:::::: ${widget.officeId}");
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
                stream: lisenceController.stream,
                builder: (context, snapshot) {
                  getListMCorporateCompliancefetch(
                          context,
                          AppConfig.corporateAndCompliance,
                          AppConfig.subDocId1Licenses,
                          1,
                          20)
                      .then((data) {
                    lisenceController.add(data);
                  }).catchError((error) {});
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
                        ErrorMessageString.noLicenses,
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
                                var cclicenses = snapshot.data![index];
                                var fileUrl = cclicenses.docurl;
                                final fileExtension = fileUrl.split('/').last;

                                int serialNumber = index +
                                    1 +
                                    (currentPage - 1) * itemsPerPage;
                                String formattedSerialNumber =
                                    serialNumber.toString().padLeft(2, '0');
                                MCorporateComplianceModal manageCCLicence =
                                    paginatedData[index];


                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 5),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorManager.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorManager.black
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
                                                    //   onTap: () {},
                                                    //   child: Image.asset(
                                                    //     'images/eye.png',
                                                    //     height: AppSize.s15,
                                                    //     width: AppSize.s22,
                                                    //   ),
                                                    // ),
                                                    //IconButton(onPressed: (){},
                                                    // icon: Icon(Icons.remove_red_eye_outlined,
                                                    // size:20,color: ColorManager.blueprime,)),
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
                                                          // "ID : ${manageCCLicence.idOfDoc.toString()}",
                                                          "ID : ${manageCCLicence.idOfDocument.toString()}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:  DocumentTypeDataStyle.customTextStyle(context),
                                                        ),
                                                        Text(
                                                          // manageCCLicence.docname.toString(),
                                                          manageCCLicence
                                                              .docName
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
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
                                                            docHistory:
                                                                manageCCLicence
                                                                    .docHistory,
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
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
                                                        DowloadFile()
                                                            .downloadPdfFromBase64(
                                                                fileExtension,
                                                                "Licenses.pdf");
                                                        downloadFile(fileUrl);
                                                      },
                                                      icon: Icon(
                                                          Icons
                                                              .save_alt_outlined,
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
                                                                  manageCCLicence
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
                                                                      title:
                                                                          EditPopupString.editLicenses,
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
                                                                      expiryDate: snapshotPrefill
                                                                          .data!
                                                                          .expiry_date,
                                                                      url: snapshotPrefill
                                                                          .data!
                                                                          .url,
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon:  Icon(Icons.edit_outlined,
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
                                                                          DeletePopupString.deleteLicenses,
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
                                                                                orgDocId: manageCCLicence.orgOfficeDocumentId,
                                                                              );
                                                                              // await deleteManageCorporate(context, manageCCLicence.docId);
                                                                              setState(() async {
                                                                                await getListMCorporateCompliancefetch(context, AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 20).then((data) {
                                                                                  lisenceController.add(data);
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
                                                          size: IconSize.I18,
                                                          color:
                                                          IconColorManager.red,
                                                        ),
                                                    ),
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
