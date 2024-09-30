import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/error_pop_up.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../company_identity_screen.dart';
import '../../upload_add_popup.dart';
import '../ci_cc_adr.dart';
import '../ci_cc_cap_reports.dart';
import '../ci_cc_licence.dart';
import '../ci_cc_medical_cost_report.dart';
import '../ci_cc_quaterly_bal_report.dart';

class CiCorporateComplianceScreen extends StatefulWidget {
  final int docId;
  final String officeId;
  final int companyID;

  const CiCorporateComplianceScreen({
    super.key,
    required this.docId,
    required this.officeId,
    required this.companyID,
  });

  @override
  State<CiCorporateComplianceScreen> createState() =>
      _CiCorporateComplianceScreenState();
}

class _CiCorporateComplianceScreenState
    extends State<CiCorporateComplianceScreen> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
      StreamController<List<IdentityDocumentIdData>>.broadcast();

  int _selectedIndex = 0;
  //int docTypeMetaId = 8;
  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  // int docTypeDropMetaId = 0;
  int docSubTypeMetaId = 0;
  String? expiryType;
  bool _isLoading = false;
  int docTypeId = 0;
  DateTime? datePicked;
  String? selectedDocTypeValue;
  String? selectedSubDocTypeValue;
  int selectedSubDocId = AppConfig.subDocId1Licenses; // Default value
  String selectedSubDocType = "";
  dynamic filePath;
  late Future<List<DocumentTypeData>> docTypeFuture;
  bool showExpiryDateField = false; // Declare the state variable
  // showExpiryDateField = doc.expiryreminder.isNotEmpty;

  TextEditingController expiryDateController = TextEditingController();
  String fileName = '';
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.first.bytes;
        fileName = result.files.first.name;
        print('File path ${filePath}');
        print('File name ${fileName}');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedDocTypeValue = "Select Document Type";
    selectedSubDocTypeValue = "Select Sub Document";
    docTypeFuture = documentTypeGet(context);
    _updateSelectedSubDocId(selectedSubDocId);
    print("office id ::::::::${widget.officeId}");
  }

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;

      _updateSelectedSubDocId(index == 0
          ? AppConfig.subDocId1Licenses
          : index == 1
              ? AppConfig.subDocId2Adr
              : index == 2
                  ? AppConfig.subDocId3CICCMedicalCR
                  : index == 3
                      ? AppConfig.subDocId4CapReport
                      : AppConfig.subDocId5BalReport);
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _updateSelectedSubDocId(int subDocId) {
    setState(() {
      selectedSubDocId = subDocId;
      selectedSubDocType = getSubDocTypeText(subDocId);
    });
  }

  String getSubDocTypeText(int subDocId) {
    switch (subDocId) {
      case AppConfig.subDocId1Licenses:
        return "Licenses";
      case AppConfig.subDocId2Adr:
        return "ADR";
      case AppConfig.subDocId3CICCMedicalCR:
        return "Medical Cost Reports";
      case AppConfig.subDocId4CapReport:
        return "CAP Reports";
      case AppConfig.subDocId5BalReport:
        return "Quarterly Balance Reports";
      default:
        return "Unknown Document Type";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  flex: 1,
                  child: Container()),
              ///tabbar
              Expanded(
                flex: 5,
                child: Container(
                // color: Colors.greenAccent,
                  padding: EdgeInsets.only(top: AppPadding.p4),
                  width: MediaQuery.of(context).size.width /1.3,
                  height: AppSize.s60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          height: AppSize.s56,
                          width: MediaQuery.of(context).size.width / 10,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                _selectedIndex == 0 ? Colors.transparent : null,
                          ),
                          child: Column(
                            children: [
                              Text(
                                  AppStringEM.licenses,
                                textAlign: TextAlign.center,
                                  style: TransparentBgTabbar.customTextStyle(0, _selectedIndex)
                                // style: GoogleFonts.firaSans(
                                //   fontSize: FontSize.s12,
                                //   fontWeight: _selectedIndex == 0
                                //       ? FontWeightManager.bold
                                //       : FontWeightManager.regular,
                                //   color: _selectedIndex == 0
                                //       ? ColorManager.blueprime
                                //       : ColorManager.mediumgrey,
                                // ),
                              ),
                              _selectedIndex == 0
                                  ? Divider(
                                      color: ColorManager.blueprime,
                                      thickness: 2,
                                    )
                                  : Offstage()
                            ],
                          ),
                        ),
                        onTap: () => _selectButton(0),
                      ),
                      InkWell(
                        child: Container(
                          height: AppSize.s50,
                          width: MediaQuery.of(context).size.width / 10,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                _selectedIndex == 1 ? Colors.transparent : null,
                          ),
                          child: Column(
                            children: [
                              Text(
                                AppStringEM.ard,
                                textAlign: TextAlign.center,
                                  style: TransparentBgTabbar.customTextStyle(1, _selectedIndex)
                              ),
                              _selectedIndex == 1
                                  ? Divider(
                                      color: ColorManager.blueprime,
                                      thickness: 2,
                                    )
                                  : Offstage()
                            ],
                          ),
                        ),
                        onTap: () => _selectButton(1),
                      ),
                      InkWell(
                        child: Container(
                          height: AppSize.s50,
                          width: MediaQuery.of(context).size.width / 10,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                _selectedIndex == 2 ? Colors.transparent : null,
                          ),
                          child: Column(
                            children: [
                              Text(
                                  AppStringEM.mcr,
                                textAlign: TextAlign.center,
                                  style: TransparentBgTabbar.customTextStyle(2, _selectedIndex)
                              ),
                              _selectedIndex == 2
                                  ? Divider(
                                      color: ColorManager.blueprime,
                                      thickness: 2,
                                    )
                                  : Offstage()
                            ],
                          ),
                        ),
                        onTap: () => _selectButton(2),
                      ),
                      InkWell(
                        child: Container(
                          height: AppSize.s50,
                          width: MediaQuery.of(context).size.width / 10,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                _selectedIndex == 3 ? Colors.transparent : null,
                          ),
                          child: Column(
                            children: [
                              Text(
                                  AppStringEM.capReport,
                                textAlign: TextAlign.center,
                                  style: TransparentBgTabbar.customTextStyle(3, _selectedIndex)
                              ),
                              _selectedIndex == 3
                                  ? Divider(
                                      color: ColorManager.blueprime,
                                      thickness: 2,
                                    )
                                  : Offstage()
                            ],
                          ),
                        ),
                        onTap: () => _selectButton(3),
                      ),
                      InkWell(
                        child: Container(
                          height: AppSize.s50,
                          width: MediaQuery.of(context).size.width / 8,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                _selectedIndex == 4 ? Colors.transparent : null,
                          ),
                          child: Column(
                            children: [
                              Text(
                                  AppStringEM.qbr,
                                textAlign: TextAlign.center,
                                  style: TransparentBgTabbar.customTextStyle(4, _selectedIndex)
                              ),
                              _selectedIndex == 4
                                  ? Divider(
                                      color: ColorManager.blueprime,
                                      thickness: 2,
                                    )
                                  : Offstage()
                            ],
                          ),
                        ),
                        onTap: () => _selectButton(4),
                      ),
                    ],
                  ),
                ),
              ),

             ///button
              Padding(
                padding: const EdgeInsets.only(bottom: 5, right: 25),
                child: CustomIconButton(
                    icon: CupertinoIcons.plus,
                    text: "Add Document",
                    onPressed: () async {
                      String? selectedExpiryType = expiryType;
                      calenderController.clear();
                      docIdController.clear();
                      docNamecontroller.clear();
                      selectedExpiryType = "";
                      datePicked = null;
                      showDialog(
                          context: context,
                          builder: (context) {
                            return FutureBuilder<List<TypeofDocpopup>>(
                                future: getTypeofDoc(
                                    context, docTypeMetaIdCC, selectedSubDocId),
                                builder: (contex, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasData) {
                                    return UploadDocumentAddPopup(
                                      loadingDuration: _isLoading,
                                      title: 'Upload Document',
                                      officeId: widget.officeId,
                                      docTypeMetaIdCC: docTypeMetaIdCC,
                                      selectedSubDocId: selectedSubDocId,
                                      dataList: snapshot.data!,
                                    );
                                  } else {
                                    return ErrorPopUp(
                                        title: "Received Error",
                                        text: snapshot.error.toString());
                                  }
                                });
                          });
                    }),
              ),
            ],
          ),
        ),
        SizedBox(
          height: AppSize.s20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 50),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                // Page 1
                CICCLicense(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId1Licenses,
                  officeId: widget.officeId,
                ),
                CICCADR(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId2Adr,
                  officeId: widget.officeId,
                ),
                CICCMedicalCR(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId3CICCMedicalCR,
                  officeId: widget.officeId,
                ),
                CICCCAPReports(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId4CapReport,
                  officeId: widget.officeId,
                ),
                CICCQuarterlyBalReport(
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId5BalReport,
                  officeId: widget.officeId,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

