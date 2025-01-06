import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/heading_constant_widget.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/org_add_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../../../../../data/api_data/establishment_data/company_identity/new_org_doc.dart';
import '../../../../../../../widgets/error_popups/delete_success_popup.dart';
import '../files_constant-widget.dart';

class CIPoliciesProcedure extends StatefulWidget {
  final int docId;
  final int subDocId;
  const CIPoliciesProcedure({
    super.key,
    required this.docId,
    required this.subDocId,
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
  final StreamController<List<NewOrgDocument>> _policiesandprocedureController =
      StreamController<List<NewOrgDocument>>();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
      StreamController<List<IdentityDocumentIdData>>.broadcast();

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
    return Column(
      children: [
        TableHeadingConst(),
        SizedBox(height: AppSize.s10),
        PoliciesProcedureList(
          controller: _policiesandprocedureController,
          fetchDocuments: (context) => getNewOrgDocfetch(context, AppConfig.policiesAndProcedure,
            AppConfig.subDocId0, 1, 50,
          ),
          emptyMessage: ErrorMessageString.noPolicyProcedure,
          onEdit: (NewOrgDocument doc) {
            showDialog(
                context: context,
                builder: (context) {
                  return FutureBuilder<NewOrgDocument>(
                      future: getPrefillNewOrgDocument(context, doc.orgDocumentSetupid),
                      builder: (context, snapshotPrefill) {
                        if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime,
                            ),
                          );
                        }

                        var name = snapshotPrefill.data!.docName;
                        docNameController = TextEditingController(text: snapshotPrefill.data!.docName);

                        var expiry = snapshotPrefill.data!.expiryType;
                        String? selectedExpiryType = expiry;

                        return StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return OrgDocNewEditPopup(
                              height: AppSize.s374,
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
                              docTypeText: AppStringEM.policiesAndProcedures,
                              subDocTypeText: '',
                            );
                          },
                        );
                      });
                });
          },
          onDelete: (NewOrgDocument doc) {
            showDialog(
                context: context,
                builder: (context) => StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return DeletePopup(
                            title: DeletePopupString.deletePolicy,
                            loadingDuration: _isLoading,
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            onDelete: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                await deleteNewOrgDoc(context, doc.orgDocumentSetupid);
                                Navigator.pop(context);
                                showDialog(context: context, builder: (context) => DeleteSuccessPopup());
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            });
                      },
                    ));
          },
        ),
      ],
    );
  }
}

///calendar code
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
