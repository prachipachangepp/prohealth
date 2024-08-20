import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_pay_rates/widgets/custom_popup.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../widgets/button_constant.dart';
import '../../widgets/table_constant.dart';
import '../../widgets/text_form_field_const.dart';

class FinanceScreen extends StatefulWidget {
  FinanceScreen({
    super.key,
  });

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController payRatesController = TextEditingController();
  TextEditingController perMilesController = TextEditingController();
  final StreamController<List<PayRateFinanceData>> _payRatesController =
      StreamController<List<PayRateFinanceData>>();

  String _selectedOption = 'Option 1';
  int docZoneId = 0;
  int docAddVisitTypeId = 0;
  int docVisitTypeId = 0;
  int empTypeId = 0;
  @override
  void initState() {
    super.initState();
  }

  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ buildDropdownButton(context)],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clinicians Pay Rates',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff686464),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick Employee Type',
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff686464),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<List<HRClinical>>(
                      future: companyAllHrClinicApi(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 300,
                            height: 30,
                            decoration: BoxDecoration(
                              color: ColorManager.faintGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          int docType = 0;
                          List<DropdownMenuItem<String>> dropDownList = [];
                          List<DropdownMenuItem<String>> dropDownAbbreviation =
                              [];

                          for (var i in snapshot.data!) {
                            dropDownList.add(
                              DropdownMenuItem<String>(
                                child: Text(i.empType!),
                                value: i.empType,
                              ),
                            );
                            dropDownAbbreviation.add(
                              DropdownMenuItem<String>(
                                child: Text(i.abbrivation!),
                                value: i.abbrivation,
                              ),
                            );
                          }

                          return Row(
                            children: [
                              /// Disabled Clinical dropdown
                              Container(
                                height: 31,
                                width: 200,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 15),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.grey[300], // Set the color to grey
                                  border: Border.all(
                                    color: const Color(0xff686464)
                                        .withOpacity(0.5),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: DropdownButtonFormField<String>(
                                  focusColor: Colors.transparent,
                                  icon: const Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: Color(0xff686464),
                                  ),
                                  decoration: const InputDecoration.collapsed(
                                      hintText: ''),
                                  hint: Text(
                                    "Clinical",
                                    style: GoogleFonts.firaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Colors.grey[600], // Grey text color
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  items: dropDownList,
                                  onChanged:
                                      null, // Disable the dropdown by setting onChanged to null
                                  value: null,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600], // Grey text color
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              FutureBuilder<List<HRClinical>>(
                                future: companyAllHrClinicApi(context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    // Show loading indicator while waiting for data
                                    return Container(
                                      height: 31,
                                      width: 187,
                                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color(0xff686464).withOpacity(0.5),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        height: 31,
                                        width: 187,
                                      ),
                                    );
                                  }
                                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                    // Populate the dropdown when data is available
                                    List<DropdownMenuItem<String>> dropDownAbbreviation = [];
                                    for (var i in snapshot.data!) {
                                      dropDownAbbreviation.add(
                                        DropdownMenuItem<String>(
                                          child: Text(i.abbrivation!),
                                          value: i.abbrivation,
                                        ),
                                      );
                                    }

                                    return Container(
                                      height: 31,
                                      width: 187,
                                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color(0xff686464).withOpacity(0.5),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        isDense: true,
                                        icon: const Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: Color(0xff686464),
                                        ),
                                        decoration: const InputDecoration.collapsed(hintText: ''),
                                        hint: Text(
                                          "Select",
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff686464),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                        items: dropDownAbbreviation,
                                        onChanged: (newValue) {
                                          for (var a in snapshot.data!) {
                                            if (a.abbrivation == newValue) {
                                              docType = a.employeeTypesId;
                                              empTypeId = docType;
                                            }
                                          }
                                        },
                                        value: null,
                                        style: GoogleFonts.firaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff686464),
                                          decoration: TextDecoration.none,
                                        ),
                                        menuMaxHeight: 200, // Limits the maximum height of the dropdown menu
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: 31,
                                      width: 187,
                                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color(0xff686464).withOpacity(0.5),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "No data available",
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff686464),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              )
                              /// Abbreviation dropdown
                              // FutureBuilder<List<HRClinical>>(
                              //   future: companyAllHrClinicApi(context),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.waiting) {
                              //       // Show loading indicator while waiting for data
                              //       return Container(
                              //         height: 31,
                              //         width: 187,
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 6, horizontal: 15),
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           border: Border.all(
                              //             color: const Color(0xff686464)
                              //                 .withOpacity(0.5),
                              //             width: 1,
                              //           ),
                              //           borderRadius: BorderRadius.circular(12),
                              //         ),
                              //         child: Center(
                              //           child: CircularProgressIndicator(),
                              //         ),
                              //       );
                              //     }
                              //     if (snapshot.hasData &&
                              //         snapshot.data!.isNotEmpty) {
                              //       // Populate the dropdown when data is available
                              //       List<DropdownMenuItem<String>>
                              //           dropDownAbbreviation = [];
                              //       for (var i in snapshot.data!) {
                              //         dropDownAbbreviation.add(
                              //           DropdownMenuItem<String>(
                              //             child: Text(i.abbrivation!),
                              //             value: i.abbrivation,
                              //           ),
                              //         );
                              //       }
                              //
                              //       return Container(
                              //         height: 31,
                              //         width: 187,
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 6, horizontal: 15),
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           border: Border.all(
                              //             color: const Color(0xff686464)
                              //                 .withOpacity(0.5),
                              //             width: 1,
                              //           ),
                              //           borderRadius: BorderRadius.circular(12),
                              //         ),
                              //         child: DropdownButtonFormField<String>(
                              //           focusColor: Colors.transparent,
                              //           icon: const Icon(
                              //             Icons.arrow_drop_down_sharp,
                              //             color: Color(0xff686464),
                              //           ),
                              //           decoration:
                              //               const InputDecoration.collapsed(
                              //                   hintText: ''),
                              //           hint: Text(
                              //             "Select",
                              //             style: GoogleFonts.firaSans(
                              //               fontSize: 12,
                              //               fontWeight: FontWeight.w600,
                              //               color: const Color(0xff686464),
                              //               decoration: TextDecoration.none,
                              //             ),
                              //           ),
                              //           items: dropDownAbbreviation,
                              //           onChanged: (newValue) {
                              //             for (var a in snapshot.data!) {
                              //               if (a.abbrivation == newValue) {
                              //                 docType = a.employeeTypesId;
                              //                 empTypeId = docType;
                              //               }
                              //             }
                              //           },
                              //           value: null,
                              //           style: GoogleFonts.firaSans(
                              //             fontSize: 12,
                              //             fontWeight: FontWeight.w600,
                              //             color: const Color(0xff686464),
                              //             decoration: TextDecoration.none,
                              //           ),
                              //         ),
                              //       );
                              //     } else {
                              //       return Container(
                              //         height: 31,
                              //         width: 187,
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 6, horizontal: 15),
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           border: Border.all(
                              //             color: const Color(0xff686464)
                              //                 .withOpacity(0.5),
                              //             width: 1,
                              //           ),
                              //           borderRadius: BorderRadius.circular(12),
                              //         ),
                              //         child: Center(
                              //           child: Text(
                              //             "No data available",
                              //             style: GoogleFonts.firaSans(
                              //               fontSize: 12,
                              //               fontWeight: FontWeight.w600,
                              //               color: const Color(0xff686464),
                              //               decoration: TextDecoration.none,
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     }
                              //   },
                              // )
                            ],
                          );
                        } else {
                          return const Offstage();
                        }
                      },
                    ),


                    ///trial
                    Container(
                      width: 130,
                      height: 32,
                      child: CustomIconButtonConst(
                        text: 'Add Payrate',
                        icon: Icons.add,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PayRatesPopup(
                                title: 'Add Payrates',
                                child1: FutureBuilder<List<VisitListData>>(
                                  future: getVisitList(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: 354,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: ColorManager.faintGrey,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.hasData && snapshot.data!.isEmpty) {
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
                                      List<DropdownMenuItem<String>> dropDownZoneList = [];
                                      for (var i in snapshot.data!) {
                                        dropDownZoneList.add(
                                          DropdownMenuItem<String>(
                                            child: Text(i.visitType),
                                            value: i.visitType,
                                          ),
                                        );
                                      }
                                      return CICCDropdown(
                                        initialValue: dropDownZoneList.isNotEmpty
                                            ? dropDownZoneList[0].value
                                            : null,
                                        onChange: (val) {
                                          for (var a in snapshot.data!) {
                                            if (a.visitType == val) {
                                              docAddVisitTypeId = a.visitId;
                                            }
                                          }
                                        },
                                        items: dropDownZoneList,
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                                child2: FutureBuilder<List<AllZoneData>>(
                                  future: getAllZone(context),
                                  builder: (context, snapshotZone) {
                                    if (snapshotZone.connectionState == ConnectionState.waiting) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: 354,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: ColorManager.faintGrey,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshotZone.hasData && snapshotZone.data!.isEmpty) {
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
                                    if (snapshotZone.hasData) {
                                      List<DropdownMenuItem<String>> dropDownTypesList = [];
                                      for (var i in snapshotZone.data!) {
                                        dropDownTypesList.add(
                                          DropdownMenuItem<String>(
                                            value: i.zoneName,
                                            child: Text(i.zoneName),
                                          ),
                                        );
                                      }
                                      return CICCDropdown(
                                        initialValue: dropDownTypesList.isNotEmpty
                                            ? dropDownTypesList[0].value
                                            : null,
                                        onChange: (val) {
                                          for (var a in snapshotZone.data!) {
                                            if (a.zoneName == val) {
                                              docZoneId = a.zoneId;
                                            }
                                          }
                                        },
                                        items: dropDownTypesList,
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                                payRatesController: payRatesController,
                                perMilesController: perMilesController,
                                onPressed: () async {
                                  if (docAddVisitTypeId != null && docZoneId != null) {
                                    try {
                                      await addButtonPayRatesSetupPost(
                                        context,
                                        docZoneId!,
                                        int.parse(payRatesController.text),
                                        docAddVisitTypeId!.toString(),
                                        int.parse(perMilesController.text,),
                                        empTypeId,
                                      );
                                      payRatesController.clear();
                                      perMilesController.clear();
                                    } catch (e) {
                                      print("Failed to add pay rates: $e");
                                    }
                                  } else {
                                    print("Required data is missing.");
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    )


                    ///add payrate button
                    // Container(
                    //   width: 130,
                    //   height: 32,
                    //   child: CustomIconButtonConst(
                    //       text: 'Add Payrate',
                    //       icon: Icons.add,
                    //       onPressed: () {
                    //         showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return PayRatesPopup(
                    //               title: 'Add Payrates',
                    //               child1: FutureBuilder<List<VisitListData>>(
                    //                   future: getVisitList(context),
                    //                   builder: (context, snapshot) {
                    //                     if (snapshot.connectionState ==
                    //                         ConnectionState.waiting) {
                    //                       return Shimmer.fromColors(
                    //                           baseColor: Colors.grey[300]!,
                    //                           highlightColor: Colors.grey[100]!,
                    //                           child: Container(
                    //                             width: 354,
                    //                             height: 30,
                    //                             decoration: BoxDecoration(
                    //                                 color:
                    //                                     ColorManager.faintGrey,
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(
                    //                                         10)),
                    //                           ));
                    //                     }
                    //                     if (snapshot.data!.isEmpty) {
                    //                       return Center(
                    //                         child: Text(
                    //                           AppString.dataNotFound,
                    //                           style: CustomTextStylesCommon
                    //                               .commonStyle(
                    //                             fontWeight:
                    //                                 FontWeightManager.medium,
                    //                             fontSize: FontSize.s12,
                    //                             color: ColorManager.mediumgrey,
                    //                           ),
                    //                         ),
                    //                       );
                    //                     }
                    //                     if (snapshot.hasData) {
                    //                       List dropDown = [];
                    //                       int docType = 0;
                    //                       List<DropdownMenuItem<String>>
                    //                           dropDownZoneList = [];
                    //                       for (var i in snapshot.data!) {
                    //                         dropDownZoneList.add(
                    //                           DropdownMenuItem<String>(
                    //                             child: Text(i.visitType),
                    //                             value: i.visitType,
                    //                           ),
                    //                         );
                    //                       }
                    //                       return CICCDropdown(
                    //                           initialValue:
                    //                               dropDownZoneList[0].value,
                    //                           onChange: (val) {
                    //                             for (var a in snapshot.data!) {
                    //                               if (a.visitType == val) {
                    //                                 docType = a.visitId;
                    //                                 docAddVisitTypeId = docType;
                    //                               }
                    //                             }
                    //                             print(":::${docType}");
                    //                             print(
                    //                                 ":::<>${docAddVisitTypeId}");
                    //                           },
                    //                           items: dropDownZoneList);
                    //                     }
                    //                     return const SizedBox();
                    //                   }),
                    //               child2: FutureBuilder<List<AllZoneData>>(
                    //                   future: getAllZone(context),
                    //                   builder: (context, snapshotZone) {
                    //                     if (snapshotZone.connectionState ==
                    //                         ConnectionState.waiting) {
                    //                       return Shimmer.fromColors(
                    //                           baseColor: Colors.grey[300]!,
                    //                           highlightColor: Colors.grey[100]!,
                    //                           child: Container(
                    //                             width: 354,
                    //                             height: 30,
                    //                             decoration: BoxDecoration(
                    //                                 color:
                    //                                     ColorManager.faintGrey,
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(
                    //                                         10)),
                    //                           ));
                    //                     }
                    //                     if (snapshotZone.data!.isEmpty) {
                    //                       return Center(
                    //                         child: Text(
                    //                           AppString.dataNotFound,
                    //                           style: CustomTextStylesCommon
                    //                               .commonStyle(
                    //                             fontWeight:
                    //                                 FontWeightManager.medium,
                    //                             fontSize: FontSize.s12,
                    //                             color: ColorManager.mediumgrey,
                    //                           ),
                    //                         ),
                    //                       );
                    //                     }
                    //                     if (snapshotZone.hasData) {
                    //                       List dropDown = [];
                    //                       int docType = 0;
                    //                       List<DropdownMenuItem<String>>
                    //                           dropDownTypesList = [];
                    //                       for (var i in snapshotZone.data!) {
                    //                         dropDownTypesList.add(
                    //                           DropdownMenuItem<String>(
                    //                             value: i.zoneName,
                    //                             child: Text(i.zoneName),
                    //                           ),
                    //                         );
                    //                       }
                    //                       return CICCDropdown(
                    //                           initialValue:
                    //                               dropDownTypesList[0].value,
                    //                           onChange: (val) {
                    //                             for (var a
                    //                                 in snapshotZone.data!) {
                    //                               if (a.zoneName == val) {
                    //                                 docType = a.zoneId;
                    //                                 print(
                    //                                     "ZONE id :: ${a.zoneId}");
                    //                                 docZoneId = docType;
                    //                               }
                    //                             }
                    //                             print(":::${docType}");
                    //                             print(":::<>${docZoneId}");
                    //                           },
                    //                           items: dropDownTypesList);
                    //                     }
                    //                     return const SizedBox();
                    //                   }),
                    //               payRatesController: payRatesController,
                    //               perMilesController: perMilesController,
                    //               onPressed: () async {
                    //                 // await addPayRatesSetupPost(
                    //                 //   context,
                    //                 //     1,
                    //                 //     1,
                    //                 //     int.parse(perMilesController.text),
                    //                 //     docAddVisitTypeId,
                    //                 //     docZoneId,
                    //                 // int.parse(payRatesController.text),
                    //                 // );
                    //                 payRatesDataGet(context, empTypeId, 1, 30)
                    //                     .then((data) {
                    //                   _payRatesController.add(data);
                    //                 }).catchError((error) {
                    //                   // Handle error
                    //                 });
                    //                 payRatesController.clear();
                    //                 perMilesController.clear();
                    //               },
                    //             );
                    //           },
                    //         );
                    //       }),
                    // ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),

            const TableHeadConstant(
              items: [
                TableHeadItem(text: 'Sr No.', textAlign: TextAlign.center),
                TableHeadItem(
                    text: 'Type of Visit', textAlign: TextAlign.center),
                TableHeadItem(text: 'Rate', textAlign: TextAlign.center),
                TableHeadItem(text: 'Permiles', textAlign: TextAlign.center),
                TableHeadItem(text: 'Zone', textAlign: TextAlign.center),
                TableHeadItem(text: 'Actions', textAlign: TextAlign.center),
              ],
            ),
            const SizedBox(
              height: 5,
            ),

            ///list
            Expanded(
              child: StreamBuilder<List<PayRateFinanceData>>(
                stream: _payRatesController.stream,
                builder: (context, snapshot) {
                  payRatesDataGet(context, 1, 1, 30).then((data) {
                    _payRatesController.add(data);
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
                    List<PayRateFinanceData> paginatedData = snapshot.data!
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
                                PayRateFinanceData finance =
                                    paginatedData[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Container(
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  formattedSerialNumber,
                                                  //textAlign: TextAlign.end,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  finance.typeVisit,
                                                  //textAlign: TextAlign.end,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  '\$${finance.payRates}',
                                                  //textAlign: TextAlign.end,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  '${finance.permile}',
                                                  //textAlign: TextAlign.end,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  '${finance.zone!}',
                                                  // textAlign: TextAlign.start,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xff686464),
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return FutureBuilder<
                                                                    PayRatePrefillFinanceData>(
                                                                future: payPrefillRatesDataGet(
                                                                    context,
                                                                    finance
                                                                        .payRatesSetupId),
                                                                builder: (context,
                                                                    snapshotPrefill) {
                                                                  if (snapshotPrefill
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: ColorManager
                                                                            .blueprime,
                                                                      ),
                                                                    );
                                                                  }
                                                                  var payRates =
                                                                      snapshotPrefill
                                                                          .data
                                                                          ?.payRates;
                                                                  var visitTypeId =
                                                                      snapshotPrefill
                                                                          .data
                                                                          ?.typeOfVisitId;
                                                                  var perMile =
                                                                      snapshotPrefill
                                                                          .data
                                                                          ?.perMiles;
                                                                  print(
                                                                      ":::PAYRATESTYPE${visitTypeId}");
                                                                  var zoneTypeId =
                                                                      snapshotPrefill
                                                                          .data
                                                                          ?.zoneId;
                                                                  payRatesController = TextEditingController(
                                                                      text: snapshotPrefill
                                                                          .data
                                                                          ?.payRates
                                                                          .toString());
                                                                  perMilesController = TextEditingController(
                                                                      text: snapshotPrefill
                                                                          .data
                                                                          ?.perMiles
                                                                          .toString());
                                                                  return PayRatesPopup(
                                                                    title:
                                                                        'Edit Payrate',
                                                                    child1:
                                                                        SMTextFConst(
                                                                      enable:
                                                                          false,
                                                                      readOnly:
                                                                          true,
                                                                      controller:
                                                                          TextEditingController(
                                                                        text: visitTypeId
                                                                            .toString(),
                                                                      ),
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      text:
                                                                          'Type of Visit',
                                                                    ),
                                                                    child2: FutureBuilder<
                                                                            List<
                                                                                AllZoneData>>(
                                                                        future: getAllZone(
                                                                            context),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return Shimmer.fromColors(
                                                                                baseColor: Colors.grey[300]!,
                                                                                highlightColor: Colors.grey[100]!,
                                                                                child: Container(
                                                                                  width: 354,
                                                                                  height: 30,
                                                                                  decoration: BoxDecoration(color: ColorManager.faintGrey, borderRadius: BorderRadius.circular(10)),
                                                                                ));
                                                                          }
                                                                          if (snapshot
                                                                              .data!
                                                                              .isEmpty) {
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
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            List
                                                                                dropDown =
                                                                                [];
                                                                            int docType =
                                                                                0;
                                                                            List<DropdownMenuItem<String>>
                                                                                dropDownTypesList =
                                                                                [];
                                                                            for (var i
                                                                                in snapshot.data!) {
                                                                              dropDownTypesList.add(
                                                                                DropdownMenuItem<String>(
                                                                                  child: Text(i.zoneName),
                                                                                  value: i.zoneName,
                                                                                ),
                                                                              );
                                                                            }
                                                                            return CICCDropdown(
                                                                                initialValue: dropDownTypesList[0].value,
                                                                                onChange: (val) {
                                                                                  for (var a in snapshot.data!) {
                                                                                    if (a.zoneName == val) {
                                                                                      docType = a.zoneId;
                                                                                      docZoneId = docType;
                                                                                    }
                                                                                  }
                                                                                  print(":::${docType}");
                                                                                  print(":::<>${docZoneId}");
                                                                                },
                                                                                items: dropDownTypesList);
                                                                          }
                                                                          return const SizedBox();
                                                                        }),
                                                                    payRatesController:
                                                                        payRatesController,
                                                                    perMilesController:
                                                                        perMilesController,
                                                                    onPressed:
                                                                        () async {
                                                                      await updatePayRatesSetupPost(
                                                                        context,
                                                                        1,
                                                                        1,
                                                                        perMile ==
                                                                                int.parse(perMilesController.text)
                                                                            ? perMile!
                                                                            : int.parse(perMilesController.text),
                                                                        visitTypeId!,
                                                                        zoneTypeId ==
                                                                                docZoneId
                                                                            ? zoneTypeId!
                                                                            : docZoneId,
                                                                        payRates ==
                                                                                int.parse(payRatesController.text)
                                                                            ? payRates!
                                                                            : int.parse(payRatesController.text),
                                                                        snapshot
                                                                            .data![index]
                                                                            .payRatesSetupId,
                                                                      );
                                                                      print(
                                                                          "ALL::${visitTypeId}+${docVisitTypeId}+Zone${zoneTypeId}+${docZoneId}");
                                                                      payRatesDataGet(
                                                                              context,
                                                                              1,
                                                                              1,
                                                                              30)
                                                                          .then(
                                                                              (data) {
                                                                        _payRatesController
                                                                            .add(data);
                                                                      }).catchError(
                                                                              (error) {
                                                                        // Handle error
                                                                      });
                                                                      docZoneId =
                                                                          0;
                                                                      zoneTypeId =
                                                                          0;
                                                                      visitTypeId =
                                                                          0;
                                                                      payRatesController
                                                                          .clear();
                                                                      perMilesController
                                                                          .clear();
                                                                    },
                                                                  );
                                                                });
                                                          },
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.edit_outlined,
                                                        size: 18,
                                                        color: ColorManager
                                                            .blueprime,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  StatefulBuilder(
                                                                    builder: (BuildContext
                                                                            context,
                                                                        void Function(void Function())
                                                                            setState) {
                                                                      return DeletePopup(
                                                                          title:
                                                                              'Delete Pay Rates',
                                                                          loadingDuration:
                                                                              _isLoading,
                                                                          onCancel:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          onDelete:
                                                                              () async {
                                                                            setState(() {
                                                                              _isLoading = true;
                                                                            });
                                                                            try {
                                                                              await deletePayRatesSetupPost(context, snapshot.data![index].payRatesSetupId);
                                                                              setState(() async {
                                                                                await payRatesDataGet(context, 1, 1, 30).then((data) {
                                                                                  _payRatesController.add(data);
                                                                                }).catchError((error) {
                                                                                  // Handle error
                                                                                });
                                                                                Navigator.pop(context);
                                                                              });
                                                                            } finally {
                                                                              setState(() {
                                                                                _isLoading = false;
                                                                              });
                                                                            }
                                                                          });
                                                                    },
                                                                  ));
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .delete_outline_outlined,
                                                          size: 18,
                                                          color:
                                                              ColorManager.red,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            )
                                          ],
                                        )),
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
                        SizedBox(height: AppSize.s10),
                      ],
                    );
                  }
                  return const Offstage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildDropdownButton(BuildContext context) {
  return Container(
    height: 31,
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xff50B5E5), width: 1.2),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff000000).withOpacity(0.25),
          blurRadius: 2,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: DropdownButton<String>(
      value: 'Sort By',
      style: GoogleFonts.firaSans(
        fontSize: 12,
        fontWeight: FontWeightManager.bold,
        color: const Color(0xff50B5E5),
        decoration: TextDecoration.none,
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Color(0xff50B5E5),
      ),
      iconSize: 20,
      underline: const SizedBox(),
      onChanged: (String? newValue) {},
      isDense: true,
      items: <String>[
        'Sort By',
        'For all zones',
        'San Jose z4',
        'San Jose z4',
        'San Jose z4',
        'San Jose z4',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: ColorManager.blueprime),
          ),
        );
      }).toList(),
    ),
  );
}

