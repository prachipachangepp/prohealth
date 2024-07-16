import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
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
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController countynameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController zoneNumberController = TextEditingController();
  final StreamController<List<AllCountyZoneGet>> _zoneController =
      StreamController<List<AllCountyZoneGet>>();

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(60, (index) => 'Item ${index + 1}');
  }

  int countyId = 0;
  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
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
                      'Zone Number',
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Expanded(
                  child: Center(
                    child: Text('Zip Codes',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('County',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('Cities',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Actions',
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
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
              getZoneByCounty(
                      context, widget.officeId, widget.companyID, 25, 1, 20)
                  .then((data) {
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
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      int serialNumber =
                          index + 1 + (currentPage - 1) * itemsPerPage;
                      String formattedSerialNumber =
                          serialNumber.toString().padLeft(2, '0');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
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
                                          snapshot.data![index].zoneId
                                              .toString(),
                                          style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.mediumgrey,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      // Text(''),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          snapshot.data![index].zipcodes
                                              .toString(),
                                          style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.mediumgrey,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          snapshot.data![index].countyName
                                              .toString(),
                                          style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.mediumgrey,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          snapshot.data![index].cities
                                              .toString(),
                                          style: GoogleFonts.firaSans(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.mediumgrey,
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return FutureBuilder<
                                                                CountyZonePrefillGet>(
                                                            future:
                                                                getZoneByCountyPrefill(
                                                                    context,
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .zoneId),
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
                                                                zoneNumberController:
                                                                    zoneNumberController,
                                                                title:
                                                                    'Edit Zone',
                                                                onSavePressed:
                                                                    () async {
                                                                  await updateZoneCountyData(
                                                                      context,
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .zoneId,
                                                                      zoneNumber ==
                                                                              zoneNumberController
                                                                                  .text
                                                                          ? zoneNumber
                                                                              .toString()
                                                                          : zoneNumberController
                                                                              .text,
                                                                      // 25,widget.officeId, widget.companyID);
                                                                      countyPreId ==
                                                                              countyId
                                                                          ? countyPreId
                                                                          : countyId,
                                                                      widget
                                                                          .officeId,
                                                                      widget
                                                                          .companyID);
                                                                  getZoneByCounty(
                                                                          context,
                                                                          widget
                                                                              .officeId,
                                                                          widget
                                                                              .companyID,
                                                                          25,
                                                                          1,
                                                                          20)
                                                                      .then(
                                                                          (data) {
                                                                    _zoneController
                                                                        .add(
                                                                            data);
                                                                  }).catchError(
                                                                          (error) {});
                                                                  zoneNumberController
                                                                      .clear();
                                                                  countyId = 0;
                                                                },
                                                                child: FutureBuilder<
                                                                        List<
                                                                            AllCountyGetList>>(
                                                                    future: getCountyZoneList(
                                                                        context),
                                                                    builder:
                                                                        (context,
                                                                            snapshotZone) {
                                                                      if (snapshotZone
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return Shimmer.fromColors(
                                                                            baseColor: Colors.grey[300]!,
                                                                            highlightColor: Colors.grey[100]!,
                                                                            child: Container(
                                                                              width: 354,
                                                                              height: 30,
                                                                              decoration: BoxDecoration(color: ColorManager.faintGrey, borderRadius: BorderRadius.circular(10)),
                                                                            ));
                                                                      }
                                                                      if (snapshotZone
                                                                          .data!
                                                                          .isEmpty) {
                                                                        return Center(
                                                                          child:
                                                                              Text(
                                                                            AppString.dataNotFound,
                                                                            style:
                                                                                CustomTextStylesCommon.commonStyle(
                                                                              fontWeight: FontWeightManager.medium,
                                                                              fontSize: FontSize.s12,
                                                                              color: ColorManager.mediumgrey,
                                                                            ),
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
                                                        //   CIZoneEditPopup(
                                                        //   onSavePressed: (){},
                                                        //   title: 'Edit Zone',
                                                        //   title1: 'Zone Number',
                                                        //   countynameController: countynameController,
                                                        //   // title2: 'Zip Codes',
                                                        //   // landmarkController: landmarkController,
                                                        // );
                                                      });
                                                },
                                                icon: Icon(
                                                  Icons.edit_outlined,
                                                  size: 18,
                                                  color: ColorManager.blueprime,
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          DeletePopup(
                                                              title: 'Delete Zone',
                                                              onCancel: () {
                                                            Navigator.pop(
                                                                context);
                                                          }, onDelete:
                                                                  () async {
                                                            await deleteZoneCountyData(
                                                                context,
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .zoneId);
                                                            getZoneByCounty(
                                                                    context,
                                                                    widget
                                                                        .officeId,
                                                                    widget
                                                                        .companyID,
                                                                    25,
                                                                    1,
                                                                    20)
                                                                .then((data) {
                                                              _zoneController
                                                                  .add(data);
                                                            }).catchError(
                                                                    (error) {});
                                                            Navigator.pop(
                                                                context);
                                                          }));
                                                },
                                                icon: Icon(
                                                  Icons.delete_outline,
                                                  size: 18,
                                                  color:
                                                      ColorManager.faintOrange,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      );
                    });
              }
              return Offstage();
            },
          ),
        ),
        // SizedBox(
        //   height: 10,
        // ),
        // PaginationControlsWidget(
        //   currentPage: currentPage,
        //   items: items,
        //   itemsPerPage: itemsPerPage,
        //   onPreviousPagePressed: () {
        //     /// Handle previous page button press
        //     setState(() {
        //       currentPage = currentPage > 1 ? currentPage - 1 : 1;
        //     });
        //   },
        //   onPageNumberPressed: (pageNumber) {
        //     /// Handle page number tap
        //     setState(() {
        //       currentPage = pageNumber;
        //     });
        //   },
        //   onNextPagePressed: () {
        //     /// Handle next page button press
        //     setState(() {
        //       currentPage = currentPage < (items.length / itemsPerPage).ceil()
        //           ? currentPage + 1
        //           : (items.length / itemsPerPage).ceil();
        //     });
        //   },
        // ),
      ],
    );
  }
}
