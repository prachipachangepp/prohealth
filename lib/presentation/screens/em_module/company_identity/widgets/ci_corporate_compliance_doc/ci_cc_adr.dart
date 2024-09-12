import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/newpopup.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/manage_history_version.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import '../../../../../../app/constants/app_config.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/manage_insurance_manager/manage_corporate_compliance.dart';
import '../../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import '../../../../../../app/services/base64/download_file_base64.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
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
  TextEditingController idOfDocController = TextEditingController();
  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int docTypeMetaIdCCAdr = AppConfig.subDocId2Adr;
  final StreamController<List<MCorporateComplianceModal>> _ccAdrController = StreamController<List<MCorporateComplianceModal>>();
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
            StreamBuilder<List<MCorporateComplianceModal>>(
              // future:
              // getListMCorporateCompliancefetch(context,
              //     AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 20
              // ),
                stream: _ccAdrController.stream,
                builder: (context, snapshot) {
                  getListMCorporateCompliancefetch(context,
                      AppConfig.corporateAndCompliance, AppConfig.subDocId2Adr, 1, 20
                  )
                      .then((data) {
                    _ccAdrController.add(data);
                  }).catchError((error) {
                    // Handle error
                  });
            // StreamBuilder<List<ManageCCDoc>>(
            //     stream : _ccAdrController.stream,
            //     builder: (context, snapshot) {
            //       getManageCorporate(context, widget.officeId, widget.docId, widget.subDocId, 1, 20).then((data) {
            //         _ccAdrController.add(data);
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
                        ErrorMessageString.noADR,
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
                    List<MCorporateComplianceModal> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: paginatedData.length,
                              itemBuilder: (context, index) {
                                int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                                String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                                MCorporateComplianceModal manageCCADR = paginatedData[index];
                                var ccADR = snapshot.data![index];
                                var fileUrl = ccADR.docurl;
                                final fileExtension = fileUrl.split('/').last;
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
                                                    SizedBox(width: AppSize.s50),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "ID : ${ manageCCADR.idOfDocument.toString()}",
                                                         // manageCCADR.doccreatedAt.toString(),textAlign:TextAlign.center,
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: FontSize.s10,
                                                            fontWeight: FontWeightManager.regular,
                                                            color: ColorManager.granitegray,
                                                            decoration: TextDecoration.none,
                                                          ),
                                                        ),
                                                        Text(
                                                          manageCCADR.expiry_date.toString(),textAlign:TextAlign.center,
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
                                                          builder: (context) => ManageHistoryPopup(
                                                            docHistory: manageCCADR.docHistory,
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.history,
                                                        size: 18,
                                                        color: ColorManager.bluebottom,
                                                      ),
                                                      splashColor:
                                                      Colors.transparent,
                                                      highlightColor:
                                                      Colors.transparent,
                                                      hoverColor:
                                                      Colors.transparent,
                                                    ),
                                                    IconButton(onPressed: (){
                                                      print("FileExtension:${fileExtension}");
                                                      DowloadFile().downloadPdfFromBase64(fileExtension,"ADR.pdf");
                                                      downloadFile(fileUrl);
                                                    },
                                                        icon: Icon(Icons.save_alt_outlined,  size: 18,
                                                            color: ColorManager.blueprime
                                                        ),
                                                      splashColor:
                                                      Colors.transparent,
                                                      highlightColor:
                                                      Colors.transparent,
                                                      hoverColor:
                                                      Colors.transparent,),

                                                    IconButton(
                                                      onPressed: () {
                                                        String?selectedExpiryType = expiryType;
                                                        showDialog(
                                                          context: context, builder: (context) {
                                                          return FutureBuilder<MCorporateCompliancePreFillModal>(
                                                            future: getPrefillNewOrgOfficeDocument(context, manageCCADR.orgOfficeDocumentId),
                                                            builder: (context, snapshotPrefill) {
                                                              if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                    color: ColorManager
                                                                        .blueprime,
                                                                  ),
                                                                );
                                                              }

                                                              var calender = snapshotPrefill.data!.expiry_date;
                                                              calenderController = TextEditingController(text: snapshotPrefill.data!.expiry_date,);

                                                              //fileName = snapshotPrefill.data!.url;


                                                              return StatefulBuilder(
                                                                builder: (BuildContext
                                                                context,
                                                                    void Function(void Function())
                                                                    setState) {
                                                                  return VCScreenPopupEditConst(
                                                                    title:
                                                                    'Edit ADR',
                                                                    loadingDuration: _isLoading,
                                                                    onSavePressed:
                                                                        (file) async {
                                                                      setState(() {_isLoading = true;});
                                                                      try {
                                                                        String expiryTypeToSend = selectedExpiryType == "Not Applicable"
                                                                            ? "Not Applicable"
                                                                            : calenderController.text;
                                                                        var response = await updateOrgDoc(context: context,
                                                                          orgDocId: manageCCADR.orgOfficeDocumentId,
                                                                          orgDocumentSetupid: snapshotPrefill.data!.documentSetupId,
                                                                          idOfDocument: '',
                                                                          expiryDate: expiryTypeToSend,
                                                                          docCreatedat: DateTime.now().toIso8601String()+"Z",
                                                                          url: "",
                                                                          officeid: widget.officeId,);

                                                                        if (response.statusCode == 200 || response.statusCode == 201) {
                                                                          await uploadDocumentsoffice(
                                                                              context: context,
                                                                              documentFile: file,
                                                                              orgOfficeDocumentId: response.orgOfficeDocumentId!);
                                                                        }
                                                                      } finally {
                                                                        setState(() {
                                                                          _isLoading = false;
                                                                        });
                                                                        Navigator.pop(context);
                                                                      }
                                                                    },

                                                                    child: Container(
                                                                      width: 354,
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 3, horizontal: 12),
                                                                      decoration: BoxDecoration(
                                                                        color: ColorManager.white,
                                                                        borderRadius: BorderRadius.circular(4),
                                                                        border: Border.all(
                                                                            color: ColorManager.fmediumgrey,
                                                                            width: 1),
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            manageCCADR.docName!,
                                                                            style: CustomTextStylesCommon
                                                                                .commonStyle(
                                                                              fontWeight:
                                                                              FontWeightManager.medium,
                                                                              fontSize: FontSize.s12,
                                                                              color: ColorManager.mediumgrey,
                                                                            ),
                                                                          ),
                                                                          Icon(
                                                                            Icons.arrow_drop_down,
                                                                            color: Colors.transparent,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    // child: FutureBuilder<List<TypeofDocpopup>>(
                                                                    //   future: getTypeofDoc(context, widget.docId, widget.subDocId),
                                                                    //   builder: (context, snapshot) {
                                                                    //     if (snapshot.connectionState ==
                                                                    //         ConnectionState.waiting) {
                                                                    //       return Container(
                                                                    //         width: 350,
                                                                    //         height: 30,
                                                                    //         decoration: BoxDecoration(
                                                                    //           borderRadius: BorderRadius.circular(8),
                                                                    //         ),
                                                                    //       );
                                                                    //     }
                                                                    //     if (snapshot.data!.isEmpty) {
                                                                    //       return Center(
                                                                    //         child: Text(
                                                                    //           AppString.dataNotFound,
                                                                    //           style: CustomTextStylesCommon.commonStyle(
                                                                    //             fontWeight: FontWeightManager.medium,
                                                                    //             fontSize: FontSize.s12,
                                                                    //             color: ColorManager.mediumgrey,
                                                                    //           ),
                                                                    //         ),
                                                                    //       );
                                                                    //     }
                                                                    //     if (snapshot.hasData) {
                                                                    //       List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
                                                                    //           .map((doc) => DropdownMenuItem<String>(
                                                                    //         value: doc.docname,
                                                                    //         child: Text(doc.docname!),
                                                                    //       ))
                                                                    //           .toList();
                                                                    //       return CICCDropdown(
                                                                    //         initialValue: "Select",
                                                                    //         onChange: (val) {
                                                                    //           //   setState(() {
                                                                    //           // selectedDocType = val;
                                                                    //           for (var doc in snapshot.data!) {
                                                                    //             if (doc.docname == val) {
                                                                    //               docTypeId = doc.documenttypeid!;
                                                                    //             }
                                                                    //           }
                                                                    //           // getTypeofDoc(context ,widget.docId,widget.subDocId).then((data) {
                                                                    //           //   _compliancePatientDataController
                                                                    //           //       .add(data!);
                                                                    //           // }).catchError((error) {
                                                                    //           //   // Handle error
                                                                    //           // });
                                                                    //           // });
                                                                    //         },
                                                                    //         items: dropDownMenuItems,
                                                                    //       );
                                                                    //     } else {
                                                                    //       return SizedBox();
                                                                    //     }
                                                                    //   },
                                                                    // ),
                                                                    // uploadField: Container(
                                                                    //   height: AppSize.s30,
                                                                    //   width: AppSize.s354,
                                                                    //   // margin: EdgeInsets.symmetric(horizontal: 5),
                                                                    //   decoration: BoxDecoration(
                                                                    //     border: Border.all(
                                                                    //       color: ColorManager.containerBorderGrey,
                                                                    //       width: 1,
                                                                    //     ),
                                                                    //     borderRadius: BorderRadius.circular(4),
                                                                    //   ),
                                                                    //   child: StatefulBuilder(
                                                                    //     builder: (BuildContext context,
                                                                    //         void Function(void Function()) setState) {
                                                                    //       return Padding(
                                                                    //         padding: const EdgeInsets.all(0),
                                                                    //         child: Row(
                                                                    //           mainAxisAlignment:
                                                                    //           MainAxisAlignment.spaceBetween,
                                                                    //           children: [
                                                                    //             Text(
                                                                    //               fileName,
                                                                    //               style: GoogleFonts.firaSans(
                                                                    //                 fontSize: FontSize.s12,
                                                                    //                 fontWeight: FontWeightManager.regular,
                                                                    //                 color: ColorManager.lightgreyheading,
                                                                    //               ),
                                                                    //             ),
                                                                    //             IconButton(
                                                                    //               padding: EdgeInsets.all(4),
                                                                    //               onPressed: _pickFile,
                                                                    //               icon: Icon(
                                                                    //                 Icons.file_upload_outlined,
                                                                    //                 color: ColorManager.black,
                                                                    //                 size: 17,
                                                                    //               ),
                                                                    //               splashColor: Colors.transparent,
                                                                    //               highlightColor: Colors.transparent,
                                                                    //               hoverColor: Colors.transparent,
                                                                    //             ),
                                                                    //           ],
                                                                    //         ),
                                                                    //       );
                                                                    //     },
                                                                    //   ),
                                                                    // ),
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
                                                                              await deleteOrgDoc(context: context, orgDocId: manageCCADR.orgOfficeDocumentId ,);
                                                                              // await deleteManageCorporate(context, manageCCLicence.docId);
                                                                              setState(() async {
                                                                                await getListMCorporateCompliancefetch(context,
                                                                                    AppConfig.corporateAndCompliance, AppConfig.subDocId2Adr, 1, 20
                                                                                )
                                                                                    .then((data) {
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


class kk extends StatelessWidget {
  const kk({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
