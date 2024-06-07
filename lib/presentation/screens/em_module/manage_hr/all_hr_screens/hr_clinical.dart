import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/edit_emp_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../widgets/widgets/const_appbar/controller.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../widgets/table_constant.dart';

class HrClinicalScreen extends StatefulWidget {
  HrClinicalScreen({super.key});

  @override
  State<HrClinicalScreen> createState() => _HrClinicalScreenState();
}

class _HrClinicalScreenState extends State<HrClinicalScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final HRClincicalController hrClinController =
      Get.put(HRClincicalController());

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
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
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
                      size: MediaQuery.of(context).size.width / 89,
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
                              style: TextStyle(
                                color:
                                    hrClinController.selectedItem.value == value
                                        ? Colors.white
                                        : Colors.black,
                                fontFamily: 'FiraSans',
                                fontSize: FontSize.s10,
                                fontWeight: FontWeightManager.light,
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
                          onAddPressed: () {},
                          containerColor: ColorManager.sfaintOrange,
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
        TableHeadConstant(items: [
          TableHeadItem(text: AppStringEM.srno, textAlign: TextAlign.start),
          TableHeadItem(text: AppStringEM.employee, textAlign: TextAlign.start),
          TableHeadItem(
              text: AppStringEM.abbrevation, textAlign: TextAlign.start),
          TableHeadItem(text: AppStringEM.color, textAlign: TextAlign.start),
          TableHeadItem(text: AppStringEM.action, textAlign: TextAlign.center),
        ]),
        SizedBox(
          height: AppSize.s5,
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
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
                                textAlign: TextAlign.end,
                                style: AllHRTableData.customTextStyle(context)
                              ),
                              Text(
                                AppStringEM.licensevocnurse,
                                textAlign: TextAlign.end,
                                style: AllHRTableData.customTextStyle(context)
                              ),
                              Text(
                                AppStringEM.nc,
                                textAlign: TextAlign.end,
                                style: AllHRTableData.customTextStyle(context)
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 20,
                                height: AppSize.s22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: hrcontainerColors[index],
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
                                    icon: Icon(Icons.edit_outlined),
                                    color: ColorManager.mediumgrey,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
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
                }),
          ),
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        PaginationControlsWidget(
          currentPage: currentPage,
          items: items,
          itemsPerPage: itemsPerPage,
          onPreviousPagePressed: () {
            /// Handle previous page button press
            setState(() {
              currentPage = currentPage > 1 ? currentPage - 1 : 1;
            });
          },
          onPageNumberPressed: (pageNumber) {
            /// Handle page number tap
            setState(() {
              currentPage = pageNumber;
            });
          },
          onNextPagePressed: () {
            /// Handle next page button press
            setState(() {
              currentPage = currentPage < (items.length / itemsPerPage).ceil()
                  ? currentPage + 1
                  : (items.length / itemsPerPage).ceil();
            });
          },
        ),
      ],
    );
  }
}