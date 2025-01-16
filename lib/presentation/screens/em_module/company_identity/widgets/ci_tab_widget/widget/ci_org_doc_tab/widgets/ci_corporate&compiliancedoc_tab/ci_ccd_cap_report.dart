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

class CiCcdCapReportsProvider extends ChangeNotifier {
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  TextEditingController daysController = TextEditingController(text: "1");

  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int docTypeMetaIdCCCap = AppConfig.subDocId4CapReport;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int currentPage = 1;
  String? expiryType;
  String? selectedYear = AppConfig.year;

  void setLoadingState(bool loadingState) {
    _isLoading = loadingState;
    notifyListeners();
  }

  void onPageNumberPressed(int pageNumber) {
    currentPage = pageNumber;
    notifyListeners();
  }

  Future<void> handleEdit(BuildContext context, NewOrgDocument doc) async {
    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<NewOrgDocument>(
          future: getPrefillNewOrgDocument(context, doc.orgDocumentSetupid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.blueprime),
              );
            }

            var data = snapshot.data!;
            docNameController.text = data.docName;
            expiryType = data.expiryType;

            return OrgDocNewEditPopup(
              title: EditPopupString.editCap,
              orgDocumentSetupid: data.orgDocumentSetupid,
              docTypeId: data.documentTypeId,
              subDocTypeId: data.documentSubTypeId,
              idOfDoc: data.idOfDocument,
              docName: data.docName,
              expiryType: data.expiryType,
              threshhold: data.threshold,
              expiryDate: data.expiryDate,
              expiryReminder: data.expiryReminder,
              docTypeText: AppStringEM.corporateAndComplianceDocuments,
              subDocTypeText: AppStringEM.capReport,
            );
          },
        );
      },
    );
  }

  Future<void> handleDelete(BuildContext context, NewOrgDocument doc) async {
    showDialog(
      context: context,
      builder: (context) {
        return DeletePopupProvider(
          title: DeletePopupString.deleteCap,
          loadingDuration: _isLoading,
          onCancel: () {
            Navigator.pop(context);
          },
          onDelete: () async {
            setLoadingState(true);
            try {
              await deleteNewOrgDoc(context, doc.orgDocumentSetupid);
              Navigator.pop(context);
              showDialog(context: context, builder: (_) => DeleteSuccessPopup());
            } finally {
              setLoadingState(false);
            }
          },
        );
      },
    );
  }
}

class CiCcdCapReports extends StatelessWidget {
  final int docID;
  final int subDocId;

  const CiCcdCapReports({super.key, required this.docID, required this.subDocId});

  @override
  Widget build(BuildContext context) {
    return Consumer<CiCcdCapReportsProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            TableHeadingConst(),
            SizedBox(height: AppSize.s10),
            PoliciesProcedureList(
              controller: StreamController<List<NewOrgDocument>>(),
              fetchDocuments: (context) => getNewOrgDocfetch(
                context,
                AppConfig.corporateAndCompliance,
                AppConfig.subDocId4CapReport,
                1,
                50,
              ),
              emptyMessage: ErrorMessageString.noCR,
              onEdit: (NewOrgDocument doc) => provider.handleEdit(context, doc),
              onDelete: (NewOrgDocument doc) => provider.handleDelete(context, doc),
            ),
          ],
        );
      },
    );
  }
}

