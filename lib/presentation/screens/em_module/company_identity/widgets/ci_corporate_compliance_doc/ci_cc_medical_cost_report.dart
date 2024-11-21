import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/manage_history_version.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import '../../../../../../app/constants/app_config.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../upload_edit_popup.dart';

class CICCMedicalCR extends StatefulWidget {
  final int docId;
  final int subDocId;
  final String officeId;
  const CICCMedicalCR(
      {super.key,
      required this.docId,
      required this.subDocId,
      required this.officeId});

  @override
  State<CICCMedicalCR> createState() => _CICCMedicalCRState();
}

class _CICCMedicalCRState extends State<CICCMedicalCR> {
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int docTypeMetaIdCCMCR = AppConfig.subDocId3CICCMedicalCR;
  final StreamController<List<MCorporateComplianceModal>> _ccMedicalController =
      StreamController<List<MCorporateComplianceModal>>();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
      StreamController<List<IdentityDocumentIdData>>.broadcast();

  String? selectedValue;
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
                stream: _ccMedicalController.stream,
                builder: (context, snapshot) {
                  getListMCorporateCompliancefetch(context, AppConfig.corporateAndCompliance, widget.officeId, AppConfig.subDocId3CICCMedicalCR, 1, 20)
                      .then((data) {
                    _ccMedicalController.add(data);
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
                        ErrorMessageString.noMCR,
                        style: AllNoDataAvailable.customTextStyle(context)
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    int totalItems = snapshot.data!.length;
                    int totalPages = (totalItems / itemsPerPage).ceil();
                    List<MCorporateComplianceModal> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: paginatedData.length,
                              itemBuilder: (context, index) {
                                var ccMCR = snapshot.data![index];
                                var fileUrl = ccMCR.docurl;
                                final fileExtension = fileUrl.split('/').last;
                                int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                                String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                                MCorporateComplianceModal MedicalCostReport = paginatedData[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                          height: AppSize.s50,
                                          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(children: [
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
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "ID : ${MedicalCostReport.idOfDocument}",
                                                          style:  TableSubHeading.customTextStyle(context),
                                                        ),
                                                        Text(
                                                          MedicalCostReport.fileName.toString(),
                                                          textAlign: TextAlign.center,
                                                          style:  TableSubHeading.customTextStyle(context),
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
                                                            docHistory: MedicalCostReport.docHistory,
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.history,
                                                        size: IconSize.I18,
                                                        color: IconColorManager.bluebottom,
                                                      ),
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                    ),
                                                    ///print
                                                    IconButton(
                                                      onPressed: () {
                                                        print("FileExtension:${fileExtension}");
                                                        downloadFile(fileUrl);
                                                      },
                                                      icon: Icon(
                                                        Icons.print_outlined,
                                                        size:IconSize.I18,color: IconColorManager.bluebottom,
                                                      ),
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                    ),
                                                    ///download saloni
                                                    PdfDownloadButton(apiUrl: MedicalCostReport.docurl, documentName: MedicalCostReport.docName!),

                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return FutureBuilder<
                                                                MCorporateCompliancePreFillModal>(
                                                              future: getPrefillNewOrgOfficeDocument(context, MedicalCostReport.orgOfficeDocumentId),
                                                              builder: (context, snapshotPrefill) {
                                                                if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                                                  return Center(
                                                                    child: CircularProgressIndicator(
                                                                      color: ColorManager.blueprime,
                                                                    ),
                                                                  );
                                                                }
                                                                return StatefulBuilder(
                                                                  builder: (BuildContext context,
                                                                      void Function(void Function())setState) {
                                                                    return VCScreenPopupEditConst(
                                                                      fileName: snapshotPrefill.data!.fileName,
                                                                      url: snapshotPrefill.data!.url,
                                                                      expiryDate: snapshotPrefill.data!.expiry_date,
                                                                      title: EditPopupString.editMCR,
                                                                      loadingDuration: _isLoading,
                                                                      officeId: widget.officeId,
                                                                      docTypeMetaIdCC: widget.docId,
                                                                      selectedSubDocId: widget.subDocId,
                                                                      orgDocId: snapshotPrefill.data!.orgOfficeDocumentId,
                                                                      orgDocumentSetupid: snapshotPrefill.data!.documentSetupId,
                                                                      docName: snapshotPrefill.data!.docName,
                                                                      selectedExpiryType: snapshotPrefill.data!.expType,
                                                                      documentType: AppStringEM.corporateAndComplianceDocuments,
                                                                      documentSubType: AppStringEM.mcr,
                                                                      isOthersDocs: snapshotPrefill.data!.isOthersDocs,
                                                                      idOfDoc: snapshotPrefill.data!.idOfDocument,
                                                                      expiryType: snapshotPrefill.data!.expType,
                                                                      threshhold: snapshotPrefill.data!.threshould,
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
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                    ),

                                                    IconButton(
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  StatefulBuilder(
                                                                    builder: (BuildContext context,
                                                                        void Function(void Function())setState) {
                                                                      return DeletePopup(
                                                                          title: DeletePopupString.deleteMCR ,
                                                                          loadingDuration: _isLoading,
                                                                          onCancel: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          onDelete: () async {
                                                                            setState(() {
                                                                              _isLoading = true;
                                                                            });
                                                                            try {
                                                                              await deleteOrgDoc(
                                                                                context: context,
                                                                                orgDocId: MedicalCostReport.orgOfficeDocumentId,
                                                                              );
                                                                              setState(() async {
                                                                                await getListMCorporateCompliancefetch(context, AppConfig.corporateAndCompliance, widget.officeId, AppConfig.subDocId3CICCMedicalCR, 1, 20).then((data) {
                                                                                  _ccMedicalController.add(data);
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
                                                        icon: Icon(Icons.delete_outline,size:IconSize.I18,color: IconColorManager.red,)),
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