import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../widgets/button_constant.dart';
import '../../../../widgets/text_form_field_const.dart';
import '../../whitelabelling/success_popup.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_screen.dart';

class CIZoneAddPopup extends StatefulWidget {
  final TextEditingController countynameController;
  final TextEditingController? zipcodeController;
  final TextEditingController? mapController;
  final TextEditingController? landmarkController;
  final TextEditingController? zoneController;
  final TextEditingController? cityController;
  final TextEditingController? countryController;
  final TextEditingController? stateController;
  final Future<void> Function() onSavePressed;
  final String buttonTitle;
  final String title1;
  final String? title2;
  final String? title3;
  final String? title4;
  final String? title5;
  final String? title6;
  final String title;

  const CIZoneAddPopup({
    Key? key,
    required this.onSavePressed,
    required this.title1,
    this.title2,
    this.title3,
    this.title4,
    this.title5,
    this.title6,
    required this.countynameController,
    this.zipcodeController,
    this.mapController,
    this.landmarkController,
    this.zoneController,
    this.cityController,
    this.countryController,
    this.stateController,
    required this.title,
    required this.buttonTitle,
  }) : super(key: key);

  @override
  State<CIZoneAddPopup> createState() => _CIZoneAddPopupState();
}

class _CIZoneAddPopupState extends State<CIZoneAddPopup> {
  bool isLoading = false;

  // Variables to hold error messages
  String? countyNameError;
  String? zipcodeError;
  String? mapError;
  String? landmarkError;

