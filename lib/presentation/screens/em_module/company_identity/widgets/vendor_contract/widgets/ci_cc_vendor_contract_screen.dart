import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_insurance_manager/manage_corporate_compliance.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/newpopup_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/newpopup.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/leasas_services.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/snf.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/vendor_contract/widgets/vendor_add_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../company_identity_screen.dart';
import '../../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../dme.dart';
import '../md.dart';
import '../misc.dart';

class CiCcVendorContractScreen extends StatefulWidget {
  final int docId;
  final int companyID;
  final String officeId;
  const CiCcVendorContractScreen(
      {super.key,
      required this.companyID,
      required this.officeId,
      required this.docId});

  @override
  State<CiCcVendorContractScreen> createState() =>
      _CiCcVendorContractScreenState();
}

class _CiCcVendorContractScreenState extends State<CiCcVendorContractScreen> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController nameOfDocController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  TextEditingController editnameOfDocController = TextEditingController();
  TextEditingController editidOfDocController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
      StreamController<List<IdentityDocumentIdData>>.broadcast();

  int _selectedIndex = 0;
 // int docTypeMetaId = 8;
  int docSubTypeMetaId = 0;
  int docTypeMetaIdVC = AppConfig.vendorContracts;
  String? expiryType;
  bool _isLoading = false;
  String? selectedDocTypeValue;
  String? selectedSubDocTypeValue;
  String selectedSubDocType = "";
  int selectedSubDocIdVC = AppConfig.subDocId6Leases;
  dynamic filePath;
  late Future<List<DocumentTypeData>> docTypeFuture;
  TextEditingController expiryDateController = TextEditingController();
  int selectedSubDocId = AppConfig.subDocId6Leases;
  bool showExpiryDateField = false;
  int docTypeId = 0;

  @override
  void initState() {
    super.initState();
    selectedDocTypeValue = "Select Document Type";
    selectedSubDocTypeValue = "Select Sub Document";
    docTypeFuture = documentTypeGet(context);
    _updateSelectedSubDocIdVC(selectedSubDocId);
    showExpiryDateField;
  }

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;

      _updateSelectedSubDocIdVC(
          index == 0 ? AppConfig.subDocId6Leases :
          index == 1 ? AppConfig.subDocId7SNF :
          index == 2 ? AppConfig.subDocId8DME :
          index == 3 ? AppConfig.subDocId9MD :
          AppConfig.subDocId10MISC
      );
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
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


  void _updateSelectedSubDocIdVC(int subDocIdVC) {
    setState(() {
      selectedSubDocId = subDocIdVC;
      selectedSubDocType = getSubDocTypeTextVC(subDocIdVC);
    });
  }

  String getSubDocTypeTextVC(int subDocIdVC) {
    switch (subDocIdVC) {
      case AppConfig.subDocId6Leases:
        return "Leases & Services";
      case AppConfig.subDocId7SNF:
        return "SNF";
      case AppConfig.subDocId8DME:
        return "DME";
      case AppConfig.subDocId9MD:
        return "MD";
      case AppConfig.subDocId10MISC:
        return "MISC";
      default:
        return "Unknown Document Type";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Container(
                // color: Colors.greenAccent,
                padding: EdgeInsets.only(top: AppPadding.p6),
                width: MediaQuery.of(context).size.width / 1.7,
                height: AppSize.s60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Container(
                        height: AppSize.s56,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                          _selectedIndex == 0 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Leases & Services',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: _selectedIndex == 0
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 0
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
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
                        height: 50,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                          _selectedIndex == 1 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'SNF',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: _selectedIndex == 1
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 1
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
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
                        height: 50,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                          _selectedIndex == 2 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'DME',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: _selectedIndex == 2
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 2
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
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
                        height: 50,
                        width: MediaQuery.of(context).size.width /12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                          _selectedIndex == 3 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'MD',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: _selectedIndex == 3
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 3
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
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
                        height: 50,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                          _selectedIndex == 4 ? Colors.transparent : null,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'MISC',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: _selectedIndex == 4
                                    ? FontWeightManager.bold
                                    : FontWeightManager.regular,
                                color: _selectedIndex == 4
                                    ? ColorManager.blueprime
                                    : ColorManager.mediumgrey,
                              ),
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
              SizedBox(
                width: MediaQuery.of(context).size.width / 9,
              ),
              CustomIconButton(
                  icon: CupertinoIcons.plus,
                  text: "Add Document",
                  onPressed: () async {
                    String? selectedExpiryType = expiryType;
                    calenderController.clear();
                    docIdController.clear();
                    docNamecontroller.clear();
                    selectedExpiryType = "";
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              String? documentID;
                              return VCScreenPopupADDConst(
                                loadingDuration: _isLoading,
                                onPressed: () async {
                                  //  print('File path on pressed ${filePath}');
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  print("Id document ${documentID}");

                                  ///Add Doctype API on save button
                                  try {
                                    ApiData response = await addOrgDocPPPost(
                                      context: context,
                                      orgDocumentSetupid: docTypeId,
                                      idOfDocument: documentID!,
                                      expiryDate:
                                      // selectedExpiryType.toString(),
                                      expiryDateController.text,
                                      docCreated: DateTime.now().toIso8601String()+"Z",
                                      url: "url",
                                      officeId: widget.officeId,
                                    );
                                    expiryDateController.clear();
                                    if (response.statusCode == 200 ||
                                        response.statusCode == 201) {
                                      await uploadDocumentsoffice(
                                          context: context,
                                          documentFile: filePath,
                                          orgOfficeDocumentId:
                                          response.orgOfficeDocumentId!);
                                    }
                                  }

                                  finally {
                                    setState(() {
                                      _isLoading = false;
                                      Navigator.pop(context);
                                    });
                                  }

                                },
                                title: 'Upload Document',
                                child:FutureBuilder<List<TypeofDocpopup>>(
                                  future: getTypeofDoc(context,
                                      docTypeMetaIdVC, selectedSubDocId) ,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width: 350,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      );
                                    }

                                    if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          AppString.dataNotFound,
                                          style: CustomTextStylesCommon
                                              .commonStyle(
                                            fontWeight:
                                            FontWeightManager.medium,
                                            fontSize: FontSize.s12,
                                            color: ColorManager.mediumgrey,
                                          ),
                                        ),
                                      );
                                    }

                                    if (snapshot.hasData) {
                                      List<DropdownMenuItem<String>>
                                      dropDownMenuItems = snapshot.data!
                                          .map((doc) =>
                                          DropdownMenuItem<String>(
                                            value: doc.docname,
                                            child: Text(doc.docname!),
                                          ))
                                          .toList();

                                      return
                                        ///
                                        StatefulBuilder(
                                          builder: (context, setState) {
                                            return Column(
                                              children: [
                                                CICCDropdown(
                                                  initialValue: "Select",
                                                  onChange: (val) {
                                                    setState(() {
                                                      // Always reset the expiry field visibility to false initially
                                                      showExpiryDateField = false;
                                                      // Loop through the documents and check the selected value
                                                      for (var doc in snapshot.data!) {
                                                        if (doc.docname ==
                                                            val) {
                                                          docTypeId = doc.orgDocumentSetupid!;
                                                          documentID = doc.docname;

                                                          // Show expiry date field only if expirytype is "issuer expiry"
                                                          if (doc.expirytype ==
                                                              AppConfig
                                                                  .issuer) {
                                                            showExpiryDateField =
                                                            true;
                                                          }
                                                        }
                                                      }
                                                    });
                                                  },
                                                  items: dropDownMenuItems,
                                                ),
                                                Visibility(
                                                  visible: showExpiryDateField,

                                                  /// Conditionally display expiry date field
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        top: 8.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 352,
                                                      child: TextField(
                                                        controller:
                                                        expiryDateController,
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          fontSize:
                                                          FontSize.s12,
                                                          fontWeight:
                                                          FontWeightManager
                                                              .bold,
                                                          color: ColorManager
                                                              .mediumgrey,
                                                        ),
                                                        readOnly: true,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText:
                                                          "Expiry Date",
                                                          labelStyle:
                                                          GoogleFonts
                                                              .firaSans(
                                                            fontSize:
                                                            FontSize.s12,
                                                            fontWeight:
                                                            FontWeightManager
                                                                .semiBold,
                                                            color: ColorManager
                                                                .mediumgrey,
                                                          ),
                                                          suffixIcon:
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                size: 16),
                                                            onPressed:
                                                                () async {
                                                              DateTime?
                                                              pickedDate =
                                                              await showDatePicker(
                                                                context:
                                                                context,
                                                                initialDate:
                                                                DateTime
                                                                    .now(),
                                                                firstDate:
                                                                DateTime(
                                                                    2000),
                                                                lastDate:
                                                                DateTime(
                                                                    2101),
                                                              );
                                                              if (pickedDate !=
                                                                  null) {
                                                                setState(() {
                                                                  expiryDateController
                                                                      .text = DateFormat(
                                                                      'yyyy-MM-dd')
                                                                      .format(
                                                                      pickedDate);
                                                                });
                                                              }
                                                            },
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: ColorManager
                                                                      .fmediumgrey)),
                                                          contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.0,
                                                              horizontal:
                                                              10.0), // Adjust padding
                                                          hintText:
                                                          'YYYY-MM-DD',
                                                          hintStyle: GoogleFonts
                                                              .firaSans(
                                                            fontSize:
                                                            FontSize.s12,
                                                            fontWeight:
                                                            FontWeightManager
                                                                .bold,
                                                            color: ColorManager
                                                                .mediumgrey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        });
                  }),
            ],
          ),
        ),
        SizedBox(
          height: 20,
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
                CiLeasesAndServices(
                  companyID: widget.companyID,
                  officeId: widget.officeId,
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId6Leases,
                ),
                CiSnf(
                  companyID: widget.companyID,
                  officeId: widget.officeId,
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId7SNF,
                ),
                CiDme(
                  companyID: widget.companyID,
                  officeId: widget.officeId,
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId8DME,
                ),
                CiMd(
                  companyID: widget.companyID,
                  officeId: widget.officeId,
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId9MD,
                ),
                CiMisc(
                  companyID: widget.companyID,
                  officeId: widget.officeId,
                  docId: widget.docId,
                  subDocId: AppConfig.subDocId10MISC,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
