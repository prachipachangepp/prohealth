import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/heading_constant_widget.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../../../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../../../app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import '../../../../../../../../../../data/api_data/establishment_data/company_identity/new_org_doc.dart';
import '../../../../../../../../../widgets/error_popups/delete_success_popup.dart';
import '../../../files_constant-widget.dart';
import '../org_add_popup_const.dart';
class VendorContractMedicalCostReport extends StatefulWidget {
  final int docId;
  final int subDocId;
  const VendorContractMedicalCostReport({super.key, required this.docId,
    required this.subDocId,
  });

  @override
  State<VendorContractMedicalCostReport> createState() => _VendorContractMedicalCostReportState();
}

class _VendorContractMedicalCostReportState extends State<VendorContractMedicalCostReport> {
  TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  TextEditingController daysController = TextEditingController(text: "1");
  int docTypeMetaIdVC = AppConfig.vendorContracts;
  int docTypeMetaIdVCdme = AppConfig.subDocId8DME;
  final StreamController<List<NewOrgDocument>> _controller = StreamController<List<NewOrgDocument>>();
  int docSubTypeMetaId =0;
  String? expiryType;
  bool _isLoading = false;

  String? selectedValue;
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
        SizedBox(height: AppSize.s10,),
        PoliciesProcedureList(
          controller: _controller,
          fetchDocuments: (context) => getNewOrgDocfetch(
            context,
            AppConfig.vendorContracts, AppConfig.subDocId8DME, 1, 50,
          ),
          emptyMessage: ErrorMessageString.noDME,
          onEdit: (NewOrgDocument doc) {
            String? selectedExpiryType = expiryType;
            showDialog(context: context, builder: (context){
              return  FutureBuilder<NewOrgDocument>(
                  future: getPrefillNewOrgDocument(context,doc.orgDocumentSetupid),
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
                          title: EditPopupString.editDME,
                          orgDocumentSetupid: snapshotPrefill.data!.orgDocumentSetupid,
                          docTypeId: snapshotPrefill.data!.documentTypeId,
                          subDocTypeId: snapshotPrefill.data!.documentSubTypeId,
                          idOfDoc: snapshotPrefill.data!.idOfDocument,
                          docName: snapshotPrefill.data!.docName,
                          expiryType: snapshotPrefill.data!.expiryType,
                          threshhold: snapshotPrefill.data!.threshold,
                          expiryDate: snapshotPrefill.data!.expiryDate,
                          expiryReminder: snapshotPrefill.data!.expiryReminder,
                          docTypeText: AppStringEM.vendorContracts,
                          subDocTypeText: AppStringEM.dme,
                        );
                      },
                    );
                  }
              );
            });
          },
          onDelete: (NewOrgDocument doc) {
            showDialog(context: context,
                builder: (context) => StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) {
                    return  DeletePopup(
                        title: DeletePopupString.deleteDME,
                        loadingDuration: _isLoading,
                        onCancel: (){
                          Navigator.pop(context);
                        }, onDelete: () async{
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
