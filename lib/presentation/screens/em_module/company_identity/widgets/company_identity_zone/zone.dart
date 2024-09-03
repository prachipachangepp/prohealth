import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_country.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_zone.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/ci_zone_zipcode.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../company_identity_screen.dart';

class CiZone extends StatefulWidget {
  final int companyID;
  final String officeId;
  final int docId;
  const CiZone(
      {super.key,
      required this.companyID,
      required this.officeId,
      required this.docId});

  @override
  State<CiZone> createState() => _CiOrgDocumentState();
}

class _CiOrgDocumentState extends State<CiZone> {
  final PageController _tabPageController = PageController();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController countynameController = TextEditingController();
  TextEditingController countyController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zoneController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  int _selectedIndex = 0;
  int docZoneId = 0;
  int countyId = 0;
  int countySortId = 0;
  double? _latitude;
  double? _longitude;

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

  LatLng _selectedLocation = LatLng(37.7749, -122.4194); // Default location
  String _location = 'Lat/Long not selected'; // Default text

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _selectedIndex == 1
                  ? FutureBuilder<List<AllCountyGetList>>(
                      future: getCountyZoneList(context),
                      builder: (context, snapshotZone) {
                        if (snapshotZone.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 354,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: ColorManager.faintGrey,
                                    borderRadius: BorderRadius.circular(10)),
                              ));
                        }
                        if (snapshotZone.data!.isEmpty) {
                          return Container(
                            height: 30,
                            width: 354,
                            child: Center(
                              child: Text(
                               "No available countys !!",
                                style: CustomTextStylesCommon.commonStyle(
                                  fontWeight: FontWeightManager.medium,
                                  fontSize: FontSize.s12,
                                  color: ColorManager.mediumgrey,
                                ),
                              ),
                            ),
                          );
                        }
                        if (snapshotZone.hasData) {
                          List dropDown = [];
                          int docType = 0;
                          List<DropdownMenuItem<String>> dropDownTypesList = [];
                          for (var i in snapshotZone.data!) {
                            dropDownTypesList.add(
                              DropdownMenuItem<String>(
                                value: i.countyName,
                                child: Text(i.countyName),
                              ),
                            );
                          }
                          return CICCDropdown(
                              initialValue: dropDownTypesList[0].value,
                              onChange: (val) {
                                for (var a in snapshotZone.data!) {
                                  if (a.countyName == val) {
                                    docType = a.countyId;
                                    print("County id :: ${a.companyId}");
                                    countySortId = docType;
                                    _selectButton(1);
                                  }
                                }
                                print(":::${docType}");
                                print(":::<>${countySortId}");
                              },
                              items: dropDownTypesList);
                        }
                        return const SizedBox();
                      })
                  : SizedBox(
                      width: 354,
                    ),

              ///tabbar
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 6),
                child: Container(
                  //color: Colors.greenAccent,
                  padding: EdgeInsets.only(top: AppPadding.p10),
                  width: MediaQuery.of(context).size.width / 5.5,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => _selectButton(0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 20,
                          child: Column(
                            children: [
                              Text(
                                "County",
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: _selectedIndex == 0
                                      ? FontWeightManager.bold
                                      : FontWeightManager.regular,
                                  color: _selectedIndex == 0
                                      ? ColorManager.blueprime
                                      : ColorManager.mediumgrey,
                                ),
                              ),
                              _selectedIndex == 0
                                  ? Divider(
                                      color: ColorManager.blueprime,
                                      thickness: 2,
                                    )
                                  : Offstage()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () => _selectButton(1),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 20, //80,
                          child: Column(
                            children: [
                              Text(
                                "Zone",
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: _selectedIndex == 1
                                      ? FontWeightManager.bold
                                      : FontWeightManager.regular,
                                  color: _selectedIndex == 1
                                      ? ColorManager.blueprime
                                      : ColorManager.mediumgrey,
                                ),
                              ),
                              _selectedIndex == 1
                                  ? Divider(
                                      color: ColorManager.blueprime,
                                      thickness: 2,
                                    )
                                  : Offstage()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () => _selectButton(2),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 20, // 80,
                          child: Column(
                            children: [
                              Text(
                                "Zip Code",
                                style: GoogleFonts.firaSans(
                                  fontSize: 12,
                                  fontWeight: _selectedIndex == 2
                                      ? FontWeightManager.bold
                                      : FontWeightManager.regular,
                                  color: _selectedIndex == 2
                                      ? ColorManager.blueprime
                                      : ColorManager.mediumgrey,
                                ),
                              ),
                              _selectedIndex == 2
                                  ? Divider(
                                      color: ColorManager.blueprime,
                                      thickness: 2,
                                    )
                                  : Offstage()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///button
              _selectedIndex == 0
                  ? CustomIconButtonConst(
                                  width: 79,
                      icon: Icons.add,
                      text: "Add",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CIZoneAddPopup(
                                title: 'Add County',
                                onSavePressed: () async {
                                  await addCounty(
                                      context,
                                      countynameController.text,
                                      stateController.text,
                                      countyController.text,
                                      "37.0902°",
                                      "95.7129°",
                                      widget.officeId);
                                  Navigator.pop(context);
                                },
                                title1: 'State Name',
                                countynameController: stateController,
                                title2: 'Country Name',
                                zipcodeController: countyController,
                                title3: 'County Name',
                                mapController: countynameController,
                              );
                            });
                      })
                  : _selectedIndex == 1
                       ? CustomIconButtonConst(
                         width: 79,
                            icon: Icons.add,
                          text: AppStringEM.add,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AddZonePopup(
                                    zoneNumberController: zoneNumberController,
                                    title: 'Add Zone',
                                    onSavePressed: () async {
                                      await addZoneCountyData(
                                          context,
                                          zoneNumberController.text,
                                          countyId,
                                          widget.officeId);
                                    },
                                    child: FutureBuilder<
                                            List<AllCountyGetList>>(
                                        future: getCountyZoneList(context),
                                        builder: (context, snapshotZone) {
                                          if (snapshotZone.connectionState ==
                                              ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  width: 354,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: ColorManager
                                                          .faintGrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ));
                                          }
                                          if (snapshotZone.data!.isEmpty) {
                                            return Center(
                                              child: Text(
                                                AppString.dataNotFound,
                                                style: CustomTextStylesCommon
                                                    .commonStyle(
                                                  fontWeight:
                                                      FontWeightManager.medium,
                                                  fontSize: FontSize.s12,
                                                  color:
                                                      ColorManager.mediumgrey,
                                                ),
                                              ),
                                            );
                                          }
                                          if (snapshotZone.hasData) {
                                            List dropDown = [];
                                            int docType = 0;
                                            List<DropdownMenuItem<String>>
                                                dropDownTypesList = [];
                                            for (var i in snapshotZone.data!) {
                                              dropDownTypesList.add(
                                                DropdownMenuItem<String>(
                                                  value: i.countyName,
                                                  child: Text(i.countyName),
                                                ),
                                              );
                                            }
                                            return CICCDropdown(
                                                initialValue:
                                                    dropDownTypesList[0].value,
                                                onChange: (val) {
                                                  for (var a
                                                      in snapshotZone.data!) {
                                                    if (a.countyName == val) {
                                                      docType = a.countyId;
                                                      print(
                                                          "County id :: ${a.companyId}");
                                                      countyId = docType;
                                                    }
                                                  }
                                                  print(":::${docType}");
                                                  print(":::<>${countyId}");
                                                },
                                                items: dropDownTypesList);
                                          }
                                          return const SizedBox();
                                        }),
                                  );
                                });
                          })
                      : CustomIconButtonConst(
                         width: 79,
                          icon: Icons.add,
                          text: "Add",
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  print("Location passed to dialog: $_location");
                                  return AddZipCodePopup(
                                    title: 'Add Zip Code',
                                    countynameController: countynameController,
                                    cityNameController: cityController,
                                    zipcodeController: zipcodeController,
                                     child1: FutureBuilder<List<AllCountyGetList>>(
                                        future: getCountyZoneList(context),
                                        builder: (context, snapshotZone) {
                                          if (snapshotZone.connectionState ==
                                              ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  width: 354,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: ColorManager
                                                          .faintGrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ));
                                          }
                                          if (snapshotZone.data!.isEmpty) {
                                            return Center(
                                              child: Text(
                                                AppString.dataNotFound,
                                                style: CustomTextStylesCommon
                                                    .commonStyle(
                                                  fontWeight:
                                                      FontWeightManager.medium,
                                                  fontSize: FontSize.s12,
                                                  color:
                                                      ColorManager.mediumgrey,
                                                ),
                                              ),
                                            );
                                          }
                                          if (snapshotZone.hasData) {
                                            List dropDown = [];
                                            int docType = 0;
                                            List<DropdownMenuItem<String>>
                                                dropDownTypesList = [];
                                            for (var i in snapshotZone.data!) {
                                              dropDownTypesList.add(
                                                DropdownMenuItem<String>(
                                                  value: i.countyName,
                                                  child: Text(i.countyName),
                                                ),
                                              );
                                            }
                                            return CICCDropdown(
                                                initialValue:
                                                    dropDownTypesList[0].value,
                                                onChange: (val) {
                                                  for (var a
                                                      in snapshotZone.data!) {
                                                    if (a.countyName == val) {
                                                      docType = a.countyId;
                                                      print(
                                                          "County id :: ${a.companyId}");
                                                      countyId = docType;
                                                    }
                                                  }
                                                  print(":::${docType}");
                                                  print(":::<>${countyId}");
                                                },
                                                items: dropDownTypesList);
                                          }
                                          return const SizedBox();
                                        }),
                                    onSavePressed: () async {
                                      await addZipCodeSetup(
                                          context,
                                          docZoneId,
                                          countyId,
                                          widget.officeId,
                                          cityController.text,
                                          zipcodeController.text,
                                          _selectedLocation.latitude.toString(),
                                          _selectedLocation.longitude.toString(),
                                          landmarkController.text);
                                      print("Saved lat long${_selectedLocation.latitude.toString()} + ${_selectedLocation.longitude.toString()}");
                                      Navigator.pop(context);
                                    },
                                    mapController: mapController,
                                    landmarkController: landmarkController,
                                    // locationController:    locationController ,
                                    child: FutureBuilder<List<SortByZoneData>>(
                                        future: PayRateZoneDropdown(context),
                                        builder: (context, snapshotZone) {
                                          if (snapshotZone.connectionState ==
                                              ConnectionState.waiting) {
                                            return Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  width: 354,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: ColorManager
                                                          .faintGrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ));
                                          }
                                          if (snapshotZone.data!.isEmpty) {
                                            return Center(
                                              child: Text(
                                                "No Zone Added.",
                                              //  AppString.dataNotFound,
                                                style: CustomTextStylesCommon
                                                    .commonStyle(
                                                  fontWeight:
                                                      FontWeightManager.medium,
                                                  fontSize: FontSize.s12,
                                                  color:
                                                      ColorManager.mediumgrey,
                                                ),
                                              ),
                                            );
                                          }
                                          if (snapshotZone.hasData) {
                                            List dropDown = [];
                                            int docType = 0;
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
                                            return CICCDropdown(
                                                initialValue:
                                                    dropDownTypesList[0].value,
                                                onChange: (val) {
                                                  for (var a
                                                      in snapshotZone.data!) {
                                                    if (a.zoneName == val) {
                                                      docType = a.zoneId;
                                                      print(
                                                          "ZONE id :: ${a.zoneId}");
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
                                  );
                                });
                          })
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 50),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                // Page 1
                CIZoneCountry(
                  companyID: widget.companyID,
                  officeId: widget.officeId,
                ),
                CIZoneZone(
                  countyId: countySortId,
                  companyID: widget.companyID,
                  officeId: widget.officeId,
                ),
                CiZoneZipcode(
                  companyID: widget.companyID,
                  officeId: widget.officeId,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}




