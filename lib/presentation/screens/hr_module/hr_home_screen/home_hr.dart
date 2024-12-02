import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/search_byfilter.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/profile_mnager.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import 'package:prohealth/presentation/screens/em_module/em_desktop_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/dashoboard_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/referesh_provider.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/web_manage/manage_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/bottom_row.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/new_onboard_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/register_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/see_all_hr_screen.dart';
import 'package:prohealth/presentation/widgets/app_bar/app_bar.dart';
import 'package:prohealth/presentation/widgets/widgets/const_appbar/controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/widgets/constant_textfield/const_textfield.dart';

class HomeHrScreen extends StatefulWidget {
  const HomeHrScreen({super.key});

  @override
  State<HomeHrScreen> createState() => _HomeHrScreenState();
}

class _HomeHrScreenState extends State<HomeHrScreen> {
  PageController _pageController = PageController();
  PageController _pageManageController = PageController();
  final EMController smController = Get.put(EMController());
  late final String? dropdownValue;
  late final ValueChanged<String?>? onChanged;
  final HRController hrController = Get.put(HRController());
  late final VoidCallback? onItem2Selected;
  bool showSelectOption = true;
  bool isSelected = false;
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
  List<ApiDataFilter> data1 = [];

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Detect taps outside the overlay to remove it
          GestureDetector(
            onTap: _removeOverlay,
            child: Container(
              color: Colors.transparent, // Make this transparent so it's invisible
            ),
          ),
          Positioned(
            width: 330,
            // height: 400,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: true,
              offset: Offset(0.0, 40),
              child: Material(
                elevation: 4.0,
                child: _searchResults.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 150),
                          child: Text(
                            'No User Found!',
                            style:
                                AllNoDataAvailable.customTextStyle(context),
                          ),
                        ),
                      )
                    : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _searchResults.length > 10 ? 400.0 : double.infinity,
                  ),
                      child: SingleChildScrollView(
                        child: Column(
                            children: [
                              ..._searchResults.map((result) => ListTile(
                                    title: Text(
                                      result,
                                      style: TextStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeightManager.regular,
                                        color: ColorManager.mediumgrey,
                                      ),
                                    ),
                                    onTap: data.isEmpty
                                        ? () {
                                            _controller.text = result;
                                            int id = 0;
                                            for (var e in data1) {
                                              if (result ==
                                                  e.firstName +
                                                      " " +
                                                      e.lastName) {
                                                id = e.employeeId;
                                              }
                                            }
                                            _removeOverlay();
                                            setState(() {
                                              employeeId = id;
                                              getSearchByEmployeeIdProfileByText(
                                                  context, employeeId);
                                              myController.selectButton(1);
                                              _pageController =
                                                  PageController(initialPage: 1);
                                            });
                                          }
                                        : () {
                                            _controller.text = result;
                                            int id = 0;
                                            for (var e in data) {
                                              if (result ==
                                                  e.firstName +
                                                      " " +
                                                      e.lastName) {
                                                id = e.employeeId;
                                              }
                                            }
                                            _removeOverlay();
                                            setState(() {
                                              employeeId = id;
                                              getSearchByEmployeeIdProfileByText(
                                                  context, employeeId);
                                              myController.selectButton(1);
                                              _pageController =
                                                  PageController(initialPage: 1);
                                            });
                                          },
                                  )),
                            ],
                          ),
                      ),
                    ),
                
              ),
            ),
          ),
        ],
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
    if (searchSelect == false) {
      print("Search using Normal");
      print('search value ${searchSelect}');
      data = await getSearchProfileByText(context, query);
      _searchResults = data.map((e) => e.firstName + " " + e.lastName).toList();
      print(_searchResults);
    } else if (searchSelect == true) {
      print("Search using hanBurger");
      data1 = await firstResult;
      _searchResults =
          data1.map((e) => e.firstName + " " + e.lastName).toList();
      print(_searchResults);
    }
    _showOverlay();
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  int selectedZoneId = 0;
  bool searchSelect = false;
  var firstResult;
  Future<void> _searchByFilter(
      {required int zoneId,
      required bool isZoneSelectedBool,
      required bool isReportingOffice,
      required String officeName,
      required bool isLicensesSelected,
      required String licenseStatusName,
      required bool isSelectAvailability,
      required String availabilityName}) async {
    final usrId = await TokenManager.getuserId();
    print('UserID:: ${usrId}');
    List<ApiDataFilter> result = await postSearchByFilter(
        context,
        false, // patientProfileSearch
        '', // profileName
        isReportingOffice, // officeLocationSearch
        officeName, // officeId
        isZoneSelectedBool, // zoneSearch
        zoneId, // zoneId
        isLicensesSelected, // licenseSearch
        licenseStatusName, // licenseStatus
        isSelectAvailability, // availabilitySearch
        availabilityName,
        isSelected,
        usrId
        // availability
        ) as List<ApiDataFilter>;
    print("Search : ${isSelected}");
    print('Search successful');
    //print("result ${result.data}");

    // Process the list of results
    setState(() {
      searchSelect = true;
      firstResult = result;
      print('search value ${searchSelect}');
    });
  }
  int employeeId = 0;
  int pgeControllerId = 0;
  String dropdownLicenseStatus = '';
  String dropdownAvailability = '';
  String reportingOfficeId = '';
  String? _selectedValue;
  String dropdownAbbrevation = '';
  bool isDropDownAbbreavation = false;
  bool isDropdownLicenseStatus = false;
  bool isDropdownAvailability = false;
  bool isReportingOfficeId = false;
  bool isZoneSelected = false;
  bool isSelectedBox = false;
  //bool isDropdownLicenseStatus = false;
  final ValueNotifier<bool> _isEditMode = ValueNotifier<bool>(false);





  void _goBack() {
    if (pgeControllerId > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        pgeControllerId--;
      });
    }
  }


  Future<bool> _onWillPop() async {
    if (pgeControllerId == 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
     // return false; // Prevent the default back navigation
    }else if(pgeControllerId == 1){
      myController.selectButton(0);
      _pageController.animateToPage(0,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
      return false;
    }else if(pgeControllerId == 2){
      myController.selectButton(1);
      _pageController.animateToPage(1,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
      return false;
    }else if(pgeControllerId == 3){
      myController.selectButton(2);
      _pageController.animateToPage(2,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
      return false;
    }
    return true; // Allow the back navigation to exit the app
  }

  /// Referesh code
  @override
  void initState() {
    super.initState();
    // _loadIndex();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final pageIndexProvider = Provider.of<PageIndexProvider>(context, listen: false);
  //     final pgeControllerId = pageIndexProvider.currentIndex;
  //     print('Page controller id ${pgeControllerId}');
  //     setState(() {
  //       _pageController.animateToPage(
  //         pgeControllerId,
  //         duration: Duration(milliseconds: 500),
  //         curve: Curves.ease,
  //       );
  //       myController.selectButton(pgeControllerId);
  //     });
  //
  //   });
  // }

  void onPageChanged(int index) {
    Provider.of<PageIndexProvider>(context, listen: false).setIndex(index);
  }

  Future<void> _loadIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pgeControllerId = prefs.getInt('currentIndex') ?? 0;
      print('pageIndex ${pgeControllerId}');
      myController.selectButton(pgeControllerId);
      pageChanges(pgeControllerId);
         // Default to 0 if not found
      //  _pageController.jumpToPage(pgeControllerId); // Jump to the saved index
    });
  }
  void pageChanges(int pageIndex){
    _pageController.animateToPage(pgeControllerId,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease);
  }

  Future<void> _saveIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentIndex', index);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      //     () async{
      //   myController.selectButton(0);
      //   _pageController.animateToPage(0,
      //       duration: Duration(milliseconds: 500),
      //       curve: Curves.ease);
      //   pgeControllerId = 0;
      //   return false;
      // } ,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ///log appbar
            ApplicationAppBar(headingText: "Human Resource Manager"),
      
            ///appbar titles
            Container(
              // color: Colors.pink,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Row(
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
                                setState(() {});
                                //companyAll(context);
                                myController.selectButton(0);
                                _pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                _saveIndex(0);
                                onPageChanged(0);
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
                                setState(() {});
                                myController.selectButton(1);
                                _pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                _saveIndex(1);
                                onPageChanged(1);
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
                                setState(() {});
                                myController.selectButton(2);
                                _pageController.animateToPage(2,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                onPageChanged(2);
                                _saveIndex(2);

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
                                setState(() {});
                                myController.selectButton(3);
                                _pageController.animateToPage(3,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                                onPageChanged(3);
                                _saveIndex(3);

                                pgeControllerId = 3;
                              },
                              text: 'Onboarding',
                              isSelected: myController.selectedIndex.value == 3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
      
                      /// search text
                      pgeControllerId == 2 || pgeControllerId == 3
                          ? SizedBox()
                          : Row(
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
                                        textCapitalization:
                                            TextCapitalization.words,
                                        style: TextStyle(fontSize: 12),
                                        onChanged: _search,
                                        decoration: InputDecoration(
                                            hintText: 'Search User',
                                            alignLabelWithHint: true,
                                            hintStyle: TextStyle(
                                              fontSize: FontSize.s14,
                                              fontWeight: FontWeight.w500,
                                              color: ColorManager.mediumgrey,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 70,
                                ),
                                MediaQuery.of(context).size.width >= 1100
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Container(
                                              width: 37,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: ColorManager.white,
                                                borderRadius:
                                                    BorderRadius.circular(9),
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
                                                  // isReportingOfficeId = false;
                                                  // isDropdownAvailability = false;
                                                  // isDropdownLicenseStatus = false;
                                                  // isZoneSelected = false;
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return ProfilePatientPopUp(
                                                        officceIdWidget: FutureBuilder<List<CompanyOfficeListData>>(
                                                          future: getCompanyOfficeList(context),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return PatientCustomDropDown(
                                                                items: ['Office'],
                                                                labelText: '',
                                                                value: 'Office',
                                                                onChanged:
                                                                    (value) {},
                                                              );
                                                            }
                                                            if (snapshot.hasData) {
                                                              {
                                                                List<DropdownMenuItem<String>>dropDownList = [];
                                                                for (var i in snapshot.data!) {
                                                                  dropDownList.add(DropdownMenuItem<String>(
                                                                    child: Text(i.name,
                                                                      style: SearchDropdownConst.customTextStyle(context),
                                                                    ),
                                                                    value: i.name,
                                                                  ));
                                                                }
                                                                // snapshot.data!
                                                                //     .map((zone) => zone.zoneName ?? '')
                                                                //     .toList();
                                                                return Container(
//height: 31,
                                                                  width: 170,

                                                                  child:  CustomDropdownTextFieldwidh(
                                                                    dropDownMenuList: dropDownList,
                                                                    onChanged: (newValue) {for (var a
                                                                    in snapshot.data!) {
                                                                      if (a.name == newValue) {
                                                                        reportingOfficeId =a.name;
                                                                        isReportingOfficeId = true;
                                                                        print(
                                                                            'Office Name : ${reportingOfficeId}');
                                                                        //empTypeId = docType;
                                                                      }
                                                                    }
                                                                    },
                                                                  ),
                                                                );
                                                              }
                                                            } else {
                                                              return const Offstage();
                                                            }
                                                          },
                                                        ),


                                                        avabilityWidget: Row(
                                                          children: [
                                                            Container( width: 170,
                                                              child: CustomDropdownTextFieldwidh(
                                                                items: [
                                                                  'Full Time',
                                                                  'Part Time'
                                                                ],

                                                                // labelStyle: SearchDropdownConst.customTextStyle(context),
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    dropdownAvailability =
                                                                        value!;
                                                                    isDropdownAvailability =
                                                                        true;
                                                                    print(
                                                                        "Availability Status :: ${dropdownAvailability}");
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        licensesWidget: Row(
                                                          children: [
                                                            Container(
                                                              // height: 31,
                                                              width: 170,
                                                              // margin: EdgeInsets.symmetric(horizontal: 20),
                                                              child: CustomDropdownTextFieldwidh(
                                                                items:[
                                                                  'Expired',
                                                                          'About to Expire',
                                                                          'Upto date'],
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    dropdownLicenseStatus = value!;
                                                                    isDropdownLicenseStatus = true;
                                                                    print("License Status :: ${dropdownLicenseStatus}");
                                                                  });
                                                                },
                                                              ) ,

                                                            ),
                                                          ],
                                                        ),
                                                        // Row(
                                                        //   children: [
                                                        //     Center(
                                                        //       child:
                                                        //           PatientCustomDropDown(
                                                        //         items: [
                                                        //           'Expired',
                                                        //           'About to Expire',
                                                        //           'Upto date'
                                                        //         ],
                                                        //         labelText: 'License Status',
                                                        //         value: 'Expired',
                                                        //         onChanged: (value) {
                                                        //           setState(() {
                                                        //             dropdownLicenseStatus = value!;
                                                        //             isDropdownLicenseStatus = true;
                                                        //             print("License Status :: ${dropdownLicenseStatus}");
                                                        //           });
                                                        //         },
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        zoneDropDown: FutureBuilder<List<SortByZoneData>>(
                                                          future:
                                                          PayRateZoneDropdown(
                                                            context,
                                                          ),
                                                          builder: (context, snapshot) {
                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                              return PatientCustomDropDown(
                                                                items: ['Zone'],
                                                                labelText: '',
                                                                value: 'Zone',
                                                                onChanged: (value) {},
                                                              );
                                                            } else if (snapshot.hasData) {
                                                              List<DropdownMenuItem<String>>dropDownList = [];
                                                              int zoneId = 0;
                                                              for (var i
                                                              in snapshot.data!) {
                                                                dropDownList.add(DropdownMenuItem<String>(
                                                                      child: Text(
                                                                        i.zoneName,
                                                                        style: SearchDropdownConst.customTextStyle(context),
                                                                      ),
                                                                      value: i.zoneName,
                                                                    ));
                                                              }

                                                              print("Zone: ");
                                                              return Container(
                                                               // height: 31,
                                                                width: 170,
                                                                // margin: EdgeInsets.symmetric(horizontal: 20),
                                                               child: CustomDropdownTextFieldwidh(
                                                                 dropDownMenuList: dropDownList,
                                                                 onChanged: (newValue) {
                                                                   for (var a in snapshot.data!) {
                                                                     if (a.zoneName == newValue) {
                                                                       zoneId = a.zoneId;
                                                                       selectedZoneId = zoneId;
                                                                       isZoneSelected = true;
                                                                       print("Zone id :: ${selectedZoneId}");
                                                                       //empTypeId = docType;
                                                                     }
                                                                   }
                                                                 },
                                                               ) ,
                                                                // child: DropdownButtonFormField<String>(
                                                                //     focusColor: Colors
                                                                //         .transparent,
                                                                //     icon:
                                                                //     const Icon(
                                                                //       Icons
                                                                //           .arrow_drop_down_sharp,
                                                                //       color: Color(
                                                                //           0xff686464),
                                                                //     ),
                                                                //     decoration: const InputDecoration
                                                                //         .collapsed(
                                                                //         hintText:
                                                                //         ''),
                                                                //     items:
                                                                //     dropDownList,
                                                                //     onChanged:
                                                                //         (newValue) {
                                                                //       for (var a
                                                                //       in snapshot
                                                                //           .data!) {
                                                                //         if (a.zoneName ==
                                                                //             newValue) {
                                                                //           zoneId =
                                                                //               a.zoneId;
                                                                //           selectedZoneId =
                                                                //               zoneId;
                                                                //           isZoneSelected =
                                                                //           true;
                                                                //           print(
                                                                //               "Zone id :: ${selectedZoneId}");
                                                                //           //empTypeId = docType;
                                                                //         }
                                                                //       }
                                                                //     },
                                                                //     value:
                                                                //     dropDownList[
                                                                //     0]
                                                                //         .value,
                                                                //     style: DropdownItemStyle
                                                                //         .customTextStyle(
                                                                //         context)),
                                                              );
                                                            } else {
                                                              return CustomDropdownTextField(
                                                                // width: MediaQuery.of(context).size.width / 5,
                                                                headText: 'Zone',
                                                                items: [
                                                                  'No Data'
                                                                ],
                                                              );
                                                            }
                                                          },
                                                        ),
                                                          onSearch: () {
                                                          setState(() {
                                                            _searchByFilter(
                                                                zoneId:
                                                                    selectedZoneId,
                                                                isZoneSelectedBool:
                                                                    isZoneSelected,
                                                                isReportingOffice:
                                                                    isReportingOfficeId,
                                                                officeName:
                                                                    reportingOfficeId,
                                                                isLicensesSelected:
                                                                    isDropdownLicenseStatus,
                                                                licenseStatusName:
                                                                    dropdownLicenseStatus,
                                                                isSelectAvailability:
                                                                    isDropdownAvailability,
                                                                availabilityName:
                                                                    dropdownAvailability);
                                                          });
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                      'images/menuLines.svg'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                90,
                                          ),
                                          Obx(
                                            () => Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: DZoneButton(
                                                isSelected: myController
                                                        .selectedIndex.value ==
                                                    4,
                                                onTap: () {
                                                  myController.selectButton(4);
                                                  setState(() {
                                                    isSelected = true;
                                                    print(
                                                        "IsDZone : ${isSelected}");
                                                    _searchByFilter(
                                                        zoneId: selectedZoneId,
                                                        isZoneSelectedBool:
                                                            isZoneSelected,
                                                        isReportingOffice:
                                                            isReportingOfficeId,
                                                        officeName:
                                                            reportingOfficeId,
                                                        isLicensesSelected:
                                                            isDropdownLicenseStatus,
                                                        licenseStatusName:
                                                            dropdownLicenseStatus,
                                                        isSelectAvailability:
                                                            isDropdownAvailability,
                                                        availabilityName:
                                                            dropdownAvailability);
                                                  });
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : SizedBox(width: 1),
                              ],
                            ),
                    ],
                  );
                },
              ),
            ),
      
            ///page view
            Expanded(
              flex: 8,
              child: FutureBuilder<SearchByEmployeeIdProfileData>(
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
                            "Select a User by Searching for One!",
                            style: CustomTextStylesCommon.commonStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: FontSize.s14,
                                color: ColorManager.mediumgrey),
                          )),
                          //AddEmployeeHomeScreen(),
                          RegisterScreen(
                            onRefresh: () {
                              // myController.selectButton(2);
                            },
                            onBackPressed: () {
                              if (myController.selectedIndex.value == 2) {
                                myController.selectButton(myController.selectedIndex.value - 1);
                                _pageController.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
                          },
                          ),
                          NewOnboardScreen(
                            onBackPressed: () {
                              if (myController.selectedIndex.value == 3) {
                                myController.selectButton(myController.selectedIndex.value - 1);
                                _pageController.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
      
                            },
                          ),
                          //SeeAllHrScreen()
                        ],
                      );
                    }
                    if (snapshot.hasData) {
                      SearchByEmployeeIdProfileData
                          searchByEmployeeIdProfileData = snapshot.data!;
                      print(
                          "Employee ID:::${searchByEmployeeIdProfileData.employeeId!}");
                      int empID = searchByEmployeeIdProfileData.employeeId!;
      
                      return PageView(
                        controller: _pageController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          DashBoardScreen(),
                          ManageScreen(
                            searchByEmployeeIdProfileData:
                                searchByEmployeeIdProfileData,
                            employeeId: empID,
                            pageManageController: _pageManageController,
                            onRefresh: () {
                              setState(() {});
                            },
                          ),
                          //AddEmployeeHomeScreen(),
                          RegisterScreen(
                            onRefresh: () {
                              myController.selectButton(2);
                              // setState(() {
                              //
                              //  });
                            }, onBackPressed: () {
                            if (myController.selectedIndex.value == 2) {
                              myController.selectButton(myController.selectedIndex.value - 1);
                              _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            }
      
                          },
                          ),
                          NewOnboardScreen(
                            onBackPressed: () {
                              if (myController.selectedIndex.value == 3) {
                                myController.selectButton(myController.selectedIndex.value - 1);
                                _pageController.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
      
                            },
      
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
            ),
            BottomBarRow(),
          ],
        ),
      ),
    );
  }
}
