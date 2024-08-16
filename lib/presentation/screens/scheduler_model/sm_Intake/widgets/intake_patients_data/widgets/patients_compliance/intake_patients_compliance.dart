import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/patient_data/patient_data_compliance.dart';
import 'package:prohealth/data/api_data/sm_data/patient_data/patient_data_compliance.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_compliance/widget/compliance_add_popup.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../../../em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';

class IntakePComplianceScreen extends StatefulWidget {
  const IntakePComplianceScreen({super.key});

  @override
  State<IntakePComplianceScreen> createState() =>
      _IntakePComplianceScreenState();
}

class _IntakePComplianceScreenState extends State<IntakePComplianceScreen> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  final StreamController<List<PatientDataComplianceModal>>
      _compliancePatientDataController =
      StreamController<List<PatientDataComplianceModal>>();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  int docTypeMetaId = 8;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Status: Not Completed',
                    style: GoogleFonts.firaSans(
                        decoration: TextDecoration.none,
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.burnt_red),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 60),
                  Container(
                    height: AppSize.s32,
                    width: AppSize.s105,
                    // SchedularIconButtonConst(
                    //     icon: CupertinoIcons.plus,
                    //     text: "Add Compliance",
                    //     onPressed: () async{
                    //       String? selectedDocType;
                    //       String? selectedSubDocType;
                    //        // String? selectedExpiryType = expiryType;
                    //
                    //       showDialog(
                    //           context: context,
                    //           builder: (context) {
                    //             return  StatefulBuilder(
                    //               builder: (BuildContext context, void Function(void Function()) setState) {
                    //                 return CCScreenEditPopup(
                    //                   height: AppSize.s350,
                    //                   idDocController: docIdController,
                    //                   nameDocController: docNamecontroller,
                    //                   loadingDuration: _isLoading,
                    //                   onSavePressed: () async{
                    //                     setState(() {
                    //                       _isLoading = true;
                    //                     });
                    //                     try {
                    //                       await addComplianceDocumentPost(
                    //                         context: context,
                    //                         patientId: 4,
                    //                         docTypeId: docTypeMetaId,
                    //                         docName: docNamecontroller.text,
                    //                         docUrl:"url",
                    //                         expDate: calenderController.text,
                    //                         // name: docNamecontroller.text,
                    //                         // docTypeID: docTypeMetaId,
                    //                         // docSubTypeID: docTypeMetaId == 10 ?0:docSubTypeMetaId,
                    //                         // docCreated: DateTime.now().toString(),
                    //                          // url: "url",
                    //                         // expiryType: expiryType.toString(),
                    //                         // expiryDate: calenderController.text,
                    //                         // expiryReminder: "Schedule",
                    //                         // officeId: widget.officeId,
                    //                       );
                    //                       setState(() async {
                    //                         await fetchPatientDataCompliance(
                    //                           context,
                    //                           // patientId,
                    //                           // docTypeId,
                    //                           // // docTypeMetaId,
                    //                           // // docSubTypeMetaId,
                    //                           // 1,
                    //                           // 15,
                    //                         );
                    //                         Navigator.pop(context);
                    //
                    //                         calenderController.clear();
                    //                         docIdController.clear();
                    //                         docNamecontroller.clear();
                    //                       });
                    //                     } finally {
                    //                       setState(() {
                    //                         _isLoading = false;
                    //                       });
                    //                     }
                    //                   },
                    //                   child:  FutureBuilder<List<PatientDataComplianceDoc>>(
                    //                       future: getpatientDataComplianceDoc(context),
                    //                       builder: (context,snapshot) {
                    //                         if(snapshot.connectionState == ConnectionState.waiting){
                    //                           return Shimmer.fromColors(
                    //                               baseColor: Colors.grey[300]!,
                    //                               highlightColor: Colors.grey[100]!,
                    //                               child: Container(
                    //                                 width: 350,
                    //                                 height: 30,
                    //                                 decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                    //                               )
                    //                           );
                    //                         }
                    //                         if (snapshot.data!.isEmpty) {
                    //                           return Center(
                    //                             child: Text(
                    //                               AppString.dataNotFound,
                    //                               style: CustomTextStylesCommon.commonStyle(
                    //                                 fontWeight: FontWeightManager.medium,
                    //                                 fontSize: FontSize.s12,
                    //                                 color: ColorManager.mediumgrey,
                    //                               ),
                    //                             ),
                    //                           );
                    //                         }
                    //                         if(snapshot.hasData){
                    //                           List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
                    //                               .map((doc) => DropdownMenuItem<String>(
                    //                             value: doc.docType,
                    //                             child: Text(doc.docType!),
                    //                           ))
                    //                               .toList();
                    //                           // List dropDown = [];
                    //                           // int docType = 0;
                    //                           // List<DropdownMenuItem<String>> dropDownMenuItems = [];
                    //                           // for(var i in snapshot.data!){
                    //                           //   dropDownMenuItems.add(
                    //                           //     DropdownMenuItem<String>(
                    //                           //       child: Text(i.docType),
                    //                           //       value: i.docType,
                    //                           //     ),
                    //                           //   );
                    //                           // }
                    //                           return CICCDropdown(
                    //                               initialValue: selectedDocType ?? dropDownMenuItems[0].value,
                    //                               onChange: (val){
                    //                                 setState(() {
                    //                                   selectedDocType = val;
                    //                                   for(var doc in snapshot.data!){
                    //                                     if(doc.docType == val){
                    //                                       // docType = a.docID;
                    //                                       // docTypeMetaId = doc.docID;
                    //
                    //                                     }
                    //                                   }
                    //                                   fetchPatientDataCompliance(context).then((data) {
                    //                                     _compliancePatientDataController.add(data);
                    //                                   }).catchError((error) {
                    //                                     // Handle error
                    //                                   });
                    //                                 });
                    //                               },
                    //                               items:dropDownMenuItems
                    //                           );
                    //                         }else{
                    //                           return SizedBox();
                    //                         }
                    //                       }
                    //                   ),
                    //
                    //                   // radioButton: Column(
                    //                   //   mainAxisAlignment: MainAxisAlignment.start,
                    //                   //   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   //   children: [
                    //                   //     CustomRadioListTile(
                    //                   //       value: "Not Applicable",
                    //                   //       groupValue: expiryType.toString(),
                    //                   //       onChanged: (value) {
                    //                   //         setState(() {
                    //                   //           expiryType = value!;
                    //                   //         });
                    //                   //       },
                    //                   //       title: "Not Applicable",
                    //                   //     ),
                    //                   //     CustomRadioListTile(
                    //                   //       value: 'Scheduled',
                    //                   //       groupValue: expiryType.toString(),
                    //                   //       onChanged: (value) {
                    //                   //         setState(() {
                    //                   //           expiryType = value!;
                    //                   //         });
                    //                   //       },
                    //                   //       title: 'Scheduled',
                    //                   //     ),
                    //                   //     CustomRadioListTile(
                    //                   //       value: 'Issuer Expiry',
                    //                   //       groupValue: expiryType.toString(),
                    //                   //       onChanged: (value) {
                    //                   //         setState(() {
                    //                   //           expiryType = value!;
                    //                   //         });
                    //                   //       },
                    //                   //       title: 'Issuer Expiry',
                    //                   //     ),
                    //                   //   ],
                    //                   // ),
                    //                   title: 'Add Compliance', child1: SizedBox(),
                    //                 );
                    //               },
                    //
                    //             );
                    //           });
                    //     }),
                    child: SchedularIconButtonConst(
                        text: AppString.add_new,
                        icon: Icons.add,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ComplianceAddPopUp(
                                calenderController: calenderController,
                                idDocController: docIdController,
                                nameDocController: docNamecontroller,
                                onPressed: () {  },
                                title: '',);
                            },
                          );
                        }),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.width * 0.3,
                // width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<List<PatientDataComplianceModal>>(
                            stream: _compliancePatientDataController.stream,
                            builder: (context, snapshot) {
                              fetchPatientDataCompliance(context).then((data) {
                                _compliancePatientDataController.add(data);
                              }).catchError((error) {
                                // Handle error
                              });
                              print('55555555');
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                                // int totalItems = snapshot.data!.length;
                                // int totalPages = (totalItems / itemsPerPage).ceil();
                                // List<PatientDataComplianceModal>
                                //     currentPageItems = snapshot.data!.sublist(
                                //   (currentPage - 1) * itemsPerPage,
                                //   (currentPage * itemsPerPage) > totalItems
                                //       ? totalItems
                                //       : (currentPage * itemsPerPage),
                                // );
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder:
                                      (BuildContext context,  index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 40),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: AppSize.s65,
                                            // width: 1109, //1109
                                            decoration: BoxDecoration(
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Container(
                                                        color:
                                                            Color(0xff50B5E5),
                                                        height: AppSize.s45,
                                                        width: AppSize.s62,
                                                        child: Icon(
                                                          Icons
                                                              .remove_red_eye_outlined,
                                                          color: ColorManager
                                                              .white,
                                                          size: AppSize.s24,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            120),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 11.5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            snapshot.data![index].complianceId.toString(),
                                                            style: GoogleFonts.firaSans(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize:
                                                                    FontSize
                                                                        .s10,
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .medium,
                                                                color: ColorManager
                                                                    .textPrimaryColor),
                                                          ),
                                                          SizedBox(height: 3.5),
                                                          Text(
                                                            snapshot.data![index].docName.toString(),
                                                            // textAlign:TextAlign.center,
                                                            style: GoogleFonts.firaSans(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize:
                                                                    AppSize.s12,
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .bold,
                                                                color: ColorManager
                                                                    .textPrimaryColor),
                                                          ),
                                                          SizedBox(height: 1),
                                                          Text(
                                                              snapshot.data![index].expDate.toString(),
                                                            // textAlign:TextAlign.center,
                                                            style: GoogleFonts.firaSans(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize:
                                                                    FontSize
                                                                        .s10,
                                                                fontWeight:
                                                                    FontWeightManager
                                                                        .lightbold,
                                                                color: ColorManager
                                                                    .textPrimaryColor),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // SizedBox(width: MediaQuery.of(context).size.width/4.5), //3.5
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50.0),
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(
                                                            Icons.history,
                                                            color: ColorManager
                                                                .textPrimaryColor),
                                                        onPressed: () {},
                                                      ),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              120),
                                                      IconButton(
                                                        icon: Icon(
                                                            Icons
                                                                .print_outlined,
                                                            color: ColorManager
                                                                .textPrimaryColor),
                                                        onPressed: () async {
                                                          final pdf =
                                                              pw.Document();

                                                          pdf.addPage(
                                                            pw.Page(
                                                              build: (pw.Context
                                                                      context) =>
                                                                  pw.Center(
                                                                child: pw.Text(
                                                                    'Hello, this is a test print!'),
                                                              ),
                                                            ),
                                                          );

                                                          await Printing
                                                              .layoutPdf(
                                                            onLayout: (PdfPageFormat
                                                                    format) async =>
                                                                pdf.save(),
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              120),
                                                      IconButton(
                                                        icon: Icon(
                                                            Icons
                                                                .file_download_outlined,
                                                            color: ColorManager
                                                                .textPrimaryColor),
                                                        onPressed: () {},
                                                      ),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              120),
                                                      IconButton(
                                                        icon: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: ColorManager
                                                                .textPrimaryColor),
                                                        onPressed: () {},
                                                      ),
                                                      IconButton(
                                                          onPressed: (){
                                                            showDialog(context: context,
                                                                builder: (context) => StatefulBuilder(
                                                                  builder: (BuildContext context, void Function(void Function()) setState) {
                                                                    return  DeletePopup(
                                                                        title: 'Delete license',
                                                                        loadingDuration: _isLoading,
                                                                        onCancel: (){
                                                                          Navigator.pop(context);
                                                                        }, onDelete: () async{
                                                                      setState(() {
                                                                        _isLoading = true;
                                                                      });
                                                                      try {
                                                                        await deleteDocumentCompliance(
                                                                            context,
                                                                            snapshot.data![index].complianceId!);
                                                                        setState(() async {
                                                                          await fetchPatientDataCompliance(
                                                                              context,).then((data) {
                                                                            _compliancePatientDataController.add(data);
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
                                      ),
                                    );
                                  },
                                );
                              }
                              return Offstage();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
