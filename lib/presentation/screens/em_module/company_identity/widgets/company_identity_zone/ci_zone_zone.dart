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
                      context, widget.officeId,widget.countyId, 1, 20)
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
                int totalItems = snapshot.data!.length;
                int totalPages = (totalItems / itemsPerPage).ceil();
                List<AllCountyZoneGet> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                            AllCountyZoneGet zone = paginatedData[index];
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
                                                zone.zoneId
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
                                                zone.zipcodes
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
                                                zone.countyName
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
                                                zone.cities
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
                                                                      zoneNumberController:
                                                                          zoneNumberController,
                                                                      title:
                                                                          'Edit Zone',
                                                                      onSavePressed:
                                                                          () async {
                                                                        await updateZoneCountyData(
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
                                                                        getZoneByCounty(
                                                                                context,
                                                                                widget
                                                                                    .officeId,
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
                                                                      zone.zoneId);
                                                                  getZoneByCounty(
                                                                          context,
                                                                          widget
                                                                              .officeId,
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
                          }),
                    ),
                    // Pagination Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Previous Page Button
                        InkWell(
                          onTap: currentPage > 1 ? () {
                            setState(() {
                              currentPage--;
                            });
                          } : null,
                          child: Container(
                            height: 20,
                            width: 20,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ColorManager.bluelight,
                            ),
                            child: Icon(Icons.arrow_back_ios_sharp, size: 14, color: Colors.white),
                          ),
                        ),
                        for (var i = 1; i <= totalPages; i++)
                          if (i == 1 ||
                              i == totalPages ||
                              i == currentPage ||
                              (i == currentPage - 1 && i > 1) ||
                              (i == currentPage + 1 && i < totalPages))
                            InkWell(
                              onTap: () => onPageNumberPressed(i),
                              child: Container(
                                width: 20,
                                height: 20,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: currentPage == i ? ColorManager.bluelight : ColorManager.fmediumgrey.withOpacity(0.2),
                                    width: currentPage == i ? 2.0 : 1.0,
                                  ),
                                  color: currentPage == i ? ColorManager.bluelight : Colors.transparent,
                                ),
                                child: Text(
                                  '$i',
                                  style: TextStyle(
                                    color: currentPage == i ? Colors.white : ColorManager.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          else if (i == currentPage - 2 || i == currentPage + 2)
                            Text(
                              '..',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                        ///Page Number Buttons
                        InkWell(
                          onTap: currentPage < totalPages ? () {
                            setState(() {
                              currentPage++;
                            });
                          } : null,
                          child: Container(
                            height: 20,
                            width: 20,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ColorManager.bluelight,
                            ),
                            child: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
                          ),
                        ),
                      ],
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
