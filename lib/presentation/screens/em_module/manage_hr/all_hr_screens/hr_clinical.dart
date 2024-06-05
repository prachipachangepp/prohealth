import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/edit_emp_popup_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              height: 32,
              width: 103,
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Obx(
                () => Center(
                  child: DropdownButton<String>(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: MediaQuery.of(context).size.width / 89,
                      color: Colors.white,
                    ),
                    dropdownColor: ColorManager.white,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 92,
                      color: Colors.white,
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
                                fontSize: 11,
                                fontWeight: FontWeight.w200,
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
              width: 170,
              height: 32,
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
                          containerColor: Color(0xffE8A87D),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TableHeadConstant(items: [
          TableHeadItem(text: AppString.srno, textAlign: TextAlign.start),
          TableHeadItem(text: AppString.employee, textAlign: TextAlign.start),
          TableHeadItem(
              text: AppString.abbrevation, textAlign: TextAlign.start),
          TableHeadItem(text: AppString.color, textAlign: TextAlign.start),
          TableHeadItem(text: AppString.action, textAlign: TextAlign.center),
        ]),
        SizedBox(
          height: 5,
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
                      margin: EdgeInsets.all(
                        5,
                      ),
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
                      height: 56,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5, right: 10),
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Color(0xff008000)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                formattedSerialNumber,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.firaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff686464),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                AppString.licensevocnurse,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.firaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff686464),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                AppString.nc,
                                textAlign: TextAlign.end,
                                style: GoogleFonts.firaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff686464),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 20,
                                height: 22,
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
                                  //           containerColor: Color(0xffE4CCF3),
                                  //           onSavePressed: () {},
                                  //           onColorChanged: (Color) {},
                                  //           // onColorChanged: (Color) {},
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.edit_outlined,
                                  //     color: Color(0xff898989),
                                  //   ),
                                  // ),
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
      ],
    );
  }
}

///
// DropdownButtonFormField<String>(
//   focusColor: Colors.transparent,
//   icon: Icon(
//     Icons.arrow_drop_down_sharp,
//     color: Colors.white,
//   ),
//   decoration: InputDecoration.collapsed(
//     hintText: '',
//   ),
//   items: <String>[
//     'Sort By',
//     'Available',
//     'Unavailable',
//   ].map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(
//         textAlign: TextAlign.center,
//         value,
//         style: TextStyle(
//           color: selectedValue != null ? Colors.white : Colors.black,
//         ),
//       ),
//     );
//   }).toList(),
//   onChanged: (String? newValue) {
//     // setState(() {
//     //   selectedValue = newValue;
//     // });
//     if (newValue != null) {
//       selectedValue == newValue;
//     }
//   },
//   value: selectedValue,
//   style: GoogleFonts.firaSans(
//     fontSize: 12,
//     fontWeight: FontWeight.w600,
//     color: Color(0xff686464),
//     decoration: TextDecoration.none,
//   ),
// ),
///
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
