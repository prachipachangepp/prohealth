import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/profile_mnager.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/dashoboard_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/new_onboard_screen.dart';
import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../widgets/app_bar/app_bar.dart';
import '../../../widgets/widgets/const_appbar/controller.dart';
import '../../em_module/em_desktop_screen.dart';
import '../add_employee/add_employee_screen.dart';
import '../manage/web_manage/manage_screen.dart';
import '../manage/widgets/custom_icon_button_constant.dart';
import '../register/register_screen.dart';
import '../see_all_hr/see_all_hr_screen.dart';

class HomeHrScreen extends StatefulWidget {
  const HomeHrScreen({super.key});

  @override
  State<HomeHrScreen> createState() => _HomeHrScreenState();
}

class _HomeHrScreenState extends State<HomeHrScreen> {
  final PageController _pageController = PageController();
  final SMController smController = Get.put(SMController());
  late final String? dropdownValue;
  late final ValueChanged<String?>? onChanged;
  final HRController hrController = Get.put(HRController());
  late final VoidCallback? onItem2Selected;
  bool showSelectOption = true;
  final ButtonSelectionController myController =
  Get.put(ButtonSelectionController());
  String selectedOption = 'Select';
  int employeeId = 2;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ///log appbar
          ApplicationAppBar(headingText: "Human Resource Manager"),

          ///appbar titles
          Container(
            // color: Colors.pink,
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///heading bar
                Row(
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
                        isSelected: myController.selectedIndex.value == 0,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 55,
                    ),
                    Obx(
                          () => CustomTitleButton(
                        height: 30,
                        width: 140,
                        onPressed: () {
                          myController.selectButton(1);
                          _pageController.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'Manage',
                        isSelected: myController.selectedIndex.value == 1,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 55,
                    ),
                    Obx(
                          () => CustomTitleButton(
                          height: 30,
                          width: 140,
                          onPressed: () {
                            myController.selectButton(2);
                            _pageController.animateToPage(2,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          text: 'Add Employee',
                          isSelected: myController.selectedIndex.value == 2),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 55,
                    ),
                    Obx(
                          () => CustomTitleButton(
                        height: 30,
                        width: 140,
                        onPressed: () {
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'Register',
                        isSelected: myController.selectedIndex.value == 3,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 55,
                    ),
                    Obx(
                          () => CustomTitleButton(
                        height: 30,
                        width: 140,
                        onPressed: () {
                          myController.selectButton(4);
                          _pageController.animateToPage(4,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'Onboarding',
                        isSelected: myController.selectedIndex.value == 4,
                      ),
                    ),
                  ],
                ),
                MediaQuery.of(context).size.width >= 1024
                    ? Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 2),
                      width: 301,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xFF686464), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: searchController,
                        textAlign: TextAlign.start,
                        cursorHeight: 18,
                        cursorColor: ColorManager.black,
                        style: GoogleFonts.firaSans(fontSize: MediaQuery.of(context).size.width / 100),
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                          hintText: 'John S',
                          hintStyle: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.mediumgrey,
                            //decoration: TextDecoration.underline, // Remove underline from the text
                          ),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search,size: 20,),
                          contentPadding: EdgeInsets.only(left: 8,right: 8,bottom: 20),
                        ),
                        onChanged: (val){
                          setState(() {
                            employeeId = 9;
                            getSearchByEmployeeIdProfileByText(context,employeeId);
                          });

                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/70,
                    ),
                    MediaQuery.of(context).size.width >=1100 ?
                    Row(
                      children: [
                        Container(
                          width: 37,
                          height: 25,
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x40000000),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){

                            },
                            child: Center(
                                child: SvgPicture.asset('images/menuLines.svg')
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/90,
                        ),
                        Container(
                          width: 32,
                          height: 25,
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x40000000),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: (){

                            },
                            child: Center(
                              child: Text(
                                'DZ',textAlign: TextAlign.center,
                                style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s11,
                                  fontWeight: FontWeightManager.regular,
                                  color: ColorManager.black,
                                  //decoration: TextDecoration.underline, // Remove underline from the text
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ): SizedBox(width: 1,)
                  ],
                )
                    : SizedBox(
                  width: 1,
                ),

                ///see all
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                          () => CustomTitleButton(
                        height: 30,
                        width: 140,
                        onPressed: () {
                          //companyAll(context);
                          myController.selectButton(6);
                          _pageController.animateToPage(6,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        text: 'See All',
                        isSelected: myController.selectedIndex.value == 6,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          ///page view
          Expanded(
            flex: 8,
            child: FutureBuilder<SearchByEmployeeIdProfileData>(
                future: getSearchByEmployeeIdProfileByText(context,employeeId),
                builder: (context,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                  }

                  if(snapshot.hasData){
                    Map<String, dynamic> profileList;
                    SearchByEmployeeIdProfileData searchByEmployeeIdProfileData = snapshot.data!;
                    return PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        DashBoardScreen(searchByEmployeeIdProfileData: searchByEmployeeIdProfileData,),
                        ManageScreen(searchByEmployeeIdProfileData: searchByEmployeeIdProfileData,),
                        AddEmployeeHomeScreen(),
                        RegisterScreen(),
                        NewOnboardScreen(),
                        SeeAllHrScreen()
                      ],
                    );
                  }
                  return SizedBox();

                }
            ),
          ),
          // BottomAppBar()
        ],
      ),
    );
  }
}
