import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/zone_manager.dart';
import '../../../../../../../data/api_data/establishment_data/ci_manage_button/manage_zone_data.dart';
import '../../../../../../../data/api_data/establishment_data/zone/zone_model_data.dart';
import '../../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'location_screen.dart';

class CiZoneZipcode extends StatefulWidget {
  final int companyID;
  final String officeId;
  const CiZoneZipcode({super.key, required this.companyID, required this.officeId});

  @override
  State<CiZoneZipcode> createState() => _CiZoneZipcodeState();
}

class _CiZoneZipcodeState extends State<CiZoneZipcode> {
  TextEditingController countynameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  final StreamController<List<AllZipCodeGet>> _zipcodeController = StreamController<List<AllZipCodeGet>>();

  int docZoneId =0;
  int countyId =0;
  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;
  double? _latitude;
  double? _longitude;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }
  LatLng _selectedLocation = LatLng(37.7749, -122.4194);
  String _location = 'Lat/Long not selected'; // Default text
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
    return Column(
      children: [
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          ///heading
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(''),
                // Expanded(
                //   child: Center(
                //     child: Text(
                //       'City Name',
                //style:AllHRTableHeading.customTextStyle(context),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Center(
                    child: Text('Zip Code',textAlign: TextAlign.start,
                      style:AllHRTableHeading.customTextStyle(context),),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: Text('Map',
                        textAlign: TextAlign.start,
                      style:AllHRTableHeading.customTextStyle(context),),
                  ),
                ),
                // Expanded(
                //   child: Center(
                //     child: Text(
                //       'Landmark',
                //       style: GoogleFonts.firaSans(
                //         fontSize: 12,
                //         fontWeight: FontWeight.w700,
                //         color: Colors.white,
                //         decoration: TextDecoration.none,
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Actions',
                      style:AllHRTableHeading.customTextStyle(context),
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
          child:
          StreamBuilder<List<AllZipCodeGet>>(
            stream: _zipcodeController.stream,
            builder: (context, snapshot) {
              getZipcodeSetup(context, widget.officeId, 1, 20).then((data){
                _zipcodeController.add(data);
              }).catchError((error){
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
                    ErrorMessageString.noZipcode,
                    style: CustomTextStylesCommon.commonStyle(
                      fontWeight:FontWeight.w500,
                      fontSize: FontSize.s12,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                int totalItems = snapshot.data!.length;
                int totalPages = (totalItems / itemsPerPage).ceil();
                List<AllZipCodeGet> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                            AllZipCodeGet zipcode = paginatedData[index];
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
                                      color: Color(0xff000000).withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      // Expanded(
                                      //   flex: 2,
                                      //   child: Text(
                                      //     textAlign: TextAlign.center,
                                      //     zipcode.city.toString(),
                                      //     style: GoogleFonts.firaSans(
                                      //       fontSize: 10,
                                      //       fontWeight: FontWeight.w500,
                                      //       color: ColorManager.mediumgrey,
                                      //       decoration: TextDecoration.none,
                                      //     ),
                                      //   ),
                                      // ),
                                      // Text(''),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          zipcode.zipcode.toString(),
                                          style:  DocumentTypeDataStyle.customTextStyle(context),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: InkWell(
                                          onTap:() async{
                                             String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=${snapshot.data![index].latitude}, ${snapshot.data![index].longitude}";
                                            if (await canLaunchUrlString(googleMapsUrl)) {
                                            await launchUrlString(googleMapsUrl);
                                            } else {
                                            print('Could not open the map.');
                                            }
                                          },
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            'View Map',
                                            style:  DocumentTypeDataStyle.customTextStyle(context),
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   flex: 2,
                                      //   child: Text(
                                      //     textAlign: TextAlign.center,
                                      //     zipcode.landmark.toString(),
                                      //     style: GoogleFonts.firaSans(
                                      //       fontSize: 10,
                                      //       fontWeight: FontWeight.w500,
                                      //       color: ColorManager.mediumgrey,
                                      //       decoration: TextDecoration.none,
                                      //     ),
                                      //   ),
                                      // ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                splashColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onPressed: (){
                                              showDialog(context: context, builder: (context){
                                                return FutureBuilder<ZipCodeGetPrefill>(
                                                  future: getZipcodeSetupPrefill(context, zipcode.zipcodeSetupId!),
                                                  builder: (context,snapshotPrefill) {
                                                    if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                      return Center(child:CircularProgressIndicator(color: ColorManager.blueprime,));
                                                    }
                                                    // var countyName = snapshotPrefill.data!.countyName;
                                                    // var cityName = snapshotPrefill.data!.city;
                                                    var zipCode = snapshotPrefill.data!.zipcode;
                                                    // var landmark = snapshotPrefill.data!.landmark;
                                                    var zoinId = snapshotPrefill.data!.zoneId;
                                                    docZoneId = zoinId!;
                                                    var countyPreId = snapshotPrefill.data!.countyID;
                                                    countyId = countyPreId!;
                                                    // landmarkController = TextEditingController(text:snapshotPrefill.data!.landmark.toString());
                                                    // countynameController = TextEditingController(text:snapshotPrefill.data!.countyName.toString());
                                                    // cityController = TextEditingController(text: snapshotPrefill.data!.city.toString());
                                                    zipcodeController = TextEditingController(text: snapshotPrefill.data!.zipcode.toString());
                                                    return EditZipCodePopup(
                                                      title: 'Edit Zip Code',
                                                      // countynameController: countynameController,
                                                      zipcodeController: zipcodeController,
                                                      child1: FutureBuilder<List<AllCountyGetList>>(
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
                                                                      style: CustomTextStylesCommon
                                                                          .commonStyle(
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                        fontSize: FontSize.s12,
                                                                        color:
                                                                        ColorManager.mediumgrey,
                                                                      ),
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
                                                      child:  FutureBuilder<List<SortByZoneData>>(
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
                                                                      style: CustomTextStylesCommon
                                                                          .commonStyle(
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                        fontSize: FontSize.s12,
                                                                        color:
                                                                        ColorManager.mediumgrey,
                                                                      ),
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
                                                      onPickLocation: _pickLocation,
                                                      onSavePressed: () async{
                                                     var response = await updateZipCodeSetup(context,
                                                          zipcode.zipcodeSetupId!,
                                                          zoinId == docZoneId ? zoinId : docZoneId,
                                                          countyPreId == countyId ? countyPreId : countyId,
                                                          widget.officeId,
                                                         "",
                                                         zipCode == zipcodeController.text ? zipCode.toString() : zipcodeController.text,
                                                          _selectedLocation.latitude.toString(),
                                                          _selectedLocation.longitude.toString(),
                                                          // "37.0902°",
                                                          // "95.7129°",
                                                          "");
                                                      getZipcodeSetup(context, widget.officeId,1, 20).then((data){
                                                        _zipcodeController.add(data);
                                                      }).catchError((error){
                                                      });
                                                      Navigator.pop(context);
                                                      },
                                                      );
                                                  }
                                                );
                                              });
                                            },
                                                icon: Icon(Icons.edit_outlined,
                                                  size:IconSize.I18,color: IconColorManager.bluebottom,),),
                                            // IconButton(
                                            //     splashColor: Colors.transparent,
                                            //     hoverColor: Colors.transparent,
                                            //     highlightColor: Colors.transparent,
                                            //     onPressed: (){
                                            //   showDialog(context: context, builder: (context) => DeletePopup(
                                            //       title: 'Delete Zipcode',
                                            //       onCancel: (){
                                            //     Navigator.pop(context);
                                            //   }, onDelete: () async{
                                            //     await deleteZipCodeSetup(context, zipcode.zipcodeSetupId!);
                                            //     getZipcodeSetup(context, widget.officeId, 1, 20).then((data){
                                            //       _zipcodeController.add(data);
                                            //     }).catchError((error){
                                            //     });
                                            //     Navigator.pop(context);
                                            //   }));
                                            // }, icon: Icon(Icons.delete_outline,size:18,color: ColorManager.faintOrange,)),
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
