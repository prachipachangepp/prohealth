import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/sales_hr.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../app/services/api/managers/hr_module_manager/manage_emp/search_byfilter.dart';
import 'administration_hr.dart';
import 'clinical_hr.dart';

// class SeeAllHrScreen extends StatefulWidget {
//   const SeeAllHrScreen({super.key});
//
//   @override
//   State<SeeAllHrScreen> createState() => _SeeAllHrScreenState();
// }
//
// class _SeeAllHrScreenState extends State<SeeAllHrScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int adminCount = 0;
//   int clinicalCount = 0;
//   int salesCount = 0;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   void updateAdminCount(int count) {
//     setState(() {
//       adminCount = count;
//       print('......${adminCount}');
//     });
//   }
//
//   void updateClinicalCount(int count) {
//     setState(() {
//       clinicalCount = count;
//       print('clinical......${clinicalCount}');
//     });
//   }
//
//   void updateSalesCount(int count) {
//     setState(() {
//       salesCount = count;
//       print('sales......${salesCount}');
//     });
//   }
//
//   Widget _buildTabWithCircle(int selectedIndex) {
//     return Container(
//       height: 30,
//       width: MediaQuery.of(context).size.width / 3,
//       decoration: BoxDecoration(
//         color: Color(0xff50B5E5),
//         borderRadius: BorderRadius.circular(40),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           _buildSingleTab('Clinical', clinicalCount.toString(),
//               selectedIndex == 0, true, false),
//           _buildSingleTab(
//               'Sales', salesCount.toString(), selectedIndex == 1, false, false),
//           _buildSingleTab('Administration', adminCount.toString(),
//               selectedIndex == 2, false, true),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSingleTab(
//       String text, String number, bool isSelected, bool isLeft, bool isRight) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           int index = isLeft ? 0 : (isRight ? 2 : 1);
//           setState(() {
//             _tabController.index = index;
//           });
//         },
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.white : Color(0xff50B5E5),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40),
//               bottomLeft: Radius.circular(40),
//               topRight: Radius.circular(40),
//               bottomRight: Radius.circular(40),
//             ),
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 5,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ]
//                 : [],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 text,
//                 style: TextStyle(
//                   color: isSelected ? Color(0xff686464) : Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 12,
//                 ),
//               ),
//               if (isSelected && number.isNotEmpty)
//                 Container(
//                   height: 40, // Increased height of container
//                   width: 40, // Increased width
//                   margin: EdgeInsets.only(left: 5),
//                   decoration: BoxDecoration(
//                     color: Color(0xff50B5E5),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       number,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                         fontSize: FontSize.s10,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 49.0, right: 49.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text(
//                   'Go Back',
//                   style: TextStyle(
//                     fontSize: FontSize.s12,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF686464),
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//               _buildTabWithCircle(_tabController.index),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     showDialog(
//               //       context: context,
//               //       builder: (BuildContext context) {
//               //         return ProfilePatientPopUp(onSearch: () {  },);
//               //       },
//               //     );
//               //   },
//               //   child: SvgPicture.asset('images/menu_lines.svg'),
//               //   style: ElevatedButton.styleFrom(
//               //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               //     backgroundColor: Color(0xff50B5E5),
//               //     shape: RoundedRectangleBorder(
//               //       borderRadius: BorderRadius.circular(9),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 ClinicalHrScreen(
//                   onClinicalCountChange: updateClinicalCount,
//                 ),
//                 SalesHrScreen(
//                   onSalesCountChange: updateSalesCount,
//                 ),
//                 AdministrationHrScreen(onAdminCountChange: updateAdminCount),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



