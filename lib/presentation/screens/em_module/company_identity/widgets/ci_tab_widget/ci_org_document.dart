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
import 'package:prohealth/app/resources/value_manager.dart';
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
    identityDocumentTypeGet(context, docTypeMetaId).then((data) {
      _identityDataController.add(data);
    }).catchError((error) {
      // Handle error
    });
    docTypeFuture = documentTypeGet(context);
  }

  var docID = 8;
  int docTypeMetaId = 8;
  int docSubTypeMetaId = 0;
  String? selectedDocTypeValue;
  String? selectedSubDocTypeValue;
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
                        // identityDocumentTypeGet(
                        //     context, docTypeData[index].docID);
                        // docID = docTypeData[index].docID;
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
                        // identityDocumentTypeGet(
                        //     context, docTypeData[index].docID);
                        // docID = docTypeData[index].docID;
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
                      selectedDocTypeValue = "";
                      selectedSubDocTypeValue = "";
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
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
                                    await addOrgCorporateDocumentPost(
                                      context: context,
                                      name: docNamecontroller.text,
                                      docTypeID: docTypeMetaId,
                                      docSubTypeID: docSubTypeMetaId,
                                      expiryType: selectedExpiryType.toString(),
                                      expiryDate: expiryTypeToSend,
                                      expiryReminder:
                                      selectedExpiryType.toString(),
                                      //officeId: widget.officeId,
                                    );
                                    Navigator.pop(context);
                                  } finally {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                                child: FutureBuilder<List<DocumentTypeData>>(
                                  future: docTypeFuture,
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
                                    if (snapshot.data == null || snapshot.data!.isEmpty) {
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
                                      List<DropdownMenuItem<String>> dropDownMenuItems = [];

                                      // Add a placeholder item for "Select Document"
                                      dropDownMenuItems.add(
                                        DropdownMenuItem<String>(
                                          value: "Select Document",
                                          child: Text("Select Document"),
                                        ),
                                      );

                                      for (var i in snapshot.data!) {
                                        dropDownMenuItems.add(
                                          DropdownMenuItem<String>(
                                            value: i.docType,
                                            child: Text(i.docType),
                                          ),
                                        );
                                      }

                                      return CICCDropdown(
                                        initialValue: "Select Document",  // Set initial value to the placeholder
                                        onChange: (val) {
                                          setState(() {
                                            selectedDocTypeValue = val;
                                            if (val != "Select Document") {
                                              for (var a in snapshot.data!) {
                                                if (a.docType == val) {
                                                  docTypeMetaId = a.docID;
                                                }
                                              }
                                              identityDocumentTypeGet(context, docTypeMetaId).then((data) {
                                                _identityDataController.add(data);
                                              }).catchError((error) {
                                                // Handle error
                                              });
                                            }
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
                                    return CICCDropdown(
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
                                  visible: selectedExpiryType == "Scheduled" ||
                                      selectedExpiryType == "Issuer Expiry",
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
                                                  borderSide: BorderSide(
                                                      color: ColorManager
                                                          .fmediumgrey,
                                                      width: 1),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ColorManager
                                                          .fmediumgrey,
                                                      width: 1),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                ),
                                                hintText: 'mm-dd-yyyy',
                                                hintStyle: GoogleFonts.firaSans(
                                                  fontSize: FontSize.s12,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorManager.mediumgrey,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: ColorManager
                                                          .fmediumgrey),
                                                ),
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                suffixIcon: Icon(
                                                    Icons.calendar_month_outlined,
                                                    color:
                                                    ColorManager.blueprime),
                                                errorText: field.errorText,
                                              ),
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(3101),
                                                );
                                                if (pickedDate != null) {
                                                  calenderController.text =
                                                      DateFormat('MM-dd-yyyy')
                                                          .format(pickedDate);
                                                }
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                title: 'Add Corporate Compliance',
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ))
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
                     selectedDocTypeValue = "";
                     selectedSubDocTypeValue = "";
                     showDialog(
                       context: context,
                       builder: (context) {
                         return StatefulBuilder(
                           builder: (BuildContext context,
                               void Function(void Function()) setState) {
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
                                   await addOrgCorporateDocumentPost(
                                     context: context,
                                     name: docNamecontroller.text,
                                     docTypeID: docTypeMetaId,
                                     docSubTypeID: docSubTypeMetaId,
                                     expiryType: selectedExpiryType.toString(),
                                     expiryDate: expiryTypeToSend,
                                     expiryReminder:
                                     selectedExpiryType.toString(),
                                     //officeId: widget.officeId,
                                   );
                                   Navigator.pop(context);
                                 } finally {
                                   setState(() {
                                     _isLoading = false;
                                   });
                                 }
                               },
                               child: FutureBuilder<List<DocumentTypeData>>(
                                 future: docTypeFuture,
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
                                   if (snapshot.data == null || snapshot.data!.isEmpty) {
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
                                     List<DropdownMenuItem<String>> dropDownMenuItems = [];

                                     // Add a placeholder item for "Select Document"
                                     dropDownMenuItems.add(
                                       DropdownMenuItem<String>(
                                         value: "Select Document",
                                         child: Text("Select Document"),
                                       ),
                                     );

                                     for (var i in snapshot.data!) {
                                       dropDownMenuItems.add(
                                         DropdownMenuItem<String>(
                                           value: i.docType,
                                           child: Text(i.docType),
                                         ),
                                       );
                                     }

                                     return CICCDropdown(
                                       initialValue: "Select Document",  // Set initial value to the placeholder
                                       onChange: (val) {
                                         setState(() {
                                           selectedDocTypeValue = val;
                                           if (val != "Select Document") {
                                             for (var a in snapshot.data!) {
                                               if (a.docType == val) {
                                                 docTypeMetaId = a.docID;
                                               }
                                             }
                                             identityDocumentTypeGet(context, docTypeMetaId).then((data) {
                                               _identityDataController.add(data);
                                             }).catchError((error) {
                                               // Handle error
                                             });
                                           }
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
                                     return CICCDropdown(
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
                                 visible: selectedExpiryType == "Scheduled" ||
                                     selectedExpiryType == "Issuer Expiry",
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
                                                 borderSide: BorderSide(
                                                     color: ColorManager
                                                         .fmediumgrey,
                                                     width: 1),
                                                 borderRadius:
                                                 BorderRadius.circular(8),
                                               ),
                                               focusedBorder: OutlineInputBorder(
                                                 borderSide: BorderSide(
                                                     color: ColorManager
                                                         .fmediumgrey,
                                                     width: 1),
                                                 borderRadius:
                                                 BorderRadius.circular(8),
                                               ),
                                               hintText: 'mm-dd-yyyy',
                                               hintStyle: GoogleFonts.firaSans(
                                                 fontSize: FontSize.s12,
                                                 fontWeight: FontWeight.w700,
                                                 color: ColorManager.mediumgrey,
                                               ),
                                               border: OutlineInputBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(8),
                                                 borderSide: BorderSide(
                                                     width: 1,
                                                     color: ColorManager
                                                         .fmediumgrey),
                                               ),
                                               contentPadding:
                                               EdgeInsets.symmetric(
                                                   horizontal: 16),
                                               suffixIcon: Icon(
                                                   Icons.calendar_month_outlined,
                                                   color:
                                                   ColorManager.blueprime),
                                               errorText: field.errorText,
                                             ),
                                             onTap: () async {
                                               DateTime? pickedDate =
                                               await showDatePicker(
                                                 context: context,
                                                 initialDate: DateTime.now(),
                                                 firstDate: DateTime(2000),
                                                 lastDate: DateTime(3101),
                                               );
                                               if (pickedDate != null) {
                                                 calenderController.text =
                                                     DateFormat('MM-dd-yyyy')
                                                         .format(pickedDate);
                                               }
                                             },
                                             validator: (value) {
                                               if (value == null ||
                                                   value.isEmpty) {
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
                               title: 'Add Corporate Compliance',
                             );
                           },
                         );
                       },
                     );
                   },
                 ),
               ))
           ///Policies
               :Align(
               alignment: Alignment.bottomRight,
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
                     calenderController.clear();
                     docIdController.clear();
                     docNamecontroller.clear();
                     selectedExpiryType = "";
                     selectedDocTypeValue = "";
                     selectedSubDocTypeValue = "";

                     showDialog(
                       context: context,
                       builder: (context) {
                         return StatefulBuilder(
                           builder: (BuildContext context,
                               void Function(void Function()) setState) {
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
                                   await addOrgCorporateDocumentPost(
                                     context: context,
                                     name: docNamecontroller.text,
                                     docTypeID: docTypeMetaId,
                                     docSubTypeID: docTypeMetaId == AppConfig.policiesAndProcedure
                                         ? 0
                                         : docSubTypeMetaId,
                                     expiryType:
                                     selectedExpiryType.toString(),
                                     expiryDate: expiryTypeToSend,
                                     expiryReminder:
                                     selectedExpiryType.toString(),
                                   );
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
                                     List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                     int docType = snapshot.data![0].docID;
                                     docTypeMetaId = docType;

                                     for (var i in snapshot.data!) {
                                       dropDownMenuItems.add(
                                         DropdownMenuItem<String>(
                                           child: Text(i.docType),
                                           value: i.docType,
                                         ),
                                       );
                                     }
                                     return CICCDropdown(
                                       initialValue: dropDownMenuItems[0].value,
                                       onChange: (val) {
                                         for (var a in snapshot.data!) {
                                           if (a.docType == val) {
                                             docType = a.docID;
                                             docTypeMetaId = docType;
                                           }
                                         }
                                         identityDocumentTypeGet(context, docTypeMetaId).then((data) {
                                           _identityDataController.add(data);
                                         }).catchError((error) {
                                           // Handle error
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

                                     return CICCDropdown(
                                      // initialValue: "Select Sub Document",
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
                                 visible: selectedExpiryType ==
                                     "Scheduled" ||
                                     selectedExpiryType == "Issuer Expiry",
                                 child: Column(
                                   crossAxisAlignment:
                                   CrossAxisAlignment.start,
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
                                       builder:
                                           (FormFieldState<String> field) {
                                         return SizedBox(
                                           width: 354,
                                           height: 30,
                                           child: TextFormField(
                                             controller: calenderController,
                                             cursorColor: ColorManager.black,
                                             style: GoogleFonts.firaSans(
                                               fontSize: FontSize.s12,
                                               fontWeight: FontWeight.w700,
                                               color:
                                               ColorManager.mediumgrey,
                                             ),
                                             decoration: InputDecoration(
                                               enabledBorder:
                                               OutlineInputBorder(
                                                 borderSide: BorderSide(
                                                     color: ColorManager
                                                         .fmediumgrey,
                                                     width: 1),
                                                 borderRadius:
                                                 BorderRadius.circular(
                                                     8),
                                               ),
                                               focusedBorder:
                                               OutlineInputBorder(
                                                 borderSide: BorderSide(
                                                     color: ColorManager
                                                         .fmediumgrey,
                                                     width: 1),
                                                 borderRadius:
                                                 BorderRadius.circular(
                                                     8),
                                               ),
                                               hintText: 'mm-dd-yyyy',
                                               hintStyle:
                                               GoogleFonts.firaSans(
                                                 fontSize: FontSize.s12,
                                                 fontWeight: FontWeight.w700,
                                                 color:
                                                 ColorManager.mediumgrey,
                                               ),
                                               border: OutlineInputBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(
                                                     8),
                                                 borderSide: BorderSide(
                                                     width: 1,
                                                     color: ColorManager
                                                         .fmediumgrey),
                                               ),
                                               contentPadding:
                                               EdgeInsets.symmetric(
                                                   horizontal: 16),
                                               suffixIcon: Icon(
                                                   Icons
                                                       .calendar_month_outlined,
                                                   color: ColorManager
                                                       .blueprime),
                                               errorText: field.errorText,
                                             ),
                                             onTap: () async {
                                               DateTime? pickedDate =
                                               await showDatePicker(
                                                 context: context,
                                                 initialDate: DateTime.now(),
                                                 firstDate: DateTime(2000),
                                                 lastDate: DateTime(3101),
                                               );
                                               if (pickedDate != null) {
                                                 calenderController.text =
                                                     DateFormat('MM-dd-yyyy')
                                                         .format(pickedDate);
                                               }
                                             },
                                             validator: (value) {
                                               if (value == null ||
                                                   value.isEmpty) {
                                                 return 'Please select a date';
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
                               title: 'Add Document',
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
                  CICorporateCompilianceDocument(
                    docID: AppConfig.corporateAndCompliance, //officeId: widget.officeId,
                  ),
                  CIVendorContract(
                    docId: AppConfig.vendorContracts, //officeId: widget.officeId
                  ),
                  CIPoliciesProcedure(
                    docId: AppConfig.policiesAndProcedure, subDocId: AppConfig.subDocId0,
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
