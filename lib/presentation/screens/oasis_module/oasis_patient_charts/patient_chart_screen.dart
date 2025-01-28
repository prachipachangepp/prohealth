import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prohealth/presentation/screens/oasis_module/oasis_patient_charts/widget/administrative_info.dart';
import 'package:prohealth/presentation/screens/oasis_module/oasis_patient_charts/widget/consent_for_care.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/resources/color.dart';
//import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';

import '../../../../app/resources/value_manager.dart';
import '../../hr_module/hr_home_screen/referesh_provider.dart';
import '../them_manager/oasis_them_mnager.dart';
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
final ButtonSelectionControlleroasis myController =
Get.put(ButtonSelectionControlleroasis());


// Method to update drawer content based on selected index
Widget _getDrawerContent(int index) {
  switch (index) {
    case 0:
      return Drawerrightside(); // Replace with the widget for Consent For Care
    case 1:
      return DrawerrightsideA(); // Replace with the widget for Administrative Information
    case 2:
      return DrawerrightsideB(); // Replace with the widget for Clinical Record Items
    // case 3:
    //   return PatientHistoryImmunization(); // Replace with the widget for Patient History/Immunization
    // case 33:
    //   return DiagnosisCodes(); // Replace with the widget for Diagnosis Codes
    default:
      return DefaultDrawerContent(); // Default content if no index is selected
  }
}


Future<void> _saveIndex(int index) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('currentIndex', index);
}

