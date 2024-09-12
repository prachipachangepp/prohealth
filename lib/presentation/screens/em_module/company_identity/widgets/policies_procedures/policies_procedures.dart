import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_insurance_manager/manage_corporate_compliance.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/manage_history_version.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../app/services/api/managers/establishment_manager/newpopup_manager.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../ci_corporate_compliance_doc/widgets/newpopup.dart';
import 'widgets/add_policies_popup.dart';

class CiPoliciesAndProcedures extends StatefulWidget {
  final int docID;
  final int subDocID;
  final int companyID;
  final String officeId;
  const CiPoliciesAndProcedures(
      {super.key,
        required this.docID,
        required this.subDocID,
        required this.companyID,
        required this.officeId});

  @override
  State<CiPoliciesAndProcedures> createState() =>
      _CiPoliciesAndProceduresState();
}

class _CiPoliciesAndProceduresState extends State<CiPoliciesAndProcedures> {
  TextEditingController nameOfDocController = TextEditingController();
  TextEditingController idOfDocController = TextEditingController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  final StreamController<List<MCorporateComplianceModal>> _controller =
  StreamController<List<MCorporateComplianceModal>>();
  TextEditingController calenderController = TextEditingController();
  final StreamController<List<IdentityDocumentIdData>> _identityDataController =
  StreamController<List<IdentityDocumentIdData>>.broadcast();
  int docTypeMetaIdPP = AppConfig.policiesAndProcedure;
  int selectedSubDocId = AppConfig.subDocId0;
  int docTypeMetaId = AppConfig.policiesAndProcedure;
  int docSubTypeMetaId = AppConfig.subDocId0;
  String? expiryType;
  bool _isLoading = false;
  TextEditingController expiryDateController = TextEditingController();
  bool showExpiryDateField = false;

