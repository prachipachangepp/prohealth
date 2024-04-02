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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomDropdownTextField(
                              labelText: 'Type of Clinician',
                              labelStyle: TextStyle(),
                              labelFontSize: 12,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 20,
                              labelText: 'First Name',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 20,
                              labelText: 'Last Name',
                              labelStyle: TextStyle(),
                              controller: _controller4,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomDropdownTextField(
                              labelText: 'Speciality',
                              labelStyle: TextStyle(),
                              labelFontSize: 12,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 20,
                              labelText: 'Social Security No',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              suffixIcon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.blue,
                                size: 14,
                              ),
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Primary Phone No',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Secondary Phone No',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Personal Phone No',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomDropdownTextField(
                              labelText: 'City',
                              labelStyle: TextStyle(),
                              labelFontSize: 12,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomDropdownTextField(
                              labelText: 'Country',
                              labelStyle: TextStyle(),
                              labelFontSize: 12,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomDropdownTextField(
                              labelText: 'Zone',
                              labelStyle: TextStyle(),
                              labelFontSize: 12,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomDropdownTextField(
                              labelText: 'Reporting Office',
                              labelStyle: TextStyle(),
                              labelFontSize: 12,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Personal Email',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Work Email',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Address',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Date of Birth',
                              labelStyle: TextStyle(),
                              controller: _controller2,
                              suffixIcon: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.blue,
                                size: 14,
                              ),
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: MediaQuery.of(context).size.width / 24),
                        //   child: CustomTextField(
                        //     width: textFieldWidth,
                        //     height: textFieldHeight,
                        //     cursorHeight: 22,
                        //     labelText: 'Emergency',
                        //     labelStyle: TextStyle(),
                        //     controller: _controller2,
                        //     focusNode: FocusNode(),
                        //     labelFontSize: 12,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 99,
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
                    child: Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: McqWidget(
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
                              ),
                              Flexible(
                                child: McqWidget(
                                  title: 'Flexible Coverage',
                                  items: [
                                    'Saturday',
                                    'Sunday',
                                    'Holiday',
                                    'On Call'
                                  ],
                                  onChanged: (int) {},
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: McqWidget(
                                  title: 'Gender',
                                  items: [
                                    'Male',
                                    'Female',
                                    'Other',
                                  ],
                                  onChanged: (int) {},
                                ),
                              ),
                              Flexible(
                                child: McqWidget(
                                  title: 'Status',
                                  items: ['Active', 'Trainee', 'Inactive'],
                                  onChanged: (int) {},
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Flexible(
                                child: McqWidget(
                                  title: 'Service',
                                  items: [
                                    'Home Health',
                                    'Hospice',
                                    'Home Care',
                                    'Palliative Care'
                                  ],
                                  onChanged: (int) {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
