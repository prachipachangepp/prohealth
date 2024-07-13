// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/presentation/screens/hr_module/see_all_hr/administration_hr.dart';
// import 'package:prohealth/presentation/screens/hr_module/see_all_hr/clinical_hr.dart';
// import 'package:prohealth/presentation/screens/hr_module/see_all_hr/sales_hr.dart';
//
// import '../../../../app/resources/color.dart';
//
// class SeeAllHrScreen extends StatefulWidget {
//   const SeeAllHrScreen({super.key});
//
//   @override
//   State<SeeAllHrScreen> createState() => _SeeAllHrScreenState();
// }
//
// class _SeeAllHrScreenState extends State<SeeAllHrScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
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
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 49.0, right: 49.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               InkWell(
//                 onTap: (){Navigator.pop(context);},
//                 child: Text(
//                   'Go Back',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: ColorManager.mediumgrey,
//                     decoration: TextDecoration.underline,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: TabBar(
//                   controller: _tabController,
//                   tabs: [
//                     _buildTabWithCircle('Clinical', '1,366', _tabController.index == 0),
//                     _buildTabWithCircle('Sales', '1,234', _tabController.index == 1),
//                     _buildTabWithCircle('Administration', '567', _tabController.index == 2),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return PopUp();
//                     },
//                   );
//                 },
//                 child: SvgPicture.asset('images/menu_lines.svg'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   backgroundColor: Color(0xff50B5E5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(9),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 ClinicalHrScreen(),
//                 SalesHrScreen(),
//                 AdministrationHrScreen(),
//               ],
//             ),
//           ),
//         ],
//       )
//
//     );
//   }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/sales_hr.dart';

import 'administration_hr.dart';
import 'clinical_hr.dart';

class SeeAllHrScreen extends StatefulWidget {
  const SeeAllHrScreen({super.key});

  @override
  State<SeeAllHrScreen> createState() => _SeeAllHrScreenState();
}

class _SeeAllHrScreenState extends State<SeeAllHrScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabWithCircle(int selectedIndex) {
    return Padding(
      padding: EdgeInsets.only(left: 180.0, right: 180.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xff50B5E5),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildSingleTab('Clinical', '1,366', selectedIndex == 0, true, false),
            _buildSingleTab('Sales', '1,234', selectedIndex == 1, false, false),
            _buildSingleTab('Administration', '567', selectedIndex == 2, false, true),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleTab(String text, String number, bool isSelected, bool isLeft, bool isRight) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          int index = isLeft ? 0 : (isRight ? 2 : 1);
          setState(() {
            _tabController.index = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Color(0xff50B5E5),
            borderRadius: BorderRadius.only(
              topLeft:  Radius.circular(40) ,
              bottomLeft: Radius.circular(40) ,
              topRight:  Radius.circular(40) ,
              bottomRight: Radius.circular(40) ,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Color(0xff686464) : Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              if (isSelected && number.isNotEmpty)
                Container(
                  height: 31,
                  width: 31,
                  margin: EdgeInsets.only(left: 24),
                  // padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xff50B5E5),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      number,
                      style: GoogleFonts.firaSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 49.0, right: 49.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){Navigator.pop(context);},
                child: Text(
                  'Go Back',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF686464),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Expanded(
                child: _buildTabWithCircle(_tabController.index),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PopUp();
                    },
                  );
                },
                child: SvgPicture.asset('images/menu_lines.svg'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  backgroundColor: Color(0xff50B5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ClinicalHrScreen(),
                SalesHrScreen(),
                AdministrationHrScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopUp extends StatefulWidget {
  const PopUp({Key? key}) : super(key: key);

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {


  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Patient Profile',
                  style: GoogleFonts.firaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2C535F),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  ConstantContainerWithText(text: 'RN'),
                  SizedBox(width: MediaQuery.of(context).size.width / 90),
                  ConstantContainerWithText(text: 'LVN'),
                  SizedBox(width: MediaQuery.of(context).size.width / 90),
                  ConstantContainerWithText(text: 'PT'),
                  SizedBox(width: MediaQuery.of(context).size.width / 90),
                  ConstantContainerWithText(text: 'PTA'),
                  SizedBox(width: MediaQuery.of(context).size.width / 90),
                  ConstantContainerWithText(text: 'HHA'),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 45),
              Row(
                children: [
                  ConstantContainerWithText(text: 'COTA'),
                  SizedBox(width: MediaQuery.of(context).size.width / 90),
                  ConstantContainerWithText(text: 'ST'),
                  SizedBox(width: MediaQuery.of(context).size.width / 90),
                  ConstantContainerWithText(text: 'MSW'),
                  SizedBox(width: MediaQuery.of(context).size.width / 90),
                  ConstantContainerWithText(text: 'OT'),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Text(
                    'Office Location',
                    style: GoogleFonts.firaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff737373),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Container(
                    height: 27,
                    width: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        'San Jose',
                        style: GoogleFonts.firaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                  Container(
                    height: 27,
                    width: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        'Zone 1',
                        style: GoogleFonts.firaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Row(
                children: [
                  Text(
                    'License status',
                    style: GoogleFonts.firaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff737373),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Container(
                    height: 27,
                    width: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        'Expired',
                        style: GoogleFonts.firaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 25),
              Row(
                children: [
                  Text(
                    'Availability',
                    style: GoogleFonts.firaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff737373),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Container(
                    height: 27,
                    width: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        'Full-Time',
                        style: GoogleFonts.firaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
  _ConstantContainerWithTextState createState() => _ConstantContainerWithTextState();
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
            style: GoogleFonts.firaSans(
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

////
