// import 'dart:async';
// import 'dart:ui';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
// import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
// import 'package:app_links/app_links.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
// import 'package:prohealth/data/api_data/api_data.dart';
// import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
// import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
// import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/confirmation_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/widgets/offer_letter_constant.dart';
// import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
// class OfferLetterScreen extends StatefulWidget {
//   final String email;
//   final int userId;
//   final String role;
//   final String status;
//   final String firstName;
//   final String lastName;
//   final String position;
//   final String phone;
//   final String reportingOffice;
//   final String services;
//   final String employement;
//   final String soecalityName;
//   final String clinicalName;
//   final int employeeId;
//   final ApiData? apiData;
//
//   const OfferLetterScreen(
//       {super.key,
//         required this.email,
//         required this.userId,
//         required this.role,
//         required this.status,
//         required this.firstName,
//         required this.lastName,
//         required this.position,
//         required this.phone,
//         required this.reportingOffice,
//         required this.services,
//         required this.employement,
//         required this.soecalityName,
//         required this.clinicalName,
//         required this.employeeId,
//         this.apiData
//       });
//
//   @override
//   State<OfferLetterScreen> createState() => _OfferLetterScreenState();
// }
//
// class _OfferLetterScreenState extends State<OfferLetterScreen> {
//   TextEditingController issueDateController = TextEditingController();
//   TextEditingController lastDateController = TextEditingController();
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController verbalAcceptanceController = TextEditingController();
//   TextEditingController patientsController = TextEditingController();
//   final StreamController<List<ZipcodeByCountyIdData>> _countyStreamController = StreamController<List<ZipcodeByCountyIdData>>.broadcast();
//
//   String selectedDropdownValue = 'Per day';
//   String dropdownValue = 'Salaried';
//   late List<Map<String, dynamic>> checkboxStates;
//   late List<Map<String, dynamic>> checkboxStatesCity;
//
//   String _salary = "";
//   String generatedURL = '';
//
//   final List<Map<String, String>> data = [
//     {'zipCode': '10001', 'city': 'New York'},
//     {'zipCode': '20001', 'city': 'Washington, D.C.'},
//     {'zipCode': '30301', 'city': 'Atlanta'},
//     {'zipCode': '94101', 'city': 'San Francisco'},
//     // Add more data as needed
//   ];
//
//   final PageController _pageController = PageController();
//   int _currentPageIndex = 0;
//
//   void _goToPage(int pageIndex) {
//     _pageController.animateToPage(
//       pageIndex,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void popNavigation(){
//     setState((){
//       Navigator.pop(context);
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     _initAppLinks();
//     _pageController.addListener(() {
//       setState(() {
//         _currentPageIndex = _pageController.page!.toInt();
//       });
//     });
//   }
//
//   // void handleDropdownChange(String? newValue) {
//   //   setState(() {
//   //     dropdownValue = newValue ?? 'Salaried';
//   //   });
//   // }
//
//   List<Widget> _buildCheckboxes() {
//     return checkboxStates.map((data) {
//       return CheckboxListTile(
//         title: Text(
//           data['title'],
//           style:
//           GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),
//         ),
//         value: data['value'],
//         onChanged: (bool? value) {
//           setState(() {
//             data['value'] = value ?? false;
//           });
//         },
//       );
//     }).toList();
//   }
//
//   List<Widget> _buildCheckboxesCity() {
//     return checkboxStatesCity.map((data) {
//       return CheckboxListTile(
//         title: Text(
//           data['title'],
//           style:
//           GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),
//         ),
//         value: data['value'],
//         onChanged: (bool? value) {
//           setState(() {
//             data['value'] = value ?? false;
//           });
//         },
//       );
//     }).toList();
//   }
//
//   AppLinks? _appLinks;
//
//   void _initAppLinks() async {
//     _appLinks = AppLinks();
//   }
//   Future<String> _generateUrlLink(String email, String Id) async {
//     final String user = email;
//     final String id = Id;
//     final String url = 'https://staging.symmetry.care/$id';
//     generatedURL = url;
//     print('Generated URL: $generatedURL');
//     return url;
//   }
//   int selectedZoneId = 0;
//   int selectedCountyId = 0;
//   int selectedCityId = 0;
//   String? selectedCounty;
//   // int? selectedCountyId;
//   bool _isLoading = false;
//   Map<String, bool> checkedZipCodes = {};
//   Map<String, bool> checkedCityName = {};
//   List<String> selectedZipCodes = [];
//   List<String> selectedCityName = [];
//   String selectedZipCodesString = '';
//   String selectedCityString = '';
//   List<DropdownMenuItem<String>> dropDownList = [];
//   int countyId = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Offer Letter',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xff1696C8),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTextFieldOfferScreen(
//                       height: 36,
//                       controller: issueDateController,
//                       labelText: 'Issue Date'),
//                   //SizedBox(width: MediaQuery.of(context).size.width / 80),
//                   CustomTextFieldOfferScreen(
//                     height: 36,
//                     controller: lastDateController,
//                     labelText: 'Last Date',
//                   ),
//                   // SizedBox(width: MediaQuery.of(context).size.width / 80),
//                   CustomTextFieldOfferScreen(
//                     height: 36,
//                     controller: startDateController,
//                     labelText: 'Anticipated Start Date',
//                   )
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 60),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTextFieldOfferScreen(
//                     height: 36,
//                     controller: verbalAcceptanceController,
//                     labelText: 'Verbal Acceptance',
//                   ),
//                   //SizedBox(width: MediaQuery.of(context).size.width / 80),
//
//                   Container(
//                     height: 30,
//                     width: MediaQuery.of(context).size.width / 5,
//                     child: StatefulBuilder(
//                       builder: (BuildContext context, void Function(void Function()) setState) {
//                         return TextField(
//                           cursorColor: Colors.black,
//                           controller: patientsController,
//                           decoration: InputDecoration(
//                             border: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//                             ),
//                             focusedBorder: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             labelText: 'No. of Patients',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: 10.0,
//                               fontWeight: FontWeight.w400,
//                               color: const Color(0xff575757),
//                             ),
//                             suffixIcon: DropdownButton<String>(
//                               value: selectedDropdownValue,
//                               items: ['Per day', 'Per week', 'Per month']
//                                   .map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12.0),
//                                     child: Text(
//                                       value,
//                                       style: const TextStyle(fontSize: 10.0),
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                               onChanged: (String? value) {
//                                 if (value != null) {
//                                   setState(() {
//                                     selectedDropdownValue = value;
//                                   });
//                                 }
//                               },
//                               underline: const SizedBox(),
//                               icon: const Icon(Icons.arrow_drop_down,
//                                   color: Colors.blue),
//                             ),
//                             contentPadding:
//                             const EdgeInsets.only(left: 20, bottom: 5),
//                           ),
//                           style: GoogleFonts.firaSans(
//                               fontSize: 10.0,
//                               fontWeight: FontWeight.w400,
//                               color: const Color(0xff575757)),
//                         );
//                       },
//                     ),
//                   ),
//                   //SizedBox(width: MediaQuery.of(context).size.width / 10),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 5,
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 50),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 100),
//                 child: Divider(
//                   color: ColorManager.cream,
//                   thickness: 4,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 40),
//               ///blue container
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 100),
//                 child: Container(
//                   width: double.infinity, //1030
//                   height: 330, //MediaQuery.of(context).size.height / 2,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: const Color(0xff1696C8)),
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 ///county
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'County',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w600,
//                                         color: ColorManager.mediumgrey,
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                     FutureBuilder<List<AllCountyGetList>>(
//                                       future: getCountyZoneList(context),
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState == ConnectionState.waiting) {
//                                           return Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 7),
//                                             child: Container(
//                                               height: 31,
//                                               width: 250,
//                                               decoration: BoxDecoration(color: ColorManager.white),
//                                             ),
//                                           );
//                                         } else if (snapshot.hasError) {
//                                           return const CustomDropdownTextField(
//                                             hintText: 'Select County',
//                                             labelText: 'County',
//                                             labelStyle: TextStyle(
//                                               fontSize: 12,
//                                               color: Color(0xff575757),
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             labelFontSize: 12,
//                                             items: ['Error'],
//                                           );
//                                         } else if (snapshot.hasData) {
//                                           // Clear dropdown list to avoid duplicates
//                                           dropDownList.clear();
//
//                                           // Add the default "Select" item
//                                           dropDownList.add(DropdownMenuItem<String>(
//                                             child: Text('Select County'),
//                                             value: 'Select County',
//                                           ));
//
//                                           // Populate dropdown list with counties
//                                           for (var i in snapshot.data!) {
//                                             dropDownList.add(DropdownMenuItem<String>(
//                                               child: Text(i.countyName),
//                                               value: i.countyName,
//                                             ));
//                                           }
//
//                                           // Set initial selectedCounty if not already set
//                                           if (selectedCounty == null) {
//                                             selectedCounty = 'Select County';
//                                           }
//
//                                           return StatefulBuilder(
//                                             builder: (BuildContext context, StateSetter setState) {
//                                               return Container(
//                                                 height: 31,
//                                                 width: 250,
//                                                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   border: Border.all(color: const Color(0xff686464).withOpacity(0.5), width: 1),
//                                                   borderRadius: BorderRadius.circular(6),
//                                                 ),
//                                                 child: DropdownButtonFormField<String>(
//                                                   focusColor: Colors.transparent,
//                                                   icon: const Icon(
//                                                     Icons.arrow_drop_down_sharp,
//                                                     color: Color(0xff686464),
//                                                   ),
//                                                   decoration: const InputDecoration.collapsed(hintText: ''),
//                                                   items: dropDownList,
//                                                   onChanged: (newValue) {
//                                                     setState(() {
//                                                       selectedCounty = newValue;
//                                                       for (var a in snapshot.data!) {
//                                                         if (a.countyName == newValue) {
//                                                           selectedCountyId = a.countyId;
//                                                           print("County Id :: ${selectedCountyId}");
//                                                           // Perform other actions if needed
//                                                         }
//                                                       }
//                                                     });
//                                                   },
//                                                   value: selectedCounty,
//                                                   style: GoogleFonts.firaSans(
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.w600,
//                                                     color: const Color(0xff686464),
//                                                     decoration: TextDecoration.none,
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                         } else {
//                                           return CustomDropdownTextField(
//                                             labelText: 'County',
//                                             labelStyle: GoogleFonts.firaSans(
//                                               fontSize: 12,
//                                               color: const Color(0xff575757),
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             labelFontSize: 12,
//                                             items: ['No Data'],
//                                           );
//                                         }
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 20),
//
//                                 ///zone api
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Zone',style: GoogleFonts.firaSans(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: ColorManager.mediumgrey,
//                                     ),),
//                                     SizedBox(height:5),
//                                     FutureBuilder<List<SortByZoneData>>(
//                                       future: PayRateZoneDropdown(context),
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState == ConnectionState.waiting) {
//                                           return Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 7),
//                                             child: Container(
//                                               height: 31,
//                                               width: 250,
//                                               decoration: BoxDecoration(color: ColorManager.white),
//                                             ),
//                                           );
//                                         } else if (snapshot.hasError) {
//                                           return const CustomDropdownTextField(
//                                             labelText: 'Zone',
//                                             labelStyle: TextStyle(
//                                               fontSize: 12,
//                                               color: Color(0xff575757),
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             labelFontSize: 12,
//                                             items: ['Error'],
//                                           );
//                                         } else if (snapshot.hasData) {
//                                           List<DropdownMenuItem<String>> dropDownList = [];
//
//                                           // Add the default "Select" item
//                                           dropDownList.add(DropdownMenuItem<String>(
//                                             child: Text('Select Zone'),
//                                             value: 'Select Zone',
//                                           ));
//
//                                           // Populate dropdown list with zones
//                                           for (var i in snapshot.data!) {
//                                             dropDownList.add(DropdownMenuItem<String>(
//                                               child: Text(i.zoneName),
//                                               value: i.zoneName,
//                                             ));
//                                           }
//
//                                           // Set initial selectedZone if not already set
//                                           String? selectedZone = 'Select Zone';
//
//                                           return StatefulBuilder(
//                                             builder: (BuildContext context, StateSetter setState) {
//                                               return Container(
//                                                 height: 31,
//                                                 width: 250,
//                                                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   border: Border.all(color: const Color(0xff686464).withOpacity(0.5), width: 1),
//                                                   borderRadius: BorderRadius.circular(6),
//                                                 ),
//                                                 child: DropdownButtonFormField<String>(
//                                                   focusColor: Colors.transparent,
//                                                   icon: const Icon(
//                                                     Icons.arrow_drop_down_sharp,
//                                                     color: Color(0xff686464),
//                                                   ),
//                                                   decoration: const InputDecoration.collapsed(hintText: ''),
//                                                   items: dropDownList,
//                                                   onChanged: (newValue) {
//                                                     setState(() {
//                                                       selectedZone = newValue;
//                                                       for (var a in snapshot.data!) {
//                                                         if (a.zoneName == newValue) {
//                                                           int zoneId = a.zoneId;
//                                                           selectedZoneId = zoneId;
//                                                           print("Zone Id :: ${selectedZoneId}");
//                                                           // Perform other actions if needed
//                                                         }
//                                                       }
//                                                     });
//                                                   },
//                                                   value: selectedZone,
//                                                   style: GoogleFonts.firaSans(
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.w600,
//                                                     color: const Color(0xff686464),
//                                                     decoration: TextDecoration.none,
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                         } else {
//                                           return CustomDropdownTextField(
//                                             labelText: 'Zone',
//                                             labelStyle: GoogleFonts.firaSans(
//                                               fontSize: 12,
//                                               color: const Color(0xff575757),
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                             labelFontSize: 12,
//                                             items: ['No Data'],
//                                           );
//                                         }
//                                       },
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         ///old code tabbar
//                         Expanded(
//                           child: DefaultTabController(
//                             length: 2,
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 180.0, right: 180.0),
//                                   child: TabBar(
//                                     indicatorColor: const Color(0xff1696C8),
//                                     labelColor: const Color(0xff686464),
//                                     unselectedLabelColor: const Color(0xff686464),
//                                     labelStyle: GoogleFonts.firaSans(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                     unselectedLabelStyle: GoogleFonts.firaSans(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                     tabs: const [
//                                       Tab(text: 'Zip Codes'),
//                                       // Tab(text: 'Cities'),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 100.0, right: 100.0),
//                                     child: TabBarView(
//                                       physics:
//                                       const NeverScrollableScrollPhysics(),
//                                       children: [
//                                         StreamBuilder<List<ZipcodeByCountyIdData>>(
//                                           stream: _countyStreamController.stream,
//                                           builder: (BuildContext context,snapshot) {
//                                             getZipcodeByCountyId(context: context, countyId:selectedCountyId).then((data) {
//                                               _countyStreamController.add(data);
//                                             }).catchError((error) {
//                                               // Handle error
//                                             });
//                                             if(snapshot.connectionState == ConnectionState.waiting){
//                                               return SizedBox();
//                                             }
//                                             if(selectedCountyId == 0){
//                                               return Center(child: Text('Select county',style:
//                                               GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),));
//                                             }
//                                             if(snapshot.data!.isEmpty){
//                                               return Center(child: Text('No Data Found!',style:
//                                               GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),));
//                                             }
//                                             return Row(
//                                               children: [
//                                                 StatefulBuilder(
//                                                   builder: (BuildContext context, void Function(void Function()) setState) {
//                                                     return Container(
//                                                       width:200,
//                                                       height:300,
//                                                       child: ListView.builder(
//                                                         itemCount: snapshot.data!.length,
//                                                         itemBuilder: (BuildContext context, int index) {
//                                                           String zipCode = snapshot.data![index].zipCode;
//                                                           bool isChecked = checkedZipCodes[zipCode] ?? false;
//                                                           return  CheckBoxTileConst(text: zipCode, value: isChecked, onChanged: (bool? val) {setState(() {
//                                                             print('Clicked check box 1');
//                                                             checkedZipCodes[zipCode] = val ?? false;
//                                                             if (val == true) {
//                                                               selectedZipCodes.add(zipCode);
//                                                             } else {
//                                                               selectedZipCodes.remove(zipCode);
//                                                             }
//                                                             // Update the string representation
//                                                             selectedZipCodesString = selectedZipCodes.join(', ');
//                                                           });  });
//                                                         },
//                                                       ),
//                                                     );
//                                                   },
//                                                 ),
//                                                 // Expanded(
//                                                 //   child: ListView(
//                                                 //     children: _buildCheckboxes()
//                                                 //         .sublist(5, 10),
//                                                 //   ),
//                                                 // ),
//                                               ],
//                                             );
//                                           },
//
//                                         ),
//                                         // Tab 2 content: Cities
//                                         // StreamBuilder<List<ZipcodeByCountyIdData>>(
//                                         //   stream: _countyStreamController.stream,
//                                         //   builder: (BuildContext context,snapshot) {
//                                         //     getZipcodeByCountyId(context: context, countyId:selectedCountyId).then((data) {
//                                         //       _countyStreamController.add(data);
//                                         //     }).catchError((error) {
//                                         //       // Handle error
//                                         //     });
//                                         //     if(snapshot.connectionState == ConnectionState.waiting){
//                                         //       return SizedBox();
//                                         //     }
//                                         //     if(selectedCountyId == 0){
//                                         //       return Center(child: Text('Select county',style:
//                                         //       GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),));
//                                         //     }
//                                         //     if(snapshot.data!.isEmpty){
//                                         //       return Center(child: Text('No Data Found!',style:
//                                         //       GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),));
//                                         //     }
//                                         //     return Row(
//                                         //       children: [
//                                         //         StatefulBuilder(
//                                         //           builder: (BuildContext context, void Function(void Function()) setState) {
//                                         //             return Container(
//                                         //               width:200,
//                                         //               height:300,
//                                         //               child: ListView.builder(
//                                         //                 itemCount: snapshot.data!.length,
//                                         //                 itemBuilder: (BuildContext context, int index) {
//                                         //                   String cityName = snapshot.data![index].city;
//                                         //                   bool isChecked = checkedCityName[cityName] ?? false;
//                                         //                   return  CheckBoxTileConst(text: cityName, value: isChecked, onChanged: (bool? val) {setState(() {
//                                         //                     print('Clicked');
//                                         //                     checkedCityName[cityName] = val ?? false;
//                                         //                     if (val == true) {
//                                         //                       selectedCityName.add(cityName);
//                                         //                     } else {
//                                         //                       selectedCityName.remove(cityName);
//                                         //                     }
//                                         //                     // Update the string representation
//                                         //                     selectedCityString = selectedCityName.join(', ');
//                                         //                     print(selectedCityString);
//                                         //                   });  });
//                                         //                 },
//                                         //               ),
//                                         //             );
//                                         //           },
//                                         //         ),
//                                         //         // Expanded(
//                                         //         //   child: ListView(
//                                         //         //     children: _buildCheckboxes()
//                                         //         //         .sublist(5, 10),
//                                         //         //   ),
//                                         //         // ),
//                                         //       ],
//                                         //     );
//                                         //   },
//                                         //
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 40),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 100),
//                 child: StatefulBuilder(
//
//                   builder: (BuildContext context, void Function(void Function()) setState) {
//                     return  Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           height: 30,
//                           width: 300,
//                           child: CustomDropdownFormField(
//                               hintText: 'Salaried',
//                               items: ['Salaried', 'Per Visit'],
//                               value: dropdownValue,
//                               onChanged: (newValue){
//                                 setState(() {
//                                   dropdownValue = newValue! ?? 'Salaried';
//                                   print('dropDownValue ${dropdownValue}');
//                                 });
//                               }),
//                         ),
//                         Row(
//                           children: [
//                             if (_salary.isNotEmpty)
//                               Text(
//                                 "\$ ${_salary}",
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             ElevatedButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(12.0),
//                                         ),
//                                         titlePadding: EdgeInsets.zero,
//                                         title: Container(
//                                           decoration: const BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(12),
//                                               bottomLeft: Radius.circular(12),
//                                               bottomRight: Radius.circular(12),
//                                               topRight: Radius.circular(12),
//                                             ),
//                                           ),
//                                           width: 302,
//                                           height: 230,
//                                           child: Column(
//                                             children: [
//                                               Container(
//                                                 height: 35,
//                                                 width: double.infinity,
//                                                 decoration: const BoxDecoration(
//                                                   color: Color(0xff1696C8),
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12.0),
//                                                     topRight: Radius.circular(12.0),
//                                                   ),
//                                                 ),
//                                                 padding: EdgeInsets.only(right: 5,bottom: 5),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.end,
//                                                   children: [
//                                                     IconButton(
//                                                       icon: const Icon(Icons.close,
//                                                           color: Colors.white),
//                                                       onPressed: () {
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     vertical: 15.0, horizontal: 16.0),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   children: [
//                                                     dropdownValue == 'Salaried' ?  Text(
//                                                       'Salary',
//                                                       style: GoogleFonts.firaSans(
//                                                           fontSize: 14.0,
//                                                           fontWeight: FontWeightManager.medium,
//                                                           color: ColorManager.mediumgrey),
//                                                     ) : Text(
//                                                       'Per Visit',
//                                                       style: GoogleFonts.firaSans(
//                                                           fontSize: 14.0,
//                                                           fontWeight: FontWeightManager.medium,
//                                                           color: ColorManager.mediumgrey),
//                                                     ),
//                                                     SizedBox(
//                                                       height: MediaQuery.of(context)
//                                                           .size
//                                                           .height /
//                                                           30,
//                                                     ),
//                                                     Container(
//                                                       height: 30,
//                                                       child: TextFormField(
//                                                         cursorColor: Colors.black,
//                                                         style: GoogleFonts.firaSans(
//                                                           fontSize: 12,
//                                                           fontWeight: FontWeightManager.medium,
//                                                           color: ColorManager.mediumgrey,),
//                                                         decoration: InputDecoration(
//                                                           prefix:Text("\$ "),
//                                                           hintText: '0.00',
//                                                           hintStyle: GoogleFonts.firaSans(
//                                                               fontSize: 12,
//                                                               fontWeight: FontWeight.w700,
//                                                               color: const Color(
//                                                                   0xff686464)),
//                                                           enabledBorder:
//                                                           OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 8.0),
//                                                             borderSide: const BorderSide(
//                                                               color: Color(0xff51B5E6),
//                                                               width: 1.0,
//                                                             ),
//                                                           ),
//                                                           focusedBorder:
//                                                           OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 8.0),
//                                                             borderSide: const BorderSide(
//                                                               color: Color(0xff51B5E6),
//                                                               width: 1.0,
//                                                             ),
//                                                           ),
//                                                           border: OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 8.0),
//                                                             borderSide: const BorderSide(
//                                                               color: Color(0xff51B5E6),
//                                                               width: 1.0,
//                                                             ),
//                                                           ),
//                                                           contentPadding:
//                                                           const EdgeInsets.symmetric(
//                                                               horizontal: 16.0,
//                                                               vertical: 12.0),
//                                                         ),
//                                                         keyboardType:
//                                                         TextInputType.number,
//                                                         onChanged: (value) {
//                                                           setState((){
//                                                             _salary = value;
//                                                           });
//                                                           print("Salary:: ${_salary}");
//                                                         },
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                         height: MediaQuery.of(context)
//                                                             .size
//                                                             .height /
//                                                             20),
//                                                     Center(
//                                                       child: ElevatedButton(
//                                                         onPressed: () {
//                                                           // Handle the submit action
//                                                           Navigator.of(context).pop();
//                                                         },
//                                                         style: ElevatedButton.styleFrom(
//                                                           backgroundColor:
//                                                           const Color(0xff1696C8),
//                                                           shape: RoundedRectangleBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 12),
//                                                           ),
//                                                         ),
//                                                         child: Padding(
//                                                           padding: const EdgeInsets
//                                                               .symmetric(
//                                                               horizontal: 24.0,
//                                                               vertical: 8.0),
//                                                           child: Text(
//                                                             'Submit',
//                                                             style: GoogleFonts.firaSans(
//                                                                 fontSize: 12.0,
//                                                                 fontWeight:
//                                                                 FontWeight.w700,
//                                                                 color: Colors.white),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color(0xff1696C8),
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 child: dropdownValue == 'Salaried' ? Text(
//                                   'Add',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 12.0,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ) : Text(
//                                   'Add Visit',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 12.0,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 )
//                             ),
//                             SizedBox(width: 15),
//                             ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xff1696C8),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Add New Coverage',
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 10.0,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 10),
//               ///buttons
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ///back button
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: const Color(0xff1696C8),
//                       side: const BorderSide(color: Color(0xff1696C8)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Back',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12.0,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width / 75),
//                   ///enroll button
//                   ElevatedButton(
//                     onPressed: ()  {
//                       // await _generateUrlLink(widget.email, widget.userId.toString());
//
//
//                       // print("Widget employeeId ${widget.apiData!.employeeId!}");
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return ConfirmationPopup(
//                             // loadingDuration: _isLoading,
//                             onCancel: () {
//                               Navigator.pop(context);
//                             },
//                             onConfirm: ()  async{
//                               // setState(() {
//                               //   _isLoading = true;
//                               // });
//                               print('selected county id : ${selectedCountyId}');
//                               print('selected zone id : ${selectedZoneId}');
//                               print('selected zipCode : ${selectedZipCodes}');
//                               print('selected city : ${selectedCityName}');
//                               print('Salari ${_salary}');
//                               print('Salari Type ${dropdownValue}');
//                               print('PatianCount ${patientsController.text}');
//                               try {
//                                 var empEnrollOfferResponse = await addEmpEnrollOffers(
//                                   context,
//                                   0,
//                                   widget.apiData!.employeeId!,
//                                   int.parse(patientsController.text),
//                                   issueDateController.text,
//                                   lastDateController.text,
//                                   startDateController.text,
//                                   verbalAcceptanceController.text,
//                                 );
//                                 print('County id : ${selectedCountyId}');
//                                 print('Zone id : ${selectedZoneId}');
//                                 await addEmpEnrollAddCoverage(
//                                   context,
//                                   0,
//                                   widget.apiData!.employeeId!,
//                                   selectedCityString,
//                                   selectedCountyId,
//                                   selectedZoneId,
//                                 );
//
//                                 await addEmpEnrollAddCompensation(
//                                   context,
//                                   0,
//                                   widget.apiData!.employeeId!,
//                                   dropdownValue.toString(),
//                                   int.parse(_salary),
//                                 );
//                                 // Clear controllers
//                                 issueDateController.clear();
//                                 lastDateController.clear();
//                                 startDateController.clear();
//                                 verbalAcceptanceController.clear();
//
//                                 if(empEnrollOfferResponse.statusCode == 200 || empEnrollOfferResponse.statusCode == 201){
//                                   Navigator.pop(context);
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       Future.delayed(Duration(seconds: 2), () {
//                                         if (Navigator.of(context).canPop()) {
//                                           Navigator.of(context).pop();
//                                           popNavigation();
//                                         }
//                                       });
//                                       return AddSuccessPopup(message: 'Employee Enrolled Successfully',);
//                                     },
//                                   );
//                                 }
//                               } catch (e) {
//                                 print("Error during enrollment: $e");
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('Enrollment failed: $e')),
//                                 );
//                               } finally {
//                                 // setState(() {
//                                 //   _isLoading = false;
//                                 // });
//                               }
//                             },
//                             title: 'Confirm Enrollment',
//                             containerText: 'Do you really want to enroll?',
//                           );
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff1696C8),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Enroll',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12.0,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   // ElevatedButton(
//                   //   onPressed: () async {
//                   //     await _generateUrlLink(
//                   //         widget.email, widget.userId.toString());
//                   //     Navigator.pop(context);
//                   //     showDialog(
//                   //       context: context,
//                   //       builder: (BuildContext context) {
//                   //         return ConfirmationPopup(
//                   //           onCancel: () {
//                   //             Navigator.pop(context);
//                   //           },
//                   //           onConfirm: () async {
//                   //             await addEmpEnroll(
//                   //                 context: context,
//                   //                 employeeId: widget.employeeId,
//                   //                 code: "",
//                   //                 userId: widget.userId,
//                   //                 firstName: widget.firstName,
//                   //                 lastName: widget.lastName,
//                   //                 phoneNbr: widget.phone,
//                   //                 email: widget.email,
//                   //                 link: generatedURL,
//                   //                 status: widget.status,
//                   //                 departmentId: 1,
//                   //                 position: widget.position,
//                   //                 speciality: widget.soecalityName,
//                   //                 clinicianTypeId: 1,
//                   //                 reportingOfficeId: widget.reportingOffice,
//                   //                 cityId: 1,
//                   //                 countryId: 1,
//                   //                 countyId: 9,
//                   //                 zoneId: 18,
//                   //                 employment: widget.employement,
//                   //                 service: widget.services);
//                   //             Navigator.pop(context);
//                   //           },
//                   //           title: 'Confirm Enrollment',
//                   //           containerText: 'Do you really want to enroll?',
//                   //         );
//                   //       },
//                   //     );
//                   //   },
//                   //   style: ElevatedButton.styleFrom(
//                   //     backgroundColor: const Color(0xff1696C8),
//                   //     foregroundColor: Colors.white,
//                   //     shape: RoundedRectangleBorder(
//                   //       borderRadius: BorderRadius.circular(8),
//                   //     ),
//                   //   ),
//                   //   child: Text(
//                   //     'Enroll',
//                   //     style: GoogleFonts.firaSans(
//                   //       fontSize: 12.0,
//                   //       fontWeight: FontWeight.w700,
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CheckBoxTileConst extends StatelessWidget {
//   final String text;
//   bool value;
//   ValueChanged<bool?> onChanged;
//   CheckBoxTileConst({super.key, required this.text,required this.value,required this.onChanged});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 40,
//       height: 50,
//       child: CheckboxListTile(
//         title: Text(text,style:
//         GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),),
//         value: value,
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
//
//

///container generate
// import 'dart:async';
// import 'dart:ui';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
// import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
// import 'package:app_links/app_links.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
// import 'package:prohealth/data/api_data/api_data.dart';
// import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
// import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
// import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/confirmation_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/widgets/offer_letter_constant.dart';
// import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
// class OfferLetterScreen extends StatefulWidget {
//   final String email;
//   final int userId;
//   final String role;
//   final String status;
//   final String firstName;
//   final String lastName;
//   final String position;
//   final String phone;
//   final String reportingOffice;
//   final String services;
//   final String employement;
//   final String soecalityName;
//   final String clinicalName;
//   final int employeeId;
//   final ApiData? apiData;
//
//   const OfferLetterScreen(
//       {super.key,
//         required this.email,
//         required this.userId,
//         required this.role,
//         required this.status,
//         required this.firstName,
//         required this.lastName,
//         required this.position,
//         required this.phone,
//         required this.reportingOffice,
//         required this.services,
//         required this.employement,
//         required this.soecalityName,
//         required this.clinicalName,
//         required this.employeeId,
//         this.apiData
//       });
//
//   @override
//   State<OfferLetterScreen> createState() => _OfferLetterScreenState();
// }
//
// class _OfferLetterScreenState extends State<OfferLetterScreen> {
//   TextEditingController issueDateController = TextEditingController();
//   TextEditingController lastDateController = TextEditingController();
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController verbalAcceptanceController = TextEditingController();
//   TextEditingController patientsController = TextEditingController();
//   final StreamController<List<ZipcodeByCountyIdData>> _countyStreamController = StreamController<List<ZipcodeByCountyIdData>>.broadcast();
//
//   String selectedDropdownValue = 'Per day';
//   String dropdownValue = 'Salaried';
//   late List<Map<String, dynamic>> checkboxStates;
//   late List<Map<String, dynamic>> checkboxStatesCity;
//
//   String _salary = "";
//   String generatedURL = '';
//
//   final List<Map<String, String>> data = [
//     {'zipCode': '10001', 'city': 'New York'},
//     {'zipCode': '20001', 'city': 'Washington, D.C.'},
//     {'zipCode': '30301', 'city': 'Atlanta'},
//     {'zipCode': '94101', 'city': 'San Francisco'},
//     // Add more data as needed
//   ];
//
//   final PageController _pageController = PageController();
//   int _currentPageIndex = 0;
//
//   void _goToPage(int pageIndex) {
//     _pageController.animateToPage(
//       pageIndex,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   void popNavigation(){
//     setState((){
//       Navigator.pop(context);
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     _initAppLinks();
//     _pageController.addListener(() {
//       setState(() {
//         _currentPageIndex = _pageController.page!.toInt();
//       });
//     });
//   }
//
//   // void handleDropdownChange(String? newValue) {
//   //   setState(() {
//   //     dropdownValue = newValue ?? 'Salaried';
//   //   });
//   // }
//
//   List<Widget> _buildCheckboxes() {
//     return checkboxStates.map((data) {
//       return CheckboxListTile(
//         title: Text(
//           data['title'],
//           style:
//           GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),
//         ),
//         value: data['value'],
//         onChanged: (bool? value) {
//           setState(() {
//             data['value'] = value ?? false;
//           });
//         },
//       );
//     }).toList();
//   }
//
//   List<Widget> _buildCheckboxesCity() {
//     return checkboxStatesCity.map((data) {
//       return CheckboxListTile(
//         title: Text(
//           data['title'],
//           style:
//           GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),
//         ),
//         value: data['value'],
//         onChanged: (bool? value) {
//           setState(() {
//             data['value'] = value ?? false;
//           });
//         },
//       );
//     }).toList();
//   }
//
//   AppLinks? _appLinks;
//
//   void _initAppLinks() async {
//     _appLinks = AppLinks();
//   }
//   Future<String> _generateUrlLink(String email, String Id) async {
//     final String user = email;
//     final String id = Id;
//     final String url = 'https://staging.symmetry.care/$id';
//     generatedURL = url;
//     print('Generated URL: $generatedURL');
//     return url;
//   }
//   int selectedZoneId = 0;
//   int selectedCountyId = 0;
//   int selectedCityId = 0;
//   String? selectedCounty;
//   // int? selectedCountyId;
//   bool _isLoading = false;
//   Map<String, bool> checkedZipCodes = {};
//   Map<String, bool> checkedCityName = {};
//   List<String> selectedZipCodes = [];
//   List<String> selectedCityName = [];
//   String selectedZipCodesString = '';
//   String selectedCityString = '';
//   List<DropdownMenuItem<String>> dropDownList = [];
//   int countyId = 0;
//   List<int> containerList = [0];
//   void _addNewCoverageContainer() {
//     setState(() {
//       containerList.add(containerList.length); // Add new container
//       // Optional: Reset dropdown data or other fields for new containers
//       getCountyZoneList(context); // Example API call (adjust if needed)
//       selectedCounty = null;
//       selectedCountyId = 0;
//       dropDownList.clear(); // Clear old dropdown data
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Offer Letter',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xff1696C8),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTextFieldOfferScreen(
//                       height: 36,
//                       controller: issueDateController,
//                       labelText: 'Issue Date'),
//                   //SizedBox(width: MediaQuery.of(context).size.width / 80),
//                   CustomTextFieldOfferScreen(
//                     height: 36,
//                     controller: lastDateController,
//                     labelText: 'Last Date',
//                   ),
//                   // SizedBox(width: MediaQuery.of(context).size.width / 80),
//                   CustomTextFieldOfferScreen(
//                     height: 36,
//                     controller: startDateController,
//                     labelText: 'Anticipated Start Date',
//                   )
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 60),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTextFieldOfferScreen(
//                     height: 36,
//                     controller: verbalAcceptanceController,
//                     labelText: 'Verbal Acceptance',
//                   ),
//                   //SizedBox(width: MediaQuery.of(context).size.width / 80),
//
//                   Container(
//                     height: 30,
//                     width: MediaQuery.of(context).size.width / 5,
//                     child: StatefulBuilder(
//                       builder: (BuildContext context, void Function(void Function()) setState) {
//                         return TextField(
//                           cursorColor: Colors.black,
//                           controller: patientsController,
//                           decoration: InputDecoration(
//                             border: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//                             ),
//                             focusedBorder: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             labelText: 'No. of Patients',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: 10.0,
//                               fontWeight: FontWeight.w400,
//                               color: const Color(0xff575757),
//                             ),
//                             suffixIcon: DropdownButton<String>(
//                               value: selectedDropdownValue,
//                               items: ['Per day', 'Per week', 'Per month']
//                                   .map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12.0),
//                                     child: Text(
//                                       value,
//                                       style: const TextStyle(fontSize: 10.0),
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                               onChanged: (String? value) {
//                                 if (value != null) {
//                                   setState(() {
//                                     selectedDropdownValue = value;
//                                   });
//                                 }
//                               },
//                               underline: const SizedBox(),
//                               icon: const Icon(Icons.arrow_drop_down,
//                                   color: Colors.blue),
//                             ),
//                             contentPadding:
//                             const EdgeInsets.only(left: 20, bottom: 5),
//                           ),
//                           style: GoogleFonts.firaSans(
//                               fontSize: 10.0,
//                               fontWeight: FontWeight.w400,
//                               color: const Color(0xff575757)),
//                         );
//                       },
//                     ),
//                   ),
//                   //SizedBox(width: MediaQuery.of(context).size.width / 10),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width / 5,
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 50),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 100),
//                 child: Divider(
//                   color: ColorManager.cream,
//                   thickness: 4,
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 40),
//               ///blue container
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 100),
//                 child:  ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: containerList.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
//                       child: _buildBlueContainer(index), // Pass index if you need to differentiate
//                     );
//                   },
//                 ),
//                 // Container(
//                 //   width: double.infinity, //1030
//                 //   height: 330, //MediaQuery.of(context).size.height / 2,
//                 //   decoration: BoxDecoration(
//                 //     border: Border.all(color: const Color(0xff1696C8)),
//                 //     borderRadius: BorderRadius.circular(12.0),
//                 //   ),
//                 //   child: Padding(
//                 //     padding: const EdgeInsets.all(16.0),
//                 //     child: Row(
//                 //       children: [
//                 //         Expanded(
//                 //           child: SingleChildScrollView(
//                 //             child: Column(
//                 //               children: [
//                 //                 ///county
//                 //               Column(
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: [
//                 //                 Text(
//                 //                   'County',
//                 //                   style: GoogleFonts.firaSans(
//                 //                     fontSize: 12,
//                 //                     fontWeight: FontWeight.w600,
//                 //                     color: ColorManager.mediumgrey,
//                 //                   ),
//                 //                 ),
//                 //                 SizedBox(height: 5),
//                 //                    FutureBuilder<List<AllCountyGetList>>(
//                 //       future: getCountyZoneList(context),
//                 //       builder: (context, snapshot) {
//                 //         if (snapshot.connectionState == ConnectionState.waiting) {
//                 //           return Padding(
//                 //             padding: const EdgeInsets.symmetric(horizontal: 7),
//                 //             child: Container(
//                 //               height: 31,
//                 //               width: 250,
//                 //               decoration: BoxDecoration(color: ColorManager.white),
//                 //             ),
//                 //           );
//                 //         } else if (snapshot.hasError) {
//                 //           return const CustomDropdownTextField(
//                 //             hintText: 'Select County',
//                 //             labelText: 'County',
//                 //             labelStyle: TextStyle(
//                 //               fontSize: 12,
//                 //               color: Color(0xff575757),
//                 //               fontWeight: FontWeight.w400,
//                 //             ),
//                 //             labelFontSize: 12,
//                 //             items: ['Error'],
//                 //           );
//                 //         } else if (snapshot.hasData) {
//                 //           // Clear dropdown list to avoid duplicates
//                 //           dropDownList.clear();
//                 //
//                 //           // Add the default "Select" item
//                 //           dropDownList.add(DropdownMenuItem<String>(
//                 //             child: Text('Select County'),
//                 //             value: 'Select County',
//                 //           ));
//                 //
//                 //           // Populate dropdown list with counties
//                 //           for (var i in snapshot.data!) {
//                 //             dropDownList.add(DropdownMenuItem<String>(
//                 //               child: Text(i.countyName),
//                 //               value: i.countyName,
//                 //             ));
//                 //           }
//                 //
//                 //           // Set initial selectedCounty if not already set
//                 //           if (selectedCounty == null) {
//                 //             selectedCounty = 'Select County';
//                 //           }
//                 //
//                 //           return StatefulBuilder(
//                 //             builder: (BuildContext context, StateSetter setState) {
//                 //               return Container(
//                 //                 height: 31,
//                 //                 width: 250,
//                 //                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                 //                 decoration: BoxDecoration(
//                 //                   color: Colors.white,
//                 //                   border: Border.all(color: const Color(0xff686464).withOpacity(0.5), width: 1),
//                 //                   borderRadius: BorderRadius.circular(6),
//                 //                 ),
//                 //                 child: DropdownButtonFormField<String>(
//                 //                   focusColor: Colors.transparent,
//                 //                   icon: const Icon(
//                 //                     Icons.arrow_drop_down_sharp,
//                 //                     color: Color(0xff686464),
//                 //                   ),
//                 //                   decoration: const InputDecoration.collapsed(hintText: ''),
//                 //                   items: dropDownList,
//                 //                   onChanged: (newValue) {
//                 //                     setState(() {
//                 //                       selectedCounty = newValue;
//                 //                       for (var a in snapshot.data!) {
//                 //                         if (a.countyName == newValue) {
//                 //                           selectedCountyId = a.countyId;
//                 //                           print("County Id :: ${selectedCountyId}");
//                 //                           // Perform other actions if needed
//                 //                         }
//                 //                       }
//                 //                     });
//                 //                   },
//                 //                   value: selectedCounty,
//                 //                   style: GoogleFonts.firaSans(
//                 //                     fontSize: 12,
//                 //                     fontWeight: FontWeight.w600,
//                 //                     color: const Color(0xff686464),
//                 //                     decoration: TextDecoration.none,
//                 //                   ),
//                 //                 ),
//                 //               );
//                 //             },
//                 //           );
//                 //         } else {
//                 //           return CustomDropdownTextField(
//                 //             labelText: 'County',
//                 //             labelStyle: GoogleFonts.firaSans(
//                 //               fontSize: 12,
//                 //               color: const Color(0xff575757),
//                 //               fontWeight: FontWeight.w400,
//                 //             ),
//                 //             labelFontSize: 12,
//                 //             items: ['No Data'],
//                 //           );
//                 //         }
//                 //       },
//                 //     ),
//                 //     ],
//                 //             ),
//                 //                 SizedBox(height: MediaQuery.of(context).size.height / 20),
//                 //
//                 //                 ///zone api
//                 //                 Column(
//                 //                   crossAxisAlignment: CrossAxisAlignment.start,
//                 //                   children: [
//                 //                     Text('Zone',style: GoogleFonts.firaSans(
//                 //                       fontSize: 12,
//                 //                       fontWeight: FontWeight.w600,
//                 //                       color: ColorManager.mediumgrey,
//                 //                     ),),
//                 //                     SizedBox(height:5),
//                 //                            FutureBuilder<List<SortByZoneData>>(
//                 //       future: PayRateZoneDropdown(context),
//                 //       builder: (context, snapshot) {
//                 //         if (snapshot.connectionState == ConnectionState.waiting) {
//                 //           return Padding(
//                 //             padding: const EdgeInsets.symmetric(horizontal: 7),
//                 //             child: Container(
//                 //               height: 31,
//                 //               width: 250,
//                 //               decoration: BoxDecoration(color: ColorManager.white),
//                 //             ),
//                 //           );
//                 //         } else if (snapshot.hasError) {
//                 //           return const CustomDropdownTextField(
//                 //             labelText: 'Zone',
//                 //             labelStyle: TextStyle(
//                 //               fontSize: 12,
//                 //               color: Color(0xff575757),
//                 //               fontWeight: FontWeight.w400,
//                 //             ),
//                 //             labelFontSize: 12,
//                 //             items: ['Error'],
//                 //           );
//                 //         } else if (snapshot.hasData) {
//                 //           List<DropdownMenuItem<String>> dropDownList = [];
//                 //
//                 //           // Add the default "Select" item
//                 //           dropDownList.add(DropdownMenuItem<String>(
//                 //             child: Text('Select Zone'),
//                 //             value: 'Select Zone',
//                 //           ));
//                 //
//                 //           // Populate dropdown list with zones
//                 //           for (var i in snapshot.data!) {
//                 //             dropDownList.add(DropdownMenuItem<String>(
//                 //               child: Text(i.zoneName),
//                 //               value: i.zoneName,
//                 //             ));
//                 //           }
//                 //
//                 //           // Set initial selectedZone if not already set
//                 //           String? selectedZone = 'Select Zone';
//                 //
//                 //           return StatefulBuilder(
//                 //             builder: (BuildContext context, StateSetter setState) {
//                 //               return Container(
//                 //                 height: 31,
//                 //                 width: 250,
//                 //                 padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                 //                 decoration: BoxDecoration(
//                 //                   color: Colors.white,
//                 //                   border: Border.all(color: const Color(0xff686464).withOpacity(0.5), width: 1),
//                 //                   borderRadius: BorderRadius.circular(6),
//                 //                 ),
//                 //                 child: DropdownButtonFormField<String>(
//                 //                   focusColor: Colors.transparent,
//                 //                   icon: const Icon(
//                 //                     Icons.arrow_drop_down_sharp,
//                 //                     color: Color(0xff686464),
//                 //                   ),
//                 //                   decoration: const InputDecoration.collapsed(hintText: ''),
//                 //                   items: dropDownList,
//                 //                   onChanged: (newValue) {
//                 //                     setState(() {
//                 //                       selectedZone = newValue;
//                 //                       for (var a in snapshot.data!) {
//                 //                         if (a.zoneName == newValue) {
//                 //                           int zoneId = a.zoneId;
//                 //                           selectedZoneId = zoneId;
//                 //                           print("Zone Id :: ${selectedZoneId}");
//                 //                           // Perform other actions if needed
//                 //                         }
//                 //                       }
//                 //                     });
//                 //                   },
//                 //                   value: selectedZone,
//                 //                   style: GoogleFonts.firaSans(
//                 //                     fontSize: 12,
//                 //                     fontWeight: FontWeight.w600,
//                 //                     color: const Color(0xff686464),
//                 //                     decoration: TextDecoration.none,
//                 //                   ),
//                 //                 ),
//                 //               );
//                 //             },
//                 //           );
//                 //         } else {
//                 //           return CustomDropdownTextField(
//                 //             labelText: 'Zone',
//                 //             labelStyle: GoogleFonts.firaSans(
//                 //               fontSize: 12,
//                 //               color: const Color(0xff575757),
//                 //               fontWeight: FontWeight.w400,
//                 //             ),
//                 //             labelFontSize: 12,
//                 //             items: ['No Data'],
//                 //           );
//                 //         }
//                 //       },
//                 //     ),
//                 //     ],
//                 //                 )
//                 //               ],
//                 //             ),
//                 //           ),
//                 //         ),
//                 //         ///old code tabbar
//                 //         Expanded(
//                 //           child: DefaultTabController(
//                 //             length: 2,
//                 //             child: Column(
//                 //               children: [
//                 //                 Padding(
//                 //                   padding: const EdgeInsets.only(
//                 //                       left: 180.0, right: 180.0),
//                 //                   child: TabBar(
//                 //                     indicatorColor: const Color(0xff1696C8),
//                 //                     labelColor: const Color(0xff686464),
//                 //                     unselectedLabelColor: const Color(0xff686464),
//                 //                     labelStyle: GoogleFonts.firaSans(
//                 //                       fontSize: 10,
//                 //                       fontWeight: FontWeight.w500,
//                 //                     ),
//                 //                     unselectedLabelStyle: GoogleFonts.firaSans(
//                 //                       fontSize: 10,
//                 //                       fontWeight: FontWeight.w500,
//                 //                     ),
//                 //                     tabs: const [
//                 //                       Tab(text: 'Zip Codes'),
//                 //                      // Tab(text: 'Cities'),
//                 //                     ],
//                 //                   ),
//                 //                 ),
//                 //                 Expanded(
//                 //                   child: Padding(
//                 //                     padding: const EdgeInsets.only(
//                 //                         left: 100.0, right: 100.0),
//                 //                     child: TabBarView(
//                 //                       physics:
//                 //                       const NeverScrollableScrollPhysics(),
//                 //                       children: [
//                 //                         StreamBuilder<List<ZipcodeByCountyIdData>>(
//                 //                           stream: _countyStreamController.stream,
//                 //                           builder: (BuildContext context,snapshot) {
//                 //                             getZipcodeByCountyId(context: context, countyId:selectedCountyId).then((data) {
//                 //                               _countyStreamController.add(data);
//                 //                             }).catchError((error) {
//                 //                               // Handle error
//                 //                             });
//                 //                             if(snapshot.connectionState == ConnectionState.waiting){
//                 //                               return SizedBox();
//                 //                             }
//                 //                             if(selectedCountyId == 0){
//                 //                               return Center(child: Text('Select county',style:
//                 //                               GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),));
//                 //                             }
//                 //                             if(snapshot.data!.isEmpty){
//                 //                               return Center(child: Text('No Data Found!',style:
//                 //                               GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),));
//                 //                             }
//                 //                             return Row(
//                 //                               children: [
//                 //                                 StatefulBuilder(
//                 //                                   builder: (BuildContext context, void Function(void Function()) setState) {
//                 //                                     return Container(
//                 //                                       width:200,
//                 //                                       height:300,
//                 //                                       child: ListView.builder(
//                 //                                         itemCount: snapshot.data!.length,
//                 //                                         itemBuilder: (BuildContext context, int index) {
//                 //                                           String zipCode = snapshot.data![index].zipCode;
//                 //                                           bool isChecked = checkedZipCodes[zipCode] ?? false;
//                 //                                           return  CheckBoxTileConst(text: zipCode, value: isChecked, onChanged: (bool? val) {setState(() {
//                 //                                             print('Clicked check box 1');
//                 //                                             checkedZipCodes[zipCode] = val ?? false;
//                 //                                             if (val == true) {
//                 //                                               selectedZipCodes.add(zipCode);
//                 //                                             } else {
//                 //                                               selectedZipCodes.remove(zipCode);
//                 //                                             }
//                 //                                             // Update the string representation
//                 //                                             selectedZipCodesString = selectedZipCodes.join(', ');
//                 //                                           });  });
//                 //                                         },
//                 //                                       ),
//                 //                                     );
//                 //                                   },
//                 //                                 ),
//                 //                                 // Expanded(
//                 //                                 //   child: ListView(
//                 //                                 //     children: _buildCheckboxes()
//                 //                                 //         .sublist(5, 10),
//                 //                                 //   ),
//                 //                                 // ),
//                 //                               ],
//                 //                             );
//                 //                           },
//                 //
//                 //                         ),
//                 //                         // Tab 2 content: Cities
//                 //                         // StreamBuilder<List<ZipcodeByCountyIdData>>(
//                 //                         //   stream: _countyStreamController.stream,
//                 //                         //   builder: (BuildContext context,snapshot) {
//                 //                         //     getZipcodeByCountyId(context: context, countyId:selectedCountyId).then((data) {
//                 //                         //       _countyStreamController.add(data);
//                 //                         //     }).catchError((error) {
//                 //                         //       // Handle error
//                 //                         //     });
//                 //                         //     if(snapshot.connectionState == ConnectionState.waiting){
//                 //                         //       return SizedBox();
//                 //                         //     }
//                 //                         //     if(selectedCountyId == 0){
//                 //                         //       return Center(child: Text('Select county',style:
//                 //                         //       GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),));
//                 //                         //     }
//                 //                         //     if(snapshot.data!.isEmpty){
//                 //                         //       return Center(child: Text('No Data Found!',style:
//                 //                         //       GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),));
//                 //                         //     }
//                 //                         //     return Row(
//                 //                         //       children: [
//                 //                         //         StatefulBuilder(
//                 //                         //           builder: (BuildContext context, void Function(void Function()) setState) {
//                 //                         //             return Container(
//                 //                         //               width:200,
//                 //                         //               height:300,
//                 //                         //               child: ListView.builder(
//                 //                         //                 itemCount: snapshot.data!.length,
//                 //                         //                 itemBuilder: (BuildContext context, int index) {
//                 //                         //                   String cityName = snapshot.data![index].city;
//                 //                         //                   bool isChecked = checkedCityName[cityName] ?? false;
//                 //                         //                   return  CheckBoxTileConst(text: cityName, value: isChecked, onChanged: (bool? val) {setState(() {
//                 //                         //                     print('Clicked');
//                 //                         //                     checkedCityName[cityName] = val ?? false;
//                 //                         //                     if (val == true) {
//                 //                         //                       selectedCityName.add(cityName);
//                 //                         //                     } else {
//                 //                         //                       selectedCityName.remove(cityName);
//                 //                         //                     }
//                 //                         //                     // Update the string representation
//                 //                         //                     selectedCityString = selectedCityName.join(', ');
//                 //                         //                     print(selectedCityString);
//                 //                         //                   });  });
//                 //                         //                 },
//                 //                         //               ),
//                 //                         //             );
//                 //                         //           },
//                 //                         //         ),
//                 //                         //         // Expanded(
//                 //                         //         //   child: ListView(
//                 //                         //         //     children: _buildCheckboxes()
//                 //                         //         //         .sublist(5, 10),
//                 //                         //         //   ),
//                 //                         //         // ),
//                 //                         //       ],
//                 //                         //     );
//                 //                         //   },
//                 //                         //
//                 //                         // ),
//                 //                       ],
//                 //                     ),
//                 //                   ),
//                 //                 ),
//                 //               ],
//                 //             ),
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 40),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 100),
//                 child: StatefulBuilder(
//
//                   builder: (BuildContext context, void Function(void Function()) setState) {
//                     return  Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           height: 30,
//                           width: 300,
//                           child: CustomDropdownFormField(
//                               hintText: 'Salaried',
//                               items: ['Salaried', 'Per Visit'],
//                               value: dropdownValue,
//                               onChanged: (newValue){
//                                 setState(() {
//                                   dropdownValue = newValue! ?? 'Salaried';
//                                   print('dropDownValue ${dropdownValue}');
//                                 });
//                               }),
//                         ),
//                         Row(
//                           children: [
//                             if (_salary.isNotEmpty)
//                               Text(
//                                 "\$ ${_salary}",
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             ElevatedButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(12.0),
//                                         ),
//                                         titlePadding: EdgeInsets.zero,
//                                         title: Container(
//                                           decoration: const BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(12),
//                                               bottomLeft: Radius.circular(12),
//                                               bottomRight: Radius.circular(12),
//                                               topRight: Radius.circular(12),
//                                             ),
//                                           ),
//                                           width: 302,
//                                           height: 230,
//                                           child: Column(
//                                             children: [
//                                               Container(
//                                                 height: 35,
//                                                 width: double.infinity,
//                                                 decoration: const BoxDecoration(
//                                                   color: Color(0xff1696C8),
//                                                   borderRadius: BorderRadius.only(
//                                                     topLeft: Radius.circular(12.0),
//                                                     topRight: Radius.circular(12.0),
//                                                   ),
//                                                 ),
//                                                 padding: EdgeInsets.only(right: 5,bottom: 5),
//                                                 child: Row(
//                                                   mainAxisAlignment: MainAxisAlignment.end,
//                                                   children: [
//                                                     IconButton(
//                                                       icon: const Icon(Icons.close,
//                                                           color: Colors.white),
//                                                       onPressed: () {
//                                                         Navigator.of(context).pop();
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     vertical: 15.0, horizontal: 16.0),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                                   children: [
//                                                     dropdownValue == 'Salaried' ?  Text(
//                                                       'Salary',
//                                                       style: GoogleFonts.firaSans(
//                                                           fontSize: 14.0,
//                                                           fontWeight: FontWeightManager.medium,
//                                                           color: ColorManager.mediumgrey),
//                                                     ) : Text(
//                                                       'Per Visit',
//                                                       style: GoogleFonts.firaSans(
//                                                           fontSize: 14.0,
//                                                           fontWeight: FontWeightManager.medium,
//                                                           color: ColorManager.mediumgrey),
//                                                     ),
//                                                     SizedBox(
//                                                       height: MediaQuery.of(context)
//                                                           .size
//                                                           .height /
//                                                           30,
//                                                     ),
//                                                     Container(
//                                                       height: 30,
//                                                       child: TextFormField(
//                                                         cursorColor: Colors.black,
//                                                         style: GoogleFonts.firaSans(
//                                                           fontSize: 12,
//                                                           fontWeight: FontWeightManager.medium,
//                                                           color: ColorManager.mediumgrey,),
//                                                         decoration: InputDecoration(
//                                                           prefix:Text("\$ "),
//                                                           hintText: '0.00',
//                                                           hintStyle: GoogleFonts.firaSans(
//                                                               fontSize: 12,
//                                                               fontWeight: FontWeight.w700,
//                                                               color: const Color(
//                                                                   0xff686464)),
//                                                           enabledBorder:
//                                                           OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 8.0),
//                                                             borderSide: const BorderSide(
//                                                               color: Color(0xff51B5E6),
//                                                               width: 1.0,
//                                                             ),
//                                                           ),
//                                                           focusedBorder:
//                                                           OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 8.0),
//                                                             borderSide: const BorderSide(
//                                                               color: Color(0xff51B5E6),
//                                                               width: 1.0,
//                                                             ),
//                                                           ),
//                                                           border: OutlineInputBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 8.0),
//                                                             borderSide: const BorderSide(
//                                                               color: Color(0xff51B5E6),
//                                                               width: 1.0,
//                                                             ),
//                                                           ),
//                                                           contentPadding:
//                                                           const EdgeInsets.symmetric(
//                                                               horizontal: 16.0,
//                                                               vertical: 12.0),
//                                                         ),
//                                                         keyboardType:
//                                                         TextInputType.number,
//                                                         onChanged: (value) {
//                                                           setState((){
//                                                             _salary = value;
//                                                           });
//                                                           print("Salary:: ${_salary}");
//                                                         },
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                         height: MediaQuery.of(context)
//                                                             .size
//                                                             .height /
//                                                             20),
//                                                     Center(
//                                                       child: ElevatedButton(
//                                                         onPressed: () {
//                                                           // Handle the submit action
//                                                           Navigator.of(context).pop();
//                                                         },
//                                                         style: ElevatedButton.styleFrom(
//                                                           backgroundColor:
//                                                           const Color(0xff1696C8),
//                                                           shape: RoundedRectangleBorder(
//                                                             borderRadius:
//                                                             BorderRadius.circular(
//                                                                 12),
//                                                           ),
//                                                         ),
//                                                         child: Padding(
//                                                           padding: const EdgeInsets
//                                                               .symmetric(
//                                                               horizontal: 24.0,
//                                                               vertical: 8.0),
//                                                           child: Text(
//                                                             'Submit',
//                                                             style: GoogleFonts.firaSans(
//                                                                 fontSize: 12.0,
//                                                                 fontWeight:
//                                                                 FontWeight.w700,
//                                                                 color: Colors.white),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color(0xff1696C8),
//                                   foregroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 child: dropdownValue == 'Salaried' ? Text(
//                                   'Add',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 12.0,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ) : Text(
//                                   'Add Visit',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 12.0,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 )
//                             ),
//                             SizedBox(width: 15),
//                             ElevatedButton(
//                               onPressed: () {
//                                 _addNewCoverageContainer();
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xff1696C8),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Add New Coverage',
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 10.0,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 10),
//               ///buttons
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ///back button
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: const Color(0xff1696C8),
//                       side: const BorderSide(color: Color(0xff1696C8)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Back',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12.0,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width / 75),
//                   ///enroll button
//                   ElevatedButton(
//                     onPressed: ()  {
//                       // await _generateUrlLink(widget.email, widget.userId.toString());
//
//
//                       // print("Widget employeeId ${widget.apiData!.employeeId!}");
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return ConfirmationPopup(
//                             // loadingDuration: _isLoading,
//                             onCancel: () {
//                               Navigator.pop(context);
//                             },
//                             onConfirm: ()  async{
//                               // setState(() {
//                               //   _isLoading = true;
//                               // });
//                               print('selected county id : ${selectedCountyId}');
//                               print('selected zone id : ${selectedZoneId}');
//                               print('selected zipCode : ${selectedZipCodes}');
//                               print('selected city : ${selectedCityName}');
//                               print('Salari ${_salary}');
//                               print('Salari Type ${dropdownValue}');
//                               print('PatianCount ${patientsController.text}');
//                               try {
//                                 var empEnrollOfferResponse = await addEmpEnrollOffers(
//                                   context,
//                                   0,
//                                   widget.apiData!.employeeId!,
//                                   int.parse(patientsController.text),
//                                   issueDateController.text,
//                                   lastDateController.text,
//                                   startDateController.text,
//                                   verbalAcceptanceController.text,
//                                 );
//                                 print('County id : ${selectedCountyId}');
//                                 print('Zone id : ${selectedZoneId}');
//                                 await addEmpEnrollAddCoverage(
//                                   context,
//                                   0,
//                                   widget.apiData!.employeeId!,
//                                   selectedCityString,
//                                   selectedCountyId,
//                                   selectedZoneId,
//                                 );
//
//                                 await addEmpEnrollAddCompensation(
//                                   context,
//                                   0,
//                                   widget.apiData!.employeeId!,
//                                   dropdownValue.toString(),
//                                   int.parse(_salary),
//                                 );
//                                 // Clear controllers
//                                 issueDateController.clear();
//                                 lastDateController.clear();
//                                 startDateController.clear();
//                                 verbalAcceptanceController.clear();
//
//                                 if(empEnrollOfferResponse.statusCode == 200 || empEnrollOfferResponse.statusCode == 201){
//                                   Navigator.pop(context);
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       Future.delayed(Duration(seconds: 2), () {
//                                         if (Navigator.of(context).canPop()) {
//                                           Navigator.of(context).pop();
//                                           popNavigation();
//                                         }
//                                       });
//                                       return AddSuccessPopup(message: 'Employee Enrolled Successfully',);
//                                     },
//                                   );
//                                 }
//                               } catch (e) {
//                                 print("Error during enrollment: $e");
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('Enrollment failed: $e')),
//                                 );
//                               } finally {
//                                 // setState(() {
//                                 //   _isLoading = false;
//                                 // });
//                               }
//                             },
//                             title: 'Confirm Enrollment',
//                             containerText: 'Do you really want to enroll?',
//                           );
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff1696C8),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Enroll',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12.0,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   // ElevatedButton(
//                   //   onPressed: () async {
//                   //     await _generateUrlLink(
//                   //         widget.email, widget.userId.toString());
//                   //     Navigator.pop(context);
//                   //     showDialog(
//                   //       context: context,
//                   //       builder: (BuildContext context) {
//                   //         return ConfirmationPopup(
//                   //           onCancel: () {
//                   //             Navigator.pop(context);
//                   //           },
//                   //           onConfirm: () async {
//                   //             await addEmpEnroll(
//                   //                 context: context,
//                   //                 employeeId: widget.employeeId,
//                   //                 code: "",
//                   //                 userId: widget.userId,
//                   //                 firstName: widget.firstName,
//                   //                 lastName: widget.lastName,
//                   //                 phoneNbr: widget.phone,
//                   //                 email: widget.email,
//                   //                 link: generatedURL,
//                   //                 status: widget.status,
//                   //                 departmentId: 1,
//                   //                 position: widget.position,
//                   //                 speciality: widget.soecalityName,
//                   //                 clinicianTypeId: 1,
//                   //                 reportingOfficeId: widget.reportingOffice,
//                   //                 cityId: 1,
//                   //                 countryId: 1,
//                   //                 countyId: 9,
//                   //                 zoneId: 18,
//                   //                 employment: widget.employement,
//                   //                 service: widget.services);
//                   //             Navigator.pop(context);
//                   //           },
//                   //           title: 'Confirm Enrollment',
//                   //           containerText: 'Do you really want to enroll?',
//                   //         );
//                   //       },
//                   //     );
//                   //   },
//                   //   style: ElevatedButton.styleFrom(
//                   //     backgroundColor: const Color(0xff1696C8),
//                   //     foregroundColor: Colors.white,
//                   //     shape: RoundedRectangleBorder(
//                   //       borderRadius: BorderRadius.circular(8),
//                   //     ),
//                   //   ),
//                   //   child: Text(
//                   //     'Enroll',
//                   //     style: GoogleFonts.firaSans(
//                   //       fontSize: 12.0,
//                   //       fontWeight: FontWeight.w700,
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _buildBlueContainer(int index) {
//     return Container(
//       width: double.infinity,
//       height: 330,
//       decoration: BoxDecoration(
//         border: Border.all(color: const Color(0xff1696C8)),
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     // County Dropdown and other content...
//                     _buildCountyDropdown(),
//                   ],
//                 ),
//               ),
//             ),
//             // Add your existing TabBar logic here...
//             Expanded(
//               child: _buildTabBarSection(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Method for County Dropdown
//   Widget _buildCountyDropdown() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'County',
//           style: GoogleFonts.firaSans(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: ColorManager.mediumgrey,
//           ),
//         ),
//         SizedBox(height: 5),
//         FutureBuilder<List<AllCountyGetList>>(
//           future: getCountyZoneList(context),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 7),
//                 child: Container(
//                   height: 31,
//                   width: 250,
//                   decoration: BoxDecoration(color: ColorManager.white),
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return const CustomDropdownTextField(
//                 hintText: 'Select County',
//                 labelText: 'County',
//                 labelStyle: TextStyle(
//                   fontSize: 12,
//                   color: Color(0xff575757),
//                   fontWeight: FontWeight.w400,
//                 ),
//                 labelFontSize: 12,
//                 items: ['Error'],
//               );
//             } else if (snapshot.hasData) {
//               dropDownList.clear();
//               dropDownList.add(DropdownMenuItem<String>(
//                 child: Text('Select County'),
//                 value: 'Select County',
//               ));
//
//               for (var i in snapshot.data!) {
//                 dropDownList.add(DropdownMenuItem<String>(
//                   child: Text(i.countyName),
//                   value: i.countyName,
//                 ));
//               }
//
//               if (selectedCounty == null) {
//                 selectedCounty = 'Select County';
//               }
//
//               return StatefulBuilder(
//                 builder: (BuildContext context, StateSetter setState) {
//                   return Container(
//                     height: 31,
//                     width: 250,
//                     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(color: const Color(0xff686464).withOpacity(0.5), width: 1),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: DropdownButtonFormField<String>(
//                       focusColor: Colors.transparent,
//                       icon: const Icon(
//                         Icons.arrow_drop_down_sharp,
//                         color: Color(0xff686464),
//                       ),
//                       decoration: const InputDecoration.collapsed(hintText: ''),
//                       items: dropDownList,
//                       onChanged: (newValue) {
//                         setState(() {
//                           selectedCounty = newValue;
//                           for (var a in snapshot.data!) {
//                             if (a.countyName == newValue) {
//                               selectedCountyId = a.countyId;
//                               print("County Id :: ${selectedCountyId}");
//                             }
//                           }
//                         });
//                       },
//                       value: selectedCounty,
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: const Color(0xff686464),
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return CustomDropdownTextField(
//                 labelText: 'County',
//                 labelStyle: GoogleFonts.firaSans(
//                   fontSize: 12,
//                   color: const Color(0xff575757),
//                   fontWeight: FontWeight.w400,
//                 ),
//                 labelFontSize: 12,
//                 items: ['No Data'],
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
//
//   // Method for TabBar Section
//   Widget _buildTabBarSection() {
//     return DefaultTabController(
//       length: 2,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 180.0, right: 180.0),
//             child: TabBar(
//               indicatorColor: const Color(0xff1696C8),
//               labelColor: const Color(0xff686464),
//               unselectedLabelColor: const Color(0xff686464),
//               labelStyle: GoogleFonts.firaSans(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w500,
//               ),
//               unselectedLabelStyle: GoogleFonts.firaSans(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w500,
//               ),
//               tabs: const [
//                 Tab(text: 'Zip Codes'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 100.0, right: 100.0),
//               child: TabBarView(
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   _buildZipCodesContent(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Method for Zip Codes Content
//   Widget _buildZipCodesContent() {
//     return StreamBuilder<List<ZipcodeByCountyIdData>>(
//       stream: _countyStreamController.stream,
//       builder: (context, snapshot) {
//         getZipcodeByCountyId(context: context, countyId:selectedCountyId).then((data) {
//           _countyStreamController.add(data);
//         }).catchError((error) {
//           // Handle error
//         });
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return SizedBox();
//         }
//
//         if (selectedCountyId == 0) {
//           return Center(
//             child: Text(
//               'Select county',
//               style: GoogleFonts.firaSans(
//                 fontSize: 10.0,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           );
//         }
//
//         if (snapshot.data!.isEmpty) {
//           return Center(
//             child: Text(
//               'No Data Found!',
//               style: GoogleFonts.firaSans(
//                 fontSize: 10.0,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           );
//         }
//
//         return Row(
//           children: [
//             StatefulBuilder(
//               builder: (BuildContext context, void Function(void Function()) setState) {
//                 return Container(
//                   width: 200,
//                   height: 300,
//                   child: ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       String zipCode = snapshot.data![index].zipCode;
//                       bool isChecked = checkedZipCodes[zipCode] ?? false;
//                       return CheckBoxTileConst(
//                         text: zipCode,
//                         value: isChecked,
//                         onChanged: (bool? val) {
//                           setState(() {
//                             print('Clicked check box 1');
//                             checkedZipCodes[zipCode] = val ?? false;
//                             if (val == true) {
//                               selectedZipCodes.add(zipCode);
//                             } else {
//                               selectedZipCodes.remove(zipCode);
//                             }
//                             // Update the string representation
//                             selectedZipCodesString = selectedZipCodes.join(', ');
//                           });
//                         },
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class CheckBoxTileConst extends StatelessWidget {
//   final String text;
//   bool value;
//   ValueChanged<bool?> onChanged;
//   CheckBoxTileConst({super.key, required this.text,required this.value,required this.onChanged});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 40,
//       height: 50,
//       child: CheckboxListTile(
//         title: Text(text,style:
//         GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),),
//         value: value,
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
//
//