///change color dropdown
// Widget buildDropdownButton(BuildContext context) {
//   ValueNotifier<String> selectedValueNotifier = ValueNotifier<String>('Sort By');
//
//   return ValueListenableBuilder<String>(
//     valueListenable: selectedValueNotifier,
//     builder: (context, selectedValue, child) {
//       return Container(
//         height: 31,
//         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//             color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//             width: 1.2,
//           ),
//           borderRadius: BorderRadius.circular(12.0),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xff000000).withOpacity(0.25),
//               blurRadius: 2,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: DropdownButton<String>(
//           value: selectedValue,
//           style: GoogleFonts.firaSans(
//             fontSize: 10,
//             fontWeight: FontWeight.w500,
//             color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//             decoration: TextDecoration.none,
//           ),
//           icon: Icon(
//             Icons.arrow_drop_down,
//             color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//           ),
//           iconSize: 20,
//           underline: SizedBox(),
//           onChanged: (newValue) {
//             selectedValueNotifier.value = newValue!;
//           },
//           items: <String>['Sort By', 'For all zones', 'San Jose z4']
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(
//                 value,
//                 style: TextStyle(
//                   color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     },
//   );
// }

// items: dropDownList.map((String value) {
//   return DropdownMenuItem<String>(
//     value: value,
//     child: Text(
//       value,
//       style: GoogleFonts.firaSans(
//         fontSize: 12,
//         color: Color(0xff575757),
//         fontWeight: FontWeight.w400,
//       ),
//     ),
//   );
// }).toList(),
// )

// return SizedBox(
//   height: 32,
//   child: DropdownButtonFormField<String>(
//     decoration: InputDecoration(
//       hintStyle: GoogleFonts.firaSans(
//         fontSize: 10.0,
//         fontWeight: FontWeight.w400,
//         color: const Color(0xff9B9B9B),
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(4.0),
//         borderSide:
//         const BorderSide(color: Colors.grey),
//       ),
//       contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12),
//     ),
//     icon: Icon(Icons.arrow_drop_down,
//         color: Color(0xff9B9B9B)),
//     iconSize: 24,
//     elevation: 16,
//     style: GoogleFonts.firaSans(
//       fontSize: 10.0,
//       fontWeight: FontWeight.w400,
//       color: const Color(0xff686464),
//     ),
//     onChanged: (newValue) {
//       for (var a in snapshot.data!) {
//         if (a.degree == newValue) {
//           selectedDegree = a.degree!;
//         }
//       }
//     },
//     items: dropDownList.map((String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(
//           value,
//           style: GoogleFonts.firaSans(
//             fontSize: 12,
//             color: Color(0xff575757),
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       );
//     }).toList(),
//   ),
// );

