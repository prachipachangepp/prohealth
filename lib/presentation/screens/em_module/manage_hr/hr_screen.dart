import 'dart:async';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/screen_route_name.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/edit_emp_popup_const.dart';
import 'package:prohealth/presentation/widgets/error_popups/failed_popup.dart';
import 'package:prohealth/presentation/widgets/error_popups/four_not_four_popup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../widgets/error_popups/delete_success_popup.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../company_identity/widgets/whitelabelling/success_popup.dart';
import 'manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

/// stl conversion
class HrScreenProvider with ChangeNotifier {
  final PageController hrPageController = PageController();
  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;
  void selectButton(int index) {
    _selectedIndex = index;
    notifyListeners();
    hrPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}

class HrScreen extends StatelessWidget {
  static const String routeName = RouteStrings.emHrAdminScreen;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HrScreenProvider(),
      child: Consumer<HrScreenProvider>(
        builder: (context, hrProvider, child) {
          return ChangeNotifierProvider(
            create: (_) => HrWidgetProvider(),
            child: HrWidget(
              hrPageController: hrProvider.hrPageController,
              selectedIndex: hrProvider.selectedIndex,
              selectButton: hrProvider.selectButton,
            ),
          );
        },
      ),
    );
  }
}

///
class HrWidgetProvider with ChangeNotifier {
  final PageController _hrPageController = PageController();
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();
  final StreamController<List<HRAllData>> _controller = StreamController<List<HRAllData>>();
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  var _deptId = 0;
  get deptId => _deptId;
  String color = "";
  List<Color> containerColors = List.generate(20, (index) => Color(0xffE8A87D));

  HrWidgetProvider() {
    _loadColors();
  }

  void selectButton(int index) {
    _selectedIndex = index;
    notifyListeners();
    _hrPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < containerColors.length; i++) {
      int? colorValue = prefs.getInt('containerColor$i');
      if (colorValue != null) {
        containerColors[i] = Color(colorValue);
      }
    }
    notifyListeners();
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }


  Future<void> saveColor(int index, Color selectedColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('containerColor$index', selectedColor.r.toInt());
    containerColors[index] = selectedColor;
    color = colorToHex(selectedColor);
    notifyListeners();
  }

  void handleColorChange(int index, Color selectedColor) {
    saveColor(index, selectedColor);
  }
}

class HrWidget extends StatelessWidget {
  final PageController hrPageController;
  final int selectedIndex;
  final Function(int) selectButton;
  const HrWidget({super.key, required this.hrPageController, required this.selectedIndex, required this.selectButton});

