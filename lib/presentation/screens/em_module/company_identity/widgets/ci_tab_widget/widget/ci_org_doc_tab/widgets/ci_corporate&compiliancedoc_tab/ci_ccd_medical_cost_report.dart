import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/new_org_doc.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../../app/resources/provider/delete_popup_provider.dart';
import '../../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../../../app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import '../../../../../../../../../widgets/error_popups/delete_success_popup.dart';
import '../../../files_constant-widget.dart';
import '../heading_constant_widget.dart';
import '../org_add_popup_const.dart';

// class CiCcdMedicalCostReport extends StatefulWidget {
//   final int subDocID;
//   final int docID;
//   const CiCcdMedicalCostReport({super.key, required this.subDocID, required this.docID,});
//
//   @override
//   State<CiCcdMedicalCostReport> createState() => _CiCcdMedicalCostReportState();
// }
//
// class _CiCcdMedicalCostReportState extends State<CiCcdMedicalCostReport> {
//   TextEditingController docNameController = TextEditingController();
//   TextEditingController docIdController = TextEditingController();
//   TextEditingController calenderController = TextEditingController();
//   TextEditingController idOfDocController = TextEditingController();
//   TextEditingController daysController = TextEditingController(text: "1");
//   int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
//   int docTypeMetaIdCCMCR = AppConfig.subDocId3CICCMedicalCR;
//   final StreamController<List<NewOrgDocument>> _controller = StreamController<List<NewOrgDocument>>();
//   final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();
//   int docTypeMetaId =0;
//   int docSubTypeMetaId =0;
//   String? expiryType;
//   bool _isLoading = false;
//   String? selectedYear = AppConfig.year;
//   String? selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//   int currentPage = 1;
//   final int itemsPerPage = 10;
//   final int totalPages = 5;
//
//   void onPageNumberPressed(int pageNumber) {
//     setState(() {
//       currentPage = pageNumber;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TableHeadingConst(),
//         SizedBox(height: AppSize.s10),
//         PoliciesProcedureList(
//           controller: _controller,
//           fetchDocuments: (context) => getNewOrgDocfetch(
//             context,
//             AppConfig.corporateAndCompliance, AppConfig.subDocId3CICCMedicalCR, 1, 50,
//           ),
//           emptyMessage: ErrorMessageString.noMCR,
//           onEdit: (NewOrgDocument doc) {
//             String? selectedExpiryType = expiryType;
//             showDialog(context: context, builder: (context){
//               return  FutureBuilder<NewOrgDocument>(
//                   future: getPrefillNewOrgDocument(context,doc.orgDocumentSetupid),
//                   builder: (context,snapshotPrefill) {
//                     if(snapshotPrefill.connectionState == ConnectionState.waiting){
//                       return Center(
//                         child: CircularProgressIndicator(color: ColorManager.blueprime,),
//                       );
//                     }
//
//                     var name = snapshotPrefill.data!.docName;
//                     docNameController = TextEditingController(text: snapshotPrefill.data!.docName);
//
//                     var expiry = snapshotPrefill.data!.expiryType;
//                     String? selectedExpiryType = expiry;
//
//                     return StatefulBuilder(
//                       builder: (BuildContext context, void Function(void Function()) setState) {
//                         return OrgDocNewEditPopup(
//                           title: EditPopupString.editMCR,
//                           orgDocumentSetupid: snapshotPrefill.data!.orgDocumentSetupid,
//                           docTypeId: snapshotPrefill.data!.documentTypeId,
//                           subDocTypeId: snapshotPrefill.data!.documentSubTypeId,
//                           idOfDoc: snapshotPrefill.data!.idOfDocument,
//                           docName: snapshotPrefill.data!.docName,
//                           expiryType: snapshotPrefill.data!.expiryType,
//                           threshhold: snapshotPrefill.data!.threshold,
//                           expiryDate: snapshotPrefill.data!.expiryDate,
//                           expiryReminder: snapshotPrefill.data!.expiryReminder,
//                           docTypeText: AppStringEM.corporateAndComplianceDocuments,
//                           subDocTypeText: AppStringEM.mcr,
//                         );
//                       },
//                     );
//                   }
//               );
//             });
//           },
//           onDelete: (NewOrgDocument doc) {
//             showDialog(context: context,
//                 builder: (context) => StatefulBuilder(
//                   builder: (BuildContext context, void Function(void Function()) setState) {
//                     return  DeletePopup(
//                         title: DeletePopupString.deleteMCR,
//                         loadingDuration: _isLoading,
//                         onCancel: (){
//                           Navigator.pop(context);
//                         }, onDelete: () async{
//                       setState(() {
//                         _isLoading = true;
//                       });
//                       try {
//                         await deleteNewOrgDoc(context,doc.orgDocumentSetupid);
//                         Navigator.pop(context);
//                         showDialog(context: context, builder: (context) => DeleteSuccessPopup());
//                       } finally {
//                         setState(() {
//                           _isLoading = false;
//                         });
//                       }
//                     });
//                   },
//                 ));
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CiCcdMedicalCostReportProvider with ChangeNotifier {
  final TextEditingController docNameController = TextEditingController();
  final TextEditingController docIdController = TextEditingController();
  final TextEditingController calendarController = TextEditingController();
  final TextEditingController idOfDocController = TextEditingController();
  final TextEditingController daysController = TextEditingController(text: "1");

  final StreamController<List<NewOrgDocument>> documentStream = StreamController<List<NewOrgDocument>>.broadcast();

  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int docTypeMetaIdMCR = AppConfig.subDocId3CICCMedicalCR;
  String? selectedValue;
  String? expiryType;
  String? selectedYear = AppConfig.year;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchDocuments(BuildContext context) async {
    try {
      final documents = await getNewOrgDocfetch(
        context,
        docTypeMetaIdCC,
        docTypeMetaIdMCR,
        1,
        50,
      );
      documentStream.add(documents);
    } catch (e) {
      documentStream.addError(e);
    }
  }

  Future<void> onEdit(BuildContext context, NewOrgDocument doc) async {
    var snapshotPrefill = await getPrefillNewOrgDocument(context, doc.orgDocumentSetupid);
    docNameController.text = snapshotPrefill.docName ?? "";

    showDialog(
      context: context,
      builder: (context) {
        return OrgDocNewEditPopup(
          title: EditPopupString.editMCR,
          orgDocumentSetupid: snapshotPrefill.orgDocumentSetupid,
          docTypeId: snapshotPrefill.documentTypeId,
          subDocTypeId: snapshotPrefill.documentSubTypeId,
          idOfDoc: snapshotPrefill.idOfDocument,
          docName: snapshotPrefill.docName,
          expiryType: snapshotPrefill.expiryType,
          threshhold: snapshotPrefill.threshold,
          expiryDate: snapshotPrefill.expiryDate,
          expiryReminder: snapshotPrefill.expiryReminder,
          docTypeText: AppStringEM.corporateAndComplianceDocuments,
          subDocTypeText: AppStringEM.mcr,
        );
      },
    );
  }

  Future<void> onDelete(BuildContext context, NewOrgDocument doc) async {
    showDialog(
      context: context,
      builder: (context) {
        return DeletePopupProvider(
          title: DeletePopupString.deleteMCR,
          loadingDuration: _isLoading,
          onCancel: () => Navigator.pop(context),
          onDelete: () async {
            setLoading(true);
            try {
              await deleteNewOrgDoc(context, doc.orgDocumentSetupid);
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => DeleteSuccessPopup(),
              );
            } finally {
              setLoading(false);
            }
          },
        );
      },
    );
  }

  void disposeControllers() {
    docNameController.dispose();
    docIdController.dispose();
    calendarController.dispose();
    idOfDocController.dispose();
    daysController.dispose();
    documentStream.close();
  }
}

class CiCcdMedicalCostReport extends StatelessWidget {
  final int subDocID;
  final int docID;

  const CiCcdMedicalCostReport({
    super.key,
    required this.subDocID,
    required this.docID,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CiCcdMedicalCostReportProvider>(context, listen: false);

    return Column(
      children: [
        TableHeadingConst(),
        SizedBox(height: AppSize.s10),
        PoliciesProcedureList(
          controller: provider.documentStream,
          fetchDocuments: (context) => getNewOrgDocfetch(
            context,
            AppConfig.corporateAndCompliance,
            provider.docTypeMetaIdMCR,
            1,
            50,
          ),
          emptyMessage: ErrorMessageString.noMCR,
          onEdit: (NewOrgDocument doc) => provider.onEdit(context, doc),
          onDelete: (NewOrgDocument doc) => provider.onDelete(context, doc),
        ),
      ],
    );
  }
}
