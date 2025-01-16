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

import 'package:flutter/material.dart';

class CICcdADRProvider extends ChangeNotifier {
  final TextEditingController docNameController = TextEditingController();
  final TextEditingController docIdController = TextEditingController();
  final TextEditingController calenderController = TextEditingController();
  final TextEditingController idOfDocController = TextEditingController();
  final TextEditingController daysController = TextEditingController(text: "1");

  final StreamController<List<NewOrgDocument>> documentStream =
  StreamController<List<NewOrgDocument>>.broadcast();

  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int docTypeMetaIdCCAdr = AppConfig.subDocId2Adr;
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
        AppConfig.corporateAndCompliance,
        AppConfig.subDocId2Adr,
        1,
        50,
      );
      documentStream.add(documents);
    } catch (e) {
      documentStream.addError(e);
    }
  }

  Future<void> onEdit(BuildContext context, NewOrgDocument doc) async {
    try {
      var snapshotPrefill = await getPrefillNewOrgDocument(context, doc.orgDocumentSetupid);
      docNameController.text = snapshotPrefill.docName ?? "";
      expiryType = snapshotPrefill.expiryType;

      showDialog(
        context: context,
        builder: (context) {
          return OrgDocNewEditPopup(
            title: EditPopupString.editAdr,
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
            subDocTypeText: AppStringEM.ard,
          );
        },
      );
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> onDelete(BuildContext context, NewOrgDocument doc) async {
    showDialog(
      context: context,
      builder: (context) {
        return DeletePopupProvider(
          title: DeletePopupString.deleteAdr,
          loadingDuration: _isLoading,
          onCancel: () => Navigator.pop(context),
          onDelete: () async {
            setLoading(true);
            try {
              await deleteNewOrgDoc(context, doc.orgDocumentSetupid);
              Navigator.pop(context); // Close the delete popup
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
    calenderController.dispose();
    idOfDocController.dispose();
    daysController.dispose();
    documentStream.close();
  }
}

class CICcdADR extends StatelessWidget {
  final int subDocID;
  final int docID;

  const CICcdADR({
    super.key,
    required this.subDocID,
    required this.docID,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CICcdADRProvider>(context, listen: false);

    return Column(
      children: [
        TableHeadingConst(),
        SizedBox(height: AppSize.s10),
        PoliciesProcedureList(
          controller: provider.documentStream,
          fetchDocuments: (context) => getNewOrgDocfetch(
            context,
            AppConfig.corporateAndCompliance,
            AppConfig.subDocId2Adr,
            1,
            50,
          ),
          emptyMessage: ErrorMessageString.noADR,
          onEdit: (NewOrgDocument doc) => provider.onEdit(context, doc),
          onDelete: (NewOrgDocument doc) => provider.onDelete(context, doc),
        ),
      ],
    );
  }
}

