import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/constant_textfield/const_textfield.dart';
import 'package:prohealth/presentation/widgets/mcq_const_widget/mcq_const_widget.dart';

///prachi
class SalesTab extends StatelessWidget {
  final TextEditingController _sale1Controller = TextEditingController();
  final TextEditingController _socialsecuritynoController =
      TextEditingController();
  final TextEditingController _workemailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _personalnoController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _worknoController = TextEditingController();
  final TextEditingController _dateofbirthController = TextEditingController();
  final TextEditingController _reportingofficeController =
      TextEditingController();
  final TextEditingController _personalemailController =
      TextEditingController();
  final TextEditingController _personalcontactnoController =
      TextEditingController();
  int? _selectedItemIndex;
  @override
  Widget build(BuildContext context) {
    double containerHeight1 = MediaQuery.of(context).size.height * 0.3;
    double containerHeight2 = MediaQuery.of(context).size.height * 0.2;
    double textFieldWidth = MediaQuery.of(context).size.width / 4.8;
    double textFieldHeight = MediaQuery.of(context).size.width / 30;
    FocusNode _focusNode = FocusNode();
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      /// first container
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 80),
                child: Container(
                  // width: containerWidth,
                  height: containerHeight1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: Color(0xffB7B7B7),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(0, 3),
                        color: Color(0xffB7B7B7).withOpacity(0.5),
                      ),
                      BoxShadow(color: Colors.white, offset: Offset(-3, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(3, 0)),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ///1st column
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              labelText: 'Designation',
                              labelStyle: TextStyle(),
                              controller: _sale1Controller,
                              focusNode: _focusNode,
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              labelText: 'Social Security Number',
                              labelStyle: TextStyle(),
                              controller: _socialsecuritynoController,
                              focusNode: _focusNode,
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              labelText: 'Work Email',
                              labelStyle: TextStyle(),
                              controller: _sale1Controller,
                              focusNode: _focusNode,
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                          ]),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_sharp,
                              size: MediaQuery.of(context).size.width / 80,
                            ),
                            labelText: 'First name',
                            labelStyle: TextStyle(),
                            controller: _firstnameController,
                            focusNode: _focusNode,
                            labelFontSize:
                                MediaQuery.of(context).size.width / 99,
                          ),
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_sharp,
                              size: MediaQuery.of(context).size.width / 80,
                            ),
                            labelText: 'Personal Phone Number',
                            labelStyle: TextStyle(),
                            controller: _personalnoController,
                            focusNode: _focusNode,
                            labelFontSize:
                                MediaQuery.of(context).size.width / 99,
                          ),
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_sharp,
                              size: MediaQuery.of(context).size.width / 80,
                            ),
                            labelText: 'Address',
                            labelStyle: TextStyle(),
                            controller: _addressController,
                            focusNode: _focusNode,
                            labelFontSize:
                                MediaQuery.of(context).size.width / 99,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_sharp,
                              size: MediaQuery.of(context).size.width / 80,
                            ),
                            labelText: 'Last Name',
                            labelStyle: TextStyle(),
                            controller: _lastnameController,
                            focusNode: _focusNode,
                            labelFontSize:
                                MediaQuery.of(context).size.width / 99,
                          ),
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_sharp,
                              size: MediaQuery.of(context).size.width / 80,
                            ),
                            labelText: 'Work Phone Number',
                            labelStyle: TextStyle(),
                            controller: _worknoController,
                            focusNode: _focusNode,
                            labelFontSize:
                                MediaQuery.of(context).size.width / 99,
                          ),
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down_sharp,
                              size: MediaQuery.of(context).size.width / 80,
                            ),
                            labelText: 'Date of Birth',
                            labelStyle: TextStyle(),
                            controller: _dateofbirthController,
                            focusNode: _focusNode,
                            labelFontSize:
                                MediaQuery.of(context).size.width / 99,
                          ),
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              labelText: 'Reporting Office',
                              labelStyle: TextStyle(),
                              controller: _reportingofficeController,
                              focusNode: _focusNode,
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              labelText: 'Personal Email',
                              labelStyle: TextStyle(),
                              controller: _personalemailController,
                              focusNode: _focusNode,
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              labelText: 'Personal Contact No.',
                              labelStyle: TextStyle(),
                              controller: _personalnoController,
                              focusNode: _focusNode,
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // SizedBox(height: 5),

      /// second Container
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              // width: containerWidth,
              height: containerHeight2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Color(0xffB7B7B7)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3.0,
                    offset: Offset(0, 3),
                    color: Color(0xffB7B7B7).withOpacity(0.5),
                  ),
                  BoxShadow(color: Colors.white, offset: Offset(-3, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(3, 0)),
                ],
              ),
              child: Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    McqWidget(
                      title: 'Employment',
                      items: ['Full Time', 'Contract', 'Part Time', 'Per Diem'],
                      onChanged: (selectedIndex) {
                        print('Selected index: $selectedIndex');
                        _selectedItemIndex = selectedIndex;
                      },
                    ),
                    McqWidget(
                      title: 'Gender',
                      items: [
                        'Male',
                        'Female',
                        'Other',
                      ],
                      onChanged: (int) {},
                    ),
                    McqWidget(
                      title: 'Service',
                      items: [
                        'Home Health',
                        'Hospice',
                        'Home Care',
                        'Palliative Care'
                      ],
                      onChanged: (int) {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    ]);
  }
}

///

///
