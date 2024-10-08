// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/hr_module/add_employee/widget/administration.dart';
// import 'package:prohealth/presentation/screens/hr_module/add_employee/widget/clinical.dart';
// import 'package:prohealth/presentation/screens/hr_module/add_employee/widget/sales.dart';
// import '../../../../app/resources/color.dart';
// import '../../../../app/resources/font_manager.dart';
// import '../../../../app/resources/value_manager.dart';
// import '../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
// import '../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
// import '../manage/controller/controller.dart';
// import '../manage/widgets/bottom_row.dart';
// import 'addemployee_tab_bar_constant.dart';
//
// ///prachi
// class AddEmployeeHomeScreen extends StatefulWidget {
//   @override
//   State<AddEmployeeHomeScreen> createState() => _AddEmployeeHomeScreenState();
// }
//
// class _AddEmployeeHomeScreenState extends State<AddEmployeeHomeScreen> {
//   late AddEmployeeController controller;
//   final PageController _addEmployeePageController = PageController();
//   void _selectButton(int index) {
//     setState(() {
//       _selectedIndex = index;
//
//     });
//     _addEmployeePageController.animateToPage(
//       index,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.ease,
//     );
//   }
//   int _selectedIndex = 1;
//   @override
//   Widget build(BuildContext context) {
//     return  AddEmployeeWidget(
//       addEmplyPageController: _addEmployeePageController,
//       selectedIndex: _selectedIndex,
//       selectButton: _selectButton
//     );
//     //   Column(
//     //   children: [
//     //
//     //     // AddEmployeeTabBar(
//     //     //     AddEmployeeController(tabs: [
//     //     //   Tab(text: 'Clinical'),
//     //     //   Tab(text: 'Sales'),
//     //     //   Tab(text: 'Administration'),
//     //     // ], tabViews: [
//     //     //   ClinicalTab(),
//     //     //   SalesTab(),
//     //     //   AdministartionTab(),
//     //     // ])),
//     //   ],
//     // );
//   }
// }
//
//
// class AddEmployeeWidget extends StatefulWidget {
//   final PageController addEmplyPageController;
//   final int selectedIndex;
//   final Function(int) selectButton;
//   const AddEmployeeWidget({
//     required this.addEmplyPageController,
//     required this.selectedIndex,
//     required this.selectButton,
// });
//
//   @override
//   State<AddEmployeeWidget> createState() => _AddEmployeeWidgetState();
// }
//
// class _AddEmployeeWidgetState extends State<AddEmployeeWidget> {
//   @override
//   void initState() {
//     super.initState();
//     companyHRHeadApi(context, deptId);
//   }
//
//   var deptId = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
//             child: FutureBuilder<List<HRHeadBar>>(
//               future: companyHRHeadApi(context, deptId),
//               builder: (context, snapshot) {
//                 if(snapshot.hasData){
//                   return Material(
//                     elevation: 4,
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       height: AppSize.s25,
//                       width: MediaQuery.of(context).size.width / 2.99,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: ColorManager.blueprime,
//                         boxShadow: [
//                           BoxShadow(
//                             color: ColorManager.black.withOpacity(0.25),
//                             spreadRadius: 0,
//                             blurRadius: 4,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children:  [
//                             Expanded(
//                                 child: ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: snapshot.data!.length,
//                                     itemBuilder: (BuildContext context, int index) {
//                                       if (snapshot.connectionState ==
//                                           ConnectionState.waiting) {
//                                         // return
//                                         //   Center(
//                                         //   child: CircularProgressIndicator(
//                                         //     color: Colors.blue, // Change according to your theme
//                                         //   ),
//                                         // );
//                                       }
//                                       if(snapshot.hasData){
//                                         return InkWell(
//                                           onTap: (){
//                                             widget.selectButton(
//                                                 snapshot.data![index].deptId
//                                             );
//                                             companyHRHeadApi(
//                                                 context, snapshot.data![index].deptId);
//                                             deptId = snapshot.data![index].deptId;
//                                           },
//                                           child: Container(
//                                             height: 30,
//                                             width: MediaQuery.of(context).size.width / 9,
//                                             padding: EdgeInsets.all(4),
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(20),
//                                               color: widget.selectedIndex == snapshot.data![index].deptId
//                                                   ? Colors.white
//                                                   : null,
//                                             ),
//                                             child: Text(
//                                               snapshot.data![index].deptName,
//                                               textAlign: TextAlign.center,
//                                               style: GoogleFonts.firaSans(
//                                                 fontSize: 12,
//                                                 fontWeight: widget.selectedIndex == snapshot.data![index].deptId
//                                                     ? FontWeightManager.bold
//                                                     :FontWeightManager.semiBold,
//                                                 color: widget.selectedIndex == snapshot.data![index].deptId
//                                                     ? ColorManager.mediumgrey
//                                                     : ColorManager.white,
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       }
//                                     }))
//                           ]
//                       ),
//                     ),
//                   );
//                 } else{
//                   return SizedBox(height: 1,width: 1,);
//                 }
//               },
//             ),
//           ),
//           Expanded(
//             flex: 10,
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width / 60),
//               child: PageView(
//                 controller: widget.addEmplyPageController,
//                 physics: NeverScrollableScrollPhysics(),
//                 children: [
//                     // Container(),
//                     ClinicalTab(),
//                     ClinicalTab(),
//                     SalesTab(),
//                     AdministartionTab(),
//                     // Container(),
//                   // HrClinicalScreen(deptId: deptId,),
//                   // HrClinicalScreen(deptId: deptId,),
//                   // HrSalesScreen(deptId: deptId,),
//                   // HrAdministrativeScreen(deptId: deptId,),
//                 ],
//               ),
//             ),
//           ),
//           // Row(
//           //   children: [BottomBarRow()],
//           // )
//         ],
//       ),
//     );
//   }
// }
