import 'dart:math';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/edit_emp_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../widgets/table_constant.dart';

class HrSalesScreen extends StatefulWidget {
  HrSalesScreen({super.key});

  @override
  State<HrSalesScreen> createState() => _HrSalesScreenState();
}

class _HrSalesScreenState extends State<HrSalesScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  Color containerColor = ColorManager.pinkfaint;
  late List<Color> containerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    containerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors(); // Load saved colors
  }

  /// Load saved colors from SharedPreferences
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

  /// Save color to SharedPreferences
  void _saveColor(int index, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('containerColor$index', color.value);
  }

  @override
  Widget build(BuildContext context) {
    // void updateContainerColor(Color color) {
    //   setState(() {
    //     containerColor = color;
    //   });
    // }

    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomIconButtonConst(
            text: AppStringEM.addemployeetype,
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
                    containerColor: ColorManager.pinkfaint,
                  );
                },
              );
            }),
        SizedBox(
          height: AppSize.s20,
        ),
        TableHeadConstant(items: [
          TableHeadItem(text: AppStringEM.srno, textAlign: TextAlign.start),
          TableHeadItem(text: AppStringEM.employeetype, textAlign: TextAlign.start),
          TableHeadItem(
              text: AppStringEM.abbrevation, textAlign: TextAlign.start),
          TableHeadItem(text: AppStringEM.color, textAlign: TextAlign.start),
          TableHeadItem(text: AppStringEM.action, textAlign: TextAlign.center),
        ]),
        SizedBox(
          height: AppSize.s5,
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                String formattedSerialNumber =
                    serialNumber.toString().padLeft(2, '0');
                return Container(
                    margin: EdgeInsets.all(AppSize.s5,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              formattedSerialNumber,
                              textAlign: TextAlign.end,
                              style:AllHRTableData.customTextStyle(context)
                            ),
                            Text(
                              AppStringEM.salesManager,
                              textAlign: TextAlign.end,
                              style: AllHRTableData.customTextStyle(context)
                            ),
                            Text(
                              AppStringEM.sm,
                              textAlign: TextAlign.end,
                              style: AllHRTableData.customTextStyle(context)
                            ),

                            ///also change the color of this container
                            Container(
                              width: MediaQuery.of(context).size.width / 20,
                              height: AppSize.s56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: containerColors[index],
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
                                          typeController: TextEditingController(),
                                          shorthandController:
                                              TextEditingController(),
                                          emailController:
                                              TextEditingController(),
                                          containerColor:
                                              containerColors[index],
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
                                  icon: Icon(Icons.edit_outlined),
                                  color: ColorManager.mediumgrey,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: ColorManager.faintOrange,
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