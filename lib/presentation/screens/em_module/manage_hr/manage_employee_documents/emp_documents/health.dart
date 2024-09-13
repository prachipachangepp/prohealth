import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/employee_doc_repository.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_org_doc_tab/widgets/heading_constant_widget.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/emp_doc_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class HealthEmpDoc extends StatefulWidget {
  final metaDocID;
  const HealthEmpDoc({super.key, required this.metaDocID});

  @override
  State<HealthEmpDoc> createState() => _HealthEmpDocState();
}

class _HealthEmpDocState extends State<HealthEmpDoc> {
  TextEditingController docNamecontroller = TextEditingController();
  //TextEditingController docIdController = TextEditingController();

  final StreamController<List<EmployeeDocumentModal>> _controller = StreamController<List<EmployeeDocumentModal>>();
  TextEditingController idOfDocController = TextEditingController();
  TextEditingController nameDocController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController daysController = TextEditingController(text: "1");
  String? selectedYear= AppConfig.year;

  @override
  void dispose() {
   // idDocController.dispose();
    nameDocController.dispose();
    dateController.dispose();
    super.dispose();
  }

  String? selectedValue;
  @override
  void initState() {
    super.initState();
  }

  String? expiryType;
  int docMetaId = 1;
  bool _isLoading = false;

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
    return Container(
      child: Column(
        children: [
          TableHeadingConst(),
          SizedBox(height: AppSize.s10,),
          Expanded(
            child: StreamBuilder<List<EmployeeDocumentModal>>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  getEmployeeDoc(context, widget.metaDocID, 1, 20).then((data) {
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
                       ErrorMessageString.noEmpDocc,
                        //AppString.dataNotFound,
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
                    List<EmployeeDocumentModal> paginatedData = snapshot.data!
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
                              int serialNumber =
                                  index + 1 + (currentPage - 1) * itemsPerPage;
                              String formattedSerialNumber =
                                  serialNumber.toString().padLeft(2, '0');
                              EmployeeDocumentModal employeedoc =
                                  paginatedData[index];
                              return Column(
                                children: [
                                  SizedBox(height: AppSize.s5),
                                  Container(
                                    padding:
                                        EdgeInsets.only(bottom: AppPadding.p5),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: AppMargin.m40),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorManager.grey
                                              .withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    height: AppSize.s56,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Center(
                                              child: Text(
                                            formattedSerialNumber,
                                            // snapshot.data![index].name.toString(),
                                            style:  DocDefineTableData.customTextStyle(context),
                                            textAlign: TextAlign.start,
                                          )),
                                        ),
                                        Expanded(
                                          child: Center(
                                              child: Text(
                                            employeedoc.idOfDocument,
                                            // snapshot.data![index].name.toString(),
                                            style:  DocDefineTableData.customTextStyle(context),
                                            textAlign: TextAlign.start,
                                          )),
                                        ),
                                        Expanded(
                                          child: Center(
                                              child: Text(
                                            employeedoc.docName,
                                            style:  DocDefineTableData.customTextStyle(context),
                                          )),
                                        ),
                                        Expanded(
                                          child: Center(
                                              child: Text(
                                            employeedoc.reminderThreshold,
                                            style:  DocDefineTableData.customTextStyle(context),
                                          )),
                                        ),

                                        ///edit
                                        Expanded(
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    String? selectedExpiryType = expiryType;
                                                    String? selectedDocType;
                                                    int docMetaId = 0;
                                                    List<DropdownMenuItem<String>>dropDownMenuItems = [];
                                                    final docTypes = await getEmployeeDocTab(context);
                                                    if (docTypes.isNotEmpty) {
                                                      for (var i in docTypes) {
                                                        dropDownMenuItems.add(
                                                          DropdownMenuItem<String>(
                                                            child: Text(i.employeeDocType),
                                                            value: i.employeeDocType,
                                                          ),
                                                        );
                                                      }
                                                      selectedDocType = dropDownMenuItems[0].value;
                                                      docMetaId = docTypes[0].employeeDocMetaDataId;
                                                    }

                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return FutureBuilder<GetEmployeeSetupPrefillData>(
                                                          future: getPrefillEmployeeDocTab(context,
                                                              employeedoc.employeeDocTypesetupId),
                                                          builder: (context, snapshotPrefill) {
                                                            if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                                              return Center(
                                                                  child: CircularProgressIndicator(color: ColorManager.blueprime));
                                                            }
                                                            // var expiry = snapshotPrefill.data!.expiry;
                                                            // expiryType = expiry;

                                                            var docName = snapshotPrefill.data?.docName.toString();
                                                            docNamecontroller = TextEditingController(text: snapshotPrefill.data?.docName.toString());

                                                            var empSetupId = snapshotPrefill.data?.employeeDocTypesetupId;
                                                            var calender = snapshotPrefill.data?.reminderThreshold.toString();
                                                            var empDocType = snapshotPrefill.data?.employeeDocTypesetupId;
                                                            var expiry = snapshotPrefill.data!.expiryType;
                                                            String? selectedExpiryType = expiry;


                                                            idOfDocController = TextEditingController(text: snapshotPrefill.data?.idOfDocument.toString());
                                                            dateController = TextEditingController(text: snapshotPrefill.data?.reminderThreshold.toString());


                                                            return StatefulBuilder(
                                                              builder: (BuildContext context,
                                                                  void Function(void Function())setState) {
                                                                return EmpDocEditPopup(
                                                                  title: 'Edit Document',
                                                                  expiryType: expiryType,
                                                                  idOfDocController: idOfDocController,
                                                                  enable: true,
                                                                  nameDocController: docNamecontroller,
                                                                  calenderController: dateController,
                                                                  onSavePredded:
                                                                      () async {
                                                                        setState(() {
                                                                          _isLoading = true;
                                                                        });
                                                                        try {
                                                                          // String expiryTypeToSend = selectedExpiryType == "Not Applicable"
                                                                          //     ? "Not Applicable"
                                                                          //     : dateController.text;
                                                                          int threshold = 0;
                                                                          String? expiryDateToSend = "";
                                                                          if (selectedExpiryType == AppConfig.scheduled && daysController.text.isNotEmpty) {
                                                                            int enteredValue = int.parse(daysController.text);
                                                                            if (selectedYear == AppConfig.year) {
                                                                              threshold = enteredValue * 365;
                                                                            } else if (selectedYear == AppConfig.month) {
                                                                              threshold = enteredValue * 30;
                                                                            }
                                                                            expiryDateToSend = dateController.text;
                                                                          } else if (selectedExpiryType == AppConfig.notApplicable || selectedExpiryType == AppConfig.issuer) {
                                                                            threshold = 0;
                                                                            expiryDateToSend = null;
                                                                          }
                                                                    await editEmployeeDocTypeSetupId(context,
                                                                        docName == docNamecontroller.text ? docName.toString() : docNamecontroller.text,
                                                                        "",
                                                                        selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString() : expiryType.toString(),
                                                                        idOfDocController.text,
                                                                        selectedExpiryType == selectedExpiryType.toString() ? selectedExpiryType.toString() : expiryType.toString(),
                                                                        employeedoc.employeeDocTypesetupId,
                                                                        snapshotPrefill.data!.employeeDocTypeMetaId,
                                                                        threshold);
                                                                  } finally {
                                                                  setState(() {
                                                                  _isLoading = false;
                                                                  });
                                                                  Navigator.pop(context);
                                                                  }
                                                                  },
                                                                  child: Container(
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
                                                                       snapshotPrefill.data!.employeeDocTypeMetaId == AppConfig.healthDocId
                                                                           ? Text(
                                                                        'Health',
                                                                          style: CustomTextStylesCommon.commonStyle(
                                                                            fontWeight: FontWeightManager.medium,
                                                                            fontSize: FontSize.s12,
                                                                            color: ColorManager.mediumgrey,
                                                                          ),
                                                                        )
                                                                           : snapshotPrefill.data!.employeeDocTypeMetaId == AppConfig.certificationDocId
                                                                           ? Text(
                                                                        "Certifications",
                                                                         style: CustomTextStylesCommon.commonStyle(
                                                                           fontWeight: FontWeightManager.medium,
                                                                           fontSize: FontSize.s12,
                                                                           color: ColorManager.mediumgrey,
                                                                         ),
                                                                       )
                                                                           : snapshotPrefill.data!.employeeDocTypeMetaId == AppConfig.employmentDocId
                                                                           ? Text(
                                                                         'Employment',
                                                                         style: CustomTextStylesCommon.commonStyle(
                                                                           fontWeight: FontWeightManager.medium,
                                                                           fontSize: FontSize.s12,
                                                                           color: ColorManager.mediumgrey,
                                                                         ),
                                                                       )
                                                                           : snapshotPrefill.data!.employeeDocTypeMetaId == AppConfig.clinicalVerificationDocId
                                                                           ? Text(
                                                                         "Clinical Verification",
                                                                         style: CustomTextStylesCommon.commonStyle(
                                                                           fontWeight: FontWeightManager.medium,
                                                                           fontSize: FontSize.s12,
                                                                           color: ColorManager.mediumgrey,
                                                                         ),
                                                                       )
                                                                           : snapshotPrefill.data!.employeeDocTypeMetaId == AppConfig.acknowledgementDocId
                                                                           ? Text(
                                                                         'Acknowledgement',
                                                                         style: CustomTextStylesCommon.commonStyle(
                                                                           fontWeight: FontWeightManager.medium,
                                                                           fontSize: FontSize.s12,
                                                                           color: ColorManager.mediumgrey,
                                                                         ),
                                                                       )
                                                                           : snapshotPrefill.data!.employeeDocTypeMetaId == AppConfig.compensationDocId
                                                                           ? Text(
                                                                         "Compensation",
                                                                         style: CustomTextStylesCommon.commonStyle(
                                                                           fontWeight: FontWeightManager.medium,
                                                                           fontSize: FontSize.s12,
                                                                           color: ColorManager.mediumgrey,
                                                                         ),
                                                                       )
                                                                           : Text("Performance",
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
                                                                  ),
                                                                  radioButton: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        "Expiry Type",
                                                                        style: RadioButtonHeadStyle.customTextStyle(context),
                                                                      ),
                                                                      CustomRadioListTile(
                                                                        value:AppConfig.notApplicable,
                                                                        groupValue:
                                                                        selectedExpiryType,
                                                                        onChanged: (value) {
                                                                          setState(() {
                                                                            selectedExpiryType = value;
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
                                                                            selectedExpiryType = value;
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
                                                                            selectedExpiryType = value;
                                                                          });
                                                                        },
                                                                        title: AppConfig.issuer,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child2: Visibility(
                                                                    visible: selectedExpiryType == AppConfig.scheduled,
                                                                    child: Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: AppSize.s10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              height: AppSize.s30,
                                                                              width: AppSize.s50,
                                                                              child: TextFormField(
                                                                                controller: daysController, // Use the controller initialized with "1"
                                                                                cursorColor: ColorManager.black,
                                                                                cursorWidth: 1,
                                                                                style: DocDefination.customTextStyle(context),
                                                                                decoration: InputDecoration(
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 2),
                                                                                    borderRadius: BorderRadius.circular(8),),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 2),
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                  ),
                                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                                                ),
                                                                                keyboardType:
                                                                                TextInputType.number,
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.digitsOnly, // This ensures only digits are accepted
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            SizedBox(width: AppSize.s10),
                                                                            Container(
                                                                              height: AppSize.s30,
                                                                              width: AppSize.s80,
                                                                              padding: EdgeInsets.symmetric(horizontal: 5),
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(color: ColorManager.fmediumgrey),
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                              child: DropdownButtonFormField<String>(
                                                                                value:
                                                                                selectedYear, // Initial value (you should define this variable)
                                                                                items: [
                                                                                  DropdownMenuItem(
                                                                                    value: AppConfig.year,
                                                                                    child: Text(
                                                                                        AppConfig.year,
                                                                                        style: DocDefination.customTextStyle(context)
                                                                                    ),
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: AppConfig.month,
                                                                                    child: Text(
                                                                                        AppConfig.month,
                                                                                        style: DocDefination.customTextStyle(context)
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                                onChanged: (value) {
                                                                                  setState(() {
                                                                                    selectedYear = value;
                                                                                  });
                                                                                },
                                                                                decoration: InputDecoration(
                                                                                  enabledBorder: InputBorder.none,
                                                                                  focusedBorder: InputBorder.none,
                                                                                  hintText: AppConfig.year,
                                                                                  hintStyle: DocDefination.customTextStyle(context),
                                                                                  contentPadding: EdgeInsets.only(bottom: 20),
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
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.edit_outlined,
                                                    size: 18,
                                                    color:
                                                        ColorManager.bluebottom,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),

                                                ///delete
                                                IconButton(
                                                  onPressed: () async {
                                                    await showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            DeletePopup(
                                                                title:
                                                                    'Delete Document',
                                                                onCancel: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                onDelete: () {
                                                                  setState(
                                                                      () async {
                                                                    await employeedoctypeSetupIdDelete(
                                                                        context,
                                                                        employeedoc
                                                                            .employeeDocTypesetupId);
                                                                    getEmployeeDoc(
                                                                            context,
                                                                            widget
                                                                                .metaDocID,
                                                                            1,
                                                                            20)
                                                                        .then(
                                                                            (data) {
                                                                      _controller
                                                                          .add(
                                                                              data);
                                                                    }).catchError(
                                                                            (error) {
                                                                      // Handle error
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                }));
                                                  },
                                                  icon: Icon(
                                                    size: 18,
                                                    Icons
                                                        .delete_outline_outlined,
                                                    color: Color(0xffF6928A),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                  return Offstage();
                }),
          ),
        ],
      ),
    );
  }
}