///enums
enum OfficeLocation { sanJose, austin }
enum Zone { zone1, zone2 }
enum LicenseStatus { active, expired }
enum Availability { fullTime, partTime }
///
// class ProfilePatientPopUp extends StatefulWidget {
//   final VoidCallback onSearch;
//
//   const ProfilePatientPopUp({Key? key, required this.onSearch}) : super(key: key);
//
//   @override
//   State<ProfilePatientPopUp> createState() => _PopUpState();
// }
//
// class _PopUpState extends State<ProfilePatientPopUp> {
//   String? dropdownOfficeLocation;
//   String? dropdownZone;
//   String? dropdownLicenseStatus;
//   String? dropdownAvailability;
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       titlePadding: EdgeInsets.zero,
//       backgroundColor: Colors.white,
//       title: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(8.0),
//             topRight: Radius.circular(8.0),
//           ),
//           color: Color(0xff50B5E5),
//         ),
//         height: 32,
//         width: 300,
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Patient Profile',
//                 style: GoogleFonts.firaSans(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             Spacer(),
//             IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 Icons.close,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Other UI elements...
//             SizedBox(height: MediaQuery.of(context).size.height / 160),
//             Row(
//               children: [
//                 ConstantContainerWithText(text: 'RN'),
//                 SizedBox(width: MediaQuery.of(context).size.width / 90),
//                 ConstantContainerWithText(text: 'LVN'),
//                 SizedBox(width: MediaQuery.of(context).size.width / 90),
//                 ConstantContainerWithText(text: 'PT'),
//                 SizedBox(width: MediaQuery.of(context).size.width / 90),
//                 ConstantContainerWithText(text: 'PTA'),
//                 SizedBox(width: MediaQuery.of(context).size.width / 90),
//                 ConstantContainerWithText(text: 'HHA'),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 45),
//             Row(
//               children: [
//                 ConstantContainerWithText(text: 'COTA'),
//                 SizedBox(width: MediaQuery.of(context).size.width / 90),
//                 ConstantContainerWithText(text: 'ST'),
//                 SizedBox(width: MediaQuery.of(context).size.width / 90),
//                 ConstantContainerWithText(text: 'MSW'),
//                 SizedBox(width: MediaQuery.of(context).size.width / 90),
//                 ConstantContainerWithText(text: 'OT'),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 30),
//             Row(
//               children: [
//                 Text(
//                   'Office Location',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff737373),
//                   ),
//                 ),
//                 SizedBox(width: MediaQuery.of(context).size.width / 11),
//                 Text(
//                   'Zone',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff737373),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 60),
//             Row(
//               children: [
//                 Container(
//                   width: 120,
//                   height: 30,
//                   child: CustomDropDown(
//
//                     items: ['San Joes', 'Austin'],
//                     labelText: 'Office Location',
//                     labelStyle: GoogleFonts.firaSans(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff737373),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         dropdownOfficeLocation = value;
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(width: MediaQuery.of(context).size.width / 20),
//                 Container(
//                   width: 120,
//                   height: 30,
//                   child: CustomDropDown(
//                     items: ['Zone 1', 'Zone 2'],
//                     labelText: 'Zone',
//                     labelStyle: GoogleFonts.firaSans(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff737373),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         dropdownZone = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 25),
//             Row(
//               children: [
//                 Text(
//                   'License status',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff737373),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 60),
//             Row(
//               children: [
//                 Container(
//                   width: 120,
//                   height: 30,
//                   child: CustomDropDown(
//
//                     items: ['Active', 'Expired'],
//                     labelText: 'License Status',
//                     labelStyle: GoogleFonts.firaSans(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff737373),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         dropdownLicenseStatus = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 25),
//             Row(
//               children: [
//                 Text(
//                   'Availability',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff737373),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 60),
//             Row(
//               children: [
//                 Container(
//                   width: 120,
//                   height: 30,
//                   child: CustomDropDown(
//
//                     items: ['Full-Time', 'Part-Time'],
//                     labelText: 'Availability',
//                     labelStyle: GoogleFonts.firaSans(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff737373),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         dropdownAvailability = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 25),
//             ElevatedButton(
//               onPressed: (){
//                 widget.onSearch();
//                 Navigator.pop(context);
//               },
//               child: Text('Search', style: GoogleFonts.firaSans(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

///
class ProfilePatientPopUp extends StatefulWidget {
  final Widget? zoneDropDown;
  final VoidCallback onSearch;
  final Widget officceIdWidget;
  final Widget licensesWidget;
  final Widget avabilityWidget;
  final Widget? abbrivationWidget;
  ProfilePatientPopUp({Key? key,
    required this.avabilityWidget,
    required this.licensesWidget,
     this.abbrivationWidget,
    required this.officceIdWidget,
    required this.onSearch, this.zoneDropDown,}) : super(key: key);

  @override
  State<ProfilePatientPopUp> createState() => _PopUpState();
}

class _PopUpState extends State<ProfilePatientPopUp> {
  String? dropdownValue;
  String? dropdownOfficeLocation;
  String? dropdownZone;
  String? dropdownLicenseStatus;
  String? dropdownAvailability;

  // Example method to call the API


  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: 480, height: 450,
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Office Location',
                        style:AllPopupHeadings.customTextStyle(context)
                      ),
                      SizedBox(height: 5,),
                      widget.officceIdWidget
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Zone', style: AllPopupHeadings.customTextStyle(context)),
                        SizedBox(height: 5,),
                        widget.zoneDropDown == null ? Offstage() : widget.zoneDropDown!
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Row(
                children: [
                  Text(
                    'License status',
                    style: AllPopupHeadings.customTextStyle(context)
                  ),
                  SizedBox(height:5),
                ],
              ),
              SizedBox(height: 5,),
              widget.licensesWidget,

              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Row(
                children: [
                  Text(
                    'Availability',
                    style: AllPopupHeadings.customTextStyle(context)
                  ),
                ],
              ),
              SizedBox(height: 5,),
              widget.avabilityWidget,

            ],
          ),
        )


    ],
      bottomButtons:  ElevatedButton(
        onPressed: (){
          widget.onSearch();
          Navigator.pop(context);
        },
        child: Text('Search', style: BlueButtonTextConst.customTextStyle(context),),
      ), title: 'Clinician Search Filter',
    );
  }
}













class ConstantContainerWithText extends StatefulWidget {
  final String text;

  const ConstantContainerWithText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _ConstantContainerWithTextState createState() =>
      _ConstantContainerWithTextState();
}

class _ConstantContainerWithTextState extends State<ConstantContainerWithText> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _isSelected ? Color(0xff4FB8EB) : Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        height: 27,
        width: 31,
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: _isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