///old
// void _pickLocation() async {
//   final pickedLocation = await Navigator.of(context).push<LatLng>(
//     MaterialPageRoute(
//       builder: (context) =>
//           MapScreen(
//             initialLocation: _selectedLocation,
//
//             onLocationPicked: (location) {
//               setState(() {
//                 _selectedLocation = location;
//                 _latitude = location.latitude;
//                 _longitude = location.longitude;
//                 // Update _location with the new values
//                 _location = 'Lat: ${_latitude!.toStringAsFixed(4)}, Long: ${_longitude!.toStringAsFixed(4)}';
//                 print("Selected LatLong :: ${_latitude} + ${_longitude}");
//                 // _selectedLocation = location;
//                 // print("Selected LatLong :: ${_selectedLocation
//                 //     .latitude} + ${_selectedLocation.longitude}");
//               });
//             },
//           ),
//     ),
//   );
//
//   if (pickedLocation != null) {
//     setState(() {
//       _selectedLocation = pickedLocation;
//       _latitude = pickedLocation.latitude;
//       _longitude = pickedLocation.longitude;
//       _location = 'Lat: ${_latitude!.toStringAsFixed(4)}, Long: ${_longitude!.toStringAsFixed(4)}';
//       // _selectedLocation = pickedLocation;
//     });
//   }
// }
