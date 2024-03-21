import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/constant_textfield/const_textfield.dart';
import 'package:prohealth/presentation/widgets/mcq_const_widget/mcq_const_widget.dart';

///prachi to do
class ClinicalTab extends StatelessWidget {
  final TextEditingController _yourController = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight1 = MediaQuery.of(context).size.height * 0.4;
    double containerHeight2 = MediaQuery.of(context).size.height * 0.3;
    double textFieldWidth = 200;
    double textFieldHeight = 38;
    FocusNode _focusNode = FocusNode();
    int? _selectedItemIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// first container
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height / 70),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
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
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///1st column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomDropdownTextField(
                              labelText: 'Type of Clinician',
                              labelStyle: TextStyle(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Social Security Number',
                              labelStyle: TextStyle(),
                              suffixIcon: Icon(
                                Icons.remove_red_eye_sharp,
                                color: Color(0xff50B5E5),
                                size: MediaQuery.of(context).size.width / 99,
                              ),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomDropdownTextField(
                              labelText: 'Country',
                              labelStyle: TextStyle(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Work Email',
                              labelStyle: TextStyle(),
                              controller: _controller4,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Work Email',
                              labelStyle: TextStyle(),
                              controller: _controller4,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                          ],
                        ),
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'First Name',
                              labelStyle: TextStyle(),
                              controller: _controller5,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Personal Phone Number',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomDropdownTextField(
                              labelText: 'Zone',
                              labelStyle: TextStyle(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomTextField(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 22,
                                labelText: 'Address',
                                labelStyle: TextStyle(),
                                controller: _controller3,
                                focusNode: FocusNode(),
                                labelFontSize:
                                    MediaQuery.of(context).size.width / 99),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Last Name',
                              labelStyle: TextStyle(),
                              controller: _controller4,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Work Phone Number',
                              labelStyle: TextStyle(),
                              controller: _controller1,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomDropdownTextField(
                              labelText: 'Reporting Office',
                              labelStyle: TextStyle(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Date of Birth',
                              labelStyle: TextStyle(),
                              controller: _controller1,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdownTextField(
                              labelText: 'Speciality',
                              labelStyle: TextStyle(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'City',
                              labelStyle: TextStyle(),
                              controller: _controller1,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomDropdownTextField(
                              labelText: 'Reporting Office',
                              labelStyle: TextStyle(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Personal Email',
                              labelStyle: TextStyle(),
                              controller: _controller1,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),

        /// second Container
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height / 70),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    // width: containerWidth,
                    height: containerHeight2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffB7B7B7),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            McqWidget(
                              title: 'Employment',
                              items: [
                                'Full Time',
                                'Contract',
                                'Part Time',
                                'Per Diem'
                              ],
                              onChanged: (selectedIndex) {
                                print('Selected index: $selectedIndex');
                                _selectedItemIndex = selectedIndex;
                              },
                            ),
                            McqWidget(
                              title: 'Flexible Coverage',
                              items: [
                                'Saturday',
                                'Sunday',
                                'Holiday',
                                'On Call'
                              ],
                              onChanged: (int) {},
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              title: 'Status',
                              items: ['Active', 'Trainee', 'Inactive'],
                              onChanged: (int) {},
                            ),
                          ],
                        ),
                        Column(
                          children: [
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
