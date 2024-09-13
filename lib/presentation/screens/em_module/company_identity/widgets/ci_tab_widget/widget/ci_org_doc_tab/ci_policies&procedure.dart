import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/heading_constant_widget.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/org_add_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import '../../../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../../../../../data/api_data/establishment_data/company_identity/new_org_doc.dart';
import '../../../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';

class CIPoliciesProcedure extends StatefulWidget {
  final int docId;
  final int subDocId;
  const CIPoliciesProcedure({super.key, required this.docId, required this.subDocId, //required this.officeId,
  });

  @override
  State<CIPoliciesProcedure> createState() => _CIPoliciesProcedureState();
}

class _CIPoliciesProcedureState extends State<CIPoliciesProcedure> {
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  TextEditingController daysController = TextEditingController(text: "1");
  final StreamController<List<NewOrgDocument>> _policiesandprocedureController = StreamController<List<NewOrgDocument>>();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();

  int docSubTypeMetaId = AppConfig.subDocId0;
  String? expiryType;
  bool _isLoading = false;
  String? selectedValue;
  int docTypeMetaIdPP = AppConfig.policiesAndProcedure;
  String? selectedYear = AppConfig.year;

  @override
  void initState() {
    super.initState();
  }

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
    return
      Column(
        children: [
          TableHeadingConst(),
          SizedBox(height: AppSize.s10),
          Expanded(
            child: StreamBuilder<List<NewOrgDocument>>(
              stream: _policiesandprocedureController.stream,
              builder: (context, snapshot) {
                getNewOrgDocfetch(context,AppConfig.policiesAndProcedure,AppConfig.subDocId0,1,50).then((data) {
                  _policiesandprocedureController.add(data);
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
                      ErrorMessageString.noPolicyProcedure,
                      style: DocumentTypeDataStyle.customTextStyle(context),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  int totalItems = snapshot.data!.length;
                  int totalPages = (totalItems / itemsPerPage).ceil();
                  List<NewOrgDocument> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                            NewOrgDocument policiesdata = paginatedData[index];
                            return Column(
                              children: [
                                SizedBox(height: AppSize.s5),
                                Container(
                                  padding: EdgeInsets.only(bottom: AppPadding.p5),
                                  margin: EdgeInsets.symmetric(horizontal: AppMargin.m50),
                                  decoration: BoxDecoration(
                                    color: ColorManager.white,
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
                                            style: DocDefineTableData.customTextStyle(context),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            policiesdata.idOfDocument,
                                            style: DocDefineTableData.customTextStyle(context)
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            policiesdata.docName.toString().capitalizeFirst!,
                                            style: DocDefineTableData.customTextStyle(context)
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            policiesdata.expiryReminder.toString().capitalizeFirst!,
                                            style: DocDefineTableData.customTextStyle(context),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(onPressed: (){
                                              showDialog(context: context, builder: (context){
                                                return  FutureBuilder<NewOrgDocument>(
                                                    future: getPrefillNewOrgDocument(context,policiesdata.orgDocumentSetupid),
                                                    builder: (context,snapshotPrefill) {
                                                      if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                        return Center(
                                                          child: CircularProgressIndicator(color: ColorManager.blueprime,),
                                                        );
                                                      }

                                                      var name = snapshotPrefill.data!.docName;
                                                      docNameController = TextEditingController(text: snapshotPrefill.data!.docName);

                                                      var expiry = snapshotPrefill.data!.expiryType;
                                                      String? selectedExpiryType = expiry;

                                                      return StatefulBuilder(
                                                        builder: (BuildContext context, void Function(void Function()) setState) {
                                                          return OrgDocNewEditPopup(
                                                            title: EditPopupString.editPolicy,
                                                            orgDocumentSetupid: snapshotPrefill.data!.orgDocumentSetupid,
                                                            docTypeId: snapshotPrefill.data!.documentTypeId,
                                                            subDocTypeId: snapshotPrefill.data!.documentSubTypeId,
                                                            idOfDoc: snapshotPrefill.data!.idOfDocument,
                                                            docName: snapshotPrefill.data!.docName,
                                                            expiryType: snapshotPrefill.data!.expiryType,
                                                            threshhold: snapshotPrefill.data!.threshold,
                                                            expiryDate: snapshotPrefill.data!.expiryDate,
                                                            expiryReminder: snapshotPrefill.data!.expiryReminder,
                                                            docTypeText: AppString.policiesAndProcedures,
                                                            subDocTypeText: '',
                                                            // onSavePressed: () async {
                                                            //   setState(() {
                                                            //     _isLoading = true;
                                                            //   });
                                                            //
                                                            //   try {
                                                            //     int threshold = 0;
                                                            //     String? expiryDateToSend = "";
                                                            //     if (selectedExpiryType == AppConfig.scheduled && daysController.text.isNotEmpty) {
                                                            //       int enteredValue = int.parse(daysController.text);
                                                            //       if (selectedYear == AppConfig.year) {
                                                            //         threshold = enteredValue * 365;
                                                            //       } else if (selectedYear == AppConfig.month) {
                                                            //         threshold = enteredValue * 30;
                                                            //       }
                                                            //       expiryDateToSend = calenderController.text;
                                                            //     } else if (selectedExpiryType == AppConfig.notApplicable || selectedExpiryType == AppConfig.issuer) {
                                                            //       threshold = 0;
                                                            //       expiryDateToSend = null;
                                                            //     }
                                                            //     await updateNewOrgDocumentPatch(
                                                            //       context: context,
                                                            //       orgDocumentSetupid: snapshotPrefill.data!.orgDocumentSetupid,
                                                            //       docTypeID: AppConfig.policiesAndProcedure,
                                                            //       docSubTypeID: documentSubPreId == docSubTypeMetaId ? documentSubPreId : docSubTypeMetaId,
                                                            //       docName: name == docNameController.text ? name.toString() : docNameController.text,
                                                            //       expiryType: selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString() : expiryType.toString(),
                                                            //       threshold: threshold,
                                                            //       expiryDate: null,
                                                            //       expiryReminder: selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString() : expiryType.toString(),
                                                            //       idOfDoc: idOfDoc,
                                                            //     );
                                                            //   } finally {
                                                            //     setState(() {
                                                            //       _isLoading = false;
                                                            //     });
                                                            //     Navigator.pop(context);
                                                            //   }
                                                            // },
                                                          );
                                                        },
                                                      );
                                                    }
                                                );
                                              });
                                            },
                                                icon: Icon(Icons.edit_outlined,
                                                  size:18,color: ColorManager.bluebottom,)),
                                            IconButton(
                                                onPressed: (){
                                                  showDialog(context: context,
                                                      builder: (context) => StatefulBuilder(
                                                        builder: (BuildContext context, void Function(void Function()) setState) {
                                                          return  DeletePopup(
                                                              title: 'Delete Policies Procedure',
                                                              loadingDuration: _isLoading,
                                                              onCancel: (){
                                                                Navigator.pop(context);
                                                              }, onDelete: () async{
                                                            setState(() {
                                                              _isLoading = true;
                                                            });
                                                            try {
                                                              await deleteNewOrgDoc(context, snapshot.data![index].orgDocumentSetupid);
                                                            } finally {
                                                              setState(() {
                                                                _isLoading = false;
                                                              });
                                                              Navigator.pop(context);
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
                        ),
                      ),
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
                            currentPage = currentPage < totalPages
                                ? currentPage + 1
                                : totalPages;
                          });
                        },
                      )
                    ],
                  );
                }
                return Offstage();
              },
            ),
          ),
        ],
      );
  }
}

// child2: Visibility(
//   visible: selectedExpiryType == "Scheduled" || selectedExpiryType == "Issuer Expiry",
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 2),
//         child: Text(
//           "Expiry Date",
//           style: GoogleFonts.firaSans(
//             fontSize: FontSize.s12,
//             fontWeight: FontWeight.w700,
//             color: ColorManager.mediumgrey,
//             decoration: TextDecoration.none,
//           ),
//         ),
//       ),
//       SizedBox(height: 5,),
//       FormField<String>(
//         builder: (FormFieldState<String> field) {
//           return SizedBox (
//             width: 354,
//             height: 30,
//             child:   TextFormField(
//               controller: calenderController,
//               cursorColor: ColorManager.black,
//               style: GoogleFonts.firaSans(
//                 fontSize: FontSize.s12,
//                 fontWeight: FontWeight.w700,
//                 color: ColorManager.mediumgrey,
//                 //decoration: TextDecoration.none,
//               ),
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 hintText: 'mm-dd-yyyy',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: FontSize.s12,
//                   fontWeight: FontWeight.w700,
//                   color: ColorManager.mediumgrey,
//                   //decoration: TextDecoration.none,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(width: 1,color: ColorManager.fmediumgrey),
//                 ),
//                 contentPadding:
//                 EdgeInsets.symmetric(horizontal: 16),
//                 suffixIcon: Icon(Icons.calendar_month_outlined,
//                     color: ColorManager.blueprime),
//                 errorText: field.errorText,
//               ),
//               onTap: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(3101),
//                 );
//                 if (pickedDate != null) {
//                   calenderController.text =
//                       DateFormat('MM-dd-yyyy').format(pickedDate);
//                 }
//               },
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'please select birth date';
//                 }
//                 return null;
//               },
//             ),
//           );
//         },
//       ),
//     ],
//   ),
// ),