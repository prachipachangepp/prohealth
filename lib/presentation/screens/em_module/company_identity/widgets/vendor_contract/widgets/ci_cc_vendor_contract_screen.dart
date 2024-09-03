import 'dart:async';

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
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
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
  late Future<List<DocumentTypeData>> docTypeFuture;
  @override
  void initState() {
    super.initState();
    selectedDocTypeValue = "Select Document Type";
    selectedSubDocTypeValue = "Select Sub Document";
    docTypeFuture = documentTypeGet(context);
  }

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
                padding: EdgeInsets.only(top: AppPadding.p8),
                width: MediaQuery.of(context).size.width / 1.7,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 12,
                        padding: EdgeInsets.symmetric(vertical: 6),
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
                text: "Add Doctype",
                onPressed: () async {
                  String? selectedExpiryType = expiryType;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, void Function(void Function()) setState) {
                          return AddOrgDocButton(
                            calenderController: calenderController,
                            idDocController: docIdController,
                            nameDocController: docNamecontroller,
                            loadingDuration: _isLoading,
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              String expiryTypeToSend =
                              selectedExpiryType == "Not Applicable"
                                  ? "Not Applicable"
                                  : calenderController.text;
                              try {
                                await addManageCCVCPPPost(
                                  context: context,
                                  name: docNamecontroller.text,
                                  docTypeID: docTypeMetaIdVC,
                                  docSubTypeID: docSubTypeMetaId,
                                  expiryType: selectedExpiryType.toString(),
                                  expiryDate: calenderController.text,//expiryTypeToSend,
                                  expiryReminder: selectedExpiryType.toString(),
                                  officeId: widget.officeId,
                                  idOfDoc: docIdController.text,
                                );
                                Navigator.pop(context);
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child:FutureBuilder<List<DocumentTypeData>>(
                              future: documentTypeGet(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Container(
                                    width: 300,
                                    child: Text(
                                      'Loading...',
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontWeight: FontWeightManager.medium,
                                        fontSize: FontSize.s12,
                                        color: ColorManager.mediumgrey,
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      AppString.dataNotFound,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontWeight: FontWeightManager.medium,
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
                                    if (i.docID == AppConfig.vendorContracts) {
                                      selectedDocType = i.docType;
                                      docType = i.docID;
                                      break;
                                    }
                                  }

                                  docTypeMetaIdVC = docType;

                                  identityDocumentTypeGet(context, docTypeMetaIdVC).then((data) {
                                    _identityDataController.add(data);
                                  }).catchError((error) {
                                    // Handle error
                                  });
                                  return Container(
                                    width: 354,
                                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          selectedDocType,
                                          style: CustomTextStylesCommon.commonStyle(
                                            fontWeight: FontWeightManager.medium,
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
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                            child1: StreamBuilder<List<IdentityDocumentIdData>>(
                              stream: _identityDataController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                  List<DropdownMenuItem<String>> dropDownMenuItems = [];

                                  // Create dropdown items from the fetched data
                                  for (var i in snapshot.data!) {
                                    dropDownMenuItems.add(
                                      DropdownMenuItem<String>(
                                        value: i.subDocType,
                                        child: Text(i.subDocType),
                                      ),
                                    );
                                  }

                                  // Return the CICCDropdown with "Select Sub Document" as the initial value
                                  return CICCDropDownExcel(
                                    initialValue: "Select Sub Document",
                                    onChange: (val) {
                                      if (val != "Select Sub Document") {
                                        for (var a in snapshot.data!) {
                                          if (a.subDocType == val) {
                                            docSubTypeMetaId = a.subDocID;
                                          }
                                        }
                                      }
                                    },
                                    items: dropDownMenuItems,
                                    hintText: "Select Sub Document",
                                  );
                                } else if (snapshot.connectionState == ConnectionState.waiting) {
                                  return SizedBox();
                                } else {
                                  return Center(
                                    child: Text(
                                      AppString.dataNotFound,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontWeight: FontWeightManager.medium,
                                        fontSize: FontSize.s12,
                                        color: ColorManager.mediumgrey,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            radioButton: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    value: "Not Applicable",
                                    groupValue: selectedExpiryType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedExpiryType = value;
                                      });
                                    },
                                    title: "Not Applicable",
                                  ),
                                  CustomRadioListTile(
                                    value: 'Scheduled',
                                    groupValue: selectedExpiryType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedExpiryType = value;
                                      });
                                    },
                                    title: 'Scheduled',
                                  ),
                                  CustomRadioListTile(
                                    value: 'Issuer Expiry',
                                    groupValue: selectedExpiryType,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedExpiryType = value;
                                      });
                                    },
                                    title: 'Issuer Expiry',
                                  ),
                                ],
                              ),
                            ),
                            child2: Visibility(
                              visible: selectedExpiryType == "Scheduled" || selectedExpiryType == "Issuer Expiry",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expiry Date",
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.mediumgrey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  SizedBox(height: AppSize.s5,),
                                  FormField<String>(
                                    builder: (FormFieldState<String> field) {
                                      return SizedBox(
                                        width: 354,
                                        height: 30,
                                        child: TextFormField(
                                          controller: calenderController,
                                          cursorColor: ColorManager.black,
                                          style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorManager.mediumgrey,
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            hintText: 'mm-dd-yyyy',
                                            hintStyle: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(width: 1, color: ColorManager.fmediumgrey),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                            suffixIcon: Icon(Icons.calendar_month_outlined,
                                                color: ColorManager.blueprime),
                                            errorText: field.errorText,
                                          ),
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(3101),
                                            );
                                            if (pickedDate != null) {
                                              calenderController.text =
                                                  DateFormat('MM-dd-yyyy').format(pickedDate);
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please select an expiry date';
                                            }
                                            return null;
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            title: 'Add Vendor Contracts',
                          );
                        },
                      );
                    },
                  );
                },
              )
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
