import 'dart:async';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/edit_emp_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../widgets/widgets/const_appbar/controller.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';

class HrClinicalScreen extends StatefulWidget {
  final int deptId;
  HrClinicalScreen({super.key, required this.deptId});

  @override
  State<HrClinicalScreen> createState() => _HrClinicalScreenState();
}

class _HrClinicalScreenState extends State<HrClinicalScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final HRClincicalController hrClinController = Get.put(HRClincicalController());
  final StreamController<List<HRAllData>> _controller = StreamController<List<HRAllData>>();

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  String? selectedValue;
  late List<Color> hrcontainerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 30;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
    getAllHrDeptWise(context,widget.deptId).then((data){
    _controller.add(data);
    }).catchError((error){});
  }

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
  String seletedType = "Clinical";
  String color ="";
  int docTypeMetaId =1;
  int doceEditMetaId=1;
  void onChange(String seletedTypeEmp){
    setState(() {
      seletedType = seletedTypeEmp;
    });
  }
  void _saveColor(int index, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('containerColor$index', color.value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///dropdown
            Container(
              height: AppSize.s32,
              width: AppSize.s103,
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: BoxDecoration(
                color: ColorManager.blueprime,
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Obx(
                () => Center(
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: MediaQuery.of(context).size.width / 80,
                      color: ColorManager.white,
                    ),
                    dropdownColor: ColorManager.white,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 92,
                      color: ColorManager.white,
                    ),
                    underline: Container(),
                    value: hrClinController.selectedItem.value,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        hrClinController.changeSelectedItem(newValue);
                      }
                    },
                    items: [
                      'Sort By',
                      'Available',
                      'Unavailable',
                    ]
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                color:
                                    hrClinController.selectedItem.value == value
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.bold,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            ///button
            Container(
              width: AppSize.s172,
              height: AppSize.s32,
              child: CustomIconButtonConst(
                text: AppString.addemployeetype,
                icon: Icons.add,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomPopupWidget(
                        typeController: typeController,
                        abbreviationController: shorthandController,
                        containerColor: hrcontainerColors[1],
                        onAddPressed: () async {
                          await addEmployeeTypePost(
                            context,
                            docTypeMetaId,
                            typeController.text,
                            color,
                            shorthandController.text,
                          );
                          await getAllHrDeptWise(context, widget.deptId).then((data) {
                            _controller.add(data);
                          }).catchError((error) {});
                          Navigator.pop(context);
                          typeController.clear();
                          shorthandController.clear();
                        },
                        onColorChanged: (Color selectedColor) {
                          setState(() {
                            hrcontainerColors[1] = selectedColor;
                            color = selectedColor.toString().substring(10, 16);
                            _saveColor(1, selectedColor);
                          });
                        },
                        title: 'Add Clinical',
                        child: FutureBuilder<List<HRHeadBar>>(
                          future: companyHRHeadApi(context, widget.deptId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 350,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ColorManager.faintGrey,
                                    borderRadius: BorderRadius.circular(10),
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
                            if (snapshot.hasData) {
                              List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
                                  .map((i) => DropdownMenuItem<String>(
                                child: Text(i.deptName),
                                value: i.deptName,
                              ))
                                  .toList();

                              return CICCDropdown(
                                initialValue: dropDownMenuItems[0].value,
                                onChange: (val) {
                                  for (var a in snapshot.data!) {
                                    if (a.deptName == val) {
                                      docTypeMetaId = a.deptId;
                                    }
                                  }
                                },
                                items: dropDownMenuItems,
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),

            ),
          ],
        ),
        SizedBox(
          height: AppSize.s20,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(''),
                Text(
                    AppStringEM.srno,
                    style:  AllHRTableHeading.customTextStyle(context)
                ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Text(AppStringEM.employee,textAlign: TextAlign.start,
                      style:  AllHRTableHeading.customTextStyle(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Text(
                      AppStringEM.abbrevation,
                      style:  AllHRTableHeading.customTextStyle(context)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                      AppStringEM.color,
                      style:  AllHRTableHeading.customTextStyle(context)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(AppStringEM.action,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: AppSize.s5,
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child:
    StreamBuilder<List<HRAllData>>(
              stream: _controller.stream,
              builder: (context, snapshot) {
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
                      AppString.dataNotFound,
                      style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  int totalItems = snapshot.data!.length;
                  // int totalPages = (totalItems / itemsPerPage).ceil();
                  List<HRAllData> currentPageItems =
                  snapshot.data!.sublist(
                    (currentPage - 1) * itemsPerPage,
                    (currentPage * itemsPerPage) > totalItems
                        ? totalItems
                        : (currentPage * itemsPerPage),
                  );
                  return
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: currentPageItems.length,
                itemBuilder: (context, index) {
                  int serialNumber =
                      index + 1 + (currentPage - 1) * itemsPerPage;
                  String formattedSerialNumber =
                      serialNumber.toString().padLeft(2, '0');

                  return Container(
                      margin: EdgeInsets.all(5,),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: AppSize.s56,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              formattedSerialNumber,
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                                snapshot.data![index].empType.toString(),
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                                snapshot.data![index].abbrivation.toString(),
                                textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 20,
                              height: AppSize.s22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: snapshot.data![index].color?.toColor,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ///edit
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context, builder: (BuildContext context) {
                                        return FutureBuilder<HRGetEmpId>(
                                            future: HrGetById(context, snapshot.data![index].employeeTypesId),
                                            builder: (context, snapshot) {
                                              if(snapshot.connectionState == ConnectionState.waiting){
                                                return Center(child:CircularProgressIndicator(color: ColorManager.blueprime,));
                                              }
                                              var type = snapshot.data?.empType.toString();
                                              var shorthand = snapshot.data?.empType.toString();
                                              var hexColorData = snapshot.data!.color!.replaceAll("#","").toString();
                                               //hexColorData = i.color.replaceAll("#","");
                                              Color hexColor = Color(int.parse('0xFF$hexColorData'));
                                              print('Hex Color ::::${hexColor}');
                                               hrcontainerColors[index] = hexColor;
                                              var splitHexColor = hexColor.toString().substring(10,16);
                                              typeController = TextEditingController(text: snapshot.data?.empType.toString());
                                              shorthandController = TextEditingController(text: snapshot.data?.abbrivation.toString());
                                              return EditPopupWidget(
                                                typeController: typeController,
                                                shorthandController: shorthandController,
                                                containerColor: hrcontainerColors[index],
                                                onSavePressed: () async{
                                                  await AllFromHrPatch(context, snapshot.data!.empTypeId, 1,
                                                      type == typeController.text ? type.toString() : typeController.text,
                                                      shorthand == shorthandController.text ? shorthand.toString() : shorthandController.text,
                                                      splitHexColor == hrcontainerColors[index] ? splitHexColor : color );
                                                  getAllHrDeptWise(context,widget.deptId).then((data){
                                                    _controller.add(data);
                                                  }).catchError((error){});
                                                  Navigator.pop(context);
                                                  typeController.clear();
                                                  shorthandController.clear();
                                                  seletedType = "Administrative";
                                                },
                                                onColorChanged: (Color seletedColor) {
                                                  setState(() {
                                                    hrcontainerColors[index] = seletedColor;
                                                    print("Color ${seletedColor}");
                                                    color = seletedColor.toString().substring(10,16);
                                                    _saveColor(index, seletedColor);
                                                  });
                                                }, title: 'Edit Clinical',
                                                child:  FutureBuilder<List<HRHeadBar>>(
                                                  future: companyHRHeadApi(context,widget.deptId),
                                                  builder: (context,snapshot) {
                                                    if(snapshot.connectionState == ConnectionState.waiting){
                                                      return Shimmer.fromColors(
                                                          baseColor: Colors.grey[300]!,
                                                          highlightColor: Colors.grey[100]!,
                                                          child: Container(
                                                            width: 350,
                                                            height: 30,
                                                            decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                                          )
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
                                                          initialValue: dropDownMenuItems[0].value,
                                                          onChange: (val){
                                                            for(var a in snapshot.data!){
                                                              if(a.deptName == val){
                                                                docType = a.deptId;
                                                                doceEditMetaId = docType;
                                                              }
                                                            }
                                                            print(":::${docType}");
                                                            print(":::<>${doceEditMetaId}");
                                                          },
                                                          items:dropDownMenuItems
                                                      );
                                                    }else{
                                                      return SizedBox();
                                                    }
                                                  }
                                              ),
                                                // onColorChanged: (Color color) {
                                                //   setState(() {
                                                //     containerColors[index] =
                                                //      color; // Update color for this item
                                                //   });
                                                // },
                                              );
                                            }
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.edit_outlined,size: 18,),
                                  color: ColorManager.blueprime,
                                ),
                                ///delete
                                IconButton(
                                  onPressed: () {
                                     showDialog(context: context,
                                        builder: (context) => DeletePopup(
                                            title: 'Delete Clinical',
                                            onCancel: (){
                                              Navigator.pop(context);
                                            }, onDelete: () async {
                                           await  allfromHrDelete(
                                                context, snapshot.data![index].employeeTypesId!);
                                            getAllHrDeptWise(context,widget.deptId).then((data){
                                              _controller.add(data);
                                            }).catchError((error){});
                                             Navigator.pop(context);
                                        }));

                                  },
                                  icon: Icon(
                                    size: 18,
                                    Icons.delete_outline,
                                    color: Color(0xffF6928A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                })
              ;
  }
  return Offstage();
},
),
          ),
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        // PaginationControlsWidget(
        //   currentPage: currentPage,
        //   items: items,
        //   itemsPerPage: itemsPerPage,
        //   onPreviousPagePressed: () {
        //     /// Handle previous page button press
        //     setState(() {
        //       currentPage = currentPage > 1 ? currentPage - 1 : 1;
        //     });
        //   },
        //   onPageNumberPressed: (pageNumber) {
        //     /// Handle page number tap
        //     setState(() {
        //       currentPage = pageNumber;
        //     });
        //   },
        //   onNextPagePressed: () {
        //     /// Handle next page button press
        //     setState(() {
        //       currentPage = currentPage < (items.length / itemsPerPage).ceil()
        //           ? currentPage + 1
        //           : (items.length / itemsPerPage).ceil();
        //     });
        //   },
        // ),
      ],
    );
  }
}