  // Method to validate the input fields
  bool validateFields() {
    bool isValid = true;

    setState(() {
      countyNameError = widget.countynameController.text.isEmpty
          ? 'County field cannot be empty'
          : null;
      // zipcodeError = widget.zipcodeController!.text.isEmpty
      //     ? 'Country cannot be empty'
      //     : null;
      // mapError = widget.title3 != null && widget.mapController?.text.isEmpty == true
      //     ? 'County field cannot be empty'
      //     : null;
      // landmarkError = widget.title4 != null && widget.landmarkController?.text.isEmpty == true
      //     ? 'Landmark cannot be empty'
      //     : null;

      // If any error message is not null, the form is invalid
      isValid = countyNameError == null;
      // &&
      // zipcodeError == null &&
      // mapError == null ;
      //landmarkError == null;
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: AppSize.s407,
          height: AppSize.s250,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.bluebottom,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 27.0),
                      child: Text(
                        widget.title,
                        style:PopupBlueBarText.customTextStyle(context)
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSize.s20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p6,
                  horizontal: AppPadding.p20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstSMTextFConst(
                      controller: widget.countynameController,
                      keyboardType: TextInputType.text,
                      text: widget.title1,
                    ),
                    if (countyNameError != null)
                      Text(
                        countyNameError!,
                        textAlign: TextAlign.start,
                        style: CommonErrorMsg.customTextStyle(context),
                      ),
                    SizedBox(height: AppSize.s20),
                    if (widget.title2 != null) ...[
                      FirstSMTextFConst(
                        inputFormated: [UpperCaseTextFormatter()],
                        controller: widget.zipcodeController!,
                        keyboardType: TextInputType.text,
                        text: widget.title2!,
                      ),
                      if (zipcodeError != null)
                        Text(
                          zipcodeError!,
                          textAlign: TextAlign.start,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                    ],
                    if (widget.title3 != null) ...[
                      SizedBox(height: AppSize.s20),
                      FirstSMTextFConst(
                        controller: widget.mapController!,
                        keyboardType: TextInputType.text,
                        text: widget.title3!,
                      ),
                      if (mapError != null)
                        Text(
                          mapError!,
                          textAlign: TextAlign.start,
                          style: CommonErrorMsg.customTextStyle(context),
                        ),
                    ],
                    // if (widget.title4 != null &&
                    //     widget.landmarkController != null) ...[
                    //   SizedBox(height: AppSize.s20),
                    //   FirstSMTextFConst(
                    //     controller: widget.landmarkController!,
                    //     keyboardType: TextInputType.text,
                    //     text: widget.title4!,
                    //   ),
                    //   if (landmarkError != null)
                    //     Text(
                    //       landmarkError!,
                    //       textAlign: TextAlign.start,
                    //       style: GoogleFonts.firaSans(
                    //         fontSize: FontSize.s10,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.red,
                    //         decoration: TextDecoration.none,
                    //       ),
                    //     ),
                    // ],
                  ],
                ),
              ),
              SizedBox(height: AppSize.s5),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: AppPadding.p24, top: AppPadding.p14),
                child: isLoading
                    ? SizedBox(
                        height: AppSize.s25,
                        width: AppSize.s25,
                        child: CircularProgressIndicator(
                          color: ColorManager.blueprime,
                        ))
                    : Center(
                        child: CustomElevatedButton(
                          width: AppSize.s105,
                          height: AppSize.s30,
                          text: widget.buttonTitle,
                          onPressed: () async {
                            if (validateFields()) {
                              setState(() {
                                isLoading = true;
                              });
                              await widget.onSavePressed();
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///edit
class AddZipCodePopup extends StatefulWidget {
  final String title;
  final String officeId;
  final TextEditingController countynameController;
  final TextEditingController zipcodeController;
  final TextEditingController mapController;
  // final TextEditingController cityNameController;
  // final TextEditingController landmarkController;
  final Widget? locationText;
  final TextEditingController? locationController;
  final Future<void> Function() onSavePressed;
  final VoidCallback? onPickLocation;
  AddZipCodePopup({
    super.key,
    required this.title,
    required this.countynameController,
    required this.zipcodeController,
    required this.mapController,
    // this.landmarkController,
    required this.onSavePressed,
    // this.cityNameController,
    this.onPickLocation,
    this.locationText,
    this.locationController, required this.officeId,
  });

  @override
  State<AddZipCodePopup> createState() => _AddZipCodePopupState();
}

class _AddZipCodePopupState extends State<AddZipCodePopup> {
  bool isLoading = false;

  LatLng _selectedLocation = LatLng(37.7749, -122.4194); // Default location
  String _location = 'Select Lat/Long '; // Default text
  double? _latitude;
  double? _longitude;
  String? selectedCounty;
  String? selectedZipCodeCounty;
  String? selectedZipCodeZone;
  int docZoneId = 0;
  int countyId = 0;
  int countySortId = 0;
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
      //widget.locationController = TextEditingController(text:_location);
      //print("locationController ${locationController.text}");// Check this log to see if the value updates
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: AppSize.s400,
          height: AppSize.s400,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.bluebottom,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                height: AppSize.s40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        widget.title,
                        style: PopupBlueBarText.customTextStyle(context)
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p1,
                  horizontal: AppPadding.p20,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'County Name',
                            style: AllPopupHeadings.customTextStyle(context),
                          ),
                          SizedBox(height: AppSize.s5),
                          FutureBuilder<
                              List<OfficeWiseCountyData>>(
                              future: getCountyListOfficeIdWise(context:context,OfficeId: widget.officeId),
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
                                              .noCountyAdded,
                                          // AppString.dataNotFound,
                                          style:AllNoDataAvailable.customTextStyle(context)
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
                                  // dropDownTypesList.add(
                                  //     const DropdownMenuItem<String>(
                                  //   child: Text('Select County'),
                                  //   value: 'Select County',
                                  // ));
                                  for (var i in snapshotZone.data!) {
                                    dropDownTypesList.add(
                                      DropdownMenuItem<String>(
                                        value: i.countyName,
                                        child: Text(i.countyName),
                                      ),
                                    );
                                  }
                                  if (selectedZipCodeCounty == null) {
                                    selectedZipCodeCounty =
                                    'Select County';
                                  }
                                  countyId = snapshotZone.data![0].countyId;
                                  return CICCDropdown(
                                      initialValue:
                                      dropDownTypesList[0].value,
                                      onChange: (val) {
                                        selectedZipCodeCounty = val;
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
                        ],
                      ),
                      SizedBox(height: AppSize.s10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.zone,
                            style: AllPopupHeadings.customTextStyle(context)
                          ),
                          SizedBox(height: AppSize.s5),
                          StreamBuilder<
                              List<AllCountyZoneGet>>(
                              stream: _zoneController.stream,
                              builder: (context, snapshotZone) {
                                getZoneByCounty(
                                    context,
                                    widget.officeId,
                                    countyId,
                                    1,
                                    200)
                                    .then((data) {
                                  _zoneController.add(data);
                                }).catchError((error) {});
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
                                              .noZoneAdded,
                                          //  AppString.dataNotFound,
                                          style:
                                          AllNoDataAvailable.customTextStyle(context),
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
                                  // dropDownTypesList.add(
                                  //     const DropdownMenuItem<String>(
                                  //   child: Text('Select zone'),
                                  //   value: 'Select zone',
                                  // ));
                                  for (var i in snapshotZone.data!) {
                                    dropDownTypesList.add(
                                      DropdownMenuItem<String>(
                                        value: i.zoneName,
                                        child: Text(i.zoneName),
                                      ),
                                    );
                                  }
                                  if (selectedZipCodeZone == null) {
                                    selectedZipCodeZone =
                                        snapshotZone.data![0].zoneName;
                                  }
                                  docZoneId = snapshotZone.data![0].zoneId;
                                  return CICCDropdown(
                                      initialValue:
                                      dropDownTypesList[0].value,
                                      onChange: (val) {
                                        selectedZipCodeZone = val;
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
                        ],
                      ),
                      SizedBox(height: AppSize.s15),
                      // FirstSMTextFConst(
                      //   controller: widget.cityNameController,
                      //   keyboardType: TextInputType.text,
                      //   text: 'City Name',
                      // ),
                      // SizedBox(height: AppSize.s15),
                      SMTextFConst(
                        controller: widget.zipcodeController,
                        keyboardType: TextInputType.text,
                        text: 'Zip Code',
                      ),
                      SizedBox(height: AppSize.s15),
                      /////
                      Row(
                        children: [
                          TextButton(
                            onPressed: _pickLocation,
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent),
                            child: Text(
                              'Pick Location',
                              style: TextStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.bluelight,
                                //decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: ColorManager.granitegray,
                            size: AppSize.s18,
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _location == null ? Text(''):
                                Text(
                                  _location!,
                                  style: AllNoDataAvailable.customTextStyle(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Text('${widget.location}'),
                      // Text('Picked Location: ${widget.locationController.text}'),
                      // SizedBox(height: AppSize.s15),
                      // FirstSMTextFConst(
                      //   controller: widget.landmarkController,
                      //   keyboardType: TextInputType.text,
                      //   text: 'Landmark',
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: AppPadding.p24, top: AppPadding.p14),
                child: isLoading
                    ? SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: ColorManager.blueprime,
                        ))
                    : Center(
                        child: CustomElevatedButton(
                          width: AppSize.s105,
                          height: AppSize.s30,
                          text: AppStringEM.add,
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                             var response = await addZipCodeSetup(
                            context,
                            docZoneId,
                            countyId,
                            widget.officeId,
                           "",
                            widget.zipcodeController.text,
                            _selectedLocation.latitude.toString(),
                            _selectedLocation.longitude
                                .toString(),
                            "");
                            print(
                                "Saved lat long${_selectedLocation.latitude.toString()} + ${_selectedLocation.longitude.toString()}");
                            Navigator.pop(context);
                            // Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CountySuccessPopup(
                                  message: 'Save Successfully',
                                );
                              },
                            );
                            // Navigator.pop(context);
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///edit
class EditZipCodePopup extends StatefulWidget {
  final String title;
  // final TextEditingController? countynameController;
  final TextEditingController zipcodeController;
  final TextEditingController? mapController;
  // final TextEditingController? cityNameController;
  // final TextEditingController? landmarkController;
  final String officeId;
  final int zoneId;
  final int countyId;
  final int zipCodeSetupId;
  final String zipCodes;
  final String latitude;
  final String longitude;
  final Future<void> Function() onSavePressed;
  EditZipCodePopup({
    super.key,
    required this.title,
    // this.countynameController,
    required this.zipcodeController,
    this.mapController,
    // this.landmarkController,
    required this.onSavePressed,
    // this.cityNameController,
     required this.latitude, required this.longitude, required this.zoneId, required this.countyId, required this.zipCodes, required this.zipCodeSetupId, required this.officeId,
  });

  @override
  State<EditZipCodePopup> createState() => _EditZipCodePopupState();
}

class _EditZipCodePopupState extends State<EditZipCodePopup> {
  bool isLoading = false;
  String? fetchedLatitude;
  String? fetchedLng;
  LatLng _selectedLocation = LatLng(37.7749, -122.4194); // Default location
  String _location = "Lat 37.7749 lng -122.4194"; // Default text
  double? _latitude;
  double? _longitude;
  int docZoneId =0;
  int countyId =0;
@override
  void initState() {
    // TODO: implement initState
  fetchedLatitude = widget.latitude;
  fetchedLng = widget.longitude;
  docZoneId = widget.zoneId;
  countyId = widget.countyId;
    super.initState();
  }
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
      print("Updated Location: $_location"); // Check this log to see if the value updates
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: AppSize.s400,
          height: AppSize.s400,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.bluebottom,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                height: AppSize.s40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        widget.title,
                        style: PopupBlueBarText.customTextStyle(context)
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p1,
                  horizontal: AppPadding.p20,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'County Name',
                            style: AllPopupHeadings.customTextStyle(context),
                          ),
                          SizedBox(height: AppSize.s5),
                          FutureBuilder<List<AllCountyGetList>>(
                              future: getCountyZoneList(context),
                              builder: (context,snapshotZone) {
                                if(snapshotZone.connectionState == ConnectionState.waiting){
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
                                if (snapshotZone.data!.isEmpty) {
                                  return Container(
                                    width: 354,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorManager.containerBorderGrey, width: AppSize.s1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          ErrorMessageString.noCountyAdded,
                                          // AppString.dataNotFound,
                                          style: AllNoDataAvailable.customTextStyle(context)
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if(snapshotZone.hasData){
                                  List dropDown = [];
                                  int docType = 0;
                                  List<DropdownMenuItem<String>> dropDownTypesList = [];
                                  for(var i in snapshotZone.data!){
                                    dropDownTypesList.add(
                                      DropdownMenuItem<String>(
                                        value: i.countyName,
                                        child: Text(i.countyName),
                                      ),
                                    );
                                  }
                                  // if (countyName == null) {
                                  //   countyName = 'Select County';
                                  // }
                                  return CICCDropdown(
                                      initialValue: dropDownTypesList[0].value,
                                      onChange: (val){
                                        for(var a in snapshotZone.data!){
                                          if(a.countyName == val){
                                            docType = a.countyId;
                                            print("County id :: ${a.companyId}");
                                            countyId = docType;
                                          }
                                        }
                                        print(":::${docType}");
                                        print(":::<>${countyId}");
                                      },
                                      items:dropDownTypesList
                                  );
                                }
                                return const SizedBox();
                              }
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.zone,
                            style: AllPopupHeadings.customTextStyle(context)
                          ),
                          SizedBox(height: AppSize.s5),
                          FutureBuilder<List<SortByZoneData>>(
                              future: PayRateZoneDropdown(context),
                              builder: (context,snapshotZone) {
                                if(snapshotZone.connectionState == ConnectionState.waiting){
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
                                if (snapshotZone.data!.isEmpty) {
                                  return Container(
                                    width: 354,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorManager.containerBorderGrey, width: AppSize.s1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          ErrorMessageString.noZoneAdded,
                                          //  AppString.dataNotFound,
                                          style: AllNoDataAvailable.customTextStyle(context)
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if(snapshotZone.hasData){
                                  List dropDown = [];
                                  int docType = 0;
                                  List<DropdownMenuItem<String>> dropDownTypesList = [];
                                  for(var i in snapshotZone.data!){
                                    dropDownTypesList.add(
                                      DropdownMenuItem<String>(
                                        value: i.zoneName,
                                        child: Text(i.zoneName),
                                      ),
                                    );
                                  }
                                  return CICCDropdown(
                                      initialValue: dropDownTypesList[0].value,
                                      onChange: (val){
                                        for(var a in snapshotZone.data!){
                                          if(a.zoneName == val){
                                            docType = a.zoneId;
                                            print("ZONE id :: ${a.zoneId}");
                                            docZoneId = docType;
                                          }
                                        }
                                        print(":::${docType}");
                                        print(":::<>${docZoneId}");
                                      },
                                      items:dropDownTypesList
                                  );
                                }
                                return const SizedBox();
                              }
                          ),
                        ],
                      ),

                      // SizedBox(height: AppSize.s15),
                      // FirstSMTextFConst(
                      //   controller: widget.cityNameController!,
                      //   keyboardType: TextInputType.text,
                      //   text: 'City Name',
                      // ),
                      SizedBox(height: AppSize.s15),
                      SMTextFConst(
                        controller: widget.zipcodeController,
                        keyboardType: TextInputType.text,
                        text: 'Zip Code',
                      ),
                      SizedBox(height: AppSize.s15),
                      Row(
                        children: [
                          TextButton(
                            onPressed: _pickLocation,
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.transparent),
                            child: Text(
                              'Pick Location',
                              style: TextStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.bluelight,
                                //decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: ColorManager.granitegray,
                            size: AppSize.s18,
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              _location,
                              style: AllNoDataAvailable.customTextStyle(context)
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSize.s15),

                      // FirstSMTextFConst(
                      //   controller: widget.landmarkController!,
                      //   keyboardType: TextInputType.text,
                      //   text: 'Landmark',
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: AppPadding.p24, top: AppPadding.p14),
                child: isLoading
                    ? SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: ColorManager.blueprime,
                        ))
                    : Center(
                        child: CustomElevatedButton(
                          width: AppSize.s105,
                          height: AppSize.s30,
                          text: AppStringEM.save,
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                             var response = await updateZipCodeSetup(context,
                            widget.zipCodeSetupId,
                            widget.zoneId == docZoneId ? widget.zoneId : docZoneId,
                            widget.countyId == countyId ? widget.countyId : countyId,
                            widget.officeId,
                            "",
                            widget.zipCodes == widget.zipcodeController.text ? widget.zipCodes.toString() : widget.zipcodeController.text,
                            _selectedLocation.latitude.toString(),
                            _selectedLocation.longitude.toString(),
                            // "37.0902°",
                            // "95.7129°",
                            "");
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CountySuccessPopup(
                                  message: 'Save Successfully',
                                );
                              },
                            );
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pick google map location

// class MapScreen extends StatefulWidget {
//   final LatLng initialLocation;
//   final Function(LatLng) onLocationPicked;
//
//   MapScreen({required this.initialLocation, required this.onLocationPicked});
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController _mapController;
//   late LatLng _selectedLocation;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedLocation = widget.initialLocation;
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }
//
//   void _onTap(LatLng location) {
//     setState(() {
//       _selectedLocation = location;
//     });
//   }
//
//   void _confirmSelection() {
//     widget.onLocationPicked(_selectedLocation);
//     Navigator.of(context).pop();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pick Location'),
//         backgroundColor: ColorManager.blueprime,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.check),
//             onPressed: _confirmSelection,
//           ),
//         ],
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         onTap: _onTap,
//         initialCameraPosition: CameraPosition(
//           target: _selectedLocation,
//           zoom: 14.0,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('selectedLocation'),
//             position: _selectedLocation,
//           ),
//         },
//       ),
//     );
//   }
// }

///zone
class AddZonePopup extends StatefulWidget {
  final TextEditingController zoneNumberController;
  final TextEditingController countyNameController;
  final Future<void> Function() onSavePressed;
  final Widget? child;
  final String title;
  final String buttonTitle;
  AddZonePopup(
      {super.key,
      required this.zoneNumberController,
      this.child,
      required this.title,
      required this.onSavePressed,
      required this.buttonTitle,
      required this.countyNameController});

  @override
  State<AddZonePopup> createState() => _AddZonePopupState();
}

class _AddZonePopupState extends State<AddZonePopup> {
  bool isLoading = false;

  // Variables to hold error messages
  String? zoneNumberError;
  String? countyError;

  // Method to validate the input fields
  bool validateFields() {
    bool isValid = true;

    setState(() {
      // Validate zone number field
      zoneNumberError = widget.zoneNumberController.text.isEmpty
          ? 'Zone number cannot be empty'
          : null;

      // Validate dropdown (assuming 'Select County' is the default unselected value)
      countyError = widget.child.toString() == 'Select County'
          ? 'Please select a county'
          : null;

      // If any error message is not null, the form is invalid
      isValid = zoneNumberError == null && countyError == null;
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: AppSize.s400,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.bluebottom,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        widget.title,
                        style: PopupBlueBarText.customTextStyle(context)
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p15,
                  horizontal: AppPadding.p20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstSMTextFConst(
                      controller: widget.zoneNumberController,
                      keyboardType: TextInputType.text,
                      text: 'Zone Number',
                    ),
                    if (zoneNumberError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          zoneNumberError!,
                          style:CommonErrorMsg.customTextStyle(context)
                        ),
                      ),
                    SizedBox(height: AppSize.s10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FirstSMTextFConst(
                          enable: false,
                          controller: widget.countyNameController,
                          keyboardType: TextInputType.text,
                          text: AppString.county,
                        ),
                        // Text(
                        //   AppString.county,
                        //   style: GoogleFonts.firaSans(
                        //     fontSize: FontSize.s12,
                        //     fontWeight: FontWeightManager.bold,
                        //     color: ColorManager.mediumgrey,
                        //     //decoration: TextDecoration.none,
                        //   ),
                        // ),
                        // SizedBox(height: AppSize.s5),
                        // widget.child!,
                        if (countyError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              countyError!,
                              style: CommonErrorMsg.customTextStyle(context)
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: AppPadding.p24, top: AppPadding.p14),
                child: isLoading
                    ? SizedBox(
                        height: AppSize.s25,
                        width: AppSize.s25,
                        child: CircularProgressIndicator(
                          color: ColorManager.blueprime,
                        ))
                    : Center(
                        child: CustomElevatedButton(
                          width: AppSize.s105,
                          height: AppSize.s30,
                          text: widget.buttonTitle,
                          onPressed: () async {
                            if (validateFields()) {
                              setState(() {
                                isLoading = true;
                              });
                              await widget.onSavePressed();
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CountySuccessPopup(
                                    message: 'Save Successfully',
                                  );
                                },
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