void onPageChanged(int index) {
  Provider.of<PageIndexProvider>(context, listen: false).setIndex(index);
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Container(
          color: Colors.white,
          child:_getDrawerContent(myController.selectedIndex.value),
        ),
      ),

      body: Stack(
        children:[
          SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                height: AppSize.s100,
                child: Row(
                  children: [
                    Container(
                      //width: 300,
                      decoration: BoxDecoration(
                        color: Color(0xFFB1D6F4).withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(

                        children: [
                          SizedBox(width: AppSize.s20,),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: SizedBox(
                                    width: AppSize.s60,
                                    height: AppSize.s60,
                                    child: Image.asset(
                                      'images/hr_dashboard/man.png', // Replace with your image path
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: AppSize.s15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppSize.s10),
                              Text("JOHN SCOTT", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                              SizedBox(height: AppSize.s12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("DOB", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color:  ColorManager.granitegray)),
                                      SizedBox(height: AppSize.s13),
                                      Text("Chart Number", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color:  ColorManager.granitegray)),
                                    ],
                                  ),
                                  SizedBox(width: AppSize.s30,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("08-03-1997 (27)", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ColorManager.textBlack,)),
                                      SizedBox(height: AppSize.s13),
                                      Text("123456", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ColorManager.textBlack,)),
                                    ],
                                  ),
                                  SizedBox(width: AppSize.s10,),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: AppSize.s20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: AppSize.s2),
                          Row(children: [
                            Text("OASIS RN Start Of Care", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorManager.granitegray)),
                          ],),
                          Row(
                            children: [
                              // Use GetX to reactively display the selected text
                              Obx(() => Text(
                                myController.selectedText.value,
                                style: BoldfontStyle.customTextStyle(context),
                              )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: AppSize.s10),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Color(0xFF51B5E6),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppSize.s10),
                            Container(
                              //width: AppSize.s300,
                              height: AppSize.s32,
                              child: TextField(
                                // controller: _controller,
                                textCapitalization:
                                TextCapitalization.words,
                                style: BoldfontStyle.customTextStyle(context),
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
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                                width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(0,'Consent For Care');
                              _pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(0);
                              onPageChanged(0);
                              pgeControllerId = 0;  }, text: 'Consent for Care', isSelected: myController.selectedIndex.value == 0,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100,
                              onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(1, 'Administrative Information');
                              _pageController.animateToPage(1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(1);
                              onPageChanged(1);
                              pgeControllerId = 1;  }, text: 'Administrative Information', isSelected: myController.selectedIndex.value == 1,),
                            SizedBox(height: 5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(2,'Clinical Record Items');
                              _pageController.animateToPage(2,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(2);
                              onPageChanged(2);
                              pgeControllerId = 2;  }, text: 'Clinical Record Items', isSelected: myController.selectedIndex.value == 2,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(3,'Patient History/Immunization');
                              _pageController.animateToPage(3,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(3);
                              onPageChanged(3);
                              pgeControllerId = 3;  }, text: 'Patient History/Immunization', isSelected: myController.selectedIndex.value == 3,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(4,'Living Arrangements');
                              _pageController.animateToPage(4,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(4);
                              onPageChanged(4);
                              pgeControllerId = 4;  }, text: 'Living Arrangements', isSelected: myController.selectedIndex.value == 4,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis(
                              height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(5,'Assistance');
                              _pageController.animateToPage(5,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(5);
                              onPageChanged(5);
                              pgeControllerId = 5;  }, text: 'Assistance',
                              isSelected: myController.selectedIndex.value == 5,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(6,'Safety Hazards/Emergency Plan');
                              _pageController.animateToPage(6,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(6);
                              onPageChanged(6);
                              pgeControllerId = 6;  }, text: 'Safety Hazards/Emergency Plan', isSelected: myController.selectedIndex.value == 6,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(7,'Vital Signs, Height & Weight');
                              _pageController.animateToPage(7,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(7);
                              onPageChanged(7);
                              pgeControllerId = 7;  }, text: 'Vital Signs, Height & Weight', isSelected: myController.selectedIndex.value == 7,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(8,'Pain');
                              _pageController.animateToPage(8,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(8);
                              onPageChanged(8);
                              pgeControllerId = 8;  }, text: 'Pain', isSelected: myController.selectedIndex.value == 8,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(9,'Hearing/Speech/Vision');
                              _pageController.animateToPage(9,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(9);
                              onPageChanged(9);
                              pgeControllerId = 9;  }, text: 'Hearing/Speech/Vision', isSelected: myController.selectedIndex.value == 9,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(10,'BIMS');
                              _pageController.animateToPage(10,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(10);
                              onPageChanged(10);
                              pgeControllerId = 10;  }, text: 'BIMS', isSelected: myController.selectedIndex.value == 10,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(11,'Neurological/Cognitive');
                              _pageController.animateToPage(11,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(11);
                              onPageChanged(11);
                              pgeControllerId = 11;  },  text: 'Neurological/Cognitive', isSelected: myController.selectedIndex.value == 11,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(12,'Mood');
                              _pageController.animateToPage(12,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(12);
                              onPageChanged(12);
                              pgeControllerId = 12;  }, text: 'Mood', isSelected: myController.selectedIndex.value == 12,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(13,'Behavior/Risk Factors');
                              _pageController.animateToPage(13,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(13);
                              onPageChanged(13);
                              pgeControllerId = 13;  }, text: 'Behavior/Risk Factors', isSelected: myController.selectedIndex.value == 13,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(14,'Respiratory');
                              _pageController.animateToPage(14,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(14);
                              onPageChanged(14);
                              pgeControllerId = 14;  }, text: 'Respiratory', isSelected: myController.selectedIndex.value == 14,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(15,'Cardiovascular');
                              _pageController.animateToPage(15,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(15);
                              onPageChanged(15);
                              pgeControllerId = 15;  }, text: 'Cardiovascular', isSelected: myController.selectedIndex.value == 15,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(16,'Genitourinary');
                              _pageController.animateToPage(16,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(16);
                              onPageChanged(16);
                              pgeControllerId = 16;  }, text: 'Genitourinary', isSelected: myController.selectedIndex.value == 16,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(17,'Gastrointestinal/Nutrition/Endocrine');
                              _pageController.animateToPage(17,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(17);
                              onPageChanged(17);
                              pgeControllerId = 17;  }, text: 'Gastrointestinal/Nutrition/Endocrine', isSelected: myController.selectedIndex.value == 17,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(18,'Integumentary/Wound Care');
                              _pageController.animateToPage(18,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(18);
                              onPageChanged(18);
                              pgeControllerId = 18;  }, text: 'Integumentary/Wound Care', isSelected: myController.selectedIndex.value == 18,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(19,'Ulcers/Surgical Wounds');
                              _pageController.animateToPage(19,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(19);
                              onPageChanged(19);
                              pgeControllerId = 19;  }, text: 'Ulcers/Surgical Wounds', isSelected: myController.selectedIndex.value == 19,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(20,'Musculoskeletal');
                              _pageController.animateToPage(20,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(20);
                              onPageChanged(20);
                              pgeControllerId = 20;  }, text: 'Musculoskeletal', isSelected: myController.selectedIndex.value == 20,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(21,'Functional Status');
                              _pageController.animateToPage(21,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(21);
                              onPageChanged(21);
                              pgeControllerId = 21;  }, text: 'Functional Status', isSelected: myController.selectedIndex.value == 21,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(22,'Functional Abilities and Goals');
                              _pageController.animateToPage(22,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(22);
                              onPageChanged(22);
                              pgeControllerId = 22;  }, text: 'Functional Abilities and Goals', isSelected: myController.selectedIndex.value == 22,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(23 ,'Fall Risk/ Therapy Need');
                              _pageController.animateToPage(23,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(23);
                              onPageChanged(23);
                              pgeControllerId = 23;  }, text: 'Fall Risk/ Therapy Need', isSelected: myController.selectedIndex.value == 23,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(24 ,'Medications');
                              _pageController.animateToPage(24,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(24);
                              onPageChanged(24);
                              pgeControllerId = 24;  }, text: 'Medications', isSelected: myController.selectedIndex.value == 24,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(25,'Infusion/Lab Draw');
                              _pageController.animateToPage(25,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(25);
                              onPageChanged(25);
                              pgeControllerId = 25;  }, text: 'Infusion/Lab Draw', isSelected: myController.selectedIndex.value == 25,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(26,'Special Treatment, Procedures, And Programs');
                              _pageController.animateToPage(26,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(26);
                              onPageChanged(26);
                              pgeControllerId = 26;  }, text: 'Special Treatment, Procedures,\nAnd Programs', isSelected: myController.selectedIndex.value == 26,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(27,'Rehospitalization Risk');
                              _pageController.animateToPage(27,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(27);
                              onPageChanged(27);
                              pgeControllerId = 27;  }, text: 'Rehospitalization Risk', isSelected: myController.selectedIndex.value == 27,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(28,'Interventions/Education Provided');
                              _pageController.animateToPage(28,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(28);
                              onPageChanged(28);
                              pgeControllerId = 28;  }, text: 'Interventions/Education Provided', isSelected: myController.selectedIndex.value == 28,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(29,'Assessment Summary');
                              _pageController.animateToPage(29,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(29);
                              onPageChanged(29);
                              pgeControllerId = 29;  }, text: 'Assessment Summary', isSelected: myController.selectedIndex.value == 29,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(30,'Supplies ');
                              _pageController.animateToPage(30,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(30);
                              onPageChanged(30);
                              pgeControllerId = 30;  }, text: 'Supplies ', isSelected: myController.selectedIndex.value == 30,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(31,'Plan of Care ');
                              _pageController.animateToPage(31,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(31);
                              onPageChanged(31);
                              pgeControllerId = 31;  }, text: 'Plan of Care ', isSelected: myController.selectedIndex.value == 31,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(32,'Care Planning/Coordination');
                              _pageController.animateToPage(32,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(32);
                              onPageChanged(32);
                              pgeControllerId = 32;  }, text: 'Care Planning/Coordination', isSelected: myController.selectedIndex.value == 32,),
                            SizedBox(height: AppSize.s5,),
                            CustomTitleButtonoasis( height: AppSize.s30,
                              width: AppSize.s100, onPressed: () { setState(() {});
                              //companyAll(context);
                              myController.selectButton(33,'Diagnosis Codes');
                              _pageController.animateToPage(33,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                              _saveIndex(33);
                              onPageChanged(33);
                              pgeControllerId = 33;  }, text: 'Diagnosis Codes', isSelected: myController.selectedIndex.value == 33,),
        
                            SizedBox(height: AppSize.s50,),
        
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                  height: MediaQuery.of(context).size.height / 1,
                    //  color: Colors.red,
                      child: PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ConsentForCare(),
                          AdministrativeInfo(),
                          Screen3(),
                          Screen4(),
        
        
        
                        ],
                      ),
                    )
                  ),
        
                ],
                          ),
              ),
            ],
          ),
        ),
        Positioned(
        top: 20, // You can adjust this top value to shift the button down or up
   // bottom: 2, // This makes it stick to the bottom
    right: 5, // Position it at the right side of the screen
    child: GestureDetector(
      onTap: () {
        Scaffold.of(context).openEndDrawer();
            //_scaffoldKey.currentState?.openEndDrawer();
            _scaffoldKey.currentState?.openEndDrawer();
            //_scaffoldKey.currentState?.openDrawer();
      },
      child: Container(
        width: AppSize.s40,
        height: AppSize.s200,
        decoration: BoxDecoration(
            color: ColorManager.drawerbutton,
            borderRadius:
            BorderRadius.horizontal(left: Radius.circular(20)),
            // border: Border.all(
            //     width: 2.0, color: Color.fromARGB(221, 8, 1, 24)),
        ),
        child:  RotatedBox(
            quarterTurns: 1,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text('Not Attempted Questions',
                  style: BluebuttonStyle.customTextStyle(context),

           textAlign: TextAlign.center)),
      ),
    )
        )
    // ),),
          // Positioned(
          //   top: 20, // Position it at the top of the screen
          //   right: 1, // Position it at the right side
          //   child:ElevatedButton(onPressed: (){
          //    // Scaffold.of(context).openEndDrawer();
          //     //_scaffoldKey.currentState?.openEndDrawer();
          //     _scaffoldKey.currentState?.openEndDrawer();
          //     //_scaffoldKey.currentState?.openDrawer();
          //   }, child: Text("Not Attempted Question"))
            ),
        ]
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
