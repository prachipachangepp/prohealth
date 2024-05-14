import 'dart:math';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/sm_module/hr_screens/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/sm_module/hr_screens/widgets/edit_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/sm_module/widgets/table_constant.dart';
import 'package:prohealth/presentation/widgets/custom_icon_button_constant.dart';

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

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
  }

  ///
  List<Color> _selectedColors = List.filled(
      2, Color(0xffE8A87D)); // Initialize with default color for 2 items
  List<String> _selectedColorCodes =
      List.filled(2, ''); // Initialize with empty strings for 2 items

  void _openColorPicker(int index) async {
    Color? pickedColor = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColorPicker(
                  borderColor: _selectedColors[index],
                  onColorChanged: (Color color) {
                    setState(() {
                      _selectedColors[index] = color;
                      _selectedColorCodes[index] =
                          color.value.toRadixString(16).toUpperCase();
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_selectedColors[index]);
              },
            ),
          ],
        );
      },
    );

    if (pickedColor != null) {
      setState(() {
        _selectedColors[index] = pickedColor;
        _selectedColorCodes[index] =
            pickedColor.value.toRadixString(16).toUpperCase();
      });
    }
  }

  ///
  // Color _selectedColor = Color(0xffE8A87D); // Default color
  // void _openColorPicker() async {
  //   Color? pickedColor = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Pick a color'),
  //         content: SingleChildScrollView(
  //           child: ColorPicker(
  //             // The initial color selected in the picker
  //             borderColor: _selectedColor,
  //
  //             // Function that gets called whenever the picked color changes
  //             onColorChanged: (Color color) {
  //               setState(() {
  //                 _selectedColor = color;
  //               });
  //             },
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop(_selectedColor);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //
  //   if (pickedColor != null) {
  //     setState(() {
  //       _selectedColor = pickedColor;
  //     });
  //   }
  // }

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
            text: 'Add Employee Type',
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
                    containerColor: Color(0xffF69DF6),
                  );
                },
              );
            }),
        SizedBox(
          height: 20,
        ),
        TableHeadConstant(items: [
          TableHeadItem(text: 'Sr No', textAlign: TextAlign.start),
          TableHeadItem(text: 'EmployeeType', textAlign: TextAlign.start),
          TableHeadItem(
              text: 'Abbreviation            ', textAlign: TextAlign.start),
          TableHeadItem(text: 'Color', textAlign: TextAlign.start),
          TableHeadItem(text: 'Actions ', textAlign: TextAlign.center),
        ]),
        SizedBox(
          height: 5,
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
                              'Sales Manager',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.firaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff686464),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              'SM',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.firaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff686464),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _openColorPicker(
                                  index), // Pass index to open color picker for the correct item
                              child: Container(
                                width: MediaQuery.of(context).size.width / 20,
                                height: 22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: _selectedColors[index],
                                ),
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
                                              _selectedColors[index],
                                          onSavePressed: () {},
                                          onColorChanged: (Color color) {
                                            // Handle color change here
                                          },
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
                                //           containerColor: Color(0xffE8A87D),
                                //           onSavePressed: () {},
                                //           onColorChanged: (Color) {},
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
                          ],
                        ),
                      ],
                    ));
              }),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 30,
          // color: Colors.black12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(bottom: 2),
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      currentPage = currentPage > 1 ? currentPage - 1 : 1;
                    });
                  },
                  color: Colors.black,
                  iconSize: 20,
                ),
              ),
              SizedBox(width: 3), // Add space between containers
              for (var i = 1; i <= (items.length / itemsPerPage).ceil(); i++)
                if (i == 1 ||
                    i == currentPage ||
                    i == (items.length / itemsPerPage).ceil())
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentPage = i;
                      });
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: currentPage == i ? Colors.blue : Colors.grey,
                          width: currentPage == i ? 2.0 : 1.0,
                        ),
                        color:
                            currentPage == i ? Colors.blue : Colors.transparent,
                      ),
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: currentPage == i ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                else if (i == currentPage - 1 || i == currentPage + 1)
                  Text(
                    '..',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
              SizedBox(width: 3),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(bottom: 2),
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      currentPage =
                          currentPage < (items.length / itemsPerPage).ceil()
                              ? currentPage + 1
                              : (items.length / itemsPerPage).ceil();
                    });
                  },
                  color: Colors.black,
                  iconSize: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
//add employee popup need table in which we can fetch list  from api
///Abbrevation
///Type of employee
