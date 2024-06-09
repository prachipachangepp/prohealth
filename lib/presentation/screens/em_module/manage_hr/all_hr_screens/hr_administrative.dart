import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/admin_emp_data.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/edit_emp_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../widgets/table_constant.dart';

class HrAdministrativeScreen extends StatefulWidget {
  const HrAdministrativeScreen({super.key});

  @override
  State<HrAdministrativeScreen> createState() => _HrAdministrativeScreenState();
}

class _HrAdministrativeScreenState extends State<HrAdministrativeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  AdministrativeData administrativeData = AdministrativeData();

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  late List<Color> containerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    administrativeData.loadEmployeeData();
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

  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomIconButtonConst(
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
                    containerColor: ColorManager.sfaintOrange, onColorChanged: (Color ) {  },
                  );
                },
              );
            }),
        SizedBox(
          height: 20,
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
                Text(AppStringEM.employee,textAlign: TextAlign.start,
                    style:  AllHRTableHeading.customTextStyle(context)),
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

                Text(AppStringEM.action,
                    textAlign: TextAlign.start,
                    style: AllHRTableHeading.customTextStyle(context)),
              ],
            ),
          ),
        ),
        // TableHeadConstant(items: [
        //   TableHeadItem(text: AppStringEM.srno, textAlign: TextAlign.start),
        //   TableHeadItem(
        //       text: AppStringEM.employeetype, textAlign: TextAlign.start),
        //   TableHeadItem(
        //       text: AppStringEM.abbrevation, textAlign: TextAlign.start),
        //   TableHeadItem(text: AppStringEM.color, textAlign: TextAlign.start),
        //   TableHeadItem(text: AppStringEM.action, textAlign: TextAlign.center),
        // ]),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: administrativeData.employeeList.length,
              itemBuilder: (context, index) {
                EmployeeData employee = administrativeData.employeeList[index];
                int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                String formattedSerialNumber =
                    serialNumber.toString().padLeft(2, '0');
                return Container(
                    margin: EdgeInsets.all(
                      5,
                    ),
                    //padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/13),
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
                        Text(
                          formattedSerialNumber,
                          textAlign: TextAlign.center,
                          style: AllHRTableData.customTextStyle(context)
                        ),
                        Text(
                          administrativeData.employeeList[index].employeeType,
                          textAlign: TextAlign.center,
                          style: AllHRTableData.customTextStyle(context)
                        ),
                        Text(
                          administrativeData.employeeList[index].abbreviation,
                          textAlign: TextAlign.center,
                          style: AllHRTableData.customTextStyle(context)
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 20,
                          height: AppSize.s22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: containerColors[index],
                          ),
                        ),
                        //SizedBox(width: MediaQuery.of(context).size.width/15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return EditPopupWidget(
                                      typeController: TextEditingController(),
                                      shorthandController:
                                          TextEditingController(),
                                      emailController:
                                          TextEditingController(),
                                      containerColor: containerColors[index],
                                      onSavePressed: () {},
                                      onColorChanged: (Color color) {
                                        setState(() {
                                          containerColors[index] = color;
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: ColorManager.faintOrange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
              }),
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