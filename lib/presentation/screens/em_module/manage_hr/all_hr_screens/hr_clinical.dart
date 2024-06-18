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
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/edit_emp_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final StreamController<List<HRClinical>> _controller = StreamController<List<HRClinical>>();

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  String? selectedValue;
  late List<Color> hrcontainerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
    companyAllHrClinicApi(context).then((data){
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
                          nameController: nameController,
                          addressController: addressController,
                          emailController: emailController,
                          onAddPressed: () async {
                            await addEmployeeTypePost(context,1,nameController.text,"#E8A87D",'NC');
                            companyAllHrClinicApi(context).then((data){
                              _controller.add(data);
                            }).catchError((error){});
                            Navigator.pop(context);
                          },
                          containerColor: ColorManager.sfaintOrange, onColorChanged: (Color ) {  },
                        );
                      },
                    );
                  }),
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
                  style: AllHRTableHeading.customTextStyle(context)
                ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Text(AppStringEM.employee,textAlign: TextAlign.start,
                    style: AllHRTableHeading.customTextStyle(context)),
                Text(
                  AppStringEM.abbrevation,
                  style:  AllHRTableHeading.customTextStyle(context)
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 60.0),
                  child: Text(
                    AppStringEM.color,
                    style:  AllHRTableHeading.customTextStyle(context)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(AppStringEM.action,
                      textAlign: TextAlign.start,
                      style:  AllHRTableHeading.customTextStyle(context)),
                ),
              ],
            ),
          ),
        ),
        // TableHeadConstant(items: [
        //   TableHeadItem(text: AppStringEM.srno, textAlign: TextAlign.start),
        //   TableHeadItem(text: AppStringEM.employee, textAlign: TextAlign.start),
        //   TableHeadItem(
        //       text: AppStringEM.abbrevation, textAlign: TextAlign.start),
        //   TableHeadItem(text: AppStringEM.color, textAlign: TextAlign.start),
        //   TableHeadItem(text: AppStringEM.action, textAlign: TextAlign.center),
        // ]),
        SizedBox(
          height: AppSize.s5,
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child:
    StreamBuilder<List<HRClinical>>(
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
                  List<HRClinical> currentPageItems =
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: AppSize.s5, right: AppSize.s10),
                                height: AppSize.s7,
                                width: AppSize.s7,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: ColorManager.greenDark),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                formattedSerialNumber,
                                textAlign: TextAlign.center,
                                style: AllHRTableData.customTextStyle(context)
                              ),
                              Text(
                                  snapshot.data![index].empType.toString(),
                                textAlign: TextAlign.center,
                                style: AllHRTableData.customTextStyle(context)
                              ),
                              Text(
                                  snapshot.data![index].abbrivation.toString(),
                                  textAlign: TextAlign.center,
                                style: AllHRTableData.customTextStyle(context)
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 20,
                                height: AppSize.s22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: snapshot.data![index].color?.toColor,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EditPopupWidget(
                                            typeController:
                                                TextEditingController(),
                                            shorthandController:
                                                TextEditingController(),
                                            emailController:
                                                TextEditingController(),
                                            containerColor:
                                                hrcontainerColors[index],
                                            onSavePressed: () {},
                                            onColorChanged: (Color color) {
                                              setState(() {
                                                hrcontainerColors[index] =
                                                    color;
                                                _saveColor(index, color);
                                              });
                                            },
                                            // onColorChanged: (Color color) {
                                            //   setState(() {
                                            //     containerColors[index] =
                                            //      color; // Update color for this item
                                            //   });
                                            // },
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.edit_outlined,size: 18,),
                                    color: ColorManager.blueprime,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                        showDialog(context: context,
                                            builder: (context) => DeletePopup(onCancel: (){
                                          Navigator.pop(context);
                                        }, onDelete: (){

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
                            ],
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