  int currentPage = 1;
  int docTypeId = 0;
  String? documentID;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }

  String? documentTypeName;
  dynamic filePath;
  String? selectedDocType;
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
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomIconButton(
                      icon: Icons.add,
                      text: "Add Document",
                      onPressed: () async {
                        int? selectedDocTypeId;
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
                                  String? selectedExpiryDate;
                                  String? expiryDateToSend;
                                  return PoliciesProcedureAddPopUp(
                                    loadingDuration: _isLoading,
                                    onDocTypeSelected: (int docTypeId) {
                                      setState(() {
                                        selectedDocTypeId = docTypeId; // Update the selected docTypeId
                                      });
                                    },
                                    onExpiryDateSelected: (String? expiryDate) {
                                      setState(() {
                                        print('EXP Date : ${expiryDate}');

                                        selectedExpiryDate = expiryDate;
                                        print('selected EXP Date : ${selectedExpiryDate}');
                                      });
                                    },
                                    onPressed: () async {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      ///Add Doctype API on save button
                                      try {
                                        print('EXP Date ${selectedExpiryDate}');
                                        if (selectedExpiryDate != null && selectedExpiryDate!.isNotEmpty) {
                                          expiryDateToSend = selectedExpiryDate;
                                        } else {
                                          expiryDateToSend = null;
                                        }
                                        ApiData response = await addOrgDocPPPost(
                                            context: context,
                                            orgDocumentSetupid: docTypeId,
                                            idOfDocument: "",
                                            expiryDate: expiryDateToSend,
                                            docCreated: DateTime.now().toIso8601String()+"Z",
                                            url: "",
                                            officeId: widget.officeId);
                                        print(expiryDateToSend);
                                        print(DateTime.now().toIso8601String());
                                        print(widget.officeId);
                                        expiryDateController.clear();

                                        if (response.statusCode == 200 || response.statusCode == 201) {
                                          await uploadDocumentsoffice(
                                              context: context,
                                              documentFile: filePath,
                                              orgOfficeDocumentId: response.orgOfficeDocumentId!);
                                        }
                                      }finally {
                                        setState(() {
                                          _isLoading = false;
                                          Navigator.pop(context);
                                        });
                                      }

                                    },
                                    child:  FutureBuilder<List<TypeofDocpopup>>(
                                      future: getTypeofDoc(context, docTypeMetaIdPP, selectedSubDocId) ,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Container(
                                            width: 350,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                          );
                                        }

                                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                                          List<DropdownMenuItem<String>>dropDownMenuItems = snapshot.data!
                                              .map((doc) =>
                                              DropdownMenuItem<String>(
                                                value: doc.docname,
                                                child: Text(doc.docname!),
                                              ))
                                              .toList();

                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return Column(
                                                children: [
                                                  CICCDropdown(
                                                    initialValue: "Select",
                                                    onChange: (val) {
                                                      setState(() {
                                                        showExpiryDateField = false;
                                                        for (var doc in snapshot.data!) {
                                                          if (doc.docname == val) {
                                                            docTypeId = doc.orgDocumentSetupid!;
                                                          //  widget.onDocTypeSelected(docTypeId);
                                                            print(doc.orgDocumentSetupid);

                                                            // Show expiry date field only if expirytype is "issuer expiry"
                                                            if (doc.expirytype == AppConfig.issuer) {
                                                              showExpiryDateField = true;
                                                            }
                                                          }
                                                        }
                                                      });
                                                    },
                                                    items: dropDownMenuItems,
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Visibility(
                                                    visible: showExpiryDateField,
                                                    /// Conditionally display expiry date field
                                                    child:   Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 2),
                                                          child: Text(
                                                            "Expiry Date",
                                                            style: GoogleFonts.firaSans(
                                                              fontSize: FontSize.s12,
                                                              fontWeight: FontWeight.w700,
                                                              color: ColorManager.mediumgrey,
                                                              decoration: TextDecoration.none,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        FormField<String>(
                                                          builder: (FormFieldState<String> field) {
                                                            return SizedBox(
                                                              width: 354,
                                                              height: 30,
                                                              child: TextFormField(
                                                                controller: expiryDateController,
                                                                cursorColor: ColorManager.black,
                                                                style: GoogleFonts.firaSans(
                                                                  fontSize: FontSize.s12,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: ColorManager.mediumgrey,
                                                                ),
                                                                decoration: InputDecoration(
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                  hintText: 'mm-dd-yyyy',
                                                                  hintStyle: GoogleFonts.firaSans(
                                                                    fontSize: FontSize.s12,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: ColorManager.mediumgrey,
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                    borderSide: BorderSide(width: 1, color: ColorManager.fmediumgrey),
                                                                  ),
                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                                                  suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
                                                                  errorText: field.errorText,
                                                                ),
                                                                onTap: () async {
                                                                  DateTime? pickedDate = await showDatePicker(
                                                                    context: context,
                                                                    initialDate: DateTime.now(),
                                                                    firstDate: DateTime(1901),
                                                                    lastDate: DateTime(3101),
                                                                  );
                                                                  if (pickedDate != null) {
                                                                    expiryDateController.text = DateFormat('MM-dd-yyyy').format(pickedDate);
                                                                  }
                                                                },
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return 'please select date';
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
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                    title: 'Upload Document',
                                  );
                                },
                              );
                            });
                      }),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<List<MCorporateComplianceModal>>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    getListMCorporateCompliancefetch(
                        context,
                        AppConfig.policiesAndProcedure,
                        AppConfig.subDocId0,
                        1,
                        20)
                        .then((data) {
                      _controller.add(data);
                    }).catchError((error) {
                      // Handle error
                    });

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
                          ErrorMessageString.noPolicyProcedure,
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
                      List<MCorporateComplianceModal> paginatedData = snapshot
                          .data!
                          .skip((currentPage - 1) * itemsPerPage)
                          .take(itemsPerPage)
                          .toList();
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: paginatedData.length,
                                itemBuilder: (context, index) {
                                  int serialNumber = index +
                                      1 +
                                      (currentPage - 1) * itemsPerPage;
                                  String formattedSerialNumber =
                                  serialNumber.toString().padLeft(2, '0');
                                  MCorporateComplianceModal policiesdata =
                                  paginatedData[index];
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xff000000)
                                                      .withOpacity(0.25),
                                                  spreadRadius: 0,
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            height: 50,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "ID : ${policiesdata.docName}",
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w400,
                                                          color: const Color(0xff686464), decoration: TextDecoration.none,
                                                        ),
                                                      ),
                                                      SizedBox(height: AppSize.s5,),
                                                      Text(
                                                        policiesdata.orgDocumentSetupid.toString(),
                                                        textAlign: TextAlign.center,
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.bold,
                                                          color: const Color(0xff686464),
                                                          decoration: TextDecoration.none,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) => ManageHistoryPopup(
                                                              docHistory: policiesdata.docHistory,
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons.history,
                                                          size: 18,
                                                          color: ColorManager.bluebottom,
                                                        ),
                                                      ),

                                                      IconButton(onPressed: (){}, icon: Icon(
                                                        Icons.save_alt_outlined,
                                                        size: 18,
                                                        color: ColorManager
                                                            .bluebottom,
                                                      )),
                                                      IconButton(
                                                        onPressed: () {
                                                          String?selectedExpiryType = expiryType;
                                                          showDialog(
                                                            context: context, builder: (context) {
                                                            return FutureBuilder<MCorporateCompliancePreFillModal>(
                                                              future: getPrefillNewOrgOfficeDocument(context, policiesdata.orgOfficeDocumentId),
                                                              builder: (context, snapshotPrefill) {
                                                                if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                                                  return Center(
                                                                    child: CircularProgressIndicator(
                                                                      color: ColorManager
                                                                          .blueprime,
                                                                    ),
                                                                  );
                                                                }

                                                                var calender = snapshotPrefill.data!.expiry_date;
                                                                calenderController = TextEditingController(text: snapshotPrefill.data!.expiry_date,);

                                                                fileName = snapshotPrefill.data!.url;


                                                                return StatefulBuilder(
                                                                  builder: (BuildContext
                                                                  context,
                                                                      void Function(void Function())
                                                                      setState) {
                                                                    return VCScreenPopupEditConst(
                                                                      title:
                                                                      'Edit Policies And Procedure',
                                                                      loadingDuration: _isLoading,
                                                                      onSavePressed:
                                                                          () async {
                                                                        setState(() {_isLoading = true;});
                                                                        try {
                                                                          String expiryTypeToSend = selectedExpiryType == "Not Applicable"
                                                                              ? "Not Applicable"
                                                                              : calenderController.text;
                                                                          var response = await updateOrgDoc(context: context,
                                                                            orgDocId: policiesdata.orgOfficeDocumentId,
                                                                            orgDocumentSetupid: snapshotPrefill.data!.documentSetupId,
                                                                            idOfDocument: '',
                                                                            expiryDate: expiryTypeToSend,
                                                                            docCreatedat: DateTime.now().toIso8601String()+"Z",
                                                                            url: "",
                                                                            officeid: widget.officeId,);

                                                                          if (response.statusCode == 200 || response.statusCode == 201) {
                                                                            await uploadDocumentsoffice(
                                                                                context: context,
                                                                                documentFile: filePath,
                                                                                orgOfficeDocumentId: response.orgOfficeDocumentId!);
                                                                          }
                                                                        } finally {
                                                                          setState(() {
                                                                            _isLoading = false;
                                                                          });
                                                                          Navigator.pop(context);
                                                                        }
                                                                      },

                                                                      child: FutureBuilder<List<TypeofDocpopup>>(
                                                                        future: getTypeofDoc(context, widget.docID, widget.subDocID),
                                                                        builder: (context, snapshot) {
                                                                          if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return Container(
                                                                              width: 350,
                                                                              height: 30,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
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
                                                                              value: doc.docname,
                                                                              child: Text(doc.docname!),
                                                                            ))
                                                                                .toList();
                                                                            return CICCDropdown(
                                                                              initialValue: "Select",
                                                                              onChange: (val) {
                                                                                //   setState(() {
                                                                                // selectedDocType = val;
                                                                                for (var doc in snapshot.data!) {
                                                                                  if (doc.docname == val) {
                                                                                    docTypeId = doc.documenttypeid!;
                                                                                  }
                                                                                }
                                                                                // getTypeofDoc(context ,widget.docId,widget.subDocId).then((data) {
                                                                                //   _compliancePatientDataController
                                                                                //       .add(data!);
                                                                                // }).catchError((error) {
                                                                                //   // Handle error
                                                                                // });
                                                                                // });
                                                                              },
                                                                              items: dropDownMenuItems,
                                                                            );
                                                                          } else {
                                                                            return SizedBox();
                                                                          }
                                                                        },
                                                                      ),
                                                                      uploadField: Container(
                                                                        height: AppSize.s30,
                                                                        width: AppSize.s354,
                                                                        // margin: EdgeInsets.symmetric(horizontal: 5),
                                                                        decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                            color: ColorManager.containerBorderGrey,
                                                                            width: 1,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(4),
                                                                        ),
                                                                        child: StatefulBuilder(
                                                                          builder: (BuildContext context,
                                                                              void Function(void Function()) setState) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.all(0),
                                                                              child: Row(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    fileName,
                                                                                    style: GoogleFonts.firaSans(
                                                                                      fontSize: FontSize.s12,
                                                                                      fontWeight: FontWeightManager.regular,
                                                                                      color: ColorManager.lightgreyheading,
                                                                                    ),
                                                                                  ),
                                                                                  IconButton(
                                                                                    padding: EdgeInsets.all(4),
                                                                                    onPressed: _pickFile,
                                                                                    icon: Icon(
                                                                                      Icons.file_upload_outlined,
                                                                                      color: ColorManager.black,
                                                                                      size: 17,
                                                                                    ),
                                                                                    splashColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
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
                                                          color: ColorManager
                                                              .bluebottom,
                                                        ),
                                                        splashColor:
                                                        Colors.transparent,
                                                        highlightColor:
                                                        Colors.transparent,
                                                        hoverColor:
                                                        Colors.transparent,
                                                      ),
                                                      IconButton(
                                                          splashColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                context,
                                                                builder: (context) =>
                                                                    DeletePopup(
                                                                        title:
                                                                        'Delete Policies Procedure',
                                                                        onCancel:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        onDelete:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                                  () async {
                                                                                await  deleteOrgDoc(context:context, orgDocId:policiesdata.orgOfficeDocumentId );
                                                                                // await deleteManageCorporate(context,
                                                                                //     policiesdata.docId);
                                                                                // getManageCorporate(context, widget.officeId, widget.docID, widget.subDocID, 1, 20).then((data) {
                                                                                //   _controller.add(data);
                                                                                // }).catchError((error) {
                                                                                //   // Handle error
                                                                                // });
                                                                              });
                                                                        }));
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            size: 18,
                                                            color: ColorManager
                                                                .red,
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          PaginationControlsWidget(
                            currentPage: currentPage,
                            items: snapshot.data!,
                            itemsPerPage: itemsPerPage,
                            onPreviousPagePressed: () {
                              setState(() {
                                currentPage =
                                currentPage > 1 ? currentPage - 1 : 1;
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
                          ),
                        ],
                      );
                    }
                    return const Offstage();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