//return Container(
//   height: 31,
//   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     border: Border.all(color: const Color(0xff50B5E5), width: 1.2),
//     borderRadius: BorderRadius.circular(12.0),
//     boxShadow: [
//       BoxShadow(
//         color: const Color(0xff000000).withOpacity(0.25),
//         blurRadius: 2,
//         offset: const Offset(0, 2),
//       ),
//     ],
//   ),
//   child: DropdownButton<String>(
//     value: 'Sort By',
//     style: GoogleFonts.firaSans(
//       fontSize: 12,
//       fontWeight: FontWeightManager.bold,
//       color: const Color(0xff50B5E5),
//       decoration: TextDecoration.none,
//     ),
//     icon: const Icon(
//       Icons.arrow_drop_down,
//       color: Color(0xff50B5E5),
//     ),
//
//     iconSize: 20,
//     underline: const SizedBox(),
//     onChanged: (String? newValue) {
//       // Show popup or AlertDialog
//       // if (newValue != null) {
//       //   showDialog(
//       //     context: context,
//       //     builder: (BuildContext context) {
//       //       TextEditingController nameController = TextEditingController();
//       //       TextEditingController addressController = TextEditingController();
//       //       TextEditingController emailController = TextEditingController();
//       //       return AlertDialog(
//       //           backgroundColor: Colors.white,
//       //           content: Container(
//       //             height: 343,
//       //             width: 409,
//       //             child: Column(
//       //               mainAxisAlignment: MainAxisAlignment.start,
//       //               children: [
//       //                 Row(
//       //                   mainAxisAlignment: MainAxisAlignment.end,
//       //                   crossAxisAlignment: CrossAxisAlignment.end,
//       //                   children: [
//       //                     IconButton(
//       //                         onPressed: () {
//       //                           Navigator.pop(context);
//       //                         },
//       //                         icon: const Icon(Icons.close))
//       //                   ],
//       //                 ),
//       //                 Column(
//       //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //                   children: [
//       //                     SMTextFConst(
//       //                       controller: nameController,
//       //                       keyboardType: TextInputType.text,
//       //                       text: 'Type of Visit',
//       //                     ),
//       //                     const SizedBox(
//       //                       height: 25,
//       //                     ),
//       //                     SMTextFConst(
//       //                       controller: addressController,
//       //                       keyboardType: TextInputType.streetAddress,
//       //                       text: 'Zone',
//       //                     ),
//       //                     const SizedBox(
//       //                       height: 25,
//       //                     ),
//       //                     SMTextFConst(
//       //                       controller: emailController,
//       //                       keyboardType: TextInputType.emailAddress,
//       //                       text: 'Rate',
//       //                     ),
//       //                   ],
//       //                 ),
//       //                 const SizedBox(
//       //                   height: 60,
//       //                 ),
//       //                 CustomElevatedButton(
//       //                     width: 105,
//       //                     height: 31,
//       //                     text: 'Submit',
//       //                     onPressed: () {
//       //                       // Navigator.push(
//       //                       //     context,
//       //                       //     MaterialPageRoute(
//       //                       //         builder: (context) =>
//       //                       //             LoginScreen()));
//       //                     })
//       //               ],
//       //             ),
//       //           ));
//       //     },
//       //   );
//       // }
//     },
//     isDense: true,
//     items: <String>[
//       'Sort By',
//       'For all zones',
//       'San Jose z4',
//       'San Jose z4',
//       'San Jose z4',
//       'San Jose z4',
//     ].map<DropdownMenuItem<String>>((String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(
//           value,
//           style: TextStyle(color: ColorManager.blueprime),
//         ),
//       );
//     }).toList(),
//   ),
// );

