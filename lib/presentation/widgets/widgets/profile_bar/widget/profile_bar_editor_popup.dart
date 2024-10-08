// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
// import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/profilebar_editor.dart';
//
// import '../../../../../app/resources/color.dart';
// import '../../../../../app/resources/common_resources/common_theme_const.dart';
// import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
// import '../../../../../app/resources/theme_manager.dart';
// import '../../../../../app/resources/value_manager.dart';
// import '../../../../../app/services/api/managers/establishment_manager/zone_manager.dart';
// import '../../../../../app/services/api/managers/hr_module_manager/profile_mnager.dart';
// import '../../../../../app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
// import '../../../../../data/api_data/api_data.dart';
// import '../../../../../data/api_data/establishment_data/zone/zone_model_data.dart';
// import '../../../../../data/api_data/hr_module_data/profile_editor/profile_editor.dart';
// import '../../../../screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
// import '../../../../screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import '../../../../screens/hr_module/register/offer_letter_screen.dart';
//
// class ProfileBarEditPopup extends StatefulWidget {
//
//   final int employeeId;
//   final int employeeEnrollId;
//   const ProfileBarEditPopup({super.key, required this.employeeId, required this.employeeEnrollId,});
//
//   @override
//   State<ProfileBarEditPopup> createState() => _ProfileBarEditPopupState();
// }
//
// class _ProfileBarEditPopupState extends State<ProfileBarEditPopup> {
//   int selectedZoneId = 0;
//   int selectedCountyId = 0;
//   int selectedCityId = 0;
//   String? selectedZone;
//   String? selectedCounty;
//   String reportingOfficeId ='';
//   Map<String, bool> checkedZipCodes = {};
//   Map<String, bool> checkedCityName = {};
//   List<String> selectedZipCodes = [];
//   List<String> selectedCityName = [];
//   String selectedZipCodesString = '';
//   List<int> zipCodes = [];
//   String? selectedZipCodeZone;
//   int docZoneId = 0;
//   var deptId = 1;
//   int? firstDeptId;
//   String? selectedDeptName;
//   List<DropdownMenuItem<String>> countyDropDownList = [];
//   List<DropdownMenuItem<String>> zoneDropDownList = [];
//   String selectedCovrageCounty = "Select County";
//   String selectedCovrageZone = "Select Zone";
//   final StreamController<List<CountyWiseZoneModal>> _zoneController =
//   StreamController<List<CountyWiseZoneModal>>.broadcast();
//   List<ApiPatchCovrageData> addCovrage = [];
//   final StreamController<List<ZipcodeByCountyIdAndZoneIdData>>
//   _countyStreamController =
//   StreamController<List<ZipcodeByCountyIdAndZoneIdData>>.broadcast();
//
//   String countyName = "";
//   String zoneName = "";
//   @override
//   Widget build(BuildContext context) {
//     return DialogueTemplate(
//         width: 420,
//         height: 580,
//         title: 'Edit Coverage',
//         body: [
//           Row(
//             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ///county zone
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
//                 child: Container(
//                 //  color: ColorManager.red,
//                   height: 150,
//                   width: 354,
//                   child:
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                           'County',
//                           style: CustomTextStylesCommon.commonStyle(fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             color: const Color(0xff575757),)
//                       ),
//                       const SizedBox(height: 5),
//                       FutureBuilder<List<AllCountyGetList>>(
//                         future: getCountyZoneList(context),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState == ConnectionState.waiting) {
//                             return const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 7),
//                               child: CICCDropdown(
//                                 hintText: 'Select County',
//                                 items: [],
//                               ),
//                             );
//                           } else if (snapshot.hasError) {
//                             return const Text("Error fetching counties");
//                           } else if (snapshot.hasData) {
//                             countyDropDownList.clear();
//                             countyDropDownList.add(
//                               DropdownMenuItem<String>(
//                                 child: Text('Select County'),
//                                 value: 'Select County',
//                               ),
//                             );
//                             for (var county in snapshot.data!) {
//                               countyDropDownList.add(
//                                 DropdownMenuItem<String>(
//                                   child: Text(county.countyName),
//                                   value: county.countyName,
//                                 ),
//                               );
//                             }
//
//                             return StatefulBuilder(
//                               builder: (BuildContext context, StateSetter setState) {
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // County Dropdown
//                                     CICCDropdown(
//                                       items: countyDropDownList,
//                                       initialValue: selectedCounty,
//                                       width: 354,
//                                       onChange: (newValue) async {
//                                         setState(() {
//                                           selectedCounty = newValue;
//                                           selectedCovrageCounty = newValue;
//                                         });
//
//                                         // Get the county ID for the selected county
//                                         for (var county in snapshot.data!) {
//                                           if (county.countyName == newValue) {
//                                             selectedCountyId = county.countyId;
//                                             countyName = county.countyName;
//                                            // break;
//                                           }
//                                         }
//
//                                         print("Selected CountyId: $selectedCountyId");
//                                       },
//                                     ),
//                                     const SizedBox(height: 10),
//
//                                     // Zone Label
//                                     Text(
//                                         'Zone',
//                                         style: CustomTextStylesCommon.commonStyle(fontSize: 12,
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xff575757),)
//                                       // GoogleFonts.firaSans(
//                                       //   fontSize: 12,
//                                       //   fontWeight: FontWeight.w600,
//                                       //   color: const Color(0xff575757),
//                                       // ),
//                                     ),
//                                     const SizedBox(height: 5),
//
//                                     // Zone Dropdown with hint text
//                                     StreamBuilder<List<CountyWiseZoneModal>>(
//                                         stream: _zoneController.stream,
//                                         builder: (context, snapshotZone) {
//                                           fetchCountyWiseZone(context, selectedCountyId)
//                                               .then((data) {
//                                             _zoneController.add(data);
//                                           }).catchError((error) {});
//                                           if (snapshotZone.connectionState ==
//                                               ConnectionState.waiting) {
//                                             return Container(
//                                               width: 354,
//                                               height: 30,
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: ColorManager
//                                                         .containerBorderGrey,
//                                                     width: AppSize.s1),
//                                                 borderRadius:
//                                                 BorderRadius.circular(4),
//                                               ),
//                                               child: const Text(
//                                                 "",
//                                                 //AppString.dataNotFound,
//                                               ),
//                                             );
//                                           }
//                                           if (snapshotZone.data!.isEmpty) {
//                                             return Container(
//                                               width: 354,
//                                               height: 30,
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: ColorManager
//                                                         .containerBorderGrey,
//                                                     width: AppSize.s1),
//                                                 borderRadius:
//                                                 BorderRadius.circular(4),
//                                               ),
//                                               child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding: const EdgeInsets
//                                                       .symmetric(
//                                                       horizontal: 10),
//                                                   child: Text(
//                                                     ErrorMessageString
//                                                         .noZoneAdded,
//                                                     //  AppString.dataNotFound,
//                                                     style:
//                                                     AllNoDataAvailable.customTextStyle(context),
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           }
//                                           if (snapshotZone.hasData) {
//                                             List dropDown = [];
//                                             int docType = 0;
//                                             List<DropdownMenuItem<String>>
//                                             dropDownTypesList = [];
//
//                                             for (var i in snapshotZone.data!) {
//                                               dropDownTypesList.add(
//                                                 DropdownMenuItem<String>(
//                                                   value: i.zoneName,
//                                                   child: Text(i.zoneName),
//                                                 ),
//                                               );
//                                             }
//                                             if (selectedZipCodeZone == null) {
//                                               selectedZipCodeZone =
//                                                   snapshotZone.data![0].zoneName;
//                                             }
//                                             docZoneId = snapshotZone.data![0].zone_id;
//                                             return CICCDropdown(
//                                                 width: 354,
//                                                 initialValue:
//                                                 dropDownTypesList[0].value,
//                                                 onChange: (val) {
//                                                   selectedZipCodeZone = val;
//                                                   selectedCovrageZone = val;
//                                                   for (var a in snapshotZone.data!) {
//                                                     if (a.zoneName == val) {
//                                                       docType = a.zone_id;
//                                                       zoneName = a.zoneName;
//                                                       print("ZONE id :: ${a.zone_id}");
//                                                       docZoneId = docType;
//                                                     }
//                                                   }
//                                                   print(":::${docType}");
//                                                   print(":::<>${docZoneId}");
//                                                 },
//                                                 items: dropDownTypesList);
//                                           }
//                                           return const SizedBox();
//                                         }),
//
//                                   ],
//                                 );
//                               },
//                             );
//                           } else {
//                             return const Text('No Data available');
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [  ///Zipcode
//             Container(
//             height: 200,
//             width: 300,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                   'Zip Codes',
//                   style: CustomTextStylesCommon.commonStyle(fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xff575757),)
//               ),
//               /// Removed TabBar code
//               Expanded(
//               child: Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//               child: StreamBuilder<List<ZipcodeByCountyIdAndZoneIdData>>(
//               stream: _countyStreamController.stream,
//               builder: (BuildContext context, snapshot) {
//               getZipcodeByCountyIdAndZoneId(
//               context: context,
//               countyId: selectedCountyId,
//               zoneId: docZoneId,
//               ).then((data) {
//               _countyStreamController.add(data);
//               }).catchError((error) {
//               // Handle error
//               });
//
//               if (snapshot.connectionState == ConnectionState.waiting) {
//               return SizedBox();
//               }
//
//               if (selectedCountyId == 0) {
//               return Center(
//               child: Text(
//               'Select county',
//               style: CustomTextStylesCommon.commonStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
//               ),
//               );
//               }
//
//               if (snapshot.data!.isEmpty) {
//               return Center(
//               child: Text(
//               'No Data Found!',
//               style: CustomTextStylesCommon.commonStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
//               ),
//               );
//               }
//
//               return Row(
//               children: [
//               StatefulBuilder(
//               builder: (BuildContext context, void Function(void Function()) setState) {
//               return Container(
//               width: 200,
//               height: 300,
//               child: ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (BuildContext context, int index) {
//               String zipCode = snapshot.data![index].zipCode;
//               bool isChecked = checkedZipCodes[zipCode] ?? false;
//               return CheckBoxTileConst(
//               text: zipCode,
//               value: isChecked,
//               onChanged: (bool? val) {
//               setState(() {
//               print('Clicked check box 1');
//               checkedZipCodes[zipCode] = val ?? false;
//               if (val == true) {
//               selectedZipCodes.add(zipCode);
//               zipCodes.add(int.parse(snapshot.data![index].zipCode));
//               } else {
//               selectedZipCodes.remove(zipCode);
//               zipCodes.remove(int.parse(snapshot.data![index].zipCode));
//               }
//               selectedZipCodesString = selectedZipCodes.join(', ');
//               });
//               },
//               );
//               },
//               ),
//               );
//               },
//               ),
//               ],
//               );
//               },
//               ),
//               ),
//               ),
//               ],
//               ),
//               ),
//             ],
//           )
//         ],
//         bottomButtons:   CustomButton(
//           height: 28,
//           width: 70,
//           text: 'Add',
//           onPressed: () async {
//             // Uncomment if you need a loading state
//             // setState(() {
//             //   _isLoading = true;
//             // });
//             // setState((){
//             //   addCovrage.add(ApiPatchCovrageData(city: "",
//             //       countyId: selectedCountyId, zoneId: docZoneId,
//             //       zipCodes: zipCodes));
//             // });
//             var patchCoverage = await patchEmpEnrollAddCoverage(context,
//                 widget.employeeEnrollId,widget.employeeId,[ApiPatchCovrageData(city: "",
//                     countyId: selectedCountyId, zoneId: docZoneId,
//                     zipCodes: zipCodes)]);
//             print('Selected County ID: $selectedCountyId');
//             print('Selected Zone ID: $docZoneId');
//             print('Selected Zip Codes: $selectedZipCodes');
//             print('Selected City: $selectedCityName');
//             if (patchCoverage.success) {
//               print("Coverage added successfully");
//             } else {
//               print("Failed To Add Coverage");
//             }
//             Navigator.pop(context, countyName);
//           },
//         ),);
//   }
// }
