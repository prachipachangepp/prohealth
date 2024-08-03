import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/profile_mnager.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import 'package:prohealth/presentation/screens/em_module/em_desktop_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/add_employee/add_employee_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/dashoboard_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/web_manage/manage_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/new_onboard_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/register_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/see_all_hr_screen.dart';
import 'package:prohealth/presentation/widgets/app_bar/app_bar.dart';
import 'package:prohealth/presentation/widgets/widgets/const_appbar/controller.dart';

class HomeHrScreen extends StatefulWidget {
  const HomeHrScreen({super.key});

  @override
  State<HomeHrScreen> createState() => _HomeHrScreenState();
}

class _HomeHrScreenState extends State<HomeHrScreen> {
  PageController _pageController = PageController();
  final EMController smController = Get.put(EMController());
  late final String? dropdownValue;
  late final ValueChanged<String?>? onChanged;
  final HRController hrController = Get.put(HRController());
  late final VoidCallback? onItem2Selected;
  bool showSelectOption = true;
  final ButtonSelectionController myController =
      Get.put(ButtonSelectionController());
  String selectedOption = 'Select';
  TextEditingController searchController = TextEditingController();
  Future<List<SearchEmployeeProfileData>>? _searchFuture;

  TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;
  List<String> _searchResults = [];

  final LayerLink _layerLink = LayerLink();
  List<SearchEmployeeProfileData> data = [];

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 330,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: true,
          offset: Offset(0.0, 40),
          child: Material(
            elevation: 4.0,
            child: Column(
              children: [
                ..._searchResults.map((result) => ListTile(
                      title: Text(
                        result,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                      onTap: () {
                        _controller.text = result;
                        int id = 0;
                        for (var e in data) {
                          if (result == e.firstName + " " + e.lastName) {
                            id = e.employeeId;
                          }
                        }
                        _removeOverlay();
                        setState(() {
                          employeeId = id;
                          getSearchByEmployeeIdProfileByText(context,employeeId);
                          myController.selectButton(1);
                          _pageController = PageController(initialPage: 1);
                        });
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _search(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _removeOverlay();
      });
      return;
    }

    // Replace with your API endpoint

    data = await getSearchProfileByText(context, query);

    _searchResults = data.map((e) => e.firstName + " " + e.lastName).toList();
    print(_searchResults);
    _showOverlay();
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  int employeeId = 0;
  int pgeControllerId = 0;
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
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            pgeControllerId = 0;
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

                            pgeControllerId = 1;

                        },
                        text: 'Manage',
                        isSelected: myController.selectedIndex.value == 1,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 55,
                    ),
                    // Obx(
                    //   () => CustomTitleButton(
                    //       height: 30,
                    //       width: 140,
                    //       onPressed: () {
                    //         myController.selectButton(2);
                    //         _pageController.animateToPage(2,
                    //             duration: Duration(milliseconds: 500),
                    //             curve: Curves.ease);
                    //       },
                    //       text: 'Add Employee',
                    //       isSelected: myController.selectedIndex.value == 2),
                    // ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width / 55,
                    // ),
                    Obx(
                      () => CustomTitleButton(
                        height: 30,
                        width: 140,
                        onPressed: () {
                          myController.selectButton(2);
                          _pageController.animateToPage(2,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);

                            pgeControllerId = 2;


                        },
                        text: 'Register',
                        isSelected: myController.selectedIndex.value == 2,
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
                          myController.selectButton(3);
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);

                            pgeControllerId = 3;

                        },
                        text: 'Onboarding',
                        isSelected: myController.selectedIndex.value == 3,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width/20,),
                /// search text
                pgeControllerId == 2 || pgeControllerId == 3 ?  SizedBox() :Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        width: AppSize.s330,
                        height: 40,
                        child: CompositedTransformTarget(
                          link: _layerLink,
                          child: TextField(
                            controller: _controller,
                            style: GoogleFonts.firaSans(fontSize: 12),
                            onChanged: _search,
                            decoration: InputDecoration(
                                hintText: 'Search',
                                alignLabelWithHint: true,
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.regular,
                                  color: ColorManager.mediumgrey,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                suffixIcon: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  icon: Center(
                                    child: Icon(
                                      Icons.search,
                                      size: 18,
                                    ),
                                  ),
                                  onPressed: () {},
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5)),
                          ),
                        )),

                    /// formated text field
                    //     TextFormField(
                    //   controller: searchController,
                    //   // focusNode: focusNode,
                    //   // autofocus: true,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       getSearchProfileByText(
                    //           context, 5, searchController.text);
                    //       employeeId =
                    //           value == "" ? 0 : int.parse(value.toString());
                    //       getSearchByEmployeeIdProfileByText(
                    //           context, employeeId);
                    //       employeeId = 2;
                    //       getSearchByEmployeeIdProfileByText(
                    //           context, employeeId);
                    //     });
                    //   },
                    //   textAlign: TextAlign.start,
                    //   cursorHeight: 14,
                    //   cursorColor: ColorManager.black,
                    //   style: GoogleFonts.firaSans(
                    //     fontSize: 12,
                    //   ),
                    //   textAlignVertical: TextAlignVertical.center,
                    //   decoration: InputDecoration(
                    //       hintText: 'Search',
                    //       alignLabelWithHint: true,
                    //       hintStyle: GoogleFonts.firaSans(
                    //         fontSize: FontSize.s12,
                    //         fontWeight: FontWeightManager.regular,
                    //         color: ColorManager.mediumgrey,
                    //       ),
                    //       border: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(20))),
                    //       suffixIcon: IconButton(
                    //         icon: Center(
                    //           child: Icon(
                    //             Icons.search,
                    //             size: 18,
                    //           ),
                    //         ),
                    //         onPressed: () {},
                    //       ),
                    //       contentPadding: EdgeInsets.symmetric(
                    //           horizontal: 20, vertical: 5)),
                    // ),

