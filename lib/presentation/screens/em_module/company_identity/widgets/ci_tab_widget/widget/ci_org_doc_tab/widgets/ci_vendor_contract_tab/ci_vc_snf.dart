import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/heading_constant_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../../../app/resources/provider/delete_popup_provider.dart';
import '../../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../../../app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import '../../../../../../../../../../data/api_data/establishment_data/company_identity/new_org_doc.dart';
import '../../../../../../../../../widgets/error_popups/delete_success_popup.dart';
import '../../../files_constant-widget.dart';
import '../org_add_popup_const.dart';


class VendorContractSNFProvider with ChangeNotifier {
  final TextEditingController docNameController = TextEditingController();
  final TextEditingController docIdController = TextEditingController();
  final TextEditingController calenderController = TextEditingController();
  final TextEditingController idOfDocController = TextEditingController();
  final TextEditingController daysController = TextEditingController(text: "1");
  final StreamController<List<NewOrgDocument>> documentStream = StreamController<List<NewOrgDocument>>();

  int docTypeMetaIdVC = AppConfig.vendorContracts;
  int docTypeMetaIdVCSnf = AppConfig.subDocId7SNF;
  String? expiryType;
  String? selectedValue;
  String? selectedYear = AppConfig.year;
  bool _isLoading = false;

 // Stream<List<NewOrgDocument>> get documentStream => _controller.stream;

  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void setPageNumber(int pageNumber) {
    currentPage = pageNumber;
    notifyListeners();
  }

  Future<void> fetchDocuments(BuildContext context) async {
    try {
      final documents = await getNewOrgDocfetch(
        context, AppConfig.vendorContracts, AppConfig.subDocId7SNF, 1, 50,
      );
      documentStream.add(documents);
    } catch (e) {
      documentStream.addError(e);
    }
  }

  Future<NewOrgDocument?> fetchPrefillDocument(BuildContext context, int orgDocumentSetupid) async {
    return await getPrefillNewOrgDocument(context, orgDocumentSetupid);
  }

  Future<void> deleteDocument(BuildContext context, int orgDocumentSetupid) async {
    _isLoading = true;
    notifyListeners();

    try {
      await deleteNewOrgDoc(context, orgDocumentSetupid);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void disposeControllers() {
    docNameController.dispose();
    docIdController.dispose();
    calenderController.dispose();
    idOfDocController.dispose();
    daysController.dispose();
    documentStream.close();
  }
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> onEdit(NewOrgDocument doc, BuildContext context) async{
    var snaphotPrefill = await getPrefillNewOrgDocument(context, doc.orgDocumentSetupid);
    docNameController.text = snaphotPrefill.docName ?? "";

    showDialog(
      context: context,
      builder: (context) {
            return OrgDocNewEditPopup(
              title: EditPopupString.editSNF,
              orgDocumentSetupid: snaphotPrefill.orgDocumentSetupid,
              docTypeId: snaphotPrefill.documentTypeId,
              subDocTypeId: snaphotPrefill.documentSubTypeId,
              idOfDoc: snaphotPrefill.idOfDocument,
              docName: snaphotPrefill.docName,
              expiryType: snaphotPrefill.expiryType,
              threshhold: snaphotPrefill.threshold,
              expiryDate: snaphotPrefill.expiryDate,
              expiryReminder: snaphotPrefill.expiryReminder,
              docTypeText: AppStringEM.vendorContracts,
              subDocTypeText: AppStringEM.snf,
            );
      },
    );
  }

  Future<void> onDelete(NewOrgDocument doc, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return DeletePopupProvider(
          title: DeletePopupString.deleteSNF,
          loadingDuration: _isLoading,
          onCancel: () {
            Navigator.pop(context);
          },
          onDelete: () async {
            setLoading(true); // Set loading state
            try {
              await deleteDocument(context, doc.orgDocumentSetupid);
              Navigator.pop(context); // Close the confirmation dialog
              showDialog(
                context: context,
                builder: (context) => DeleteSuccessPopup(),
              );
            } finally {
              setLoading(false); // Reset loading state
            }
          },
        );
      },
    );
  }
}

class VendorContractSNF extends StatelessWidget {
  final int docId;
  final int subDocId;

  const VendorContractSNF({
    Key? key,
    required this.docId,
    required this.subDocId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VendorContractSNFProvider>(context, listen: false);

    return Column(
      children: [
        TableHeadingConst(),
        SizedBox(height: AppSize.s10),
        PoliciesProcedureList(
          controller: provider.documentStream,
          fetchDocuments: (context) => getNewOrgDocfetch(
            context,
            AppConfig.vendorContracts,
            AppConfig.subDocId7SNF,
            1,
            50,
          ),
          emptyMessage: ErrorMessageString.noSNF,
          onEdit: (NewOrgDocument doc) {
            provider.onEdit(doc, context);

          },
          onDelete: (NewOrgDocument doc) {
            provider.onDelete(doc, context);
          },
        ),
      ],
    );
  }
}
