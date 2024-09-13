import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
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
import 'package:prohealth/presentation/widgets/establishment_text_const/text_widget_const.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../app/constants/app_config.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../scheduler_model/textfield_dropdown_constant/schedular_textfield_const.dart';
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
  TextEditingController fixedPayRatesController = TextEditingController();
  TextEditingController dummyCtrl = TextEditingController();
  final StreamController<List<PayRatesGet>> _payRatesController =
      StreamController<List<PayRatesGet>>();

  String? _selectedZone;
  int currentPage = 1;
  final int itemsPerPage = 10;
  List<PayRatesGet> _fullPayRatesList = [];
  String _selectedOption = 'Option 1';
  int docZoneId = 0;
  String? docAddVisitTypeId;
  int docVisitTypeId = 0;
  int empTypeId = 0;
  bool _isLoading = false;
  int? selectedServiceId;
  bool isServiceSelected = false;
  String? selectedServiceName;
  int? firstServiceId;
  String? abbrivtionName;
  int? employeeTypeId;
  int? firstEmployeeTypeId;
  String abbNameVal = 'Select';

  @override
  void initState() {
    super.initState();
    _loadPayRatesData();


  }

  // List<PayRatesGet> allData = [];
  //
  // Future<void> fetchData() async {
  //   try {
  //     List<PayRatesGet> data = await companyPayratesGet(context);
  //     setState(() {
  //       allData = data;
  //     });
  //     _payRatesController.add(data);
  //   } catch (error) {
  //     // Handle error
  //   }
  // }
  void _loadPayRatesData() async {
    try {
      List<PayRatesGet> data = await companyPayratesGet(context);
      setState(() {
        _fullPayRatesList = data;
      });
     // _filterPayRatesByZone();
    } catch (error) {
      // Handle error
    }
  }
  //
  // void _filterPayRatesByZone() {
  //   List<PayRatesGet> filteredData = _selectedZone == null
  //       ? _fullPayRatesList
  //       : _fullPayRatesList
  //           .where((rate) =>
  //               rate.ZoneId.toString() == _selectedZone!.split('-')[0])
  //           .toList();
  //   _payRatesController.add(filteredData);
  // }
  String? serviceId;


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 12),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [buildDropdownButton(context)],
            // ),
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
                      'Pick Service Type',
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
                    ///disabled container
                    Row(
                      children: [
                        FutureBuilder<List<ServiceData>>(
                          future: PayRateServiceDropdown(context),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return dummeyTextField(
                                width: 300,
                                height: 30,
                                controller: dummyCtrl,
                                labelText: 'Select',
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  color: ColorManager.black,
                                ),
                              );
                            }
                            if (snapshot.hasData && snapshot.data!.isEmpty) {
                              return Container(
                                width:354,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager.containerBorderGrey, width: AppSize.s1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Text(
                                    ErrorMessageString.noserviceAdded,
                                    style: CustomTextStylesCommon.commonStyle(
                                      fontWeight: FontWeightManager.medium,
                                      fontSize: FontSize.s12,
                                      color: ColorManager.mediumgrey,
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              List<DropdownMenuItem<String>>
                              dropDownServiceList = [];
                              for (var service in snapshot.data!) {
                                dropDownServiceList.add(
                                  DropdownMenuItem<String>(
                                    value: service.serviceName,
                                    child: Text(service.serviceName ?? ''),
                                  ),
                                );
                              }

                              // Store the service ID of the 0th position
                              if (dropDownServiceList.isNotEmpty) {
                                firstServiceId =
                                    snapshot.data![0].officeServiceId;
                              }
                              serviceId =
                                  snapshot.data![0].serviceId;

                              if (selectedServiceName == null &&
                                  dropDownServiceList.isNotEmpty) {
                                selectedServiceName =
                                    dropDownServiceList[0].value;
                                selectedServiceId = firstServiceId;
                              }

                              return StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return  CICCDropdown(
                                    width: 300,
                                    initialValue: selectedServiceName,
                                    onChange: (val) {
                                      setState(() {
                                        selectedServiceName = val;
                                        for (var service in snapshot.data!) {
                                          if (service.serviceName == val) {
                                            selectedServiceId =
                                                service.officeServiceId;
                                            serviceId = service.serviceId;
                                          }
                                        }
                                      });
                                    },
                                    items: dropDownServiceList,
                                  );
                                },
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                        // Container(
                        //   height: 30,
                        //   width: 150,
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 6, horizontal: 15),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     border: Border.all(
                        //         color: ColorManager.fmediumgrey, width: 1.2),
                        //     borderRadius: BorderRadius.circular(4),
                        //     boxShadow: [
                        //       // BoxShadow(
                        //       //   color:
                        //       //       const Color(0xff000000).withOpacity(0.25),
                        //       //   blurRadius: 2,
                        //       //   offset: const Offset(0, 2),
                        //       // ),
                        //     ],
                        //   ),
                        //   child: Text(
                        //     'Clinical',
                        //     style: GoogleFonts.firaSans(
                        //       fontSize: 12,
                        //       fontWeight: FontWeightManager.bold,
                        //       color: ColorManager.fmediumgrey,
                        //       decoration: TextDecoration.none,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: 10,
                        ),
                        // FutureBuilder<List<HRAllData>>(
                        //   future: getAllHrDeptWise(context, 1),
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return dummeyTextField(
                        //         width: 300,
                        //         height: 30,
                        //         controller: dummyCtrl,
                        //         labelText: 'Select',
                        //         suffixIcon: Icon(
                        //           Icons.arrow_drop_down,
                        //           color: ColorManager.black,
                        //         ),
                        //       );
                        //     }
                        //     if (snapshot.hasData && snapshot.data!.isEmpty) {
                        //       return Center(
                        //         child: Text(
                        //           ErrorMessageString.noserviceAdded,
                        //           style: CustomTextStylesCommon.commonStyle(
                        //             fontWeight: FontWeightManager.medium,
                        //             fontSize: FontSize.s12,
                        //             color: ColorManager.mediumgrey,
                        //           ),
                        //         ),
                        //       );
                        //     }
                        //     if (snapshot.hasData) {
                        //       List<DropdownMenuItem<String>>
                        //       dropDownServiceList = [];
                        //       for (var service in snapshot.data!) {
                        //         dropDownServiceList.add(
                        //           DropdownMenuItem<String>(
                        //             value: service.abbrivation,
                        //             child: Text(service.abbrivation ?? ''),
                        //           ),
                        //         );
                        //       }
                        //
                        //       // Store the service ID of the 0th position
                        //       if (dropDownServiceList.isNotEmpty) {
                        //         firstEmployeeTypeId =
                        //             snapshot.data![0].employeeTypesId;
                        //       }
                        //
                        //       if (
                        //           dropDownServiceList.isNotEmpty) {
                        //         abbrivtionName =
                        //             dropDownServiceList[0].value;
                        //         employeeTypeId = firstEmployeeTypeId;
                        //       }
                        //
                        //       return CICCDropdown(
                        //         width: 300,
                        //         initialValue: abbrivtionName,
                        //         onChange: (val) {
                        //           setState(() {
                        //             abbrivtionName = val;
                        //             for (var abbrivation in snapshot.data!) {
                        //               if (abbrivation.abbrivation == val) {
                        //                 employeeTypeId =
                        //                     abbrivation.employeeTypesId;
                        //               }
                        //             }
                        //           });
                        //         },
                        //         items: dropDownServiceList,
                        //       );
                        //     }
                        //     return const SizedBox();
                        //   },
                        // ),
                        ///
                        // FutureBuilder<List<HRAllData>>(
                        //   future: getAllHrDeptWise(context, AppConfig.clinicalId),
                        //   builder: (context, snapshotZone) {
                        //     if (snapshotZone.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return Container(
                        //         width: 350,
                        //         height: 30,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(8),
                        //         ),
                        //       );
                        //     }
                        //     if (snapshotZone.data!.isEmpty) {
                        //       return Container(
                        //         height: 30,
                        //         width: 354,
                        //         child: Center(
                        //           child: Text(
                        //             ErrorMessageString.noserviceAdded,
                        //             style: CustomTextStylesCommon.commonStyle(
                        //               fontWeight: FontWeightManager.medium,
                        //               fontSize: FontSize.s12,
                        //               color: ColorManager.mediumgrey,
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     }
                        //     if (snapshotZone.hasData) {
                        //       List<DropdownMenuItem<String>> dropDownTypesList = [];
                        //       int docType = 0;
                        //
                        //       for (var i in snapshotZone.data!) {
                        //         dropDownTypesList.add(
                        //           DropdownMenuItem<String>(
                        //             value: i.abbrivation,
                        //             child: Text(i.abbrivation!),
                        //           ),
                        //         );
                        //       }
                        //
                        //       if (abbNameVal == 'Select County') {
                        //         empTypeId = snapshotZone.data![0].employeeTypesId;
                        //       }
                        //
                        //       return StatefulBuilder(
                        //         builder: (BuildContext context,
                        //             void Function(void Function()) setState) {
                        //           return CICCDropdown(
                        //             initialValue: abbNameVal,
                        //             onChange: (val) {
                        //               setState(() {
                        //                 abbNameVal = val!;
                        //
                        //                 for (var a in snapshotZone.data!) {
                        //                   if (a.abbrivation == val) {
                        //                     docType = a.employeeTypesId;
                        //                     empTypeId = docType;
                        //                     //_selectButton(1);
                        //                     break;
                        //                   }
                        //                 }
                        //               });
                        //             },
                        //             items: dropDownTypesList,
                        //           );
                        //         },
                        //       );
                        //     }
                        //     return const SizedBox();
                        //   },
                        // )
                      ],
                    ),
                    // SizedBox(width: 10,),
                    ///
                    Container(
                      width: 130,
                      height: 32,
                      child: CustomIconButtonConst(
                        text: 'Add Payrate',
                        icon: Icons.add,
                        onPressed: () {
                          payRatesController.clear();
                          perMilesController.clear();
                          // if (selectedServiceId == null) {
                          //   // If no service selected, use the ID of the first service
                          //   setState(() {
                          //     selectedServiceId = firstServiceId;
                          //   });
                          // }
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PayRatesPopup(
                                fixPayRatesController: fixedPayRatesController,
                                visitTypeTextActive: true,
                                payRatesController: payRatesController,
                                perMilesController: perMilesController,
                                title: 'Add Payrates',
                                // Pass the selectedServiceId to the API call
                                onPressed: () async {
                                  if (docAddVisitTypeId != null &&
                                      docZoneId != null) {
                                    try {
                                      int zoneId = docZoneId;
                                      int rate = int.parse(payRatesController.text);
                                      String typeOfVisitId = docAddVisitTypeId.toString();
                                      int perMile = int.parse(perMilesController.text);
                                      String serviceTypeId = serviceId!;
                                      int fixedRate = int.parse(fixedPayRatesController.text);

                                      await addPayrates(
                                        context,
                                        rate,
                                        typeOfVisitId,
                                        perMile,
                                        serviceTypeId,
                                          fixedRate
                                      );
                                      setState(() {
                                        companyPayratesGet(context)
                                            .then((data) {
                                          _payRatesController.add(data);
                                        }).catchError((error) {});
                                      });
                                      // payRatesController.clear();
                                      // perMilesController.clear();
                                    } catch (e) {
                                      print("Failed to add pay rates: $e");
                                    }
                                  } else {
                                    print("Required data is missing.");
                                  }
                                },
                                child1: FutureBuilder<List<VisitListData>>(
                                  future: getVisitList(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CICCDropDownExcel(
                                        width: 354,
                                        initialValue: 'Select',
                                        items: [],
                                      );
                                    }
                                    if (snapshot.hasData &&
                                        snapshot.data!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "No available visits !!",
                                          //AppString.dataNotFound,
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
                                      dropDownZoneList = [];
                                      for (var i in snapshot.data!) {
                                        dropDownZoneList.add(
                                          DropdownMenuItem<String>(
                                            child: Text(i.visitType),
                                            value: i.visitType,
                                          ),
                                        );
                                      }
                                      return CICCDropDownExcel(
                                        initialValue:
                                        dropDownZoneList.isNotEmpty
                                            ? dropDownZoneList[0].value
                                            : null,
                                        onChange: (val) {
                                          for (var a in snapshot.data!) {
                                            if (a.visitType == val) {
                                              docAddVisitTypeId = a.visitType;
                                            }
                                          }
                                        },
                                        items: dropDownZoneList,
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                                child2: FutureBuilder<List<SortByZoneData>>(
                                  future: PayRateZoneDropdown(context),
                                  builder: (context, snapshotZone) {
                                    if (snapshotZone.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CICCDropDownExcel(
                                        width: 354,
                                        initialValue: 'Select',
                                        items: [],
                                      );
                                    }
                                    if (snapshotZone.hasData &&
                                        snapshotZone.data!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "No available zones !!",
                                          //AppString.dataNotFound,
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
                                    if (snapshotZone.hasData) {
                                      List<DropdownMenuItem<String>>
                                      dropDownTypesList = [];
                                      for (var i in snapshotZone.data!) {
                                        dropDownTypesList.add(
                                          DropdownMenuItem<String>(
                                            value: i.zoneName,
                                            child: Text(i.zoneName),
                                          ),
                                        );
                                      }
                                      return CICCDropDownExcel(
                                        initialValue:
                                        dropDownTypesList.isNotEmpty
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
                              );
                            },
                          );
                        },
                      ),
                    ),
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
                //TableHeadItem(text: 'Zone', textAlign: TextAlign.center),
                TableHeadItem(text: 'Actions', textAlign: TextAlign.center),
              ],
            ),
            const SizedBox(
              height: 5,
            ),

            /// List
            Expanded(
              child: StreamBuilder<List<PayRatesGet>>(
                stream: _payRatesController.stream,
                //companyPayratesGet(context);
                builder: (context, snapshot) {
                  companyPayratesGet(context).then((data) {
                    _payRatesController.add(data);
                  }).catchError((error) {});
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
                        ErrorMessageString.noPayRates,
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
                    List<PayRatesGet> paginatedData = snapshot.data!
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
                                PayRatesGet finance = paginatedData[index];
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
                                                  finance.typeOfVisitId,
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
                                                  '\$${finance.rate}',
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
                                                      splashColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      onPressed: () {
                                                        payRatesController
                                                            .clear();
                                                        perMilesController
                                                            .clear();
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return FutureBuilder<
                                                                    PayRatePrefillFinanceData>(
                                                                future: payPrefillRatesDataGet(
                                                                    context,
                                                                    finance
                                                                        .payratesId),
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
                                                                  var fixPayRates =
                                                                      snapshotPrefill
                                                                          .data
                                                                          ?.outOfZoneRate;
                                                                  var payRates =
                                                                      snapshotPrefill
                                                                          .data
                                                                          ?.payratesId;
                                                                  var visitTypeId =
                                                                      snapshotPrefill
                                                                          .data
                                                                          ?.typeOfVisitId;
                                                                  var perMile =
                                                                      snapshotPrefill
                                                                          .data
                                                                          ?.outOfZoneperMile;
                                                                  print(
                                                                      ":::PAYRATESTYPE${visitTypeId}");
                                                                  // var zoneTypeId =
                                                                  //     snapshotPrefill
                                                                  //         .data
                                                                  //         ?.ZoneId;
                                                                  fixedPayRatesController = TextEditingController(text:snapshotPrefill
                                                                      .data
                                                                      ?.outOfZoneRate
                                                                      .toString());
                                                                  payRatesController = TextEditingController(
                                                                      text: snapshotPrefill
                                                                          .data
                                                                          ?.rate
                                                                          .toString());
                                                                  perMilesController = TextEditingController(
                                                                      text: snapshotPrefill
                                                                          .data
                                                                          ?.outOfZoneperMile
                                                                          .toString());
                                                                  return PayRatesPopup(
                                                                    visitTypeTextActive:
                                                                        false,
                                                                    title:
                                                                        'Edit Payrate',
                                                                    child1: SMTextFConst(
                                                                      enable: false,
                                                                      readOnly: true,
                                                                      controller: TextEditingController(
                                                                        text: visitTypeId
                                                                            .toString(),
                                                                      ),
                                                                      keyboardType: TextInputType.number,
                                                                      text: 'Type of Visit',
                                                                    ),
                                                                    child2: FutureBuilder<List<SortByZoneData>>(
                                                                        future: PayRateZoneDropdown(
                                                                            context),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return CICCDropDownExcel(
                                                                              width: 354,
                                                                              initialValue: 'Select',
                                                                              items: [],
                                                                            );
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
                                                                            return CICCDropDownExcel(
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
                                                                    payRatesController: payRatesController,
                                                                    perMilesController: perMilesController,
                                                                    fixPayRatesController: fixedPayRatesController,
                                                                    onPressed:
                                                                        () async {
                                                                      await updatePayRatesSetupPost(
                                                                          context:context,
                                                                          payratesId: finance.payratesId, rate: payRates == int.parse(payRatesController.text)
                                                                          ? payRates!
                                                                          : int.parse(payRatesController
                                                                          .text), typeOfVisitId: visitTypeId!, outOfZoneperMile: perMile == int.parse(perMilesController.text)
                                                                          ? perMile!
                                                                          : int.parse(perMilesController.text),
                                                                          outOfZoneRate: fixPayRates == int.parse(fixedPayRatesController.text)?fixPayRates!:int.parse(fixedPayRatesController.text),
                                                                          serviceId: snapshotPrefill.data!.serviceId);

                                                                      // payRatesController
                                                                      //     .clear();
                                                                      // perMilesController
                                                                      //     .clear();
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
                                                        splashColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
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
                                                                              await deletePayRatesId(context, finance.payratesId);
                                                                            } finally {
                                                                              setState(() {
                                                                                _isLoading = false;
                                                                              });
                                                                              companyPayratesGet(context).then((data) {
                                                                                _payRatesController.add(data);
                                                                              }).catchError((error) {});
                                                                              Navigator.pop(context);
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
                                            SizedBox(width: 30),
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

  Widget buildDropdownButton(BuildContext context) {
    return FutureBuilder<List<SortByZoneData>>(
      future: PayRateZoneDropdown(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
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
            child: Text(
              "No available zone",
              style: GoogleFonts.firaSans(
                fontSize: FontSize.s12,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.blueprime,
                decoration: TextDecoration.none,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text(
            ErrorMessageString.noZoneAdded,
            style: CustomTextStylesCommon.commonStyle(
              fontWeight: FontWeightManager.medium,
              fontSize: FontSize.s12,
              color: ColorManager.mediumgrey,
            ),
          );
        } else {
          List<SortByZoneData> zoneList = snapshot.data!;
          return Container(
            height: 31,
            width: 110,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
              value: _selectedZone,
              hint: Text(
                'Sort By',
                style: GoogleFonts.firaSans(
                  fontSize: FontSize.s12,
                  fontWeight: FontWeightManager.bold,
                  color: ColorManager.blueprime,
                  decoration: TextDecoration.none,
                ),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xff50B5E5),
              ),
              iconSize: 20,
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedZone = newValue;
                 // _filterPayRatesByZone();
                });
              },
              isDense: true,
              items:
                  zoneList.map<DropdownMenuItem<String>>((SortByZoneData zone) {
                String dropdownValue = "${zone.zoneId}-${zone.zoneName}";
                return DropdownMenuItem<String>(
                  value: dropdownValue,
                  child: Text(
                    zone.zoneName,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.medium,
                      color: ColorManager.blueprime,
                      decoration: TextDecoration.none,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
