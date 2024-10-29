import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';

import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_country.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/ci_zone_zone.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/ci_zone_zipcode.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/location_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../company_identity_screen.dart';

class CiZone extends StatefulWidget {
  final int companyID;
  final String officeId;
  final int docId;
  final String stateName;
  final String countryName;
  const CiZone(
      {super.key,
      required this.stateName,
      required this.countryName,
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
  TextEditingController countyNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  int _selectedIndex = 0;
  int docZoneId = 0;
  int countyId = 0;
  int countySortId = 0;
  double? _latitude;
  double? _longitude;
  String coyntyNameVal = 'Select County';

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  String? selectedCounty;
  String? selectedZipCodeCounty;
  String? selectedZipCodeZone;
  LatLng _selectedLocation =
       LatLng(37.7749, -122.4194); // Default location
  String?_location ;
  final StreamController<List<AllCountyZoneGet>> _zoneController =
      StreamController<List<AllCountyZoneGet>>.broadcast();
  void _pickLocation() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          initialLocation: _selectedLocation,
          onLocationPicked: (location) {
            setState(() {
              _selectedLocation = location;
              _latitude = location.latitude;
              _longitude = location.longitude;
              String formatLatLong(double? latitude, double? longitude) {
                if (latitude != null && longitude != null) {
                  // print('Lat : ${latitude}')
                  return 'Lat: ${latitude.toStringAsFixed(4)}, Long: ${longitude.toStringAsFixed(4)}';
                } else {
                  return 'Lat/Long not selected';
                }
              }

              final latlong = formatLatLong(_latitude, _longitude);

              print("Selected LatLong :: $latlong");

              // Update the location in the UI directly
              _updateLocation(latlong);
            });
          },
        ),
      ),
    );

    if (pickedLocation != null) {
      setState(() {
        _selectedLocation = pickedLocation;
        _latitude = pickedLocation.latitude;
        _longitude = pickedLocation.longitude;
      });
    }
  }
  void _updateLocation(String latlong) {
    setState(() {
      _location = latlong;
      print("Updated Location: $_location");
      locationController = TextEditingController(text:_location);
      print("locationController ${locationController.text}");// Check this log to see if the value updates
    });
  }
  bool isAddButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: _selectedIndex == 1
                    ? FutureBuilder<List<OfficeWiseCountyData>>(
                  future: getCountyListOfficeIdWise(context: context, OfficeId: widget.officeId),
                  builder: (context, snapshotZone) {
                    if (snapshotZone.connectionState == ConnectionState.waiting) {
                      return Container(
                        width:  354,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManager.containerBorderGrey, width: AppSize.s1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: AppSize.s8),
                            Expanded(
                              child: Text(
                                "Select",
                                style: TableSubHeading.customTextStyle(context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.arrow_drop_down),
                            ),
                          ],
                        ),
                      );
                    }
                    if (snapshotZone.data!.isEmpty) {
                      return Container(
                        width: 354,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManager.containerBorderGrey,
                              width: AppSize.s1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              ErrorMessageString.noCountyAdded,
                              style: DocumentTypeDataStyle.customTextStyle(context),
                            ),
                          ),
                        ),
                      );
                    }
                    if (snapshotZone.hasData) {
                      List<DropdownMenuItem<String>> dropDownTypesList = [];

                      for (var i in snapshotZone.data!) {
                        dropDownTypesList.add(
                          DropdownMenuItem<String>(
                            value: i.countyName,
                            child: Text(i.countyName),
                          ),
                        );
                      }

                      if (coyntyNameVal == 'Select County') {
                        countySortId = snapshotZone.data![0].countyId;
                        countynameController.text = coyntyNameVal;
                      }

                      return CICCDropdown(
                        initialValue: coyntyNameVal,
                        onChange: (val) {
                          setState(() {
                            coyntyNameVal = val!;
                            var selectedCounty = snapshotZone.data!.firstWhere((a) => a.countyName == val);
                            countySortId = selectedCounty.countyId;
                            countynameController.text = selectedCounty.countyName;
                            isAddButtonEnabled = true;
                            _selectButton(1);
                          });
                        },
                        items: dropDownTypesList,
                      );
                    }
                    return const SizedBox();
                  },
                )
                    : _selectedIndex == 0
                    ?  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text( AppStringLegalDocument.ZonesMsgHead,
                      style:  LegalDocumentPopupMessage.customTextStyle(context),),
                  ],)
                    : const SizedBox(width: 354),
              ),

              ///tabbar
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 6),
                  child: Container(
                   // color: Colors.greenAccent,
                    padding: const EdgeInsets.only(top: AppPadding.p10),
                    width: MediaQuery.of(context).size.width / 5.5,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => _selectButton(0),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 20,
                            child: Column(
                              children: [
                                Text(
                                  AppString.county,
                                  style: TransparentBgTabbar.customTextStyle(0, _selectedIndex),
                                  // style: GoogleFonts.firaSans(
                                  //   fontSize: 12,
                                  //   fontWeight: _selectedIndex == 0
                                  //       ? FontWeightManager.bold
                                  //       : FontWeightManager.regular,
                                  //   color: _selectedIndex == 0
                                  //       ? ColorManager.blueprime
                                  //       : ColorManager.mediumgrey,
                                  // ),
                                ),
                                _selectedIndex == 0
                                    ? Divider(
                                        color: ColorManager.blueprime,
                                        thickness: 2,
                                      )
                                    : const Offstage()
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => _selectButton(1),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 20, //80,
                            child: Column(
                              children: [
                                Text(
                                  AppString.zone,
                                  style: TransparentBgTabbar.customTextStyle(1, _selectedIndex),
                                ),
                                _selectedIndex == 1
                                    ? Divider(
                                        color: ColorManager.blueprime,
                                        thickness: 2,
                                      )
                                    : const Offstage()
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => _selectButton(2),
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 20, // 80,
                            child: Column(
                              children: [
                                Text(
                                  AppString.zip_code,
                                  style: TransparentBgTabbar.customTextStyle(2, _selectedIndex),
                                ),
                                _selectedIndex == 2
                                    ? Divider(
                                        color: ColorManager.blueprime,
                                        thickness: 2,
                                      )
                                    : const Offstage()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///button
              _selectedIndex == 0
              ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomIconButtonConst(
                width: 79,
                icon: Icons.add,
                text: AppStringEM.add,
                onPressed: () {
                  countynameController.clear();
                  countyController.clear();
                  stateController.clear();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CIZoneAddPopup(
                          buttonTitle: AppStringEM.add,
                          title: 'Add County',
                          onSavePressed: () async {
                            await addCounty(
                                context,
                                countynameController.text,
                                widget.stateName,
                                widget.countryName,
                                "37.0902°",
                                "95.7129°",
                                widget.officeId);
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddSuccessPopup(
                                  message: 'County Added Successfully',
                                );
                              },
                            );
                          },
                          title1: 'County Name',
                          countynameController: countynameController,
                          // title2: 'Country Name',
                          // zipcodeController: countyController,
                          // title3: 'County Name',
                          // mapController: countynameController,
                        );
                      });
                }),
                            )
              : _selectedIndex == 1
              ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CustomIconButtonConst(
                width: 79,
                icon: Icons.add,
                text: AppStringEM.add,
                onPressed: isAddButtonEnabled
                    ? () {
                  //selectedExpiryType = expiryType;
                  zoneNumberController.clear();
                  print('County Name ${countynameController.text}');
                  print('County id ${countySortId}');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AddZonePopup(
                          countyNameController: countynameController,
                          buttonTitle: AppStringEM.add,
                          zoneNumberController: zoneNumberController,
                          title: 'Add Zone',
                          onSavePressed: () async {
                            var response = await addZoneCountyData(
                                context,
                                zoneNumberController.text,
                                countySortId,
                                widget.officeId);
                            Navigator.pop(context);
                            if(response.statusCode == 200 || response.statusCode == 201){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddSuccessPopup(
                                    message: 'Zone Added Successfully',
                                  );
                                },
                              );
                            }
                          },
                          child: FutureBuilder<
                              List<AllCountyGetList>>(
                              future: getCountyZoneList(context),
                              builder: (context, snapshotZone) {
                                if (snapshotZone.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width: 354,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorManager
                                              .containerBorderGrey,
                                          width: AppSize.s1),
                                      borderRadius:
                                      BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      "",
                                      //AppString.dataNotFound,
                                    ),
                                  );
                                }
                                if (snapshotZone.data!.isEmpty) {
                                  return Container(
                                    width: 354,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorManager
                                              .containerBorderGrey,
                                          width: AppSize.s1),
                                      borderRadius:
                                      BorderRadius.circular(4),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets
                                            .symmetric(
                                            horizontal: 10),
                                        child: Text(
                                            ErrorMessageString
                                                .noCounties,
                                            //AppString.dataNotFound,
                                            style: DocumentTypeDataStyle.customTextStyle(context)
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (snapshotZone.hasData) {
                                  List dropDown = [];
                                  int docType = 0;
                                  List<DropdownMenuItem<String>>
                                  dropDownTypesList = [];
                                  dropDownTypesList.add(
                                      const DropdownMenuItem<String>(
                                        child: Text('Select County'),
                                        value: 'Select County',
                                      ));
                                  for (var i in snapshotZone.data!) {
                                    dropDownTypesList.add(
                                      DropdownMenuItem<String>(
                                        value: i.countyName,
                                        child: Text(i.countyName),
                                      ),
                                    );
                                  }
                                  if (selectedCounty == null) {
                                    selectedCounty = 'Select County';
                                  }
                                  print('County Id : ${countyId}');
                                  return CICCDropdown(
                                      initialValue:
                                      dropDownTypesList[0].value,
                                      onChange: (val) {
                                        selectedCounty = val;
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
                }
                    : () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return VendorSelectNoti(message: "Select county first.",);
                    },
                  );
                },
              enabled: isAddButtonEnabled,),
                            )
              : Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomIconButtonConst(
                width: 79,
                icon: Icons.add,
                text: "Add",
                onPressed: () {
                  countynameController.clear();
                  cityController.clear();
                  zipcodeController.clear();
                  showDialog(
                      context: context,
                      builder: (context) {
                        print(
                            "Location passed to dialog: $_location");
                        return AddZipCodePopup(
                          officeId: widget.officeId,
                          title: 'Add Zip Code',
                          countynameController: countynameController,
                          zipcodeController: zipcodeController,
                          onPickLocation: _pickLocation,
                          onSavePressed: () async {
                            setState(() {
                              String latlong = _selectedLocation.latitude.toString();
                            });
                          },
                          mapController: mapController,
                          locationController: locationController,
                        );
                      });
                }),
                            ),

            ],
          ),
        ),
        const SizedBox(
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
