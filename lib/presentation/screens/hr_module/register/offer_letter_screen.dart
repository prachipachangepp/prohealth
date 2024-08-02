// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
// import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/confirmation_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/widgets/offer_letter_constant.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../../app/resources/const_string.dart';
// import '../../../../app/resources/value_manager.dart';
// import '../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
// import '../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
// import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
//
//  List<Map<String, dynamic>> checkboxData = [
//   {'title': '95673', 'value': false},
//   {'title': '95673', 'value': false},
//   {'title': '95673', 'value': false},
//   {'title': '95673', 'value': false},
//   {'title': '95673', 'value': false},
//   {'title': '56866', 'value': false},
//   {'title': '56866', 'value': false},
//   {'title': '56866', 'value': false},
//   {'title': '56866', 'value': false},
//   {'title': '56866', 'value': false},
// ];
//
// List<Map<String, dynamic>> checkboxDataCity = [
//   {'title': 'RioLinda', 'value': false},
//   {'title': 'Antelope', 'value': false},
//   {'title': 'PleasantGrove', 'value': false},
//   {'title': 'Elverta', 'value': false},
//   {'title': 'Natomas', 'value': false},
//   {'title': 'Nicolaus', 'value': false},
// ];
//
// class OfferLetterScreen extends StatefulWidget {
//   const OfferLetterScreen({super.key});
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
//
//   String selectedDropdownValue = 'Per day';
//   String dropdownValue = 'Salaried';
//   late List<Map<String, dynamic>> checkboxStates;
//   late List<Map<String, dynamic>> checkboxStatesCity;
//
//
//   String _salary = "";
//
//   @override
//   void initState() {
//     super.initState();
//     checkboxStates = List.from(checkboxData);
//     checkboxStatesCity = List.from(checkboxDataCity);
//   }
//
//   void handleDropdownChange(String? newValue) {
//     setState(() {
//       dropdownValue = newValue ?? 'Salaried';
//     });
//   }
//
//
//   List<Widget> _buildCheckboxes() {
//     return checkboxStates.map((data) {
//       return CheckboxListTile(
//         title: Text(data['title'],
//           style: GoogleFonts.firaSans(
//             fontSize: 10.0,
//             fontWeight: FontWeight.w500
//         ),),
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
//
//   List<Widget> _buildCheckboxesCity() {
//     return checkboxStatesCity.map((data) {
//       return CheckboxListTile(
//         title: Text(data['title'],
//           style: GoogleFonts.firaSans(
//               fontSize: 10.0,
//               fontWeight: FontWeight.w500
//           ),),
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
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         // titlePadding: EdgeInsets.zero,
//         title: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           width: 1100,
//           height: 700, //1029
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(32.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 'Offer Letter',
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xff1696C8),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             Icons.close,
//                             color: Color(0xff454545),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     SizedBox(height: MediaQuery.of(context).size.height/20,),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: CustomTextFieldOfferScreen(
//                             height: 36,
//                               controller: issueDateController,
//                               labelText: 'Issue Date'),
//                         ),
//                         SizedBox(width: MediaQuery.of(context).size.width / 80),
//                         Expanded(
//                           child: CustomTextFieldOfferScreen(
//                             height: 36,
//                             controller: lastDateController,
//                             labelText: 'Last Date',
//                           ),
//                         ),
//                         SizedBox(width: MediaQuery.of(context).size.width / 80),
//                         Expanded(
//                           child: CustomTextFieldOfferScreen(
//                             height: 36,
//                             controller: startDateController,
//                             labelText: 'Anticipated Start Date',
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 60),
//                     Row(
//                       children: [
//                         Container(
//                           // width: MediaQuery.of(context).size.width/4,
//                           child: Expanded(
//                             child: CustomTextFieldOfferScreen(
//                               height: 36,
//                               controller: verbalAcceptanceController,
//                               labelText: 'Verbal Acceptance',
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: MediaQuery.of(context).size.width / 80),
//                         Expanded(
//                           child: Stack(
//                             children: [
//                               Container(
//                                 height: 36,
//                                 child: TextField(
//                                   cursorColor: Colors.black,
//                                   controller: patientsController,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//                                     ),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     labelText: 'No. of Patients',
//                                     labelStyle: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff575757)),
//                                     suffixIcon: Container(
//                                       // padding: EdgeInsets.only(right: 10),
//                                       margin: EdgeInsets.only(right: 10, top: 6, bottom: 6),
//                                       height: 3,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: Colors.grey),
//                                         borderRadius: BorderRadius.circular(5.0),
//                                       ),
//                                       child: DropdownButton<String>(
//                                         value: selectedDropdownValue,
//                                         items: ['Per day', 'Per week', 'Per month']
//                                             .map((String value) {
//                                           return DropdownMenuItem<String>(
//                                               value: value,
//                                               child: Container(
//                                               padding: EdgeInsets.symmetric(horizontal: 12.0),
//                                           child: Text(
//                                           value,
//                                           style: TextStyle(fontSize: 10.0),
//                                           )// Set your desired font size here
//
//                                             ),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? value) {
//                                           if (value != null) {
//                                             setState(() {
//                                               selectedDropdownValue = value;
//                                             });
//                                           }
//                                         },
//                                         underline: SizedBox(),
//                                         icon: Icon(Icons.arrow_drop_down,
//                                             color: ColorManager.blueprime),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: MediaQuery.of(context).size.width / 80),
//                         Expanded(
//                           child: TextFormField(
//                             cursorColor: Colors.transparent,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.transparent, width: 1.0),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.transparent, width: 1.0),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.transparent, width: 1.0),
//                               ),
//                               labelStyle: GoogleFonts.firaSans(
//                                   fontSize: 10.0,
//                                   fontWeight: FontWeight.w400,
//                                   color: Colors.transparent,
//                             ),
//                           ),
//                         ),
//                         )
//                         // SizedBox(width: MediaQuery.of(context).size.width / 3.15),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 50),
//                     Divider(
//                       color: ColorManager.cream,
//                       thickness: 4,
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 40),
//                     Container(
//                       width: 1030,
//                       height: MediaQuery.of(context).size.height / 2,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Color(0xff1696C8)),
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 71.0, top: 50),
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     children: [
//                                       ///county
//                                       FutureBuilder<List<AllCountyGetList>>(
//                                         future:getCountyZoneList(context),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState ==
//                                               ConnectionState.waiting) {
//                                             return Shimmer.fromColors(
//                                               baseColor: Colors.grey[300]!,
//                                               highlightColor: Colors.grey[100]!,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     horizontal: 7),
//                                                 child: Container(
//                                                   width: AppSize.s250,
//                                                   height: AppSize.s40,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.grey[300]),
//                                                 ),
//                                               ),
//                                             );
//                                           } else if (snapshot.hasError) {
//                                             return CustomDropdownTextField(
//                                               labelText: 'County',
//                                               labelStyle: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Color(0xff575757),
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               labelFontSize: 12,
//                                               items: ['Error'],
//                                             );
//                                           } else if (snapshot.hasData) {
//                                             List<String> dropDownList = snapshot.data!
//                                                 .map((county) => county.countyName ?? '')
//                                                 .toList();
//                                             print("County: ");
//                                             return CustomDropdownTextField(
//                                               labelText: 'County',
//                                               labelStyle: GoogleFonts.firaSans(
//                                                 fontSize: 12,
//                                                 color: Color(0xff575757),
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               labelFontSize: 12,
//                                               items: dropDownList,
//                                               onChanged: (newValue) {
//                                                 // Handle onChanged here if needed
//                                               },
//                                             );
//                                           } else {
//                                             return CustomDropdownTextField(
//                                               labelText: 'County',
//                                               labelStyle: GoogleFonts.firaSans(
//                                                 fontSize: 12,
//                                                 color: Color(0xff575757),
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               labelFontSize: 12,
//                                               items: ['No Data'],
//                                             );
//                                           }
//                                         },
//                                       ),
//
//
//                                       SizedBox(height: MediaQuery.of(context).size.height / 20),
//                                       ///zone api
//
//                                       FutureBuilder<List<AEClinicalZone>>(
//                                         future: HrAddEmplyClinicalZoneApi(
//                                           context,
//                                         ),
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState ==
//                                               ConnectionState.waiting) {
//                                             return Shimmer.fromColors(
//                                               baseColor: Colors.grey[300]!,
//                                               highlightColor: Colors.grey[100]!,
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     horizontal: 7),
//                                                 child: Container(
//                                                   width: AppSize.s250,
//                                                   height: AppSize.s40,
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.grey[300]),
//                                                 ),
//                                               ),
//                                             );
//                                           } else if (snapshot.hasError) {
//                                             return CustomDropdownTextField(
//                                               labelText: 'Zone',
//                                               labelStyle: TextStyle(
//                                                 fontSize: 12,
//                                                 color: Color(0xff575757),
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               labelFontSize: 12,
//                                               items: ['Error'],
//                                             );
//                                           } else if (snapshot.hasData) {
//                                             List<String> dropDownList = snapshot.data!
//                                                 .map((zone) => zone.zoneName ?? '')
//                                                 .toList();
//                                             print("Zone: ");
//                                             return CustomDropdownTextField(
//                                               labelText: 'Zone',
//                                               labelStyle: GoogleFonts.firaSans(
//                                                 fontSize: 12,
//                                                 color: Color(0xff575757),
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               labelFontSize: 12,
//                                               items: dropDownList,
//                                               onChanged: (newValue) {
//                                                 // Handle onChanged here if needed
//                                               },
//                                             );
//                                           } else {
//                                             return CustomDropdownTextField(
//                                               labelText: 'Zone',
//                                               labelStyle: GoogleFonts.firaSans(
//                                                 fontSize: 12,
//                                                 color: Color(0xff575757),
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               labelFontSize: 12,
//                                               items: ['No Data'],
//                                             );
//                                           }
//                                         },
//                                       ),
//                                       ///
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             SizedBox(width: MediaQuery.of(context).size.width / 260),
//                             Expanded(
//                               child: DefaultTabController(
//                                 length: 2,
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(left: 135.0, right: 135.0),
//                                       child: TabBar(
//                                         indicatorColor: Color(0xff1696C8),
//                                         labelColor: Color(0xff686464),
//                                         unselectedLabelColor: Color(0xff686464),
//                                         labelStyle: GoogleFonts.firaSans(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         unselectedLabelStyle: GoogleFonts.firaSans(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         tabs: [
//                                           Tab(text: 'Zip Codes'),
//                                           Tab(text: 'Cities'),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(left: 100.0, right: 100.0),
//                                         child: TabBarView(
//                                           physics: NeverScrollableScrollPhysics(),
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: ListView(
//                                                     children: _buildCheckboxes().sublist(0, 5),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: ListView(
//                                                     children: _buildCheckboxes().sublist(5, 10),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             // Tab 2 content: Cities
//                                             Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: ListView(
//                                                     children: _buildCheckboxesCity().sublist(0, 3),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: ListView(
//                                                     children: _buildCheckboxesCity().sublist(3, 6),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height/40),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xff1696C8),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: Text(
//                             'Add New Coverage',
//                             style: GoogleFonts.firaSans(
//                               fontSize: 12.0,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height/30),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: CustomDropdownFormField(
//                               hintText: 'Salaried',
//                               items: ['Salaried', 'Per Visit'],
//                               value: dropdownValue,
//                               onChanged: handleDropdownChange
//                           )
//                         ),
//                       ],
//                     ),
//
//
//                     SizedBox(height: MediaQuery.of(context).size.height/30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         if (_salary.isNotEmpty)
//                           Text(
//                             _salary,
//                             style: GoogleFonts.firaSans(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black,
//                             ),
//                           ),
//                         SizedBox(width: MediaQuery.of(context).size.width/120),
//                         ElevatedButton(
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12.0),
//                                   ),
//                                   titlePadding: EdgeInsets.zero,
//                                   title: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(12.0),
//                                         topRight: Radius.circular(12.0),
//                                       ),
//                                     ),
//                                     width: 302,
//                                     height: 246,
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Container(
//                                           //height: 35,
//                                           width: double.infinity,
//                                           decoration: BoxDecoration(
//                                             color: Color(0xff1696C8),
//                                             borderRadius: BorderRadius.only(
//                                               topLeft: Radius.circular(12.0),
//                                               topRight: Radius.circular(12.0),
//                                             ),
//                                           ),
//                                           padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
//                                           child: Align(
//                                             alignment: Alignment.topRight,
//                                             child: IconButton(
//                                               icon: Icon(Icons.close, color: Colors.white),
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Salary',
//                                                 style: GoogleFonts.firaSans(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Color(0xff686464)
//                                                 ),
//                                               ),
//                                               SizedBox(height: MediaQuery.of(context).size.height/30,),
//                                               TextFormField(
//                                                 cursorColor: Colors.black,
//                                                 decoration: InputDecoration(
//                                                   hintText: '0.00',
//                                                   hintStyle: GoogleFonts.firaSans(
//                                                     fontSize: 12,
//                                                     fontWeight: FontWeight.w700,
//                                                     color: Color(0xff686464)
//                                                   ),
//                                                   enabledBorder: OutlineInputBorder(
//                                                     borderRadius: BorderRadius.circular(8.0),
//                                                     borderSide: BorderSide(
//                                                       color: Color(0xff51B5E6),
//                                                       width: 1.0,
//                                                     ),
//                                                   ),
//                                                   focusedBorder: OutlineInputBorder(
//                                                     borderRadius: BorderRadius.circular(8.0),
//                                                     borderSide: BorderSide(
//                                                       color: Color(0xff51B5E6),
//                                                       width: 1.0,
//                                                     ),
//                                                   ),
//                                                   border: OutlineInputBorder(
//                                                     borderRadius: BorderRadius.circular(8.0),
//                                                     borderSide: BorderSide(
//                                                       color: Color(0xff51B5E6),
//                                                       width: 1.0,
//                                                     ),
//                                                   ),
//                                                   contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                                                 ),
//                                                 keyboardType: TextInputType.number,
//                                                 onChanged: (value) {
//                                                   setState(() {
//                                                     _salary = value;
//                                                   });
//                                                 },
//                                               ),
//                                               SizedBox(height: MediaQuery.of(context).size.height/20),
//                                               Center(
//                                                 child: ElevatedButton(
//                                                   onPressed: () {
//                                                     // Handle the submit action
//                                                     Navigator.of(context).pop();
//                                                   },
//                                                   style: ElevatedButton.styleFrom(
//                                                     backgroundColor: Color(0xff1696C8),
//                                                     shape: RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(12),
//                                                     ),
//                                                   ),
//                                                   child: Padding(
//                                                     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
//                                                     child: Text(
//                                                       'Submit',
//                                                       style: GoogleFonts.firaSans(
//                                                         fontSize: 12.0,
//                                                         fontWeight: FontWeight.w700,
//                                                         color: Colors.white
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xff1696C8),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: Text(
//                             'Add',
//                             style: GoogleFonts.firaSans(
//                               fontSize: 12.0,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     SizedBox(height: MediaQuery.of(context).size.height/30),
//                     Container(
//                       height: 50,
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xff1696C8),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: Text(
//                           'Compensation',
//                           style: GoogleFonts.firaSans(
//                             fontSize: 12.0,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height/80),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                             'Not Defined',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600
//                         ),)
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height/40),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             foregroundColor: Color(0xff1696C8),
//                             side: BorderSide(color: Color(0xff1696C8)),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text(
//                             'Back',
//                             style: GoogleFonts.firaSans(
//                               fontSize: 12.0,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: MediaQuery.of(context).size.width/75),
//                         ElevatedButton(
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return ConfirmationPopup(
//                                   onCancel: () {Navigator.pop(context);},
//                                   onConfirm: () {Navigator.pop(context);},
//                                   title: 'Confirm Enrollment',
//                                   containerText: 'Do you really want to enroll?',
//                                 );
//                               },
//                             );
//                           },
//
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xff1696C8),
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text(
//                             'Enroll',
//                             style: GoogleFonts.firaSans(
//                               fontSize: 12.0,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
// //
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:prohealth/app/resources/color.dart';
// // import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
// // import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
// // import 'package:prohealth/presentation/screens/hr_module/register/widgets/offer_letter_constant.dart';
// //
// // List<Map<String, dynamic>> checkboxData = [
// //   {'title': '95673', 'value': false},
// //   {'title': '95673', 'value': false},
// //   {'title': '95673', 'value': false},
// //   {'title': '95673', 'value': false},
// //   {'title': '95673', 'value': false},
// //   {'title': '56866', 'value': false},
// //   {'title': '56866', 'value': false},
// //   {'title': '56866', 'value': false},
// //   {'title': '56866', 'value': false},
// //   {'title': '56866', 'value': false},
// // ];
// //
// // List<Map<String, dynamic>> checkboxDataCity = [
// //   {'title': 'RioLinda', 'value': false},
// //   {'title': 'Antelope', 'value': false},
// //   {'title': 'PleasantGrove', 'value': false},
// //   {'title': 'Elverta', 'value': false},
// //   {'title': 'Natomas', 'value': false},
// //   {'title': 'Nicolaus', 'value': false},
// // ];
// //
// // class OfferLetterScreen extends StatefulWidget {
// //   const OfferLetterScreen({super.key});
// //
// //   @override
// //   State<OfferLetterScreen> createState() => _OfferLetterScreenState();
// // }
// //
// // class _OfferLetterScreenState extends State<OfferLetterScreen> {
// //   TextEditingController issueDateController = TextEditingController();
// //   TextEditingController lastDateController = TextEditingController();
// //   TextEditingController startDateController = TextEditingController();
// //   TextEditingController verbalAcceptanceController = TextEditingController();
// //   TextEditingController patientsController = TextEditingController();
// //
// //   String selectedDropdownValue = 'Per day';
// //   String dropdownValue = 'Salaried';
// //   late List<Map<String, dynamic>> checkboxStates;
// //   late List<Map<String, dynamic>> checkboxStatesCity;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     checkboxStates = List.from(checkboxData);
// //     checkboxStatesCity = List.from(checkboxDataCity);
// //   }
// //
// //   void handleDropdownChange(String? newValue) {
// //     setState(() {
// //       dropdownValue = newValue ?? 'Salaried';
// //     });
// //   }
// //
// //   List<Widget> _buildCheckboxes() {
// //     return checkboxStates.map((data) {
// //       return CheckboxListTile(
// //         title: Text(data['title'],
// //           style: GoogleFonts.firaSans(
// //               fontSize: 10.0,
// //               fontWeight: FontWeight.w500
// //           ),),
// //         value: data['value'],
// //         onChanged: (bool? value) {
// //           setState(() {
// //             data['value'] = value ?? false;
// //           });
// //         },
// //       );
// //     }).toList();
// //   }
// //
// //   List<Widget> _buildCheckboxesCity() {
// //     return checkboxStatesCity.map((data) {
// //       return CheckboxListTile(
// //         title: Text(data['title'],
// //           style: GoogleFonts.firaSans(
// //               fontSize: 10.0,
// //               fontWeight: FontWeight.w500
// //           ),),
// //         value: data['value'],
// //         onChanged: (bool? value) {
// //           setState(() {
// //             data['value'] = value ?? false;
// //           });
// //         },
// //       );
// //     }).toList();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         automaticallyImplyLeading: false,
// //         title: Center(
// //           child: Text(
// //             'Offer Letter',
// //             style: GoogleFonts.firaSans(
// //                 fontSize: 12.0,
// //                 fontWeight: FontWeight.w500,
// //                 color: Color(0xff1696C8)),
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             children: [
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: CustomTextField(
// //                         controller: issueDateController,
// //                         labelText: 'Issue Date'),
// //                   ),
// //                   SizedBox(width: MediaQuery.of(context).size.width / 80),
// //                   Expanded(
// //                     child: CustomTextField(
// //                       controller: lastDateController,
// //                       labelText: 'Last Date',
// //                     ),
// //                   ),
// //                   SizedBox(width: MediaQuery.of(context).size.width / 80),
// //                   Expanded(
// //                     child: CustomTextField(
// //                       controller: startDateController,
// //                       labelText: 'Anticipated Start Date',
// //                     ),
// //                   )
// //                 ],
// //               ),
// //               SizedBox(height: MediaQuery.of(context).size.height / 60),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: CustomTextField(
// //                       controller: verbalAcceptanceController,
// //                       labelText: 'Verbal Acceptance',
// //                     ),
// //                   ),
// //                   SizedBox(width: MediaQuery.of(context).size.width / 80),
// //                   Expanded(
// //                     child: Stack(
// //                       children: [
// //                         TextField(
// //                           cursorColor: Colors.black,
// //                           controller: patientsController,
// //                           decoration: InputDecoration(
// //                             border: OutlineInputBorder(
// //                               borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
// //                             ),
// //                             enabledBorder: OutlineInputBorder(
// //                               borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
// //                             ),
// //                             focusedBorder: OutlineInputBorder(
// //                               borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
// //                             ),
// //                             filled: true,
// //                             fillColor: Colors.white,
// //                             labelText: 'No. of Patients',
// //                             labelStyle: GoogleFonts.firaSans(
// //                                 fontSize: 10.0,
// //                                 fontWeight: FontWeight.w400,
// //                                 color: Color(0xff575757)),
// //                             suffixIcon: Container(
// //                               // padding: EdgeInsets.only(right: 10),
// //                               margin: EdgeInsets.only(right: 10, top: 6, bottom: 6),
// //                               height: 5,
// //                               decoration: BoxDecoration(
// //                                 border: Border.all(color: Colors.grey),
// //                                 borderRadius: BorderRadius.circular(5.0),
// //                               ),
// //                               child: DropdownButton<String>(
// //                                 value: selectedDropdownValue,
// //                                 items: ['Per day', 'Per week', 'Per month']
// //                                     .map((String value) {
// //                                   return DropdownMenuItem<String>(
// //                                     value: value,
// //                                     child: Container(
// //                                       padding: EdgeInsets.symmetric(
// //                                           horizontal: 12.0),
// //                                       child: Text(value),
// //                                     ),
// //                                   );
// //                                 }).toList(),
// //                                 onChanged: (String? value) {
// //                                   if (value != null) {
// //                                     setState(() {
// //                                       selectedDropdownValue = value;
// //                                     });
// //                                   }
// //                                 },
// //                                 underline: SizedBox(),
// //                                 icon: Icon(Icons.arrow_drop_down,
// //                                     color: ColorManager.blueprime),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(width: MediaQuery.of(context).size.width / 80),
// //                   SizedBox(width: MediaQuery.of(context).size.width / 3.15),
// //                 ],
// //               ),
// //               SizedBox(height: MediaQuery.of(context).size.height / 30),
// //               Divider(
// //                 color: ColorManager.cream,
// //                 thickness: 4,
// //               ),
// //               SizedBox(height: MediaQuery.of(context).size.height / 10),
// //               Container(
// //                 height: MediaQuery.of(context).size.height / 2,
// //                 decoration: BoxDecoration(
// //                   border: Border.all(color: Color(0xff1696C8)),
// //                   borderRadius: BorderRadius.circular(12.0),
// //                 ),
// //                 child: Padding(
// //                   padding: EdgeInsets.all(16.0),
// //                   child: Row(
// //                     children: [
// //                       Expanded(
// //                         child: Padding(
// //                           padding: EdgeInsets.only(left: 71.0),
// //                           child: Column(
// //                             children: [
// //                               CustomDropdownFormField(
// //                                   hintText: 'Select a City',
// //                                   labelText: 'City',
// //                                   items: [
// //                                     'ProHealth San Jose',
// //                                     'ProHealth Sacramento',
// //                                     'ProHealth Walnut Creek',
// //                                     'ProHealth Stockton',],
// //                                   onChanged: (String) {}
// //                               ),
// //                               SizedBox(height: MediaQuery.of(context).size.height / 30),
// //                               CustomDropdownFormField(
// //                                   hintText: 'Select a Country',
// //                                   labelText: 'Country',
// //                                   items: [
// //                                     'Alameida',
// //                                     'San Joachim'],
// //                                   onChanged: (String) {}
// //                               ),
// //                               SizedBox(height: MediaQuery.of(context).size.height / 30),
// //                               CustomDropdownFormField(
// //                                   hintText: 'Select a Zone',
// //                                   labelText: 'Zone',
// //                                   items: [
// //                                     '1',
// //                                     '2',
// //                                     '3',
// //                                     '4'],
// //                                   onChanged: (String) {}
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(width: MediaQuery.of(context).size.width / 10),
// //                       Expanded(
// //                         child: DefaultTabController(
// //                           length: 2,
// //                           child: Column(
// //                             children: [
// //                               Container(
// //                                 child: TabBar(
// //                                   indicator: BoxDecoration(
// //                                       color: Color(0xff1696C8),
// //                                       borderRadius: BorderRadius.circular(20)),
// //                                   labelStyle: TextStyle(
// //                                       fontWeight: FontWeight.bold,
// //                                       fontSize: 14),
// //                                   labelColor: Colors.white,
// //                                   unselectedLabelColor: Colors.black,
// //                                   tabs: [
// //                                     Tab(
// //                                       child: Align(
// //                                         alignment: Alignment.center,
// //                                         child: Text('Zip Code'),
// //                                       ),
// //                                     ),
// //                                     Tab(
// //                                       child: Align(
// //                                         alignment: Alignment.center,
// //                                         child: Text('City'),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                               Expanded(
// //                                 child: TabBarView(
// //                                   children: [
// //                                     SingleChildScrollView(
// //                                       scrollDirection: Axis.horizontal,
// //                                       child: Row(
// //                                         children: _buildCheckboxes(),
// //                                       ),
// //
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
// //                                     SingleChildScrollView(
// //                                       scrollDirection: Axis.horizontal,
// //                                       child: Row(
// //                                         children: _buildCheckboxesCity(),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
import 'package:prohealth/presentation/screens/hr_module/register/confirmation_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/offer_letter_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/value_manager.dart';
import '../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../widgets/widgets/constant_textfield/const_textfield.dart';

List<Map<String, dynamic>> checkboxData = [
  {'title': '95673', 'value': false},
  {'title': '95673', 'value': false},
  {'title': '95673', 'value': false},
  {'title': '95673', 'value': false},
  {'title': '95673', 'value': false},
  {'title': '56866', 'value': false},
  {'title': '56866', 'value': false},
  {'title': '56866', 'value': false},
  {'title': '56866', 'value': false},
  {'title': '56866', 'value': false},
];

List<Map<String, dynamic>> checkboxDataCity = [
  {'title': 'RioLinda', 'value': false},
  {'title': 'Antelope', 'value': false},
  {'title': 'PleasantGrove', 'value': false},
  {'title': 'Elverta', 'value': false},
  {'title': 'Natomas', 'value': false},
  {'title': 'Nicolaus', 'value': false},
];

class OfferLetterScreen extends StatefulWidget {
  final String email;
  final int userId;
  final String role;
  final String status;
  final String firstName;
  final String lastName;
  final String position;
  final String phone;
  final String reportingOffice;
  final String services;
  final String employement;
  final String soecalityName;
  final String clinicalName;
  final int employeeId;

  const OfferLetterScreen(
      {super.key,
      required this.email,
      required this.userId,
      required this.role,
      required this.status,
      required this.firstName,
      required this.lastName,
      required this.position,
      required this.phone,
      required this.reportingOffice,
      required this.services,
      required this.employement,
      required this.soecalityName,
      required this.clinicalName,
      required this.employeeId});

  @override
  State<OfferLetterScreen> createState() => _OfferLetterScreenState();
}

class _OfferLetterScreenState extends State<OfferLetterScreen> {
  TextEditingController issueDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController verbalAcceptanceController = TextEditingController();
  TextEditingController patientsController = TextEditingController();

  String selectedDropdownValue = 'Per day';
  String dropdownValue = 'Salaried';
  late List<Map<String, dynamic>> checkboxStates;
  late List<Map<String, dynamic>> checkboxStatesCity;

  String _salary = "";
  String generatedURL = '';

  final List<Map<String, String>> data = [
    {'zipCode': '10001', 'city': 'New York'},
    {'zipCode': '20001', 'city': 'Washington, D.C.'},
    {'zipCode': '30301', 'city': 'Atlanta'},
    {'zipCode': '94101', 'city': 'San Francisco'},
    // Add more data as needed
  ];

  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  void _goToPage(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _initAppLinks();
    checkboxStates = List.from(checkboxData);
    checkboxStatesCity = List.from(checkboxDataCity);
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.toInt();
      });
    });
  }

  void handleDropdownChange(String? newValue) {
    setState(() {
      dropdownValue = newValue ?? 'Salaried';
    });
  }

  List<Widget> _buildCheckboxes() {
    return checkboxStates.map((data) {
      return CheckboxListTile(
        title: Text(
          data['title'],
          style:
              GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),
        ),
        value: data['value'],
        onChanged: (bool? value) {
          setState(() {
            data['value'] = value ?? false;
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildCheckboxesCity() {
    return checkboxStatesCity.map((data) {
      return CheckboxListTile(
        title: Text(
          data['title'],
          style:
              GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),
        ),
        value: data['value'],
        onChanged: (bool? value) {
          setState(() {
            data['value'] = value ?? false;
          });
        },
      );
    }).toList();
  }

  AppLinks? _appLinks;

  void _initAppLinks() async {
    _appLinks = AppLinks();
  }

  Future<String> _generateUrlLink(String email, String Id) async {
    final String user = email;
    final String id = Id;
    final String url = 'https://staging.symmetry.care/$id';
    generatedURL = url;
    print('Generated URL: $generatedURL');
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Offer Letter',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff1696C8),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFieldOfferScreen(
                      height: 36,
                      controller: issueDateController,
                      labelText: 'Issue Date'),
                  //SizedBox(width: MediaQuery.of(context).size.width / 80),
                  CustomTextFieldOfferScreen(
                    height: 36,
                    controller: lastDateController,
                    labelText: 'Last Date',
                  ),
                  // SizedBox(width: MediaQuery.of(context).size.width / 80),
                  CustomTextFieldOfferScreen(
                    height: 36,
                    controller: startDateController,
                    labelText: 'Anticipated Start Date',
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFieldOfferScreen(
                    height: 36,
                    controller: verbalAcceptanceController,
                    labelText: 'Verbal Acceptance',
                  ),
                  //SizedBox(width: MediaQuery.of(context).size.width / 80),

                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 5,
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: patientsController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'No. of Patients',
                        labelStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff575757),
                        ),
                        suffixIcon: DropdownButton<String>(
                          value: selectedDropdownValue,
                          items: ['Per day', 'Per week', 'Per month']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 10.0),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                selectedDropdownValue = value;
                              });
                            }
                          },
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.blue),
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 20, bottom: 5),
                      ),
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff575757)),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 10),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              Divider(
                color: ColorManager.cream,
                thickness: 4,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Container(
                width: double.infinity, //1030
                height: 330, //MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff1696C8)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 71.0, top: 50),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ///county
                                FutureBuilder<List<AllCountyGetList>>(
                                  future: getCountyZoneList(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Container(
                                            // width: AppSize.s250,
                                            height: AppSize.s40,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300]),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const CustomDropdownTextField(
                                        labelText: 'County',
                                        labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff575757),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        labelFontSize: 12,
                                        items: ['Error'],
                                      );
                                    } else if (snapshot.hasData) {
                                      List<String> dropDownList = snapshot.data!
                                          .map((county) =>
                                              county.countyName ?? '')
                                          .toList();
                                      print("County: ");
                                      return CustomDropdownTextField(
                                        // width: MediaQuery.of(context).size.width / 5,
                                        labelText: 'County',
                                        labelStyle: GoogleFonts.firaSans(
                                          fontSize: 12,
                                          color: const Color(0xff575757),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        labelFontSize: 12,
                                        items: dropDownList,
                                        onChanged: (newValue) {
                                          // Handle onChanged here if needed
                                        },
                                      );
                                    } else {
                                      return CustomDropdownTextField(
                                        labelText: 'County',
                                        labelStyle: GoogleFonts.firaSans(
                                          fontSize: 12,
                                          color: const Color(0xff575757),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        labelFontSize: 12,
                                        items: ['No Data'],
                                      );
                                    }
                                  },
                                ),

                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        20),

                                ///zone api

                                FutureBuilder<List<AEClinicalZone>>(
                                  future: HrAddEmplyClinicalZoneApi(
                                    context,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Container(
                                            width: AppSize.s250,
                                            height: AppSize.s40,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300]),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const CustomDropdownTextField(
                                        //width: MediaQuery.of(context).size.width / 5,

                                        labelText: 'Zone',
                                        labelStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff575757),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        labelFontSize: 12,
                                        items: ['Error'],
                                      );
                                    } else if (snapshot.hasData) {
                                      List<String> dropDownList = snapshot.data!
                                          .map((zone) => zone.zoneName ?? '')
                                          .toList();
                                      print("Zone: ");
                                      return CustomDropdownTextField(
                                        // width: MediaQuery.of(context).size.width / 5,
                                        labelText: 'Zone',
                                        labelStyle: GoogleFonts.firaSans(
                                          fontSize: 12,
                                          color: const Color(0xff575757),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        labelFontSize: 12,
                                        items: dropDownList,
                                        onChanged: (newValue) {
                                          // Handle onChanged here if needed
                                        },
                                      );
                                    } else {
                                      return CustomDropdownTextField(
                                        // width: MediaQuery.of(context).size.width / 5,
                                        labelText: 'Zone',
                                        labelStyle: GoogleFonts.firaSans(
                                          fontSize: 12,
                                          color: const Color(0xff575757),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        labelFontSize: 12,
                                        items: ['No Data'],
                                      );
                                    }
                                  },
                                ),

                                ///
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 260),

                      ///old code tabbar
                      Expanded(
                        child: DefaultTabController(
                          length: 2,
                          child: Column( 
                            children: [
                              Padding(
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal:
                                //         180.0),
                                padding: const EdgeInsets.only(
                                    left: 180.0, right: 180.0),
                                child: TabBar(
                                  indicatorColor: const Color(0xff1696C8),
                                  labelColor: const Color(0xff686464),
                                  unselectedLabelColor: const Color(0xff686464),
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  unselectedLabelStyle: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  tabs: const [
                                    Tab(text: 'Zip Codes'),
                                    Tab(text: 'Cities'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          100.0), //const EdgeInsets.only(left: 100.0, right: 100.0),
                                  child: TabBarView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ListView(
                                              children: _buildCheckboxes()
                                                  .sublist(0, 5),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView(
                                              children: _buildCheckboxes()
                                                  .sublist(5, 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Tab 2 content: Cities
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ListView(
                                              children: _buildCheckboxesCity()
                                                  .sublist(0, 3),
                                            ),
                                          ),
                                          Expanded(
                                            child: ListView(
                                              children: _buildCheckboxesCity()
                                                  .sublist(3, 6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1696C8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Add New Coverage',
                      style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: CustomDropdownFormField(
                    hintText: 'Salaried',
                    items: ['Salaried', 'Per Visit'],
                    value: dropdownValue,
                    onChanged: handleDropdownChange),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_salary.isNotEmpty)
                    Text(
                      _salary,
                      style: GoogleFonts.firaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  SizedBox(width: MediaQuery.of(context).size.width / 120),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            titlePadding: EdgeInsets.zero,
                            title: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              width: 302,
                              height: 246,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    //height: 35,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Color(0xff1696C8),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0, horizontal: 6.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: const Icon(Icons.close,
                                            color: Colors.white),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Salary',
                                          style: GoogleFonts.firaSans(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff686464)),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                        ),
                                        TextFormField(
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            hintText: '0.00',
                                            hintStyle: GoogleFonts.firaSans(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xff686464)),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: const BorderSide(
                                                color: Color(0xff51B5E6),
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: const BorderSide(
                                                color: Color(0xff51B5E6),
                                                width: 1.0,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: const BorderSide(
                                                color: Color(0xff51B5E6),
                                                width: 1.0,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 12.0),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState(() {
                                              _salary = value;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Handle the submit action
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xff1696C8),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24.0,
                                                      vertical: 8.0),
                                              child: Text(
                                                'Submit',
                                                style: GoogleFonts.firaSans(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1696C8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1696C8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Compensation',
                    style: GoogleFonts.firaSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 80),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not Defined',
                    style: GoogleFonts.firaSans(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xff1696C8),
                      side: const BorderSide(color: Color(0xff1696C8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 75),
                  ElevatedButton(
                    onPressed: () async {
                      await _generateUrlLink(
                          widget.email, widget.userId.toString());
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmationPopup(
                            onCancel: () {
                              Navigator.pop(context);
                            },
                            onConfirm: () async {
                              await addEmpEnroll(
                                  context: context,
                                  employeeId: widget.employeeId,
                                  code: "",
                                  userId: widget.userId,
                                  firstName: widget.firstName,
                                  lastName: widget.lastName,
                                  phoneNbr: widget.phone,
                                  email: widget.email,
                                  link: generatedURL,
                                  status: widget.status,
                                  departmentId: 1,
                                  position: widget.position,
                                  speciality: widget.soecalityName,
                                  clinicianTypeId: 1,
                                  reportingOfficeId: widget.reportingOffice,
                                  cityId: 1,
                                  countryId: 1,
                                  countyId: 9,
                                  zoneId: 18,
                                  employment: widget.employement,
                                  service: widget.services);
                              Navigator.pop(context);
                            },
                            title: 'Confirm Enrollment',
                            containerText: 'Do you really want to enroll?',
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1696C8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Enroll',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Stack(
//   children: [
//     Container(
//       height: 36,
//       width: MediaQuery.of(context).size.width / 3.5,
//       child: TextField(
//         cursorColor: Colors.black,
//         controller: patientsController,
//         decoration: InputDecoration(
//           border: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           labelText: 'No. of Patients',
//           labelStyle: GoogleFonts.firaSans(
//               fontSize: 10.0,
//               fontWeight: FontWeight.w400,
//               color: const Color(0xff575757)),
//           suffixIcon: Container(
//             // padding: EdgeInsets.only(right: 10),
//             margin: const EdgeInsets.only(right: 10, top: 6, bottom: 6),
//             height: 3,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             child: DropdownButton<String>(
//               value: selectedDropdownValue,
//               items: ['Per day', 'Per week', 'Per month']
//                   .map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       child: Text(
//                         value,
//                         style: const TextStyle(fontSize: 10.0),
//                       )// Set your desired font size here
//
//                   ),
//                 );
//               }).toList(),
//               onChanged: (String? value) {
//                 if (value != null) {
//                   setState(() {
//                     selectedDropdownValue = value;
//                   });
//                 }
//               },
//               underline: const SizedBox(),
//               icon: Icon(Icons.arrow_drop_down,
//                   color: ColorManager.blueprime),
//             ),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
