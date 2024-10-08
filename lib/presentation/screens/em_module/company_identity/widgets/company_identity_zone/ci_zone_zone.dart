import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';

import '../../../../../../data/api_data/establishment_data/zone/zone_model_data.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class CIZoneZone extends StatefulWidget {
  final int countyId;
  final int companyID;
  final String officeId;
  const CIZoneZone(
      {super.key,
      required this.companyID,
      required this.officeId,
      required this.countyId});

  @override
  State<CIZoneZone> createState() => _CIZoneZoneState();
}

class _CIZoneZoneState extends State<CIZoneZone> {
  TextEditingController countynameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController zoneNumberController = TextEditingController();
  final StreamController<List<AllCountyZoneGet>> _zoneController =
      StreamController<List<AllCountyZoneGet>>();


  int countyId = 0;
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
    return Column(
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(''),
                Expanded(
                  child: Center(
                    child: Text(
                      'Zone Name',
                      style:TableHeading.customTextStyle(context),
                    ),
                  ),
                ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Expanded(
                  child: Center(
                    child: Text('Zip Codes',
                      style:TableHeading.customTextStyle(context),),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('County',
                      style:TableHeading.customTextStyle(context),),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Actions',
                      style:TableHeading.customTextStyle(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: StreamBuilder<List<AllCountyZoneGet>>(
            stream: _zoneController.stream,
            builder: (context, snapshot) {
              getZoneByCounty(context, widget.officeId,widget.countyId, 1, 20).then((data) {
                data.sort((a, b) => b.countyId.compareTo(a.countyId));
                _zoneController.add(data);
              }).catchError((error) {});
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
                    ErrorMessageString.noZones,
                    style: DocumentTypeDataStyle.customTextStyle(context)
                  ),
                );
              }
              if (snapshot.hasData) {
                int totalItems = snapshot.data!.length;
                int totalPages = (totalItems / itemsPerPage).ceil();
                List<AllCountyZoneGet> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          // scrollDirection: Axis.vertical,
                          // itemCount: paginatedData.length,
                          // itemBuilder: (context, index) {
                          //   int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                          //   String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                          //   AllCountyZoneGet zone = paginatedData[index];
                          scrollDirection: Axis.vertical,
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            // Reverse the index to show newly added items at the top
                            int reverseIndex = paginatedData.length - 1 - index;
                            int serialNumber = reverseIndex + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                            AllCountyZoneGet zone = paginatedData[reverseIndex];  // Use reverseIndex here
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color(0xff000000).withOpacity(0.25),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                zone.zoneName
                                                    .toString(),
                                                style:  TableSubHeading.customTextStyle(context),
                                              ),
                                            ),
                                            // Text(''),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                zone.zipcodes
                                                    .toString(),
                                                style:  TableSubHeading.customTextStyle(context),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                zone.countyName
                                                    .toString(),
                                                style:  DocumentTypeDataStyle.customTextStyle(context),
                                              ),
                                            ),
                                            // Expanded(
                                            //   flex: 3,
                                            //   child: Text(
                                            //     textAlign: TextAlign.center,
                                            //     zone.cities
                                            //         .toString(),
                                            //     style: GoogleFonts.firaSans(
                                            //       fontSize: 10,
                                            //       fontWeight: FontWeight.w500,
                                            //       color: ColorManager.mediumgrey,
                                            //       decoration: TextDecoration.none,
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                              flex: 3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      splashColor: Colors.transparent,
                                                      hoverColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return FutureBuilder<CountyZonePrefillGet>(
                                                                  future: getZoneByCountyPrefill(
                                                                          context,
                                                                        zone.zoneId),
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
                                                                    var zoneNumber =
                                                                        snapshotPrefill
                                                                            .data!
                                                                            .zoneName
                                                                            .toString();
                                                                    var countyPreId =
                                                                        snapshotPrefill
                                                                            .data!
                                                                            .countyId;
                                                                    countyId =
                                                                        countyPreId;
                                                                    zoneNumberController =
                                                                        TextEditingController(
                                                                            text: snapshotPrefill
                                                                                .data!
                                                                                .zoneName
                                                                                .toString());
                                                                    return AddZonePopup(
                                                                      countyNameController: TextEditingController(text: snapshotPrefill.data!.countyName),
                                                                      buttonTitle: AppStringEM.save,
                                                                      zoneNumberController:
                                                                          zoneNumberController,
                                                                      title:
                                                                          'Edit Zone',
                                                                      onSavePressed:
                                                                          () async {
                                                                       var response =  await updateZoneCountyData(
                                                                            context,
                                                                           zone.zoneId,
                                                                            zoneNumber ==
                                                                                zoneNumberController.text
                                                                                ? zoneNumber.toString()
                                                                                : zoneNumberController.text,
                                                                            // 25,widget.officeId, widget.companyID);
                                                                            countyPreId ==
                                                                                    countyId
                                                                                ? countyPreId
                                                                                : countyId,
                                                                            widget
                                                                                .officeId,
                                                                            widget
                                                                                .companyID);
                                                                        zoneNumberController
                                                                            .clear();
                                                                        countyId = 0;
                                                                       Navigator.pop(context);
                                                                       if(response.statusCode == 200 || response.statusCode == 201){
                                                                         showDialog(
                                                                           context: context,
                                                                           builder: (BuildContext context) {
                                                                             return AddSuccessPopup(
                                                                               message: 'Zone Edited Successfully',
                                                                             );
                                                                           },
                                                                         );
                                                                       }
                                                                      },
                                                                      child: FutureBuilder<
                                                                          List<AllCountyGetList>>(
                                                                          future: getCountyZoneList(
                                                                              context),
                                                                          builder:
                                                                              (context,
                                                                                  snapshotZone) {
                                                                            if (snapshotZone
                                                                                    .connectionState ==
                                                                                ConnectionState
                                                                                    .waiting) {
                                                                              return Container(
                                                                                width: 354,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border.all(
                                                                                      color: ColorManager.containerBorderGrey, width: AppSize.s1),
                                                                                  borderRadius: BorderRadius.circular(4),
                                                                                ),
                                                                                child: const Text(
                                                                                  "",
                                                                                  //AppString.dataNotFound,
                                                                                ),
                                                                              );
                                                                            }
                                                                            if (snapshotZone
                                                                                .data!
                                                                                .isEmpty) {
                                                                              return Center(
                                                                                child:
                                                                                    Text(
                                                                                      ErrorMessageString.noCountyAdded,
                                                                                  style:
                                                                                  DocumentTypeDataStyle.customTextStyle(context)
                                                                                ),
                                                                              );
                                                                            }
                                                                            if (snapshotZone
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
                                                                                  in snapshotZone.data!) {
                                                                                dropDownTypesList
                                                                                    .add(
                                                                                  DropdownMenuItem<String>(
                                                                                    value: i.countyName,
                                                                                    child: Text(i.countyName),
                                                                                  ),
                                                                                );
                                                                              }
                                                                              return CICCDropdown(
                                                                                  initialValue: dropDownTypesList[0]
                                                                                      .value,
                                                                                  onChange:
                                                                                      (val) {
                                                                                    for (var a in snapshotZone.data!) {
                                                                                      if (a.countyName == val) {
                                                                                        docType = a.countyId;
                                                                                        print("County id :: ${a.companyId}");
                                                                                        countyId = docType;
                                                                                      }
                                                                                    }
                                                                                    print(":::${docType}");
                                                                                    print(":::<>${countyId}");
                                                                                  },
                                                                                  items:
                                                                                      dropDownTypesList);
                                                                            }
                                                                            return const SizedBox();
                                                                          }),
                                                                    );
                                                                  });
                                                            });
                                                      },
                                                      icon:Icon(Icons.edit_outlined,
                                                        size:IconSize.I18,color: IconColorManager.bluebottom,),),
                                                  // IconButton(
                                                  //     splashColor: Colors.transparent,
                                                  //     hoverColor: Colors.transparent,
                                                  //     highlightColor: Colors.transparent,
                                                  //     onPressed: () {
                                                  //       showDialog(
                                                  //           context: context,
                                                  //           builder: (context) =>
                                                  //               DeletePopup(
                                                  //                   title: 'Delete Zone',
                                                  //                   onCancel: () {
                                                  //                 Navigator.pop(
                                                  //                     context);
                                                  //               }, onDelete:
                                                  //                       () async {
                                                  //                 await deleteZoneCountyData(
                                                  //                     context,
                                                  //                     zone.zoneId);
                                                  //                 getZoneByCounty(
                                                  //                         context,
                                                  //                         widget
                                                  //                             .officeId,
                                                  //                         25,
                                                  //                         1,
                                                  //                         20)
                                                  //                     .then((data) {
                                                  //                   _zoneController
                                                  //                       .add(data);
                                                  //                 }).catchError(
                                                  //                         (error) {});
                                                  //                 Navigator.pop(
                                                  //                     context);
                                                  //               }));
                                                  //     },
                                                  //     icon: Icon(
                                                  //       Icons.delete_outline,
                                                  //       size: 18,
                                                  //       color:
                                                  //           ColorManager.faintOrange,
                                                  //     )),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            );
                          }),
                    ),
                    // Pagination Controls
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
                          currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                        });
                      },
                    ),
                  ],
                );
              }
              return Offstage();
            },
          ),
        ),
      ],
    );
  }
}
