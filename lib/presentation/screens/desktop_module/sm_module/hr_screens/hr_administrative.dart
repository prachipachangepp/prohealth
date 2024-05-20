import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/desktop_module/sm_module/hr_screens/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/desktop_module/sm_module/hr_screens/widgets/admin_emp_data.dart';
import 'package:prohealth/presentation/screens/desktop_module/sm_module/hr_screens/widgets/edit_emp_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../widgets/custom_icon_button_constant.dart';
import '../../widgets/profile_bar/widget/pagination_widget.dart';
import '../widgets/table_constant.dart';

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
                    containerColor: Color(0xffE8A87D),
                  );
                },
              );
            }),
        SizedBox(
          height: 20,
        ),
        TableHeadConstant(items: [
          TableHeadItem(text: AppString.srNo, textAlign: TextAlign.start),
          TableHeadItem(
              text: AppString.employeetype, textAlign: TextAlign.start),
          TableHeadItem(
              text: AppString.abbrevation, textAlign: TextAlign.start),
          TableHeadItem(text: AppString.color, textAlign: TextAlign.start),
          TableHeadItem(text: AppString.action, textAlign: TextAlign.center),
        ]),
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
                          color: Color(0xff000000).withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: AppSize.s56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Text(
                            formattedSerialNumber,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff686464),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            administrativeData.employeeList[index].employeeType,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff686464),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            administrativeData.employeeList[index].abbreviation,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff686464),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 20,
                            height: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: containerColors[index],
                            ),
                          ),
                        ),
                        //SizedBox(width: MediaQuery.of(context).size.width/15,),
                        Expanded(
                          child: Row(
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
                                icon: Icon(Icons.edit_outlined),
                                color: ColorManager.mediumgrey,
                              ),
                              // IconButton(
                              //   onPressed: () {
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return EditPopupWidget(
                              //           typeController: typeController,
                              //           shorthandController:
                              //               shorthandController,
                              //           emailController: emailController,
                              //           containerColor: Color(0xffF37F81),
                              //           onSavePressed: () {},
                              //           onColorChanged: (Color) {},
                              //           // onColorChanged: (Color) {},
                              //         );
                              //       },
                              //     );
                              //   },
                              //   icon: Icon(
                              //     Icons.edit_outlined,
                              //     color: ColorManager.mediumgrey,
                              //   ),
                              // ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: ColorManager.faintOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              }),
        ),
        SizedBox(
          height: 10,
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
        // Container(
        //   height: 30,
        //   // color: Colors.black12,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Container(
        //         width: 20,
        //         height: 20,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.rectangle,
        //           borderRadius: BorderRadius.circular(6.39),
        //           border: Border.all(
        //             color: ColorManager.grey,
        //             width: 0.79,
        //           ),
        //         ),
        //         child: IconButton(
        //           padding: EdgeInsets.only(bottom: 1.5),
        //           icon: Icon(Icons.chevron_left),
        //           onPressed: () {
        //             setState(() {
        //               currentPage = currentPage > 1 ? currentPage - 1 : 1;
        //             });
        //           },
        //           color: ColorManager.black,
        //           iconSize: 20,
        //         ),
        //       ),
        //       SizedBox(width: 3),
        //       for (var i = 1; i <= (items.length / itemsPerPage).ceil(); i++)
        //         if (i == 1 ||
        //             i == currentPage ||
        //             i == (items.length / itemsPerPage).ceil())
        //           InkWell(
        //             onTap: () {
        //               setState(() {
        //                 currentPage = i;
        //               });
        //             },
        //             child: Container(
        //               width: 20,
        //               height: 20,
        //               margin: EdgeInsets.only(left: 5, right: 5),
        //               alignment: Alignment.center,
        //               decoration: BoxDecoration(
        //                 shape: BoxShape.rectangle,
        //                 borderRadius: BorderRadius.circular(4),
        //                 border: Border.all(
        //                   color: currentPage == i
        //                       ? ColorManager.blueprime
        //                       : ColorManager.grey,
        //                   width: currentPage == i ? 2.0 : 1.0,
        //                 ),
        //                 color: currentPage == i
        //                     ? ColorManager.blueprime
        //                     : Colors.transparent,
        //                 // border: Border.all(
        //                 //   color: currentPage == i
        //                 //       ? Colors.blue
        //                 //       : Colors.transparent,
        //                 // ),
        //               ),
        //               child: Text(
        //                 '$i',
        //                 style: TextStyle(
        //                   color: currentPage == i ? Colors.white : Colors.grey,
        //                   fontWeight: FontWeightManager.bold,
        //                   fontSize: 12,
        //                 ),
        //               ),
        //             ),
        //           )
        //         else if (i == currentPage - 1 || i == currentPage + 1)
        //           Text(
        //             '..',
        //             style: TextStyle(
        //               color: ColorManager.black,
        //               fontWeight: FontWeightManager.bold,
        //               fontSize: 12,
        //             ),
        //           ),
        //       Container(
        //         width: 20,
        //         height: 20,
        //         alignment: Alignment.center,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.rectangle,
        //           borderRadius: BorderRadius.circular(4),
        //           border: Border.all(
        //             color: Colors.grey,
        //             width: 0.79,
        //           ),
        //         ),
        //         child: IconButton(
        //           padding: EdgeInsets.only(bottom: 2),
        //           icon: Icon(Icons.chevron_right),
        //           onPressed: () {
        //             setState(() {
        //               currentPage =
        //                   currentPage < (items.length / itemsPerPage).ceil()
        //                       ? currentPage + 1
        //                       : (items.length / itemsPerPage).ceil();
        //             });
        //           },
        //           color: ColorManager.black,
        //           iconSize: 20,
        //         ),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }
}
