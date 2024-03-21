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
    double textFieldWidth = MediaQuery.of(context).size.width / 4.8;
    double textFieldHeight = MediaQuery.of(context).size.width / 30;
    FocusNode _focusNode = FocusNode();
    int? _selectedItemIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///1st column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              labelText: 'Type of Clinician',
                              labelStyle: TextStyle(),
                              controller: _controller1,
                              focusNode: _focusNode,
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Social Security Number',
                              labelStyle: TextStyle(),
                              suffixIcon: Icon(
                                Icons.remove_red_eye_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Country',
                              labelStyle: TextStyle(),
                              controller: _controller3,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
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
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
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
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Zone',
                              labelStyle: TextStyle(),
                              controller: _controller3,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
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
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Reporting Office',
                              labelStyle: TextStyle(),
                              controller: _controller5,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Speciality',
                              labelStyle: TextStyle(),
                              controller: _controller5,
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                size: MediaQuery.of(context).size.width / 80,
                              ),
                              focusNode: FocusNode(),
                              labelFontSize:
                                  MediaQuery.of(context).size.width / 99,
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
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 180,
        ),

        /// second Container
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
