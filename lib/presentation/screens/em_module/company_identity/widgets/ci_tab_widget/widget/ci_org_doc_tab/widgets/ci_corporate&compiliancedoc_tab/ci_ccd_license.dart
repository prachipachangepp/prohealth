import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../../../../app/constants/app_config.dart';
import '../../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

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
    int docTypeMetaIdCC = AppConfig.corporateAndCompliance;
    int docTypeMetaIdCCL = AppConfig.subDocId1Licenses;
  final StreamController<List<CiOrgDocumentCC>> _controller = StreamController<List<CiOrgDocumentCC>>.broadcast();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController = StreamController<List<IdentityDocumentIdData>>.broadcast();

  String? selectedValue;
  int docSubTypeMetaId =0;
  String? expiryType;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    print(":::SUBDOCID              ${widget.subDocID} + ${widget.docID}");
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
          Container(
            height: AppSize.s30,
            margin: EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: ColorManager.fmediumgrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      AppString.srNo,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Document Id",
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Text(
                      AppString.name,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      AppString.expiry,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      AppString.reminderthershold,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      AppString.actions,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSize.s10),
          Expanded(
            child: StreamBuilder<List<CiOrgDocumentCC>>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                getORGDoc(context, widget.docID, widget.subDocID, 1, 15
                ).then((data) {
                  _controller.add(data);
                }).catchError((error) {
                  // Handle error
                });
                print('1111111');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.blueprime,
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
                  int totalItems = snapshot.data!.length;
                  int totalPages = (totalItems / itemsPerPage).ceil();
                  List<CiOrgDocumentCC> paginatedData = snapshot.data!.skip(
                      (currentPage - 1) * itemsPerPage)
                      .take(itemsPerPage)
                      .toList();
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                            CiOrgDocumentCC lisenceData = paginatedData[index];
                            return Column(
                              children: [
                                SizedBox(height: AppSize.s5),
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: AppPadding.p5),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: AppMargin.m50),
                                  decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorManager.grey.withOpacity(
                                            0.5),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  height: AppSize.s56,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceAround,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            formattedSerialNumber,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            lisenceData.idOfDocument,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            lisenceData.name
                                                .toString()
                                                .capitalizeFirst!,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            lisenceData.expirtDate.toString(),
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            lisenceData.expirtReminder!
                                                .toString().capitalizeFirst!,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                String? selectedExpiryType = expiryType;
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return FutureBuilder<CorporatePrefillDocumentData>(
                                                      future: getPrefillCorporateDocument(context, lisenceData.docId),
                                                      builder: (context,
                                                          snapshotPrefill) {
                                                        if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                                          return Center(
                                                            child: CircularProgressIndicator(
                                                              color: ColorManager
                                                                  .blueprime,
                                                            ),
                                                          );
                                                        }

                                                        // Prefill values from API
                                                        var documentPreId = snapshotPrefill.data!.documentId;
                                                        docIdController = TextEditingController(text: snapshotPrefill.data!.documentId.toString(),);

                                                        var documentSubPreId = snapshotPrefill.data!.documentSubTypeId;docSubTypeMetaId = documentSubPreId;

                                                        var name = snapshotPrefill.data!.docName;
                                                        docNameController = TextEditingController(text: snapshotPrefill.data!.docName,);

                                                        var calender = snapshotPrefill.data!.expiryDate;
                                                        calenderController = TextEditingController(text: snapshotPrefill.data!.expiryDate,);

                                                        var expiry = snapshotPrefill.data!.expiryType;expiryType = expiry;
                                                        var idOfDoc = snapshotPrefill.data!.idOfDoc;
                                                        idOfDocController = TextEditingController(text: snapshotPrefill.data!.idOfDoc.toString());


                                                        // Fetch sub-document types based on the document type
                                                        identityDocumentTypeGet(context, AppConfig.corporateAndCompliance).then((data) {
                                                          _identityDataController.add(data);
                                                        }).catchError((error) {
                                                          // Handle error
                                                        });

                                                        return StatefulBuilder(
                                                          builder: (
                                                              BuildContext context,
                                                              void Function(void Function()) setState) {
                                                            return CCScreenEditPopup(
                                                              title: 'Edit Licenses',
                                                              //id: documentPreId,
                                                              idOfDocController: idOfDocController,
                                                              nameDocController: docNameController,
                                                              loadingDuration: _isLoading,
                                                              onSavePressed: () async {
                                                                setState(() {
                                                                  _isLoading =
                                                                  true;
                                                                });
                                                                try {
                                                                  String expiryTypeToSend = selectedExpiryType == "Not Applicable"
                                                                      ? "Not Applicable"
                                                                      : calenderController.text;
                                                                  await updateCorporateDocumentPost(
                                                                    context: context,
                                                                    docId: documentPreId,
                                                                    name: name == docNameController.text ? name.toString() : docNameController.text,
                                                                    docTypeID: AppConfig.corporateAndCompliance,
                                                                    docSubTypeID: documentSubPreId == docSubTypeMetaId ? documentSubPreId : docSubTypeMetaId,
                                                                    docCreated: DateTime.now().toString(),
                                                                    url: "url",
                                                                    expiryType: selectedExpiryType ?? expiryType.toString(),//expiry == expiryType.toString() ? expiry.toString() : expiryType.toString(),
                                                                    expiryDate: expiryTypeToSend,
                                                                    expiryReminder:selectedExpiryType ?? expiryType.toString(),// selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString() : expiryType.toString(),
                                                                    officeId: "", //widget.officeId,
                                                                      idOfDoc: snapshotPrefill.data!.idOfDoc
                                                                  );
                                                                } finally {
                                                                  setState(() {
                                                                    _isLoading = false;
                                                                  });
                                                                  Navigator.pop(context);
                                                                }
                                                              },

                                                              // Document Type Dropdown
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
                                                                    String selectedDocType = "";
                                                                    int docType = snapshot.data![0].docID;

                                                                    for (var i in snapshot.data!) {
                                                                      if (i.docID == AppConfig.corporateAndCompliance) {
                                                                        selectedDocType = i.docType;
                                                                        docType = i.docID;
                                                                        break;
                                                                      }
                                                                    }

                                                                    docTypeMetaIdCC = docType;

                                                                    identityDocumentTypeGet(context, docTypeMetaIdCC).then((data) {
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
                                                                            color: ColorManager.mediumgrey,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  } else {
                                                                    return SizedBox();
                                                                  }
                                                                },
                                                              ),
                                                              // Sub-Document Type Dropdown
                                                              child1:FutureBuilder<List<DocumentTypeData>>(
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
                                                                    String selectedDocType = "Licenses";
                                                                    int docType = snapshot.data![0].docID;

                                                                    for (var i in snapshot.data!) {
                                                                      if (i.docID == AppConfig.subDocId1Licenses) {
                                                                        selectedDocType = i.docType;
                                                                        docType = i.docID;
                                                                        break;
                                                                      }
                                                                    }

                                                                    docTypeMetaIdCCL = docType;

                                                                    identityDocumentTypeGet(context, docTypeMetaIdCC).then((data) {
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
                                                                            color: ColorManager.mediumgrey,
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
                                                                padding: const EdgeInsets.only(left: 10.0),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("Expiry Type",
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
                                                                        return SizedBox(
                                                                          width: 354,
                                                                          height: 30,
                                                                          child: TextFormField(
                                                                            controller: calenderController,
                                                                            cursorColor: ColorManager
                                                                                .black,
                                                                            style: GoogleFonts.firaSans(
                                                                              fontSize: FontSize.s12,
                                                                              fontWeight: FontWeight.w700,
                                                                              color: ColorManager.mediumgrey,
                                                                              //decoration: TextDecoration.none,
                                                                            ),
                                                                            decoration: InputDecoration(
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                                                                borderRadius: BorderRadius
                                                                                    .circular(
                                                                                    8),
                                                                              ),
                                                                              focusedBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                    color: ColorManager.fmediumgrey, width: 1),
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
                                                                                borderSide: BorderSide(width: 1,
                                                                                    color: ColorManager.fmediumgrey),
                                                                              ),
                                                                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                                                              suffixIcon: Icon(
                                                                                  Icons.calendar_month_outlined,
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
                                                                                calenderController.text = DateFormat('MM-dd-yyyy').format(pickedDate);
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
                                                );
                                              },
                                              icon: Icon(
                                                Icons.edit_outlined,
                                                size: 18,
                                                color: ColorManager.bluebottom,
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(context: context,
                                                      builder: (context) =>
                                                          StatefulBuilder(
                                                            builder: (
                                                                BuildContext context,
                                                                void Function(void Function()) setState) {
                                                              return DeletePopup(
                                                                  title: 'Delete Licenses',
                                                                  loadingDuration: _isLoading,
                                                                  onCancel: () {
                                                                    Navigator
                                                                        .pop(
                                                                        context);
                                                                  },
                                                                  onDelete: () async {
                                                                    setState(() {
                                                                      _isLoading =
                                                                      true;
                                                                    });
                                                                    try {
                                                                      await deleteDocument(
                                                                          context,
                                                                          snapshot
                                                                              .data![index]
                                                                              .docId);
                                                                      getORGDoc(
                                                                          context,
                                                                          widget
                                                                              .docID,
                                                                          widget
                                                                              .subDocID,
                                                                          1, 15
                                                                      ).then((
                                                                          data) {
                                                                        _controller
                                                                            .add(
                                                                            data);
                                                                      })
                                                                          .catchError((
                                                                          error) {
                                                                        // Handle error
                                                                      });
                                                                    } finally {
                                                                      setState(() {
                                                                        _isLoading =
                                                                        false;
                                                                      });
                                                                      Navigator
                                                                          .pop(
                                                                          context);
                                                                    }
                                                                  });
                                                            },

                                                          ));
                                                },
                                                icon: Icon(Icons.delete_outline,
                                                  size: 18,
                                                  color: ColorManager.red,)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      PaginationControlsWidget(
                        currentPage: currentPage,
                        items: snapshot.data!,
                        itemsPerPage: itemsPerPage,
                        onPreviousPagePressed: () {
                          setState(() {
                            currentPage = currentPage > 1 ? currentPage - 1 : 1;
                          });
                        },
                        onPageNumberPressed: (pageNumber) {
                          setState(() {
                            currentPage = pageNumber;
                          });
                        },
                        onNextPagePressed: () {
                          setState(() {
                            currentPage = currentPage < totalPages
                                ? currentPage + 1
                                : totalPages;
                          });
                        },
                      )
                    ],
                  );
                }
                return Offstage();
              },
            ),
          ),
        ],
      );
  }}
