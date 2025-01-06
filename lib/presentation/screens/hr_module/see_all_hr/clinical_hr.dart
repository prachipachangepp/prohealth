// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/edit_pop_up.dart';
// import '../../../../app/resources/color.dart';
// import '../../../../app/resources/const_string.dart';
// import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
// import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
// import '../../../../app/resources/font_manager.dart';
// import '../../../../app/resources/theme_manager.dart';
// import '../../../../app/resources/value_manager.dart';
// import '../../../../app/services/api/managers/hr_module_manager/see_all/see_all_manager.dart';
// import '../../../../data/api_data/hr_module_data/see_all_data/see_all_data.dart';
// import '../../em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
//
// class ClinicalHrScreen extends StatefulWidget {
//   final Function(int) onClinicalCountChange;
//
//   ClinicalHrScreen({super.key, required this.onClinicalCountChange});
//
//   @override
//   State<ClinicalHrScreen> createState() => _ClinicalHrScreenState();
// }
//
// class _ClinicalHrScreenState extends State<ClinicalHrScreen> {
//   final StreamController<List<SeeAllData>> seeAllController = StreamController<List<SeeAllData>>();
//
//   late int currentPage;
//   late int itemsPerPage;
//
//   @override
//   void initState() {
//     super.initState();
//     currentPage = 1;
//     itemsPerPage = 20;
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     try {
//       List<SeeAllData> data = await getEmployeeSeeAll(context);
//       seeAllController.add(data);
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         // Update the count after the current build phase
//         widget.onClinicalCountChange(data.length);
//       });
//     } catch (error) {
//       print("Error fetching data: $error");
//     }
//   }
//
//   @override
//   void dispose() {
//     seeAllController.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 60,
//         ),
//         Container(
//           height: 30,
//           decoration: BoxDecoration(
//             color: ColorManager.fmediumgrey,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 80.0),
//                   child: Text(
//                     AppStringEM.srno,
//                     style: TableHeading.customTextStyle(context),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 5.0),
//                   child: Text(
//                     AppStringEM.type,
//                     style: TableHeading.customTextStyle(context),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Text(
//                   AppStringEM.name,
//                   style: TableHeading.customTextStyle(context),
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 25.0),
//                   child: Text(
//                     AppStringEM.location,
//                     style: TableHeading.customTextStyle(context),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 50.0),
//                   child: Text(
//                     AppStringEM.specialization,
//                     style: TableHeading.customTextStyle(context),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 50.0),
//                   child: Text(
//                     AppStringEM.edit,
//                     style: TableHeading.customTextStyle(context),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height / 60,
//         ),
//         Expanded(
//           child: StreamBuilder<List<SeeAllData>>(
//             stream: seeAllController.stream,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: ColorManager.blueprime,
//                   ),
//                 );
//               }
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     "Error: ${snapshot.error}",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 );
//               }
//               if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text(
//                     AppString.dataNotFound,
//                     style: CustomTextStylesCommon.commonStyle(
//                       fontWeight: FontWeightManager.medium,
//                       fontSize: FontSize.s14,
//                       color: ColorManager.mediumgrey,
//                     ),
//                   ),
//                 );
//               }
//
//               List<SeeAllData> data = snapshot.data!;
//               // Ensure the count is updated without causing build errors
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 widget.onClinicalCountChange(data.length);
//               });
//
//               int totalItems = data.length;
//               List<SeeAllData> currentPageItems = data.sublist(
//                 (currentPage - 1) * itemsPerPage,
//                 (currentPage * itemsPerPage) > totalItems ? totalItems : (currentPage * itemsPerPage),
//               );
//
//               return ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: currentPageItems.length,
//                 itemBuilder: (context, index) {
//                   int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
//                   String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
//
//                   return Container(
//                     margin: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(4),
//                       boxShadow: [
//                         BoxShadow(
//                           color: ColorManager.black.withOpacity(0.25),
//                           spreadRadius: 0,
//                           blurRadius: 4,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     height: AppSize.s56,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 40.0),
//                             child: Text(
//                               formattedSerialNumber,
//                               textAlign: TextAlign.center,
//                               style: AllHRTableData.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Text(
//                             data[index].type.toString(),
//                             textAlign: TextAlign.center,
//                             style: AllHRTableData.customTextStyle(context),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             data[index].firstName.toString(),
//                             textAlign: TextAlign.center,
//                             style: AllHRTableData.customTextStyle(context),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: Text(
//                             data[index].position.toString(),
//                             textAlign: TextAlign.center,
//                             style: AllHRTableData.customTextStyle(context),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             data[index].service.toString(),///experties
//                             textAlign: TextAlign.center,
//                             style: AllHRTableData.customTextStyle(context),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return EditPopUp();
//                                     },
//                                   );
//                                 },
//                                 icon: Icon(Icons.edit_outlined, size: 18),
//                                 color: Color(0xff50B5E5),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => DeletePopup(
//                                       title: 'Delete HR Clinical',
//                                       onCancel: () {
//                                         Navigator.pop(context);
//                                       },
//                                       onDelete: () {
//                                         // Handle delete action
//                                       },
//                                     ),
//                                   );
//                                 },
//                                 icon: Icon(
//                                   size: 18,
//                                   Icons.delete_outline,
//                                   color: Color(0xffF6928A),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
