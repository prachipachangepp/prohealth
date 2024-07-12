// import 'package:flutter/material.dart';
// import 'package:prohealth/presentation/screens/hr_module/see_all_hr/administration_hr.dart';
// import 'package:prohealth/presentation/screens/hr_module/see_all_hr/clinical_hr.dart';
// import 'package:prohealth/presentation/screens/hr_module/see_all_hr/sales_hr.dart';
// import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/see_all_tab_bar_constant.dart';
//
// import '../../../../app/resources/const_string.dart';
// import '../manage/controller/controller.dart';
//
// class SeeAllHrScreen extends StatefulWidget {
//   const SeeAllHrScreen({super.key});
//
//   @override
//   State<SeeAllHrScreen> createState() => _SeeAllHrScreenState();
// }
//
// class _SeeAllHrScreenState extends State<SeeAllHrScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SeeAllHrTabBar(SeeAllHrController(tabs: [
//             _buildTabWithCircle('Clinical', '1'),
//             _buildTabWithCircle('Sales', '2'),
//             _buildTabWithCircle('Administration', '3'),
//           ], tabViews: [
//             ClinicalHrScreen(),
//             SalesHrScreen(),
//             AdministrationHrScreen()
//           ]))
//         ]);
//   }
//
//
//
// Widget _buildTabWithCircle(String text, String number) {
//   return Tab(
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(text),
//         SizedBox(width: 8),
//         Container(
//           width: 24,
//           height: 24,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.blue,
//           ),
//           child: Center(
//             child: Text(
//               number,
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
// }
// //


//
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/administration_hr.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/clinical_hr.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/sales_hr.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/drop_down.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/see_all_tab_bar_constant.dart';

import '../../../../app/resources/const_string.dart';
import '../manage/controller/controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 49.0, right: 49.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    _buildTabWithCircle('Clinical', '1,366', _tabController.index == 0),
                    _buildTabWithCircle('Sales', '1,234', _tabController.index == 1),
                    _buildTabWithCircle('Administration', '567', _tabController.index == 2),
                  ],
                ),
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

  Widget _buildTabWithCircle(String text, String number, bool isSelected) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          if (isSelected)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
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
      title: Expanded(
        child: Container(
          height: 350,
          width: 350,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Patient Profile',
                  style: GoogleFonts.firaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2C535F)
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/60),
              Row(
                children: [
                  ConstantContainerWithText(
                      text: 'RN'
                  ),
        
                  SizedBox(width: MediaQuery.of(context).size.width/90),
                  ConstantContainerWithText(
                      text: 'LVN'
                  ),
        
                  SizedBox(width: MediaQuery.of(context).size.width/90),
                  ConstantContainerWithText(
                      text: 'PT'
                  ),
        
                  SizedBox(width: MediaQuery.of(context).size.width/90),
                  ConstantContainerWithText(
                      text: 'PTA'
                  ),
        
                  SizedBox(width: MediaQuery.of(context).size.width/90),
                  ConstantContainerWithText(
                      text: 'HHA'
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/45),
              Row(
                children: [
                  ConstantContainerWithText(
                      text: 'COTA'
                  ),
        
                  SizedBox(width: MediaQuery.of(context).size.width/90),
                  ConstantContainerWithText(
                      text: 'ST'
                  ),
        
                  SizedBox(width: MediaQuery.of(context).size.width/90),
                  ConstantContainerWithText(
                      text: 'MSW'
                  ),
        
                  SizedBox(width: MediaQuery.of(context).size.width/90),
                  ConstantContainerWithText(
                      text: 'OT'
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/60),
              Row(
                children: [
                  Text('Office Location',
                    style: GoogleFonts.firaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff737373)
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/60),
              Row(
                children: [
                  Container(
                    height: 27,
                    width: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.black,
                      ),
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
                  SizedBox(width: MediaQuery.of(context).size.width/20),
                  Container(
                    height: 27,
                    width: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.black,
                      ),
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
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/25),
              Row(
                children: [
                  Text(
                    'License status',
                    style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff737373)
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/60),
              Row(
                children: [
                  Container(
                    height: 27,
                    width: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.black,
                      ),
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
              SizedBox(height: MediaQuery.of(context).size.height/25),
              Row(
                children: [
                  Text(
                    'Availability',
                    style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff737373)
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/60),
              Row(
                children: [
                  Container(
                    height: 27,
                    width: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.black,
                      ),
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




// AlertDialog(
// title: Container(
// height: 32,
// width: 932,
// color: Color(0xff50B5E5),
// child: Row(
// children: [
// Text(
// 'Edit',
// style: GoogleFonts.firaSans(
// fontSize: 16,
// fontWeight: FontWeight.w700,
// color: Colors.white,
// ),
// ),
// ],
// ),
// ),
// content: Column(
// mainAxisSize: MainAxisSize.min,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// ElevatedButton(
// onPressed: () {},
// child: Row(
// children: [
// Text(
// 'Upload Resume',
// style: GoogleFonts.firaSans(
// fontSize: 10,
// fontWeight: FontWeight.w700,
// color: Colors.white,
// ),
// ),
// SizedBox(width: 8),
// Icon(Icons.file_upload_outlined, color: Colors.white),
// ],
// ),
// style: ElevatedButton.styleFrom(
// padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// backgroundColor: Color(0xff50B5E5),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12),
// ),
// ),
// ),
// SizedBox(width: MediaQuery.of(context).size.width / 100),
// ElevatedButton(
// onPressed: () {},
// child: Row(
// children: [
// Text(
// 'Upload Photo',
// style: GoogleFonts.firaSans(
// fontSize: 10,
// fontWeight: FontWeight.w700,
// color: Colors.white,
// ),
// ),
// SizedBox(width: 8),
// Icon(Icons.file_upload_outlined, color: Colors.white),
// ],
// ),
// style: ElevatedButton.styleFrom(
// padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// backgroundColor: Color(0xff50B5E5),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12),
// ),
// ),
// ),
// ],
// ),
// SizedBox(height: 16),
// Row(
// children: [
// Expanded(
// child: CustomTextFieldRegister(
// labelText: 'First Name',
// ),
// ),
// SizedBox(width: MediaQuery.of(context).size.width/120,),
// Expanded(
// child: CustomTextFieldRegister(
// labelText: 'Last Name',
// ),
// ),
// SizedBox(width: MediaQuery.of(context).size.width/120,),
// Expanded(
// child: CustomDropdown(
// labelText: 'Type of Clinician',
// items: [
// 'option 1',
// 'option 2',
// 'option 3',
// 'option 4',
// ],
// value: dropdownValue,
// onChanged: (value) {
// setState(() {
// dropdownValue = value;
// });
// },
//
// )
// )
// ],
// ),
// ],
// ),
// actions: <Widget>[
// TextButton(
// onPressed: () {
// Navigator.of(context).pop();
// },
// child: Text('Close'),
// ),
// ],
// );