import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prohealth/presentation/screens/oasis_module/oasis_patient_charts/widget/consent_for_care.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../em_module/em_desktop_screen.dart';
import '../../hr_module/hr_home_screen/referesh_provider.dart';
import '../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../widgets/constant/blue_tabbar.dart';





class PatientChartScreen extends StatefulWidget {
  const PatientChartScreen({super.key});

  @override
  State<PatientChartScreen> createState() => _PatientChartScreenState();
}

class _PatientChartScreenState extends State<PatientChartScreen> {
  // Mixin to provide vsync (TickerProvider)
int selectindex =0;
PageController _pageController = PageController();

int pgeControllerId = 0;
final ButtonSelectionController myController =
Get.put(ButtonSelectionController());


Future<void> _saveIndex(int index) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('currentIndex', index);
}

void onPageChanged(int index) {
  Provider.of<PageIndexProvider>(context, listen: false).setIndex(index);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              height: 100,
              child: Row(
                children: [
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFFB1D6F4),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Image.asset(
                                    'images/hr_dashboard/man.png', // Replace with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text("JOHN SCOTT", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("DOB", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                                    SizedBox(height: 10),
                                    Text("Chart Number", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("08-03-1997 (27)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black)),
                                    SizedBox(height: 10),
                                    Text("123456", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
        
        
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2),
                        Row(children: [
                          Text("OASIS RN Start Of Care", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                        ],),
                        Row(children: [
                          Text("Consent For Care", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                        ],)
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    color: Color(0xFF51B5E6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          height: 32,
                          child: TextField(
                            // controller: _controller,
                            textCapitalization:
                            TextCapitalization.words,
                            style: DocumentTypeDataStyle.customTextStyle(context),
                            // onChanged: _search,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFF8F8F8),
                                hintText: 'Search',
                                alignLabelWithHint: true,
                                // hintStyle: DocumentTypeDataStyle.customTextStyle(context),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:Color(0xFFC9C9C9)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color:ColorManager.greylight ),
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                prefixIcon: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  icon: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 18,
                                      color:  ColorManager.greylight,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5)),
                          ),

                        ),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                            width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(0);
                          _pageController.animateToPage(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(0);
                          onPageChanged(0);
                          pgeControllerId = 0;  }, text: 'Consent for Care', isSelected: myController.selectedIndex.value == 0,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100,
                          onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(1);
                          _pageController.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(1);
                          onPageChanged(1);
                          pgeControllerId = 1;  }, text: 'Administrative Information', isSelected: myController.selectedIndex.value == 1,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(2);
                          _pageController.animateToPage(2,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(2);
                          onPageChanged(2);
                          pgeControllerId = 2;  }, text: 'Clinical Record Items', isSelected: myController.selectedIndex.value == 2,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Patient History/Immunization', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(4);
                          _pageController.animateToPage(4,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(4);
                          onPageChanged(4);
                          pgeControllerId = 4;  }, text: 'Living Arrangements', isSelected: myController.selectedIndex.value == 4,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(5);
                          _pageController.animateToPage(5,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(5);
                          onPageChanged(5);
                          pgeControllerId = 5;  }, text: 'Assistance', isSelected: myController.selectedIndex.value == 5,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(6);
                          _pageController.animateToPage(6,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(6);
                          onPageChanged(6);
                          pgeControllerId = 6;  }, text: 'Safety Hazards/Emergency Plan', isSelected: myController.selectedIndex.value == 6,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(7);
                          _pageController.animateToPage(7,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(7);
                          onPageChanged(7);
                          pgeControllerId = 7;  }, text: 'Vital Signs, Height & Weight', isSelected: myController.selectedIndex.value == 7,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Pain', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Hearing/Speech/Vision', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'BIMS', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Neurological/Cognitive', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Mood', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Behavior/Risk Factors', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Respiratory', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Cardiovascular', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Genitourinary', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Gastrointestinal/Nutrition/Endocrine', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Integumentary/Wound Care', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Ulcers/Surgical Wounds', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Musculoskeletal', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Functional Status', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Functional Abilities and Goals', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Fall Risk/ Therapy Need', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Medications', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Infusion/Lab Draw', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Special Treatment, Procedures,\nAnd Programs', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Rehospitalization Risk', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Interventions/Education Provided', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Assessment Summary', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Supplies ', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Plan of Care ', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Care Planning/Coordination', isSelected: myController.selectedIndex.value == 3,),
                        SizedBox(height: 5,),
                        CustomTitleButtonoasis( height: 30,
                          width: 100, onPressed: () { setState(() {});
                          //companyAll(context);
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                          _saveIndex(3);
                          onPageChanged(3);
                          pgeControllerId = 3;  }, text: 'Diagnosis Codes', isSelected: myController.selectedIndex.value == 3,),

                        SizedBox(height: 50,),

                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        ConsentForCare(),
                        Screen2(),
                        Screen3(),
                        Screen4(),


                      ],
                    ),
                  )
                ),

              ],
                        ),
            )
          ],
        ),
      ),
    );
  }
}






