import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/new_org_doc.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../../../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../../../app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import '../../../../../../../../../widgets/error_popups/delete_success_popup.dart';
import '../../../files_constant-widget.dart';
import '../heading_constant_widget.dart';
import '../org_add_popup_const.dart';

class CICcdLicense extends StatefulWidget {
  final int subDocID;
  final int docID;
 // final String officeId;
  const CICcdLicense({super.key, required this.subDocID, required this.docID,
  //  required this.officeId
  });

  @override
  State<CICcdLicense> createState() => _CICcdLicenseState();
}

class _CICcdLicenseState extends State<CICcdLicense> {
    TextEditingController docNameController = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
    TextEditingController idOfDocController = TextEditingController();
    TextEditingController daysController = TextEditingController(text: "1");
    int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
    int docTypeMetaIdCCL = AppConfig.subDocId1Licenses;
  final StreamController<List<NewOrgDocument>> _controller = StreamController<List<NewOrgDocument>>.broadcast();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();

  String? selectedValue;
  int docSubTypeMetaId =0;
  String? expiryType;
  bool _isLoading = false;
  String? selectedYear = AppConfig.year;
  @override
  void initState() {
    super.initState();
    print(":::SUBDOCID ${widget.subDocID} + ${widget.docID}");
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
          PoliciesProcedureList(
            controller: _controller,
            fetchDocuments: (context) => getNewOrgDocfetch(
              context, AppConfig.corporateAndCompliance, AppConfig.subDocId1Licenses, 1, 50,
            ),
            emptyMessage: ErrorMessageString.noLicenses,
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
                            title: EditPopupString.editLicenses,
                            orgDocumentSetupid: snapshotPrefill.data!.orgDocumentSetupid,
                            docTypeId: snapshotPrefill.data!.documentTypeId,
                            subDocTypeId: snapshotPrefill.data!.documentSubTypeId,
                            idOfDoc: snapshotPrefill.data!.idOfDocument,
                            docName: snapshotPrefill.data!.docName,
                            expiryType: snapshotPrefill.data!.expiryType,
                            threshhold: snapshotPrefill.data!.threshold,
                            expiryDate: snapshotPrefill.data!.expiryDate,
                            expiryReminder: snapshotPrefill.data!.expiryReminder,
                            docTypeText: AppStringEM.corporateAndComplianceDocuments,
                            subDocTypeText: AppString.license,
                          );
                        },
                      );
                    }
                );
              });
            },
            onDelete: (NewOrgDocument doc) {
              showDialog(context: context,
                  builder: (context) =>
                      StatefulBuilder(
                        builder: (
                            BuildContext context,
                            void Function(void Function()) setState) {
                          return DeletePopup(
                              title: DeletePopupString.deleteLicenses,
                              loadingDuration: _isLoading,
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onDelete: () async {
                                setState(() {
                                  _isLoading =
                                  true;
                                });
                                try {
                                  await deleteNewOrgDoc(context, doc.orgDocumentSetupid);
                                  Navigator.pop(context);
                                  showDialog(context: context, builder: (context) => DeleteSuccessPopup());
                                } finally {
                                  setState(() {
                                    _isLoading =
                                    false;
                                  });
                                }
                              });
                        },
                      ));
            },
          ),
        ],
      );
  }}