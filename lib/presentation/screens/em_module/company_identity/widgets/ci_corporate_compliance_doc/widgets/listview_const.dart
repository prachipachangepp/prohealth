import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';

class ListViewStyle extends StatelessWidget {
  final String idname;
  final String subidname;


  // final VoidCallback?  onHistoryPressed;
  // final VoidCallback? onDownloadePressed;
  // final  VoidCallback? onEditPressed;
  // final  VoidCallback? onDeletePressed;


  final void Function()  onHistoryPressed;
  final void Function() onDownloadePressed;
  final void Function() onEditPressed;
  final  void Function() onDeletePressed;

  const ListViewStyle({super.key, required this.idname, required this.subidname, required this.onHistoryPressed, required this.onDownloadePressed, required this.onEditPressed, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return  Column(
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
                              idname.toString(),
                              // "ID : ${manageCCLicence.idOfDoc.toString()}",
                             // "ID : ${manageCCLicence.idOfDocument.toString()}",
                              textAlign:
                              TextAlign.center,
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
                              // manageCCLicence.docname.toString(),
                              subidname.toString(),
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
                            onHistoryPressed!;
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) =>
                          //         ManageHistoryPopup(
                          //           docHistory:
                          //           manageCCLicence
                          //               .docHistory,
                          //         ),
                          //   );
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
                           onDownloadePressed!;
                            // DowloadFile()
                            //     .downloadPdfFromBase64(
                            //     fileExtension,
                            //     "Licenses.pdf");
                            // downloadFile(fileUrl);
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
                             onEditPressed!;
                          //   String?
                          //   selectedExpiryType =
                          //       expiryType;
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return FutureBuilder<
                          //           MCorporateCompliancePreFillModal>(
                          //         future: getPrefillNewOrgOfficeDocument(
                          //             context,
                          //             manageCCLicence
                          //                 .orgOfficeDocumentId),
                          //         builder: (context,
                          //             snapshotPrefill) {
                          //           if (snapshotPrefill
                          //               .connectionState ==
                          //               ConnectionState
                          //                   .waiting) {
                          //             return Center(
                          //               child:
                          //               CircularProgressIndicator(
                          //                 color: ColorManager
                          //                     .blueprime,
                          //               ),
                          //             );
                          //           }
                          //
                          //           var calender =
                          //               snapshotPrefill
                          //                   .data!
                          //                   .expiry_date;
                          //           calenderController =
                          //               TextEditingController(
                          //                 text: snapshotPrefill
                          //                     .data!
                          //                     .expiry_date,
                          //               );
                          //
                          //           // fileName = snapshotPrefill.data!.url;
                          //
                          //           return StatefulBuilder(
                          //             builder: (BuildContext
                          //             context,
                          //                 void Function(
                          //                     void Function())
                          //                 setState) {
                          //               return VCScreenPopupEditConst(
                          //                 title:
                          //                 'Edit Licenses',
                          //                 loadingDuration:
                          //                 _isLoading,
                          //                 officeId:
                          //                 widget
                          //                     .officeId,
                          //                 docTypeMetaIdCC:
                          //                 widget
                          //                     .docId,
                          //                 selectedSubDocId:
                          //                 widget
                          //                     .subDocId,
                          //                 //orgDocId: manageCCADR.orgOfficeDocumentId,
                          //                 orgDocId: snapshotPrefill
                          //                     .data!
                          //                     .orgOfficeDocumentId,
                          //                 orgDocumentSetupid: snapshotPrefill
                          //                     .data!
                          //                     .documentSetupId,
                          //                 docName: snapshotPrefill
                          //                     .data!
                          //                     .docName,
                          //                 selectedExpiryType: snapshotPrefill
                          //                     .data!
                          //                     .expType,
                          //                 expiryDate: snapshotPrefill
                          //                     .data!
                          //                     .expiry_date,
                          //                 url: snapshotPrefill
                          //                     .data!
                          //                     .url,
                          //               );
                          //             },
                          //           );
                          //         },
                          //       );
                          //     },
                          //   );
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
                             onDeletePressed!;
                              // showDialog(
                              //     context: context,
                              //     builder: (context) =>
                                      // StatefulBuilder(
                                      //   builder: (BuildContext
                                      //   context,
                                      //       void Function(void Function())
                                      //       setState) {
                                      //     return DeletePopup(
                                      //         title:
                                      //         'Delete license',
                                      //         loadingDuration:
                                      //         _isLoading,
                                      //         onCancel:
                                      //             () {
                                      //           Navigator.pop(context);
                                      //         },
                                      //         onDelete:
                                      //             () async {
                                      //           setState(() {
                                      //             _isLoading = true;
                                      //           });
                                      //           try {
                                      //             await deleteOrgDoc(
                                      //               context: context,
                                      //               orgDocId: manageCCLicence.orgOfficeDocumentId,
                                      //             );
                                      //             // await deleteManageCorporate(context, manageCCLicence.docId);
                                      //             setState(() async {
                                      //               await getListMCorporateCompliancefetch(context, AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 20).then((data) {
                                      //                 lisenceController.add(data);
                                      //               }).catchError((error) {
                                      //                 // Handle error
                                      //               });
                                      //               Navigator.pop(context);
                                      //             });
                                      //           } finally {
                                      //             setState(() {
                                      //               _isLoading = false;
                                      //             });
                                      //           }
                                      //         });
                                      //   },
                                      // ));
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
  }
}