////


///
///
///
///



// class PatientChartScreen extends StatefulWidget {
//   const PatientChartScreen({super.key});
//
//   @override
//   State<PatientChartScreen> createState() => _PatientChartScreenState();
// }
//
// class _PatientChartScreenState extends State<PatientChartScreen> {
//
//
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this,);  // 4 tabs in this example
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           // This Row will have a height of 100
//           Container(
//             height: 100,
//            // color: Colors.blue,  // Set color for the top row
//             child: Row(
//               children: [
//                 Container(
//                   width: 450,
//                   //height: 200, // Height is also needed for a circular shape
//                   decoration: BoxDecoration(
//                     color: Color(0xFFB1D6F4), // Background color
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10),  // Circular border on top-right
//                       bottomRight: Radius.circular(10), // Circular border on bottom-right
//                     ), // Rounded border (half of the width for a circle)
//                   ),
//                   child: Row(
//                     children: [
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(60),
//                               child: SizedBox(
//                                 width: 60,
//                                 height: 60,
//                                 child: Image.asset(
//                                   'images/hr_dashboard/man.png', // Replace with your image path
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(width: 15),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 15),
// Text("JOHN SCOTT", style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s14,
//   fontWeight: FontWeight.w600,
//   color: ColorManager.textBlack,),),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("DOB", style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
//                                     fontWeight: FontWeight.w500,
//                                     color: ColorManager.mediumgrey,),),
//                                   SizedBox(height: 10),
//                                   Text("Chart Number", style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
//                                     fontWeight: FontWeight.w500,
//                                     color: ColorManager.mediumgrey,) ),
//                                 ],
//                               ),
//                               //SizedBox(height: 10),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text("08-03-1997 (27)", style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
//                                     fontWeight: FontWeight.w600,
//                                     color: ColorManager.textBlack,),),
//                                   SizedBox(height: 10),
//                                   Text("123456", style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
//                                     fontWeight: FontWeight.w600,
//                                     color: ColorManager.textBlack,),),
//                                 ],
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       // Add your widgets here
//                     ],
//                   ),
//                 )
//
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           // This SingleChildScrollView will make the container scrollable
//           Expanded(
//             child: SingleChildScrollView(
//               child: Container(
//                 child: Row(
//                   children: [
//                     // First Column with flex: 2
//                     Expanded(
//                       flex: 3,
//                       child: Container(
//                         color: Color(0xFF51B5E6),  // Color to identify this column
//                         child: Column(
//                           children: [
//                             TabBar(
//                               controller: _tabController,
//                               tabs: [
//                                 Tab(text: 'Tab 1'),
//                                 Tab(text: 'Tab 2'),
//                                 Tab(text: 'Tab 3'),
//                                 Tab(text: 'Tab 4'),
//                               ],
//                               labelColor: Colors.white,
//                               indicatorColor: Colors.white,
//                             ),
//                             SizedBox(
//                               height: 100,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     // Second Column with remaining space
//                     Expanded(
//                       flex: 7,
//                       child: Container(
//                         color: Colors.white,  // Color to identify this column
//                         child:  TabBarView(
//                           controller: _tabController,
//                           children: [
//                             // Content for Tab 1
//                             Center(child: Text('Content for Tab 1')),
//                             // Content for Tab 2
//                             Center(child: Text('Content for Tab 2')),
//                             // Content for Tab 3
//                             Center(child: Text('Content for Tab 3')),
//                             // Content for Tab 4
//                             Center(child: Text('Content for Tab 4')),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
// }
// }
