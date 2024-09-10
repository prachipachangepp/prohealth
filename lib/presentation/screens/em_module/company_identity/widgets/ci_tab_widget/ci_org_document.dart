import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_corporate&compiliance_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_policies&procedure.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_vendor_contract.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/org_add_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/establishment_text_const/text_widget_const.dart';
import '../../../../../../app/services/api/managers/establishment_manager/new_org_doc/new_org_doc.dart';
import '../../company_identity_screen.dart';

class CiOrgDocument extends StatefulWidget {
  final String officeId;
  final int? companyId;
  const CiOrgDocument({super.key, required this.officeId, this.companyId});

  @override
  State<CiOrgDocument> createState() => _CiOrgDocumentState();
}

class _CiOrgDocumentState extends State<CiOrgDocument> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  TextEditingController daysController = TextEditingController(text: "1");
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
      StreamController<List<IdentityDocumentIdData>>.broadcast();

  int _selectedIndex = 0;
  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  late Future<List<DocumentTypeData>> docTypeFuture;

  List<DocumentTypeData> docTypeData = [];
  void loadData() async {
    docTypeData = await documentTypeGet(context);
  }

  @override
  void initState() {
    super.initState();
  }

  int docTypeMetaIdPP = AppConfig.policiesAndProcedure;
  int docTypeMetaIdVC = AppConfig.vendorContracts;
  int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
  int docSubTypeMetaIdPP = AppConfig.subDocId0;
  var docID = 8;
  int docSubTypeMetaId = 0;
  String? selectedDocTypeValue;
  String? selectedSubDocTypeValue;
  String? expiryType;
  bool _isLoading = false;
  int selectedSubDocId = AppConfig.subDocId1Licenses; // Default value
  String selectedSubDocType = "";
  int selectedSubDocIdVC = AppConfig.subDocId6Leases;
  final AppConfig appConfig = AppConfig();
  String? selectedYear;

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

  void _updateSelectedSubDocIdVC(int subDocIdVC) {
    setState(() {
      selectedSubDocIdVC = subDocIdVC;
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
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 150,
            ),
            Material(
              elevation: 4,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                width: 670,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: ColorManager.blueprime),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        _selectButton(0);
                      },
                      child: Container(
                        height: 30,
                        width: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: _selectedIndex == 0
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Corporate & Compliance Documents',
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _selectedIndex == 0
                                  ? ColorManager.mediumgrey
                                  : ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        _selectButton(1);
                      },
                      child: Container(
                        height: 30,
                        width: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: _selectedIndex == 1
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Vendor Contracts',
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _selectedIndex == 1
                                  ? ColorManager.mediumgrey
                                  : ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        _selectButton(2);
                      },
                      child: Container(
                        height: 30,
                        width: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: _selectedIndex == 2
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Policies & Procedures',
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _selectedIndex == 2
                                  ? ColorManager.mediumgrey
                                  : ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),

            ///button
            _selectedIndex == 0

                ///Corporate
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 30,
                      width: 150,
                      child: CustomIconButton(
                        icon: Icons.add,
                        text: "Add Doctype",
                        onPressed: () async {
                          String? selectedExpiryType = expiryType;
                          calenderController.clear();
                          docIdController.clear();
                          docNamecontroller.clear();
                          selectedExpiryType = "";
                          selectedSubDocTypeValue = "";
                          selectedYear =AppConfig.year;
                          daysController.text = "1";
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return AddNewOrgDocButton(
                                    title: "Add Corporate & Compliance",
                                    calenderController: calenderController,
                                    idDocController: docIdController,
                                    nameDocController: docNamecontroller,
                                    loadingDuration: _isLoading,
                                    onPressed: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      int threshold = 0;
                                      if (selectedExpiryType == AppConfig.scheduled && daysController.text.isNotEmpty) {
                                        int enteredValue = int.parse(daysController.text);
                                        if (selectedYear == AppConfig.year) {
                                          threshold = enteredValue * 365;
                                        } else if (selectedYear == AppConfig.month) {
                                          threshold = enteredValue * 30;
                                        }
                                      }

                                      int subDocId = _selectedIndex == 0
                                          ? AppConfig.subDocId1Licenses
                                          : _selectedIndex == 1
                                              ? AppConfig.subDocId2Adr
                                              : _selectedIndex == 2
                                                  ? AppConfig
                                                      .subDocId3CICCMedicalCR
                                                  : _selectedIndex == 3
                                                      ? AppConfig
                                                          .subDocId4CapReport
                                                      : AppConfig
                                                          .subDocId5BalReport;
                                      try {
                                        await addNewOrgDocumentPost(
                                          context: context,
                                          docName: docNamecontroller.text,
                                          docTypeID: docTypeMetaIdCC,
                                          docSubTypeID: selectedSubDocId,
                                          threshold: threshold,
                                          expiryType: selectedExpiryType.toString(),
                                          expiryDate: null, //expiryTypeToSend,
                                          expiryReminder: selectedExpiryType.toString(),
                                          idOfDoc: docIdController.text,
                                        );
                                        Navigator.pop(context);
                                      } finally {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                                    // Document Type Dropdown (Disabled and Showing Vendor Contract)
                                    child: FutureBuilder<List<DocumentTypeData>>(
                                      future: documentTypeGet(context),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: 300,
                                            child: loadingText,
                                          );
                                        }
                                        if (snapshot.data!.isEmpty) {
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
                                          String selectedDocType = "";
                                          int docType = snapshot.data![0].docID;

                                          for (var i in snapshot.data!) {
                                            if (i.docID ==
                                                AppConfig
                                                    .corporateAndCompliance) {
                                              selectedDocType = i.docType;
                                              docType = i.docID;
                                              break;
                                            }
                                          }
                                          docTypeMetaIdCC = docType;
                                          identityDocumentTypeGet(
                                                  context, docTypeMetaIdCC)
                                              .then((data) {
                                            _identityDataController.add(data);
                                          }).catchError((error) {
                                            // Handle error
                                          });
                                          return Container(
                                            width: 354,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: ColorManager.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color:
                                                      ColorManager.fmediumgrey,
                                                  width: 1),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  selectedDocType,
                                                  style: CustomTextStylesCommon
                                                      .commonStyle(
                                                    fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                    fontSize: FontSize.s12,
                                                    color:
                                                        ColorManager.mediumgrey,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.transparent,
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                    selectedSubDocType: selectedSubDocType,
                                    child1: Container(
                                      width: 354,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: ColorManager.fmediumgrey,
                                            width: 1),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedSubDocType,
                                            style: CustomTextStylesCommon
                                                .commonStyle(
                                              fontWeight:
                                                  FontWeightManager.medium,
                                              fontSize: FontSize.s12,
                                              color: ColorManager.mediumgrey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // CICCDropDownExcel(
                                    //   isEnabled: false,
                                    //   initialValue: selectedSubDocType, // Use the updated value
                                    //   onChange: (val) {
                                    //     setState(() {
                                    //       selectedSubDocTypeValue = val;
                                    //     });
                                    //   },
                                    //   items: [DropdownMenuItem<String>(
                                    //     value: selectedSubDocType, // Display the current selection
                                    //     child: Text("Selected Sub Document Type: $selectedSubDocType"),
                                    //   )],
                                    // ),
                                    ///
                                    // child1: CICCDropDownExcel(
                                    //   isEnabled: false,
                                    //   initialValue: selectedSubDocType,
                                    //   onChange: (val) {
                                    //     setState(() {
                                    //       selectedSubDocTypeValue = val;
                                    //     });
                                    //   },
                                    //   items: [DropdownMenuItem<String>(
                                    //     value: selectedSubDocType,
                                    //     child: Text(selectedSubDocType),
                                    //   )],
                                    //   // hintText: "Select Sub Document",
                                    // ),
                                    radioButton: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Expiry Type",
                                            style: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          CustomRadioListTile(
                                            value: AppConfig.notApplicable,
                                            groupValue: selectedExpiryType,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedExpiryType = value;
                                              });
                                            },
                                            title: AppConfig.notApplicable,
                                          ),
                                          CustomRadioListTile(
                                            value: AppConfig.scheduled,
                                            groupValue: selectedExpiryType,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedExpiryType = value;
                                              });
                                            },
                                            title: AppConfig.scheduled,
                                          ),
                                          CustomRadioListTile(
                                            value: AppConfig.issuer,
                                            groupValue: selectedExpiryType,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedExpiryType = value;
                                              });
                                            },
                                            title: AppConfig.issuer,
                                          ),
                                        ],
                                      ),
                                    ),
                                    child3: Visibility(
                                      visible:
                                          selectedExpiryType == AppConfig.scheduled,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 28,
                                                width: 50,
                                                //color: ColorManager.red,
                                                child: TextFormField(
                                                  controller:
                                                      daysController, // Use the controller initialized with "1"
                                                  cursorColor:
                                                      ColorManager.black,
                                                  cursorWidth: 1,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s10,
                                                    fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                    color:
                                                        ColorManager.mediumgrey,
                                                  ),
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ColorManager
                                                              .fmediumgrey,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly, // This ensures only digits are accepted
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 30,
                                                width: 80,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .fmediumgrey),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  value:
                                                      selectedYear, // Initial value (you should define this variable)
                                                  items: [
                                                    DropdownMenuItem(
                                                      value: AppConfig.year,
                                                      child: Text(
                                                        AppConfig.year,
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          fontSize:
                                                              FontSize.s10,
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                          color: ColorManager
                                                              .mediumgrey,
                                                        ),
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: AppConfig.month,
                                                      child: Text(
                                                        AppConfig.month,
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          fontSize:
                                                              FontSize.s10,
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                          color: ColorManager
                                                              .mediumgrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedYear =
                                                          value; // Update the selected option (Year/Month)
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    hintText: AppConfig.year,
                                                    hintStyle:
                                                        GoogleFonts.firaSans(
                                                      fontSize: FontSize.s10,
                                                      fontWeight:
                                                          FontWeightManager
                                                              .medium,
                                                      color: ColorManager
                                                          .mediumgrey,
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 20),
                                                  ),
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: ColorManager.black,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                : _selectedIndex == 1

                    ///vendor
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 30,
                          width: 150,
                          child: CustomIconButton(
                            icon: Icons.add,
                            text: "Add Doctype",
                            onPressed: () async {
                              String? selectedExpiryType = expiryType;
                              calenderController.clear();
                              docIdController.clear();
                              docNamecontroller.clear();
                              selectedExpiryType = "";
                              selectedSubDocTypeValue = "";
                              selectedYear = AppConfig.year;
                              daysController.text = "1";
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return AddNewOrgDocButton(
                                        title: "Add Vendor Contract",
                                        calenderController: calenderController,
                                        idDocController: docIdController,
                                        nameDocController: docNamecontroller,
                                        loadingDuration: _isLoading,
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          int threshold = 0;
                                          if (selectedExpiryType == AppConfig.scheduled && daysController.text.isNotEmpty) {
                                            int enteredValue = int.parse(daysController.text);
                                            if (selectedYear == AppConfig.year) {
                                              threshold = enteredValue * 365;
                                            } else if (selectedYear == AppConfig.month) {
                                              threshold = enteredValue * 30;
                                            }
                                          }

                                          int subDocId = _selectedIndex == 0
                                              ? AppConfig.subDocId6Leases
                                              : _selectedIndex == 1
                                                  ? AppConfig.subDocId7SNF
                                                  : _selectedIndex == 2
                                                      ? AppConfig.subDocId8DME
                                                      : _selectedIndex == 3
                                                          ? AppConfig
                                                              .subDocId9MD
                                                          : AppConfig
                                                              .subDocId10MISC;
                                          try {
                                            await addNewOrgDocumentPost(
                                              context: context,
                                              docName: docNamecontroller.text,
                                              docTypeID: docTypeMetaIdVC,
                                              docSubTypeID: selectedSubDocIdVC,
                                              threshold: threshold,
                                              expiryType: selectedExpiryType.toString(),
                                              expiryDate: null,
                                              expiryReminder: selectedExpiryType.toString(),
                                              idOfDoc: docIdController.text,
                                            );
                                            Navigator.pop(context);
                                          } finally {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }
                                        },
                                        child: FutureBuilder<List<DocumentTypeData>>(
                                          future: documentTypeGet(context),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Container(
                                                width: 300,
                                                child: Text(
                                                  'Loading...',
                                                  style: CustomTextStylesCommon
                                                      .commonStyle(
                                                    fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                    fontSize: FontSize.s12,
                                                    color:
                                                        ColorManager.mediumgrey,
                                                  ),
                                                ),
                                              );
                                            }
                                            if (snapshot.data!.isEmpty) {
                                              return Center(
                                                child: Text(
                                                  AppString.dataNotFound,
                                                  style: CustomTextStylesCommon
                                                      .commonStyle(
                                                    fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                    fontSize: FontSize.s12,
                                                    color:
                                                        ColorManager.mediumgrey,
                                                  ),
                                                ),
                                              );
                                            }
                                            if (snapshot.hasData) {
                                              String selectedDocType = "";
                                              int docType =
                                                  snapshot.data![0].docID;

                                              for (var i in snapshot.data!) {
                                                if (i.docID ==
                                                    AppConfig.vendorContracts) {
                                                  selectedDocType = i.docType;
                                                  docType = i.docID;
                                                  break;
                                                }
                                              }

                                              docTypeMetaIdVC = docType;

                                              identityDocumentTypeGet(
                                                      context, docTypeMetaIdVC)
                                                  .then((data) {
                                                _identityDataController
                                                    .add(data);
                                              }).catchError((error) {
                                                // Handle error
                                              });
                                              return Container(
                                                width: 354,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3,
                                                    horizontal: 12),
                                                decoration: BoxDecoration(
                                                  color: ColorManager.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .fmediumgrey,
                                                      width: 1),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      selectedDocType,
                                                      style:
                                                          CustomTextStylesCommon
                                                              .commonStyle(
                                                        fontWeight:
                                                            FontWeightManager
                                                                .medium,
                                                        fontSize: FontSize.s12,
                                                        color: ColorManager
                                                            .mediumgrey,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.transparent,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          },
                                        ),
                                        selectedSubDocType: selectedSubDocType,
                                        child1: Container(
                                          width: 354,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: ColorManager.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: ColorManager.fmediumgrey,
                                                width: 1),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                selectedSubDocType,
                                                style: CustomTextStylesCommon
                                                    .commonStyle(
                                                  fontWeight:
                                                      FontWeightManager.medium,
                                                  fontSize: FontSize.s12,
                                                  color:
                                                      ColorManager.mediumgrey,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.transparent,
                                              ),
                                            ],
                                          ),
                                        ),
                                        radioButton: selectedSubDocType == AppConfig.misc
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Expiry Type",
                                                      style:
                                                          GoogleFonts.firaSans(
                                                        fontSize: FontSize.s12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ColorManager
                                                            .mediumgrey,
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    ),
                                                    CustomRadioListTile(
                                                      value: AppConfig.scheduled,
                                                      groupValue:
                                                          selectedExpiryType,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedExpiryType =
                                                              value;
                                                        });
                                                      },
                                                      title: AppConfig.scheduled,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Expiry Type",
                                                style:
                                                GoogleFonts.firaSans(
                                                  fontSize: FontSize.s12,
                                                  fontWeight:
                                                  FontWeight.w700,
                                                  color: ColorManager
                                                      .mediumgrey,
                                                  decoration:
                                                  TextDecoration.none,
                                                ),
                                              ),
                                              CustomRadioListTile(
                                                value:AppConfig.notApplicable,
                                                groupValue:
                                                selectedExpiryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedExpiryType =
                                                        value;
                                                  });
                                                },
                                                title: AppConfig.notApplicable,
                                              ),
                                              CustomRadioListTile(
                                                value: AppConfig.scheduled,
                                                groupValue:
                                                selectedExpiryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedExpiryType =
                                                        value;
                                                  });
                                                },
                                                title: AppConfig.scheduled,
                                              ),
                                              CustomRadioListTile(
                                                value: AppConfig.issuer,
                                                groupValue:
                                                selectedExpiryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedExpiryType =
                                                        value;
                                                  });
                                                },
                                                title: AppConfig.issuer,
                                              ),
                                            ],
                                          ),
                                        ),
                                        child3: Visibility(
                                          visible:
                                          selectedExpiryType == AppConfig.scheduled,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 28,
                                                    width: 50,
                                                    //color: ColorManager.red,
                                                    child: TextFormField(
                                                      controller:
                                                      daysController, // Use the controller initialized with "1"
                                                      cursorColor:
                                                      ColorManager.black,
                                                      cursorWidth: 1,
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: FontSize.s10,
                                                        fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                        color:
                                                        ColorManager.mediumgrey,
                                                      ),
                                                      decoration: InputDecoration(
                                                        enabledBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: ColorManager
                                                                  .fmediumgrey,
                                                              width: 2),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: ColorManager
                                                                  .fmediumgrey,
                                                              width: 2),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                      ),
                                                      keyboardType:
                                                      TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.digitsOnly, // This ensures only digits are accepted
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    height: 30,
                                                    width: 80,
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorManager
                                                              .fmediumgrey),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                    ),
                                                    child: DropdownButtonFormField<
                                                        String>(
                                                      value:
                                                      selectedYear, // Initial value (you should define this variable)
                                                      items: [
                                                        DropdownMenuItem(
                                                          value: AppConfig.year,
                                                          child: Text(
                                                            AppConfig.year,
                                                            style: GoogleFonts
                                                                .firaSans(
                                                              fontSize:
                                                              FontSize.s10,
                                                              fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                              color: ColorManager
                                                                  .mediumgrey,
                                                            ),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: AppConfig.month,
                                                          child: Text(
                                                            AppConfig.month,
                                                            style: GoogleFonts
                                                                .firaSans(
                                                              fontSize:
                                                              FontSize.s10,
                                                              fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                              color: ColorManager
                                                                  .mediumgrey,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedYear = value; // Update the selected option (Year/Month)
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                        enabledBorder:
                                                        InputBorder.none,
                                                        focusedBorder:
                                                        InputBorder.none,
                                                        hintText: AppConfig.year,
                                                        hintStyle:
                                                        GoogleFonts.firaSans(
                                                          fontSize: FontSize.s10,
                                                          fontWeight:
                                                          FontWeightManager
                                                              .medium,
                                                          color: ColorManager
                                                              .mediumgrey,
                                                        ),
                                                        contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 20),
                                                      ),
                                                      icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: ColorManager.black,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )

                    ///Policies
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 30,
                          width: 150,
                          child: CustomIconButton(
                            icon: Icons.add,
                            text: "Add Doctype",
                            onPressed: () async {
                              String? selectedDocType;
                              String? selectedSubDocType;
                              String? selectedExpiryType = expiryType;
                              calenderController.clear();
                              docIdController.clear();
                              docNamecontroller.clear();
                              selectedExpiryType = "";
                              selectedDocTypeValue = "";
                              selectedSubDocTypeValue = "";
                              daysController.clear();
                              selectedYear = AppConfig.year;
                              daysController.text = "1";
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return AddNewOrgDocButton(
                                        calenderController: calenderController,
                                        idDocController: docIdController,
                                        nameDocController: docNamecontroller,
                                        loadingDuration: _isLoading,
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });

                                          int threshold = 0;
                                          if (selectedExpiryType == AppConfig.scheduled && daysController.text.isNotEmpty) {
                                            int enteredValue = int.parse(daysController.text);
                                            if (selectedYear == AppConfig.year) {
                                              threshold = enteredValue * 365;
                                            } else if (selectedYear == AppConfig.month) {
                                              threshold = enteredValue * 30;
                                            }
                                          }
                                          try {
                                            await addNewOrgDocumentPost(
                                                context: context,
                                                docName: docNamecontroller.text,
                                                docTypeID: docTypeMetaIdPP,
                                                docSubTypeID: docTypeMetaIdPP == AppConfig.policiesAndProcedure ? 0 : docSubTypeMetaIdPP,
                                                threshold: threshold,
                                                expiryType: selectedExpiryType.toString(),
                                                expiryDate: null, //expiryTypeToSend,
                                                expiryReminder: selectedExpiryType.toString(),
                                                idOfDoc: docIdController.text);
                                            await getNewOrgDocument(context);
                                            Navigator.pop(context);
                                            setState(() {
                                              expiryType = '';
                                              calenderController.clear();
                                              docIdController.clear();
                                              docNamecontroller.clear();
                                              daysController.clear();
                                            });
                                          } finally {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }
                                        },
                                        child: FutureBuilder<List<DocumentTypeData>>(
                                          future: documentTypeGet(context),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Container(
                                                width: 300,
                                                child: Text(
                                                  'Loading...',
                                                  style: CustomTextStylesCommon
                                                      .commonStyle(
                                                    fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                    fontSize: FontSize.s12,
                                                    color:
                                                        ColorManager.mediumgrey,
                                                  ),
                                                ),
                                              );
                                            }
                                            if (snapshot.data!.isEmpty) {
                                              return Center(
                                                child: Text(
                                                  ErrorMessageString
                                                      .noAvailableSubType,
                                                  //AppString.dataNotFound,
                                                  style: CustomTextStylesCommon
                                                      .commonStyle(
                                                    fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                    fontSize: FontSize.s12,
                                                    color:
                                                        ColorManager.mediumgrey,
                                                  ),
                                                ),
                                              );
                                            }
                                            if (snapshot.hasData) {
                                              String selectedDocType = "";
                                              int docType =
                                                  snapshot.data![0].docID;

                                              for (var i in snapshot.data!) {
                                                if (i.docID ==
                                                    AppConfig
                                                        .policiesAndProcedure) {
                                                  selectedDocType = i.docType;
                                                  docType = i.docID;
                                                  break;
                                                }
                                              }

                                              docTypeMetaIdPP = docType;

                                              identityDocumentTypeGet(
                                                      context, docTypeMetaIdPP)
                                                  .then((data) {
                                                _identityDataController
                                                    .add(data);
                                              }).catchError((error) {
                                                // Handle error
                                              });
                                              return Container(
                                                width: 354,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3,
                                                    horizontal: 12),
                                                decoration: BoxDecoration(
                                                  color: ColorManager.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .fmediumgrey,
                                                      width: 1),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      selectedDocType,
                                                      style:
                                                          CustomTextStylesCommon
                                                              .commonStyle(
                                                        fontWeight:
                                                            FontWeightManager
                                                                .medium,
                                                        fontSize: FontSize.s12,
                                                        color: ColorManager
                                                            .mediumgrey,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.transparent,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          },
                                        ),
                                        radioButton: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Expiry Type",
                                                style: GoogleFonts.firaSans(
                                                  fontSize: FontSize.s12,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      ColorManager.mediumgrey,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                              CustomRadioListTile(
                                                value: AppConfig.notApplicable,
                                                groupValue: selectedExpiryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedExpiryType = value;
                                                  });
                                                },
                                                title: AppConfig.notApplicable,
                                              ),
                                              CustomRadioListTile(
                                                value: AppConfig.scheduled,
                                                groupValue: selectedExpiryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedExpiryType = value;
                                                  });
                                                },
                                                title: AppConfig.scheduled,
                                              ),
                                              CustomRadioListTile(
                                                value: AppConfig.issuer,
                                                groupValue: selectedExpiryType,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedExpiryType = value;
                                                  });
                                                },
                                                title: AppConfig.issuer,
                                              ),
                                            ],
                                          ),
                                        ),
                                        child3: Visibility(
                                          visible:
                                          selectedExpiryType == AppConfig.scheduled,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 28,
                                                    width: 50,
                                                    //color: ColorManager.red,
                                                    child: TextFormField(
                                                      controller:
                                                      daysController, // Use the controller initialized with "1"
                                                      cursorColor:
                                                      ColorManager.black,
                                                      cursorWidth: 1,
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: FontSize.s10,
                                                        fontWeight:
                                                        FontWeightManager
                                                            .medium,
                                                        color:
                                                        ColorManager.mediumgrey,
                                                      ),
                                                      decoration: InputDecoration(
                                                        enabledBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: ColorManager
                                                                  .fmediumgrey,
                                                              width: 2),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: ColorManager
                                                                  .fmediumgrey,
                                                              width: 2),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                        ),
                                                        contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                      ),
                                                      keyboardType:
                                                      TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.digitsOnly, // This ensures only digits are accepted
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    height: 30,
                                                    width: 80,
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorManager
                                                              .fmediumgrey),
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                    ),
                                                    child: DropdownButtonFormField<
                                                        String>(
                                                      value:
                                                      selectedYear, // Initial value (you should define this variable)
                                                      items: [
                                                        DropdownMenuItem(
                                                          value: AppConfig.year,
                                                          child: Text(
                                                            AppConfig.year,
                                                            style: GoogleFonts
                                                                .firaSans(
                                                              fontSize:
                                                              FontSize.s10,
                                                              fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                              color: ColorManager
                                                                  .mediumgrey,
                                                            ),
                                                          ),
                                                        ),
                                                        DropdownMenuItem(
                                                          value: AppConfig.month,
                                                          child: Text(
                                                            AppConfig.month,
                                                            style: GoogleFonts
                                                                .firaSans(
                                                              fontSize:
                                                              FontSize.s10,
                                                              fontWeight:
                                                              FontWeightManager
                                                                  .medium,
                                                              color: ColorManager
                                                                  .mediumgrey,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedYear =
                                                              value; // Update the selected option (Year/Month)
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                        enabledBorder:
                                                        InputBorder.none,
                                                        focusedBorder:
                                                        InputBorder.none,
                                                        hintText: AppConfig.year,
                                                        hintStyle:
                                                        GoogleFonts.firaSans(
                                                          fontSize: FontSize.s10,
                                                          fontWeight: FontWeightManager.medium,
                                                          color: ColorManager.mediumgrey,
                                                        ),
                                                        contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 20),
                                                      ),
                                                      icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: ColorManager.black,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        title: 'Add Policies & Procedures',
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ))
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: Stack(
            children: [
              _selectedIndex != 5
                  ? Container(
                      // height: MediaQuery.of(context).size.height / 3.5,
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F9FC),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.faintGrey,
                              blurRadius: 2,
                              spreadRadius: -2,
                              offset: Offset(0, -4),
                            ),
                          ]),
                    )
                  : Offstage(),
              NonScrollablePageView(
                controller: _tabPageController,
                onPageChanged: (index) {
                  // setState(() {
                  _selectedIndex = index;
                  // });
                },
                children: [
                  // Page 1
                  CICorporateCompilianceDocument(
                    docID: AppConfig.corporateAndCompliance,
                    selectedSubDocType: selectedSubDocType,
                    onSubDocIdSelected:
                        _updateSelectedSubDocId, //officeId: widget.officeId,
                  ),
                  CIVendorContract(
                    docId: AppConfig.vendorContracts,
                    onSubDocIdSelected: _updateSelectedSubDocIdVC,
                    selectedSubDocType:
                        selectedSubDocType, //officeId: widget.officeId
                  ),
                  CIPoliciesProcedure(
                    docId: AppConfig.policiesAndProcedure,
                    subDocId: AppConfig.subDocId0,
                    //officeId: widget.officeId,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