///change color dropdown
// Widget buildDropdownButton(BuildContext context) {
//   ValueNotifier<String> selectedValueNotifier = ValueNotifier<String>('Sort By');
//
//   return ValueListenableBuilder<String>(
//     valueListenable: selectedValueNotifier,
//     builder: (context, selectedValue, child) {
//       return Container(
//         height: 31,
//         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//             color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//             width: 1.2,
//           ),
//           borderRadius: BorderRadius.circular(12.0),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xff000000).withOpacity(0.25),
//               blurRadius: 2,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: DropdownButton<String>(
//           value: selectedValue,
//           style: GoogleFonts.firaSans(
//             fontSize: 10,
//             fontWeight: FontWeight.w500,
//             color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//             decoration: TextDecoration.none,
//           ),
//           icon: Icon(
//             Icons.arrow_drop_down,
//             color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//           ),
//           iconSize: 20,
//           underline: SizedBox(),
//           onChanged: (newValue) {
//             selectedValueNotifier.value = newValue!;
//           },
//           items: <String>['Sort By', 'For all zones', 'San Jose z4']
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(
//                 value,
//                 style: TextStyle(
//                   color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     },
//   );
// }

///dropdown 1 old
//               FutureBuilder<List<HRClinical>>(
//                   future: companyAllHrClinicApi(context),
//                   builder: (context,snapshot) {
//                     if(snapshot.connectionState == ConnectionState.waiting){
//                       return Shimmer.fromColors(
//                           baseColor: Colors.grey[300]!,
//                           highlightColor: Colors.grey[100]!,
//                           child: Container(
//                             width: 300,
//                             height: 30,
//                             decoration: BoxDecoration(
//                                 color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
//                           )
//                       );
//                     }
//                     if(snapshot.hasData){
//                       int docType = 0;
//                       List<DropdownMenuItem<String>> dropDownList =[];
//                       List<DropdownMenuItem<String>> dropDownAbbreviation =[];
//                       for(var i in snapshot.data!){
//                         dropDownList.add(DropdownMenuItem<String>(
//                           child: Text(i.empType!),
//                           value: i.empType,
//                         ));
//                         dropDownAbbreviation.add(
//                             DropdownMenuItem<String>(
//                               child: Text(i.abbrivation!),
//                               value: i.abbrivation,
//                             ));
//                       }
//                       return Row(
//                         children: [
//                           ///home health dropdown 1
//                           Container(
//                             height: 31,
//                             width: 200,
//                             // margin: EdgeInsets.symmetric(horizontal: 20),
//                             padding:
//                             const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                   color: const Color(0xff686464).withOpacity(0.5),
//                                   width: 1),
//                               // Black border
//                               borderRadius:
//                               BorderRadius.circular(12), // Rounded corners
//                             ),
//                             child: DropdownButtonFormField<String>(
//                               focusColor: Colors.transparent,
//                               icon: const Icon(
//                                 Icons.arrow_drop_down_sharp,
//                                 color: Color(0xff686464),
//                               ),
//                               decoration: const InputDecoration.collapsed(hintText: ''),
//                               items: dropDownList,
//                               onChanged: (newValue) {
//                                 for(var a in snapshot.data!){
//                                   if(a.empType == newValue){
//                                     docType = a.employeeTypesId;
//                                     empTypeId = docType;
//                                   }
//                                 }
//                               },
//                               value: dropDownList[0].value,
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: const Color(0xff686464),
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           /// Abbrevation dropdown 2
//                           Container(
//                             height: 31,
//                             width: 187,
//                             // margin: EdgeInsets.symmetric(horizontal: 20),
//                             padding:
//                             const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(
//                                   color: const Color(0xff686464).withOpacity(0.5),
//                                   width: 1), // Black border
//                               borderRadius:
//                               BorderRadius.circular(12), // Rounded corners
//                             ),
//                             child: DropdownButtonFormField<String>(
//                               focusColor: Colors.transparent,
//                               icon: const Icon(
//                                 Icons.arrow_drop_down_sharp,
//                                 color: Color(0xff686464),
//                               ),
//                               decoration: const InputDecoration.collapsed(hintText: ''),
//                               items: dropDownAbbreviation,
//                               onChanged: (newValue) {
//                                 for(var a in snapshot.data!){
//                                   if(a.abbrivation == newValue){
//                                     docType = a.employeeTypesId;
//                                     empTypeId = docType;
//                                   }
//                                 }
//                               },
//                               value: dropDownAbbreviation[0].value,
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: const Color(0xff686464),
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }else{
//                       return const Offstage();
//                     }
//
//                   }
//               ),
