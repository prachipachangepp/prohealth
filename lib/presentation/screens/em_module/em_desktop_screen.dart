import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/manage_emp_doc.dart';
import 'package:prohealth/presentation/screens/home_module/home_screen.dart';
import '../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../widgets/widgets/const_appbar/controller.dart';
import '../hr_module/manage/widgets/bottom_row.dart';
import '../hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'company_identity/company_identity_screen.dart';
import 'company_identity/manage_button_screen.dart';
import 'manage_hr/hr_screen.dart';
import 'manage_hr/manage_pay_rates/finance_screen.dart';

class SMDesktop extends StatelessWidget {
  final PageController _pageController = PageController();
  final SMController smController = Get.put(SMController());
  final String? dropdownValue;
  final ValueChanged<String?>? onChanged;
  final HRController hrController = Get.put(HRController());
  final VoidCallback? onItem2Selected;
  String selectedOption = 'Select';
  // final controller = Get.put(DropdownController());
  // final PageController pageController;
  bool showSelectOption = true;
  final ButtonSelectionController myController =
      Get.put(ButtonSelectionController());
  // final PageController _pageController = PageController();
  SMDesktop({
    this.dropdownValue,
    this.onChanged,
    this.onItem2Selected,
  });

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                height: 460,
                  width: 500,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    // Add your content here
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void navigateToPage2() {
    if (_pageController.page != 2) {
      _pageController.animateToPage(
        2,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(

                    child: Image.asset(
                      'images/logo_login.png',
                      fit: BoxFit.fill,
                    ),
                  )),
              Expanded(
                flex: 10,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height / 13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff51B5E6),
                          Color(0xff008ABD),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        // begin: Alignment.centerLeft,
                        // end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///ask klip
                        Container(
                          width: 96,
                          height: MediaQuery.of(context).size.height / 17,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset("images/mike.png"),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Ask',
                                      style: GoogleFonts.jost(
                                          color: Colors.white,
                                          fontSize: 10,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text("KLIP",
                                        style: GoogleFonts.jost(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 12,
                        ),
                        ///em text
                        Row(
                          children: [
                            Container(

                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Establishment Manager',
                                    style: TextStyle(
                                      fontFamily: 'Fira Sans',
                                      fontSize: FontSize.s14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff2B647F),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                   SizedBox(width: 10,),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Color(0xff434343),
                                      size:
                                          MediaQuery.of(context).size.width /
                                              100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 33,
                              height: 33,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xff2B647F), // Icon color
                                    size: 20, // Icon size
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ///plus
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                        Material(
                          elevation: 4,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                          child: Container(
                              height:
                                  MediaQuery.of(context).size.height / 19,
                              width:
                                  MediaQuery.of(context).size.width / 10,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                color: Colors.white,
                              ),
                              child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      'images/phone_app_bar.svg',

                                    ),

                                    SvgPicture.asset(
                                      'images/message_app_bar.svg',

                                    ),

                                    SvgPicture.asset(
                                      'images/email_app_bar.svg',

                                    ),
                                  ])),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 20,
                        ),
                        ///dropdown
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white,width: 2),
                                color: Colors.transparent,
                              ),
                              child: Obx(
                                () => Center(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size:
                                          MediaQuery.of(context).size.width /
                                              89,
                                      color: Colors.white,
                                    ),
                                    dropdownColor: ColorManager.white,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              92,
                                      color: Colors.white,
                                    ),
                                    underline: Container(),
                                    value: hrController.selectedItem.value,
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        hrController
                                            .changeSelectedItem(newValue);
                                      }
                                    },
                                    items: ['Admin', 'Staff', 'Patient']
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: hrController
                                                            .selectedItem
                                                            .value ==
                                                        value
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontFamily: 'FiraSans',
                                                fontSize: 11,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.white, // Splash color
                              onTap: () {},
                              child: SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width / 37,
                                  height: 25,
                                  child: Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width /
                                        68,
                                  )),
                            ),
                            InkWell(
                              splashColor: Colors.white,
                              onTap: () {},
                              child: SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width / 37,
                                  height: 25,
                                  child: Icon(
                                    Icons.settings_outlined,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).size.width /
                                        68,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 50,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Image.asset("images/profile.png"),
                              ),
                            ),
                            SizedBox(height: 2),
                            Expanded(
                              child: Text(
                                "William Christiana ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontFamily: 'FiraSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),

          ///2nd  buttons
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width / 100),
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                              () => CustomTitleButton(
                            height: 30,
                            width: 100,
                            onPressed: () {
                              //companyAll(context);
                              myController.selectButton(0);
                              _pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            text: 'Dashboard',
                            isSelected:
                            myController.selectedIndex.value == 0,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Obx(
                              () => CustomTitleButton(
                            height: 30,
                            width: 140,
                            onPressed: () {
                              // uploadCompanyLogoApi(context, 5, "employ");
                              companyByIdApi(context, 18);
                              // companyDetailsApi(context,5);
                              myController.selectButton(1);
                              _pageController.animateToPage(1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            text: 'Company Identity',
                            isSelected:
                            myController.selectedIndex.value == 1,
                          ),
                        ),

                        SizedBox(
                          width: 10,
                        ),

                        Obx(
                              () => CustomDropdownButton(
                            height: 34,
                            width: 140,
                            items: [
                              'Select a module',
                              'HR',
                              'All from HR',
                              'Work Schedule',
                              'Employee Documents',
                              'Finance',
                              'Pay Rates',
                            ],
                            selectedItem: myController.selectedIndex.value == 2
                                ? 'HR'
                                : myController.selectedIndex.value == 3
                                ? 'Work Schedule'
                                : myController.selectedIndex.value == 4
                                ? 'Employee Documents'
                                : myController.selectedIndex.value == 5
                                ? 'Finance'
                                : 'Select a module',
                            onChanged: (newValue) {
                              if (newValue == 'HR' || newValue == 'All from HR') {
                                myController.selectButton(2);
                                _pageController.animateToPage(
                                  2,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              } else if (newValue == 'Work Schedule') {
                                myController.selectButton(3);
                                _pageController.animateToPage(
                                  3,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              } else if (newValue == 'Employee Documents') {
                                myController.selectButton(4);
                                _pageController.animateToPage(
                                  4,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              } else if (newValue == 'Finance' || newValue == 'Pay Rates') {
                                myController.selectButton(5);
                                _pageController.animateToPage(
                                  5,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
                            },
                          ),
                        ),



                        ///main
                        // Obx(() => CustomDropdownButton(
                        //       height: 34,
                        //       width: 140,
                        //       items: ['Select a module', 'HR', 'Finance'],
                        //       selectedItem: myController.selectedIndex.value == 2
                        //           ? 'HR'
                        //           : myController.selectedIndex.value == 3
                        //               ? 'Finance'
                        //               : 'Select a module',
                        //       onChanged: (newValue) {
                        //         if (newValue == 'HR') {
                        //           myController.selectButton(2);
                        //           _pageController.animateToPage(2, duration: Duration(milliseconds: 500),
                        //             curve: Curves.ease,
                        //           );
                        //         } else if (newValue == 'Finance') {
                        //           myController.selectButton(3);
                        //           _pageController.animateToPage(3, duration: Duration(milliseconds: 500),
                        //             curve: Curves.ease,
                        //           );
                        //         }
                        //       },
                        //     ),),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(
                                () => CustomTitleButton(
                              height: 30,
                              width: 100,
                              onPressed: () {
                                //companyAll(context);
                                myController.selectButton(7);
                                _pageController.animateToPage(7,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              },
                              text: 'Manage',
                              isSelected:
                              myController.selectedIndex.value == 7,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 8,
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(color: Colors.white),
                CompanyIdentityScreen(),
                HrScreen(),
                Container(color: Colors.pink,),
                ManageEmployDocument(),
                FinanceScreen(),
                ManagePopUpScreen(),
              ],
            ),
          ),
          BottomBarRow()
        ],
      ),


    ]);
  }

}

class SMController extends GetxController {
  var selectedItem = 'Admin'.obs;
  void changeSelectedItem(String newItem) {
    selectedItem.value = newItem;
  }
}

class ButtonSelectionController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void selectButton(int index) {
    selectedIndex.value = index;
  }
}






// Positioned( // Positioned widget to overlay the bottom sheet
// bottom: 0,
// left: 0,
// right: 0,
// child: GestureDetector( // Add gesture detector for the "Whitelabelling" button
// onTap: () {
// showModalBottomSheet(
// context: context,
// isScrollControlled: true,
// builder: (BuildContext context) {
// return SingleChildScrollView(
// child: Container(
// padding: EdgeInsets.only(
// bottom: MediaQuery.of(context).viewInsets.bottom,
// ),
// width: double.infinity,
// decoration: BoxDecoration(
// color: Colors.red,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(12.0),
// topRight: Radius.circular(12.0),
// ),
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// IconButton(
// onPressed: () {
// Navigator.pop(context);
// },
// icon: Icon(Icons.close),
// ),
// ],
// ),
// // Add your content here
// ],
// ),
// ),
// );
// },
// );
// },
// child: Container(
// height: 40,
// width: MediaQuery.of(context).size.width / 3,
// color: Colors.blue, // Change color as needed
// child: Center(
// child: Text(
// 'Whitelabelling',
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// ),
// ),
// ),