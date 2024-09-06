import 'dart:async';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/edit_emp_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/const_appbar/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'all_hr_screens/hr_administrative.dart';
import 'all_hr_screens/hr_clinical.dart';
import 'all_hr_screens/hr_sales.dart';
import 'manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class HrScreen extends StatefulWidget {
  @override
  _HrScreenState createState() => _HrScreenState();
}

class _HrScreenState extends State<HrScreen> {
  final PageController _hrPageController = PageController();
  int _selectedIndex = 1;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _hrPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HrWidget(
      hrPageController: _hrPageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
    );
  }
}

///
class HrWidget extends StatefulWidget {
  final PageController hrPageController;
  final int selectedIndex;
  final Function(int) selectButton;

  HrWidget({
    required this.hrPageController,
    required this.selectedIndex,
    required this.selectButton,
  });

  @override
  State<HrWidget> createState() => _HrWidgetState();
}

class _HrWidgetState extends State<HrWidget> {
  final PageController _hrPageController = PageController();
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();
  final StreamController<List<HRAllData>> _controller = StreamController<List<HRAllData>>();
  int _selectedIndex = 0;
  late List<Color> containerColors;
  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _hrPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();
    companyHRHeadApi(context, deptId);
    containerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
  }
  void _loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < containerColors.length; i++) {
        int? colorValue = prefs.getInt('containerColor$i');
        if (colorValue != null) {
          containerColors[i] = Color(colorValue);
        }
      }
    });
  }
  void _saveColor(int index, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('containerColor$index', color.value);
  }
  var deptId = 0;
  int docDeptId = 0;
  String color = "";
  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  width: 180,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
                  child: FutureBuilder<List<HRHeadBar>>(
                    future: companyHRHeadApi(context, deptId),
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
                                  color: ColorManager.black.withOpacity(0.25),
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
                                      child: Container(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width / 8.421,
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: _selectedIndex == 0
                                              ? ColorManager.white
                                              : Colors.transparent,
                                        ),
                                        child: Text(
                                          'Clinical',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeightManager.semiBold,
                                            color: _selectedIndex == 0
                                                ? ColorManager.mediumgrey
                                                : ColorManager.white,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        _selectButton(0);
                                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                                      }),
                                  InkWell(
                                      child: Container(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width / 8.421,
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: _selectedIndex == 1
                                              ? ColorManager.white
                                              : Colors.transparent,
                                        ),
                                        child: Text(
                                          'Sales',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeightManager.semiBold,
                                            color: _selectedIndex == 1
                                                ? ColorManager.mediumgrey
                                                : ColorManager.white,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        _selectButton(1);
                                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                                      }),
                                  InkWell(
                                      child: Container(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width / 8.421,
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: _selectedIndex == 2
                                              ? ColorManager.white
                                              : Colors.transparent,
                                        ),
                                        child: Text(
                                          'Administration',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeightManager.semiBold,
                                            color: _selectedIndex == 2
                                                ? ColorManager.mediumgrey
                                                : ColorManager.white,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        _selectButton(2);
                                        // metaDocID = snapshot.data![index].employeeDocMetaDataId;
                                      }),


                                ]),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 1,
                          width: 1,
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/24),
                  child: CustomIconButtonConst(
                      width: 180,
                      text: AppString.addemployeetype,
                      icon: Icons.add,
                      onPressed: () {
                        typeController.clear();
                        shorthandController.clear();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomPopupWidget(
                              typeController: typeController,
                              abbreviationController: shorthandController,
                              containerColor: containerColors[1],
                              onAddPressed: () async {
                                await addEmployeeTypePost(context,
                                    deptId,
                                    // docMetaId,
                                    typeController.text,
                                    color,

                                    shorthandController.text
                                );
                                getAllHrDeptWise(context,deptId).then((data){
                                  _controller.add(data);
                                }).catchError((error){});

                                Navigator.pop(context);
                                typeController.clear();
                                shorthandController.clear();
                              },
                              onColorChanged: (Color seletedColor) {
                                setState(() {
                                  containerColors[1] = seletedColor;
                                  color = seletedColor.toString().substring(10,16);
                                  _saveColor(1, seletedColor);
                                });
                              },

                              title: 'Add Employee',
                              child: FutureBuilder<List<HRHeadBar>>(
                                  future: companyHRHeadApi(context,deptId),
                                  builder: (context,snapshot) {
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return Container(
                                        width: 300,
                                        child: Text(
                                          'Loading...',
                                          style: CustomTextStylesCommon.commonStyle(
                                            fontWeight: FontWeightManager.medium,
                                            fontSize: FontSize.s12,
                                            color: ColorManager.mediumgrey,
                                          ),
                                        ),
                                      );
                                    }
                                    if (snapshot.data!.isEmpty) {
                                      return Center(
                                        child: Text(
                                          AppString.dataNotFound,
                                          style: CustomTextStylesCommon.commonStyle(
                                            fontWeight: FontWeightManager.medium,
                                            fontSize: FontSize.s12,
                                            color: ColorManager.mediumgrey,
                                          ),
                                        ),
                                      );
                                    }
                                    if(snapshot.hasData){
                                      List dropDown = [];
                                      int docType = 0;
                                      List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                      for(var i in snapshot.data!){
                                        dropDownMenuItems.add(
                                          DropdownMenuItem<String>(
                                            child: Text(i.deptName),
                                            value: i.deptName,
                                          ),
                                        );
                                      }
                                      return CICCDropdown(
                                          initialValue: dropDownMenuItems[1].value,
                                          onChange: (val){
                                            for(var a in snapshot.data!){
                                              if(a.deptName == val){
                                                docType = a.deptId;
                                                deptId = docType;
                                              }
                                            }
                                            print(":::${docType}");
                                            print(":::<>${deptId}");
                                          },
                                          items:dropDownMenuItems
                                      );
                                    }else{
                                      return SizedBox();
                                    }
                                  }
                              ),
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
                controller: _hrPageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // Container(color: Colors.red,child: Text('Clinical'),),
                  // Container(color: Colors.greenAccent,child: Text('sales'),),
                  // Container(color: Colors.purple,child: Text('Admin'),),
                  // HrClinicalScreen(deptId: deptId,),
                  HRTabScreens(deptId: AppConfig.clinicalId),
                  HRTabScreens(deptId: AppConfig.salesId),
                  HRTabScreens(deptId: AppConfig.AdministrationId),
                  // HrClinicalScreen(deptId: deptId,),
                  // HrSalesScreen(deptId: AppConfig.salesId,),
                  // HrSalesScreen(deptId: deptId,),
                  // HrAdministrativeScreen(deptId: deptId,),
                  // HrAdministrativeScreen(deptId: AppConfig.AdministrationId,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
class HRTabScreens extends StatefulWidget {
  final deptId;
  const HRTabScreens({super.key, required this.deptId});

  @override
  State<HRTabScreens> createState() => _HRTabScreensState();
}

class _HRTabScreensState extends State<HRTabScreens> {
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();

  final StreamController<List<HRHeadBar>> _controller =
      StreamController<List<HRHeadBar>>();
  TextEditingController idDocController = TextEditingController();
  TextEditingController nameDocController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final HRClincicalController hrClinController =
      Get.put(HRClincicalController());
  // final StreamController<List<HRAllData>> _controller = StreamController<List<HRAllData>>();

  final StreamController<List<HRAllData>> _hrAllcontroller =
      StreamController<List<HRAllData>>();
  String seletedType = "Clinical";

  @override
  void dispose() {
    idDocController.dispose();
    nameDocController.dispose();
    dateController.dispose();
    super.dispose();
  }

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
    getAllHrDeptWise(context, widget.deptId).then((data) {
      _hrAllcontroller.add(data);
    }).catchError((error) {});
  }

  void _saveColor(int index, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('containerColor$index', color.value);
  }

  late List<Color> hrcontainerColors;
  void _loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < hrcontainerColors.length; i++) {
        int? colorValue = prefs.getInt('containerColor$i');
        if (colorValue != null) {
          hrcontainerColors[i] = Color(colorValue);
        }
      }
    });
  }

  String? expiryType;
  int docMetaId = 1;
  int doceEditMetaId = 1;
  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;
  String color = " ";

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: AppSize.s30,
            margin: EdgeInsets.symmetric(horizontal: 60),
            decoration: BoxDecoration(
              color: ColorManager.fmediumgrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(AppString.srNo,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.firaSans(
                            fontSize: AppSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white)
                        // style: RegisterTableHead.customTextStyle(context),
                        ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Center(
                      child: Text(AppString.employmentType,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                              fontSize: AppSize.s12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white)
                          // style: RegisterTableHead.customTextStyle(context),
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 80.0),
                    child: Center(
                      child: Text("Abbreviation",
                          style: GoogleFonts.firaSans(
                              fontSize: AppSize.s12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white)
                          // style: RegisterTableHead.customTextStyle(context),
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 80.0),
                    child: Center(
                        child: Text("Color",
                            style: GoogleFonts.firaSans(
                                fontSize: AppSize.s12,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white)
                            // style: RegisterTableHead.customTextStyle(context),
                            )),
                  ),
                ),
                //
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 100.0),
                    child: Center(
                        child: Text(AppString.actions,
                            style: GoogleFonts.firaSans(
                                fontSize: AppSize.s12,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white)
                            // style: RegisterTableHead.customTextStyle(context),
                            )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s10,
          ),
          Expanded(
            child: StreamBuilder<List<HRAllData>>(
                stream: _hrAllcontroller.stream,
                builder: (context, snapshot) {
                  getAllHrDeptWise(context, widget.deptId).then((data) {
                    _hrAllcontroller.add(data);
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
                              style: CustomTextStylesCommon.commonStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                                color: ColorManager.mediumgrey,
                              ),
                            )
                    );
                  }
                  if (snapshot.hasData) {
                    List<HRAllData> sortedData = snapshot.data!;
                    sortedData.sort((a, b) => b.employeeTypesId.compareTo(a.employeeTypesId));

                    int totalItems = sortedData.length;
                    int totalPages = (totalItems / itemsPerPage).ceil();
                    List<HRAllData> paginatedData = sortedData
                        .skip((currentPage - 1) * itemsPerPage)
                        .take(itemsPerPage)
                        .toList();
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: paginatedData.length ?? 0,
                            // itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                              String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                              HRAllData hrdoc = paginatedData[index];

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
                                          flex: 2,
                                          child: Center(
                                              child: Text(
                                            formattedSerialNumber,
                                            // snapshot.data![index].name.toString(),
                                            style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff686464)
                                                // color: isSelected ? Colors.white : Colors.black,
                                                ),
                                            textAlign: TextAlign.start,
                                          )),
                                        ),

                                        ///emptype
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: Text(
                                            hrdoc.empType!,
                                            style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff686464)
                                                // color: isSelected ? Colors.white : Colors.black,
                                                ),
                                          )),
                                        ),

                                        ///abbreviation
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: Text(
                                            hrdoc.abbrivation!,
                                            style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff686464)
                                                // color: isSelected ? Colors.white : Colors.black,
                                                ),
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
                                                                      color: ColorManager
                                                                          .blueprime,
                                                                    ));
                                                                  }
                                                                  var type = hrdoc.toString();
                                                                  var shorthand = hrdoc.toString();
                                                                  var hexColorData = snapshot.data!.color!.replaceAll("#", "").toString();
                                                                  //hexColorData = i.color.replaceAll("#","");
                                                                  Color hexColor = Color(int.parse('0xFF$hexColorData'));
                                                                  print('Hex Color ::::${hexColor}');
                                                                  hrcontainerColors[index] = hexColor;
                                                                  var splitHexColor = hexColor.toString().substring(10, 16);
                                                                  typeController = TextEditingController(text: hrdoc.empType.toString());
                                                                  shorthandController = TextEditingController(text: hrdoc.abbrivation.toString());
                                                                  return EditPopupWidget(
                                                                    typeController: typeController,
                                                                    shorthandController: shorthandController,
                                                                    containerColor: hrcontainerColors[index],
                                                                    onSavePressed: () async {
                                                                      await AllFromHrPatch(
                                                                          context,
                                                                          snapshot.data!.empTypeId,
                                                                          snapshot.data!.deptId,
                                                                          type == typeController.text ? type.toString() : typeController.text,
                                                                          shorthand == shorthandController.text ? shorthand.toString() : shorthandController.text,
                                                                          splitHexColor == hrcontainerColors[index] ? splitHexColor : color);
                                                                      getAllHrDeptWise(context, widget.deptId).then((data) {
                                                                        _hrAllcontroller.add(data);
                                                                      }).catchError((error) {});
                                                                      Navigator.pop(context);
                                                                      typeController.clear();
                                                                      shorthandController.clear();
                                                                      seletedType = "Clinical";
                                                                    },
                                                                    onColorChanged: (Color seletedColor) {
                                                                      setState(() {
                                                                        hrcontainerColors[index] = seletedColor;
                                                                        print("Color ${seletedColor}");
                                                                        color = seletedColor.toString().substring(10, 16);
                                                                        _saveColor(index, seletedColor);
                                                                      });
                                                                    },
                                                                    title: 'Edit Employee Type',
                                                                    child: Container(
                                                                      width: 354,
                                                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                                                      decoration: BoxDecoration(
                                                                        color: ColorManager.white,
                                                                        borderRadius: BorderRadius.circular(8),
                                                                        border: Border.all(color: ColorManager.fmediumgrey,width: 1),
                                                                      ),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          snapshot.data!.deptId == AppConfig.clinicalId
                                                                              ? Text(
                                                                            'Clinical',
                                                                            style: CustomTextStylesCommon.commonStyle(
                                                                              fontWeight: FontWeightManager.medium,
                                                                              fontSize: FontSize.s12,
                                                                              color: ColorManager.mediumgrey,
                                                                            ),
                                                                          )
                                                                              : snapshot.data!.deptId == AppConfig.salesId
                                                                              ? Text(
                                                                            "Sales",
                                                                            style: CustomTextStylesCommon.commonStyle(
                                                                              fontWeight: FontWeightManager.medium,
                                                                              fontSize: FontSize.s12,
                                                                              color: ColorManager.mediumgrey,
                                                                            ),
                                                                          )
                                                                              :  Text(
                                                                            'Administration',
                                                                            style: CustomTextStylesCommon.commonStyle(
                                                                              fontWeight: FontWeightManager.medium,
                                                                              fontSize: FontSize.s12,
                                                                              color: ColorManager.mediumgrey,
                                                                            ),
                                                                          ),
                                                                          Icon(
                                                                            Icons.arrow_drop_down,
                                                                            color: ColorManager.mediumgrey,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          });
                                                    },
                                                    icon: Icon(
                                                      Icons.edit_outlined,
                                                      size: 18,
                                                      color: ColorManager
                                                          .bluebottom,
                                                    )),
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
                                                            DeletePopup(
                                                                title:
                                                                    'Delete Employee Type',
                                                                onCancel: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                onDelete: () {
                                                                  setState(() async {
                                                                    await allfromHrDelete(context, hrdoc.employeeTypesId);
                                                                    getAllHrDeptWise(context, widget.deptId).then(
                                                                            (data) {_hrAllcontroller.add(data);
                                                                    }).catchError((error) {
                                                                      // Handle error
                                                                    });
                                                                    Navigator.pop(context);
                                                                  });
                                                                }));
                                                  },
                                                  icon: Icon(
                                                    size: 18,
                                                    Icons.delete_outline_outlined,
                                                    color: Color(0xffF6928A),
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
                          currentPage: currentPage,
                          items: snapshot.data!,
                          itemsPerPage: itemsPerPage,
                          onPreviousPagePressed: () {
                            setState(() {
                              currentPage = currentPage > 1 ? currentPage - 1 : 1;
                            });
                          },
                          onPageNumberPressed: (pageNumber) {
                            setState(() {
                              currentPage = pageNumber;
                            });
                          },
                          onNextPagePressed: () {
                            setState(() {
                              currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                            });
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
  }
}