  @override
  Widget build(BuildContext context) {
    return Consumer<HrWidgetProvider>(
      builder: (context, provider, child) {
        return Material(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width/70
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 180,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
                      child: FutureBuilder<List<HRHeadBar>>(
                        future: companyHRHeadApi(context, provider.deptId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: AppSize.s30,
                                width: MediaQuery.of(context).size.width / 2.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorManager.blueprime,
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorManager.black.withValues(alpha: 0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          child: Container(
                                            height: AppSize.s30,
                                            width: MediaQuery.of(context).size.width / 8.421,
                                            padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: provider.selectedIndex == 0
                                                  ? ColorManager.white
                                                  : Colors.transparent,
                                            ),
                                            child: Text(
                                              AppStringEM.clinical,
                                              textAlign: TextAlign.center,
                                              style: BlueBgTabbar.customTextStyle(0, provider.selectedIndex),
                                            ),
                                          ),
                                          onTap: () {
                                            provider.selectButton(0);
                                            // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                                          }),
                                      InkWell(
                                          child: Container(
                                            height: AppSize.s30,
                                            width: MediaQuery.of(context).size.width / 8.421,
                                            padding: const EdgeInsets.symmetric(vertical: AppPadding.p6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: provider.selectedIndex == 1
                                                  ? ColorManager.white
                                                  : Colors.transparent,
                                            ),
                                            child: Text(
                                              AppStringEM.sales,
                                              textAlign: TextAlign.center,
                                              style: BlueBgTabbar.customTextStyle(1, provider.selectedIndex),
                                            ),
                                          ),
                                          onTap: () {
                                            provider.selectButton(1);
                                            // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                                          }),
                                      InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          child: Container(
                                            height: AppSize.s30,
                                            width:
                                            MediaQuery.of(context).size.width / 8.421,
                                            padding:
                                            const EdgeInsets.symmetric(vertical: AppPadding.p6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: provider.selectedIndex == 2
                                                  ? ColorManager.white
                                                  : Colors.transparent,
                                            ),
                                            child: Text(
                                              AppStringEM.administration,
                                              textAlign: TextAlign.center,
                                              style: BlueBgTabbar.customTextStyle(2, provider.selectedIndex),
                                            ),
                                          ),
                                          onTap: () {
                                            provider.selectButton(2);
                                            // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                                          }),
                                    ]),
                              ),
                            );
                          } else {
                            return SizedBox(height: 1, width: 1,);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/24),
                      child: CustomIconButtonConst(
                          width: AppSize.s181,
                          text: AppString.addemployeetype,
                          icon: Icons.add,
                          onPressed: () {
                            provider._deptId = provider.selectedIndex == 0
                                ? AppConfig.clinicalId
                                : provider.selectedIndex == 1
                                ? AppConfig.salesId
                                : AppConfig.AdministrationId;
                            provider.typeController.clear();
                            provider.shorthandController.clear();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomPopupWidget(
                                  typeController: provider.typeController,
                                  abbreviationController: provider.shorthandController,
                                  containerColor: provider.containerColors[1],
                                  onAddPressed: () async {
                                    print('$provider.deptId');
                                    var response = await addEmployeeTypePost(context,
                                        provider.deptId,
                                        provider.typeController.text,
                                        provider.color,
                                        provider.shorthandController.text
                                    );
                                    getAllHrDeptWise(context,provider.deptId).then((data){
                                      provider._controller.add(data);
                                    }).catchError((error){});
                                    if(response.statusCode == 200 || response.statusCode == 201){
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AddSuccessPopup(
                                            message: 'Added Successfully',
                                          );
                                        },
                                      );
                                    }else if(response.statusCode == 400 || response.statusCode == 404){
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => const FourNotFourPopup(),
                                      );
                                    }
                                    else {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => FailedPopup(text: response.message),
                                      );
                                    }
                                    provider.typeController.clear();
                                    provider.shorthandController.clear();
                                  },
                                  onColorChanged: (Color selectedColor) {
                                    provider.handleColorChange(1, selectedColor);
                                    print('Selected color: $selectedColor');
                                    print('Color to Hex: ${provider.color}');
                                  },
                                  // onColorChanged: (Color seletedColor) {
                                  //  setState(() {
                                  //     print('Selected color :: ${seletedColor}');
                                  //     provider.containerColors[1] = seletedColor;
                                  //     provider.color = provider.colorToHex(seletedColor,);
                                  //     provider.saveColor(1, seletedColor);
                                  //     print('Color to Hex :: ${provider.color}');
                                  //   });
                                  // },
                                  title: AppStringEM.addEmp,
                                );
                              },
                            );
                          }),
                    ),
                  ],
                ),
                Expanded(
                  flex: 10,
                  child: PageView(
                    controller: provider._hrPageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ChangeNotifierProvider(
                          create: (_) => HRTabScreenProvider(),
                          child: HRTabScreens(deptId: AppConfig.clinicalId)),
                      ChangeNotifierProvider(
                          create: (_) => HRTabScreenProvider(),
                          child: HRTabScreens(deptId: AppConfig.salesId)),
                      ChangeNotifierProvider(
                          create: (_) => HRTabScreenProvider(),
                          child: HRTabScreens(deptId: AppConfig.AdministrationId)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

///hr tab stl
class HRTabScreenProvider with ChangeNotifier {
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();

  final StreamController<List<HRAllData>> _hrAllcontroller = StreamController<List<HRAllData>>();
  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }
  List<Color> hrContainerColors = List.generate(20, (index) => Color(0xffE8A87D));

  ColorProvider() {
    _loadColors();
  }

  Future<void> _loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < hrContainerColors.length; i++) {
      int? colorValue = prefs.getInt('containerColor$i');
      if (colorValue != null) {
        hrContainerColors[i] = Color(colorValue);
      }
    }
    notifyListeners(); // Notify listeners after colors are loaded
  }

  Future<void> _saveColor(int index, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('containerColor$index', color.value);
    hrContainerColors[index] = color; // Update in the list as well
    notifyListeners(); // Notify listeners after saving the color
  }
  void onColorChanged(int index, Color selectedColor) {
    hrContainerColors[index] = selectedColor;
    _saveColor(index, selectedColor);
    notifyListeners(); // Notify listeners after the color is updated
  }
  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;
  String color = " ";
  void onPageNumberPressed(int pageNumber) {
    currentPage = pageNumber;
    notifyListeners();
  }
  void updatePageNumber(int pageNumber) {
    currentPage = pageNumber;
    notifyListeners();
  }
  int flexVal = 2;
  bool _isLoading = false;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

class HRTabScreens extends StatelessWidget {
  final deptId;
  const HRTabScreens({super.key, this.deptId});

  @override
  Widget build(BuildContext context) {
    return Consumer<HRTabScreenProvider>(builder: (context, provider, child){
      return Container(
        child: Column(
          children: [
            Container(
              height: AppSize.s30,
              margin: EdgeInsets.symmetric(horizontal: 60),
              padding: EdgeInsets.only(right: 80,left: 20),
              decoration: BoxDecoration(
                color: ColorManager.fmediumgrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: provider.flexVal,
                    child: Text(AppStringEM.srno,
                      textAlign: TextAlign.center,
                      style:TableHeading.customTextStyle(context),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox()),
                  Expanded(
                    flex: provider.flexVal,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Text(AppStringEM.employee,
                        textAlign: TextAlign.start,
                        style:TableHeading.customTextStyle(context),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox()),
                  Expanded(
                    flex: provider.flexVal,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Center(
                        child: Text(AppStringEM.abbrevation,
                          textAlign: TextAlign.start,
                          style:TableHeading.customTextStyle(context),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: provider.flexVal,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(AppStringEM.color,
                        textAlign: TextAlign.end,
                        style:TableHeading.customTextStyle(context),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox()),
                  Expanded(
                    flex: provider.flexVal,
                    child: Center(
                        child: Text(AppStringEM.action,
                          style:TableHeading.customTextStyle(context),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s10,
            ),
            Expanded(
              child: StreamBuilder<List<HRAllData>>(
                  stream: provider._hrAllcontroller.stream,
                  builder: (context, snapshot) {
                    getAllHrDeptWise(context, deptId).then((data) {
                      provider._hrAllcontroller.add(data);
                    }).catchError((error) {});
                    print('1111111');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.blueprime,
                        ),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                            ErrorMessageString.noEmpType,
                            style: AllNoDataAvailable.customTextStyle(context),
                          )
                      );
                    }
                    if (snapshot.hasData) {

                      List<HRAllData> sortedData = snapshot.data!;
                      sortedData.sort((a, b) => b.employeeTypesId.compareTo(a.employeeTypesId));

                      int totalItems = sortedData.length;
                      int totalPages = (totalItems / provider.itemsPerPage).ceil();
                      List<HRAllData> paginatedData = sortedData
                          .skip((provider.currentPage - 1) * provider.itemsPerPage)
                          .take(provider.itemsPerPage)
                          .toList();
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: paginatedData.length ?? 0,
                              // itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                int serialNumber = index + 1 + (provider.currentPage - 1) * provider.itemsPerPage;
                                String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                                HRAllData hrdoc = paginatedData[index];
                                print('Color code ${snapshot.data![index].color}');
                                return Column(
                                  children: [
                                    SizedBox(height: AppSize.s5),
                                    Container(
                                      padding: EdgeInsets.only(bottom: AppPadding.p5),
                                      margin: EdgeInsets.symmetric(horizontal: 60),
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorManager.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      height: AppSize.s56,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          ///sr no
                                          Expanded(
                                            flex: provider.flexVal,
                                            child: Center(
                                                child: Text(
                                                  formattedSerialNumber,
                                                  style: DocumentTypeDataStyle.customTextStyle(context),
                                                  textAlign: TextAlign.start,
                                                )),
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: SizedBox()),
                                          ///emptype
                                          Expanded(
                                            flex: provider.flexVal,
                                            child: Text(
                                                hrdoc.empType!,
                                                textAlign: TextAlign.start,
                                                style: DocumentTypeDataStyle.customTextStyle(context)
                                            ),
                                          ),

                                          ///abbreviation
                                          Expanded(
                                            flex: provider.flexVal,
                                            child: Center(
                                                child: Text(
                                                    hrdoc.abbrivation!,
                                                    style: DocumentTypeDataStyle.customTextStyle(context)
                                                )),
                                          ),

                                          Container(width: 100,),
                                          ///color
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width / 30,
                                              height: AppSize.s22,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: hrdoc.color!.toColorMaybeNull,
                                              ),
                                            ),
                                          ),

                                          ///edit
                                          Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return FutureBuilder<HRGetEmpId>(
                                                            future: HrGetById(context, hrdoc.employeeTypesId),
                                                            builder: (context, snapshot) {
                                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                                return Center(
                                                                  child: CircularProgressIndicator(
                                                                    color: ColorManager.blueprime,
                                                                  ),
                                                                );
                                                              }

                                                              if (snapshot.hasData && snapshot.data != null) {
                                                                var type = hrdoc.toString();
                                                                var shorthand = hrdoc.toString();                                                              var hexColorData = snapshot.data!.color!.replaceAll("#", "");
                                                                Color hexColor = Color(int.parse('0xFF$hexColorData'));

                                                                // Initialize controllers with prefilled data
                                                                provider.typeController = TextEditingController(text: hrdoc.empType.toString());
                                                                provider.shorthandController = TextEditingController(text: hrdoc.abbrivation.toString());

                                                                return EditPopupWidget(
                                                                  typeController: provider.typeController,
                                                                  shorthandController: provider.shorthandController,
                                                                  containerColor: hexColor, // Pass the prefilled color
                                                                  onSavePressed: () async {
                                                                    print('Selected color: ${provider.colorToHex(provider.hrContainerColors[index])}');
                                                                    var response = await AllFromHrPatch(
                                                                        context,
                                                                        snapshot.data!.empTypeId,
                                                                        snapshot.data!.deptId,
                                                                        type == provider.typeController.text ? type : provider.typeController.text,
                                                                        shorthand == provider.shorthandController.text ? shorthand : provider.shorthandController.text,
                                                                        provider.colorToHex(provider.hrContainerColors[index]) // Send the updated color
                                                                    );

                                                                    // Refresh data after saving
                                                                    getAllHrDeptWise(context, deptId).then((data) {
                                                                      provider._hrAllcontroller.add(data);
                                                                    }).catchError((error) {});

                                                                    // Handle response
                                                                    if (response.statusCode == 200 || response.statusCode == 201) {
                                                                      Navigator.pop(context);
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return AddSuccessPopup(
                                                                            message: 'Edit Successfully',
                                                                          );
                                                                        },
                                                                      );
                                                                    } else {
                                                                      Navigator.pop(context);
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return FailedPopup(text: response.message);
                                                                        },
                                                                      );
                                                                    }

                                                                    // Clear controllers
                                                                    provider.typeController.clear();
                                                                    provider.shorthandController.clear();
                                                                  },
                                                                  onColorChanged: (Color selectedColor) {
                                                                    // Use provider's onColorChanged method to handle color change
                                                                    provider.onColorChanged(index, selectedColor); // This will update the color in the provider
                                                                    print("Updated Color: ${provider.colorToHex(selectedColor)}");
                                                                  },
                                                                  // onColorChanged: (Color selectedColor) {
                                                                  //   setState(() {
                                                                  //     provider.hrContainerColors[index] = selectedColor;
                                                                  //     print("Updated Color: ${provider.colorToHex(selectedColor)}");
                                                                  //     provider._saveColor(index, selectedColor);
                                                                  //   });
                                                                  // },
                                                                  title: EditPopupString.editEmptype,
                                                                );
                                                              } else {
                                                                return Center(
                                                                  child: Text('Failed to load data'),
                                                                );
                                                              }
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.edit_outlined,
                                                      size: IconSize.I18,
                                                      color: IconColorManager.bluebottom,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),

                                                  ///delete
                                                  IconButton(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    hoverColor: Colors.transparent,
                                                    onPressed: () async {
                                                      await showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            StatefulBuilder(
                                                              builder: (BuildContext context, void Function(void Function()) setState) {
                                                                return
                                                                  DeletePopup(
                                                                      loadingDuration: provider._isLoading,
                                                                      title: DeletePopupString.deleteEmpType,
                                                                      onCancel: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                      onDelete: () async {
                                                                        provider.setLoading(true);
                                                                        try {
                                                                          await allfromHrDelete(context, hrdoc.employeeTypesId);
                                                                          getAllHrDeptWise(context,deptId).then(
                                                                                  (data) {provider._hrAllcontroller.add(data);
                                                                              }).catchError((error) {
                                                                          });
                                                                          Navigator.pop(context);
                                                                          showDialog(context: context, builder: (context) => DeleteSuccessPopup());
                                                                        } finally {
                                                                         provider.setLoading(false);
                                                                        }
                                                                      }
                                                                  );
                                                              },
                                                            ),
                                                      );
                                                    },
                                                    icon: Icon(
                                                      size: IconSize.I18,
                                                      Icons.delete_outline_outlined,
                                                      color: IconColorManager.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          PaginationControlsWidget(
                            currentPage: provider.currentPage,
                            items: snapshot.data!,
                            itemsPerPage: provider.itemsPerPage,
                            onPreviousPagePressed: () {
                              if (provider.currentPage > 1) {
                                provider.updatePageNumber(
                                    provider.currentPage - 1);
                              }
                            },
                            onPageNumberPressed: (pageNumber) {
                              provider.updatePageNumber(pageNumber);
                            },
                            onNextPagePressed: () {
                              if (provider.currentPage < totalPages) {
                                provider.updatePageNumber(
                                    provider.currentPage + 1);
                              }
                            },
                          ),
                        ],
                      );
                    }
                    return Offstage();
                  }),
            ),
          ],
        ),
      );
    }) ;
  }
}