                    /// using typeAheadField
                    // TypeAheadField(
                    //   controller: searchController,
                    //   suggestionsCallback: (name){
                    //     getSearchProfileByText(context, 5, name);
                    //
                    //   },
                    //   builder:(context, controller, focusNode) {
                    //     return TextFormField(
                    //       controller: controller,
                    //       focusNode: focusNode,
                    //       autofocus: true,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           //getSearchProfileById(context, 5, int.parse(name.toString()));
                    //           employeeId = value == "" ? 0 :int.parse(value.toString());
                    //           getSearchByEmployeeIdProfileByText(context,employeeId);
                    //           // employeeId = 2;
                    //           // getSearchByEmployeeIdProfileByText(context,employeeId);
                    //         });
                    //       },
                    //       textAlign: TextAlign.start,
                    //       cursorHeight: 12,
                    //       cursorColor: ColorManager.black,
                    //       style: GoogleFonts.firaSans(
                    //         fontSize: 12,
                    //       ),
                    //       textAlignVertical: TextAlignVertical.center,
                    //       decoration: InputDecoration(
                    //           hintText: 'Search',
                    //           alignLabelWithHint: true,
                    //           hintStyle: GoogleFonts.firaSans(
                    //             fontSize: FontSize.s12,
                    //             fontWeight: FontWeightManager.regular,
                    //             color: ColorManager.mediumgrey,
                    //           ),
                    //           border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.all(
                    //                   Radius.circular(20))),
                    //           suffixIcon: IconButton(
                    //             icon: Center(
                    //               child: Icon(
                    //                 Icons.search,
                    //                 size: 18,
                    //               ),
                    //             ),
                    //             onPressed: () {},
                    //           ),
                    //           contentPadding: EdgeInsets.symmetric(
                    //               horizontal: 20, vertical: 5)),
                    //     );
                    //   },
                    //     itemBuilder: (context, String value) {
                    //     print("::::::${value}");
                    //   return ListTile(
                    //     title: Text(value),
                    //   );
                    // }, onSelected: (value) {
                    //     searchController.text = value;
                    // },
                    // )
                     SizedBox(
                      width: MediaQuery.of(context).size.width / 70,
                    ),
                    MediaQuery.of(context).size.width >= 1100
                        ? Row(
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
                                  onTap: () {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return ProfilePatientPopUp();
                                    //   },
                                    // );
                                  },

                                  child: Center(
                                    child: SvgPicture.asset('images/menuLines.svg'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 90,
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
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      'DZ',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s11,
                                        fontWeight: FontWeightManager.regular,
                                        color: ColorManager.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(width: 1),
                  ],
                ),

                // SizedBox(
                //   height: 30,
                //         width: 140,
                // ),
                ///see all
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Obx(
                //       () => CustomTitleButton(
                //         height: 30,
                //         width: 140,
                //         onPressed: () {
                //           //companyAll(context);
                //           myController.selectButton(6);
                //           _pageController.animateToPage(6,
                //               duration: Duration(milliseconds: 500),
                //               curve: Curves.ease);
                //         },
                //         text: 'See All',
                //         isSelected: myController.selectedIndex.value == 6,
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),

          ///page view
          Expanded(
            flex: 8,
            child:FutureBuilder<SearchByEmployeeIdProfileData>(
                future: getSearchByEmployeeIdProfileByText(context, employeeId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ),
                    );
                  }
                  if (employeeId == 0) {
                    return PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        DashBoardScreen(),
                        Center(
                            child: Text(
                              AppString.dataNotFound,
                              style: CustomTextStylesCommon.commonStyle(
                                  fontWeight: FontWeightManager.medium,
                                  fontSize: FontSize.s12,
                                  color: ColorManager.mediumgrey),
                            )),
                        //AddEmployeeHomeScreen(),
                        RegisterScreen(),
                        NewOnboardScreen(),
                        //SeeAllHrScreen()
                      ],
                    );
                  }
                  if (snapshot.hasData) {
                    SearchByEmployeeIdProfileData
                    searchByEmployeeIdProfileData = snapshot.data!;
                    print("Employee ID:::${searchByEmployeeIdProfileData.employeeId!}");
                    return PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        DashBoardScreen(),
                        ManageScreen(
                          searchByEmployeeIdProfileData:
                          searchByEmployeeIdProfileData, employeeId: searchByEmployeeIdProfileData.employeeId!,
                        ),
                        //AddEmployeeHomeScreen(),
                        RegisterScreen(),
                        NewOnboardScreen(),
                      //  SeeAllHrScreen()
                      ],
                    );
                  }
                  return Container();
                }),

          ),
          // BottomAppBar()
        ],
      ),
    );
  }
}































