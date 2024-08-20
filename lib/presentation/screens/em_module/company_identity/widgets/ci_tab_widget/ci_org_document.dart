import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_corporate&compiliance_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_policies&procedure.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/ci_vendor_contract.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../../../hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../../../hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../../../hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import '../../company_identity_screen.dart';

class CiOrgDocument extends StatefulWidget {
  final String officeId;
  const CiOrgDocument({super.key, required this.officeId});

  @override
  State<CiOrgDocument> createState() => _CiOrgDocumentState();
}

class _CiOrgDocumentState extends State<CiOrgDocument> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
   final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();

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
  List<DocumentTypeData> docTypeData = [];
  void loadData() async{
    docTypeData = await documentTypeGet(context);
  }
  @override
  void initState() {
    super.initState();
    identityDocumentTypeGet(context,docTypeMetaId).then((data) {
      _identityDataController.add(data);
    }).catchError((error) {
      // Handle error
    });
  }
  var docID = 8;
  int docTypeMetaId = 8;
  int docSubTypeMetaId =0;
  String? expiryType;
  bool _isLoading = false;
  final AppConfig appConfig = AppConfig();
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
                  child:InkWell(
                          onTap: () {
                            _selectButton(0);
                            // identityDocumentTypeGet(
                            //     context, docTypeData[index].docID);
                            // docID = docTypeData[index].docID;
                          },
                          child: Container(
                            height: 30,
                            width: 210,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20)),
                              color: _selectedIndex ==
                                  0
                                  ? Colors.white
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                'Corporate & Compliance Documents',
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: _selectedIndex ==
                                      0
                                      ? ColorManager.mediumgrey
                                      : ColorManager.white,
                                ),
                              ),
                            ),
                          ),
                        )
                ),
                Expanded(
                    child:InkWell(
                      onTap: () {
                        _selectButton(1);
                        // identityDocumentTypeGet(
                        //     context, docTypeData[index].docID);
                        // docID = docTypeData[index].docID;
                      },
                      child: Container(
                        height: 30,
                        width: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20)),
                          color: _selectedIndex ==
                              1
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Vendor Contracts',
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _selectedIndex ==
                                  1
                                  ? ColorManager.mediumgrey
                                  : ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    )
                ),
                Expanded(
                    child:InkWell(
                      onTap: () {
                        _selectButton(2);
                        // identityDocumentTypeGet(
                        //     context, docTypeData[index].docID);
                        // docID = docTypeData[index].docID;
                      },
                      child: Container(
                        height: 30,
                        width: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20)),
                          color: _selectedIndex ==
                              2
                              ? Colors.white
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Policies & Procedures',
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _selectedIndex ==
                                  2
                                  ? ColorManager.mediumgrey
                                  : ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),


            ///button
            Align(
                alignment: Alignment.bottomRight,
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 30,
                    width: 150,
                    child: CustomIconButton(
                      icon: Icons.add,
                      text: "Add Document",
                      onPressed: () async {
                        String? selectedDocType;
                        String? selectedSubDocType;
                        String? selectedExpiryType = expiryType;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return AddOrgDocButton(
                                  title:"Add Document",
                                  calenderController: calenderController,
                                  idDocController: docIdController,
                                  nameDocController: docNamecontroller,
                                  loadingDuration: _isLoading,
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    String expiryTypeToSend = selectedExpiryType == "Not Applicable"
                                        ? "--"
                                        :calenderController.text;
                                    try {
                                      await addCorporateDocumentPost(
                                        context: context,
                                        name: docNamecontroller.text,
                                        docTypeID: docTypeMetaId,
                                        docSubTypeID: docTypeMetaId == 10 ? 0 : docSubTypeMetaId,
                                        // docCreated: DateTime.now().toString(),
                                        // url: "url",
                                        expiryType: selectedExpiryType.toString(),
                                        expiryDate: expiryTypeToSend,
                                        expiryReminder: selectedExpiryType.toString(),
                                        officeId: widget.officeId,
                                      );
                                    //  await getORGDoc(context, docID, docSubTypeMetaId, 1, 20);
                                      await getORGDoc(context, docTypeMetaId,
                                          docSubTypeMetaId, 1, 20);
                                      Navigator.pop(context);
                                      setState(() {
                                        expiryType = '';
                                        calenderController.clear();
                                        docIdController.clear();
                                        docNamecontroller.clear();
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
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: 350,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: ColorManager.faintGrey,
                                              borderRadius: BorderRadius.circular(10),
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
                                        List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
                                            .map((doc) => DropdownMenuItem<String>(
                                          value: doc.docType,
                                          child: Text(doc.docType),
                                        ))
                                            .toList();
                                        return CICCDropdown(
                                          initialValue: selectedDocType ?? dropDownMenuItems[0].value,
                                          onChange: (val) {
                                            setState(() {
                                              selectedDocType = val;
                                              for (var doc in snapshot.data!) {
                                                if (doc.docType == val) {
                                                  docTypeMetaId = doc.docID;
                                                }
                                              }
                                              identityDocumentTypeGet(context, docTypeMetaId).then((data) {
                                                _identityDataController.add(data);
                                              }).catchError((error) {
                                                // Handle error
                                              });
                                            });
                                          },
                                          items: dropDownMenuItems,
                                        );
                                      } else {
                                        return SizedBox();
                                      }
                                    },
                                  ),
                                  child1: StreamBuilder<List<IdentityDocumentIdData>>(
                                    stream: _identityDataController.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            width: 350,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: ColorManager.faintGrey,
                                              borderRadius: BorderRadius.circular(10),
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
                                        List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
                                            .map((subDoc) => DropdownMenuItem<String>(
                                          value: subDoc.subDocType,
                                          child: Text(subDoc.subDocType),
                                        ))
                                            .toList();

                                        return CICCDropdown(
                                          initialValue: selectedSubDocType ?? dropDownMenuItems[0].value,
                                          onChange: (val) {
                                            setState(() {
                                              selectedSubDocType = val;
                                              for (var subDoc in snapshot.data!) {
                                                if (subDoc.subDocType == val) {
                                                  docSubTypeMetaId = subDoc.subDocID;
                                                }
                                              }
                                            });
                                          },
                                          items: dropDownMenuItems,
                                        );
                                      } else {
                                        return SizedBox(height: 1, width: 1);
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
                                        FormField<String>(
                                          builder: (FormFieldState<String> field) {
                                            return SizedBox (
                                              width: 354,
                                              height: 30,
                                      child:   TextFormField(
                                          controller: calenderController,
                                          cursorColor: ColorManager.black,
                                          style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorManager.mediumgrey,
                                            //decoration: TextDecoration.none,
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
                                              //decoration: TextDecoration.none,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(width: 1,color: ColorManager.fmediumgrey),
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(horizontal: 16),
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
                                            return 'please select birth date';
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
                                );
                              },
                            );
                          },
                        );
                      },
                    )
                  ),
                )),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
          child: Stack(
            children: [
              _selectedIndex != 0
                  ? Container(
                height: MediaQuery.of(context).size.height / 3.5,
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
                  CICorporateCompilianceDocument(docID: AppConfig.docId8,officeId: widget.officeId,),
                  CIVendorContract(docId: AppConfig.docId9,officeId: widget.officeId),
                  CIPoliciesProcedure(docId: AppConfig.docId10, subDocId: AppConfig.subDocId0, officeId: widget.officeId,)
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
