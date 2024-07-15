import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/zone_manager.dart';
import '../../../../../../../data/api_data/establishment_data/ci_manage_button/manage_zone_data.dart';
import '../../../../../../../data/api_data/establishment_data/zone/zone_model_data.dart';
import '../../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class CiZoneZipcode extends StatefulWidget {
  final int companyID;
  final String officeId;
  const CiZoneZipcode({super.key, required this.companyID, required this.officeId});

  @override
  State<CiZoneZipcode> createState() => _CiZoneZipcodeState();
}

class _CiZoneZipcodeState extends State<CiZoneZipcode> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController countynameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  final StreamController<List<AllZipCodeGet>> _zipcodeController = StreamController<List<AllZipCodeGet>>();

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(60, (index) => 'Item ${index + 1}');

  }
  int docZoneId =0;
  int countyId =0;
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
                      'City Name',
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
                    child: Text('Zip Code',textAlign: TextAlign.start,
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
                    child: Text('Map',
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
                      'Landmark',
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
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
          child:
          StreamBuilder<List<AllZipCodeGet>>(
            stream: _zipcodeController.stream,
            builder: (context, snapshot) {
              getZipcodeSetup(context, widget.officeId, widget.companyID, 1, 20).then((data){
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
                return
          ListView.builder(
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
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    snapshot.data![index].city.toString(),
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
                                  flex: 2,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    snapshot.data![index].zipcode.toString(),
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.mediumgrey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap:(){

                                    },
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'View Map',
                                      style: GoogleFonts.firaSans(
                                        decorationStyle: TextDecorationStyle.dashed,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.mediumgrey,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    snapshot.data![index].landmark.toString(),
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.mediumgrey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(onPressed: (){
                                        showDialog(context: context, builder: (context){
                                          return FutureBuilder<ZipCodeGetPrefill>(
                                            future: getZipcodeSetupPrefill(context, snapshot.data![index].zipcodeSetupId!),
                                            builder: (context,snapshotPrefill) {
                                              if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                return Center(child:CircularProgressIndicator(color: ColorManager.blueprime,));
                                              }
                                              var countyName = snapshotPrefill.data!.countyName;
                                              var cityName = snapshotPrefill.data!.city;
                                              var zipCode = snapshotPrefill.data!.zipcode;
                                              var landmark = snapshotPrefill.data!.landmark;
                                              var zoinId = snapshotPrefill.data!.zoneId;
                                              docZoneId = zoinId!;
                                              var countyPreId = snapshotPrefill.data!.countyID;
                                              countyId = countyPreId!;
                                              landmarkController = TextEditingController(text:snapshotPrefill.data!.landmark.toString());
                                              countynameController = TextEditingController(text:snapshotPrefill.data!.countyName.toString());
                                              cityController = TextEditingController(text: snapshotPrefill.data!.city.toString());
                                              zipcodeController = TextEditingController(text: snapshotPrefill.data!.zipcode.toString());
                                              return AddZipCodePopup(title: 'Edit Zip Code',
                                                countynameController: countynameController,
                                                cityNameController: cityController,
                                                zipcodeController: zipcodeController,
                                                child1: FutureBuilder<List<AllCountyGetList>>(
                                                    future: getCountyZoneList(context),
                                                    builder: (context,snapshotZone) {
                                                      if(snapshotZone.connectionState == ConnectionState.waiting){
                                                        return Shimmer.fromColors(
                                                            baseColor: Colors.grey[300]!,
                                                            highlightColor: Colors.grey[100]!,
                                                            child: Container(
                                                              width: 354,
                                                              height: 30,
                                                              decoration: BoxDecoration( color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                                            )
                                                        );
                                                      }
                                                      if (snapshotZone.data!.isEmpty) {
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
                                                child:  FutureBuilder<List<AllZoneData>>(
                                                    future: getAllZone(context),
                                                    builder: (context,snapshotZone) {
                                                      if(snapshotZone.connectionState == ConnectionState.waiting){
                                                        return Shimmer.fromColors(
                                                            baseColor: Colors.grey[300]!,
                                                            highlightColor: Colors.grey[100]!,
                                                            child: Container(
                                                              width: 354,
                                                              height: 30,
                                                              decoration: BoxDecoration( color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                                            )
                                                        );
                                                      }
                                                      if (snapshotZone.data!.isEmpty) {
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
                                                onSavePressed: () async{
                                                await updateZipCodeSetup(context,
                                                    snapshot.data![index].zipcodeSetupId!,
                                                    zoinId == docZoneId ? zoinId : docZoneId,
                                                    countyPreId == countyId ? countyPreId : countyId,
                                                    widget.companyID,
                                                    widget.officeId,
                                                   cityName ==  cityController.text ? cityName.toString() :cityController.text,
                                                   zipCode == zipcodeController.text ? zipCode.toString() : zipcodeController.text,
                                                    "37.0902°",
                                                    "95.7129°",
                                                    landmark == landmarkController.text ? landmark.toString() :landmarkController.text);
                                                getZipcodeSetup(context, widget.officeId, widget.companyID, 1, 20).then((data){
                                                  _zipcodeController.add(data);
                                                }).catchError((error){

                                                });
                                                }, mapController: mapController, landmarkController: landmarkController,);
                                            }
                                          );
                                        });
                                      }, icon: Icon(Icons.edit_outlined,size:18,color: ColorManager.blueprime,)),
                                      IconButton(onPressed: (){
                                        showDialog(context: context, builder: (context) => DeletePopup(onCancel: (){
                                          Navigator.pop(context);
                                        }, onDelete: () async{
                                          await deleteZipCodeSetup(context, snapshot.data![index].zipcodeSetupId!);
                                          getZipcodeSetup(context, widget.officeId, widget.companyID, 1, 20).then((data){
                                            _zipcodeController.add(data);
                                          }).catchError((error){
                                          });
                                          Navigator.pop(context);
                                        }));
                                      }, icon: Icon(Icons.delete_outline,size:18,color: ColorManager.faintOrange,)),
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
      ],
    );
  }
}
