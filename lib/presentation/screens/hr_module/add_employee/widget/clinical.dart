import 'package:flutter/material.dart';
import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../manage/widgets/custom_icon_button_constant.dart';
import 'mcq_widget_add-employee.dart';

///prachi to do
class ClinicalTab extends StatelessWidget {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  final TextEditingController _controller7 = TextEditingController();
  final TextEditingController _controller8 = TextEditingController();
  final TextEditingController _controller9 = TextEditingController();
  final TextEditingController _controller10 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // double containerWidth = MediaQuery.of(context).size.width * 0.9;
    double containerHeight1 = MediaQuery.of(context).size.height * 0.32;
    double containerHeight2 = MediaQuery.of(context).size.height * 0.25;
    double textFieldWidth = 200;
    double textFieldHeight = 38;
    FocusNode _focusNode = FocusNode();
    int? _selectedItemIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              labelFontSize: 12,
                              items: ['A', 'B', 'C', 'D'],
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 20,
                              labelText: 'First Name',
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller1,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 20,
                              labelText: 'Last Name',
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller2,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomDropdownTextField(
                              labelText: 'Speciality',
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
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
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller3,
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
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller4,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Secondary Phone No',
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller5,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Personal Phone No',
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller6,
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
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
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
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
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
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller7,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Work Email',
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller8,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Address',
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller9,
                              focusNode: FocusNode(),
                              labelFontSize: 12,
                            ),
                            CustomTextField(
                              width: textFieldWidth,
                              height: textFieldHeight,
                              cursorHeight: 22,
                              labelText: 'Date of Birth',
                              labelStyle: TextStyle(fontSize: 12,color: Color(0xff575757),fontWeight: FontWeight.w400),
                              controller: _controller10,
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
                    padding: EdgeInsets.symmetric(vertical: 15),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  title: 'Status',
                                  items: ['Active', 'Trainee', 'Inactive'],
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
                          Column(
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
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                  width: 125,
                  height: 33,
                  text: 'Add Employee',
                  style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 12,
                      fontWeight: FontWeight.w700
                  ),
                  borderRadius: 12,
                  onPressed: (){})
            ],
          ),
        )
      ],
    );
  }
}
