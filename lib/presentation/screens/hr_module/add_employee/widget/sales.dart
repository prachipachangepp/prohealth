import 'package:flutter/material.dart';
import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../manage/widgets/custom_icon_button_constant.dart';
import 'mcq_widget_add-employee.dart';

///prachi
class SalesTab extends StatelessWidget {
  final TextEditingController _sale1Controller = TextEditingController();
  final TextEditingController _workemailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _personalnoController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _worknoController = TextEditingController();
  final TextEditingController _dateofbirthController = TextEditingController();
  final TextEditingController _personalemailController = TextEditingController();
  int? _selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    double containerHeight1 = MediaQuery.of(context).size.height * 0.3;
    double containerHeight2 = MediaQuery.of(context).size.height * 0.2;
    double textFieldWidth = 200;
    double textFieldHeight = 38;
    FocusNode _focusNode = FocusNode();
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: (){},
                icon: Icon(Icons.file_upload_outlined,color: Colors.white,),
            label: Text(
             'Upload Photo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff1696C8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 10),
      /// first container
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 70),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///1st column
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDropdownTextField(
                          labelText: 'Designation',
                          labelStyle: TextStyle(color: Color(0xff686464),fontSize: 12),
                          labelFontSize: MediaQuery.of(context).size.width / 120,
                          items: ['A', 'B', 'C', 'D'],

                        ),
                        CustomTextField(
                          width: textFieldWidth,
                          height: textFieldHeight,
                          cursorHeight: 22,
                          labelText: 'Social Security Number',
                          labelStyle: TextStyle(color: Color(0xff575757),fontSize: 10),
                          suffixIcon: Icon(
                            Icons.remove_red_eye_sharp,
                            color: Color(0xff50B5E5),
                            size: MediaQuery.of(context).size.width / 99,
                          ),
                          controller: _sale1Controller,
                          focusNode: FocusNode(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
                        ),
                        CustomTextField(
                          width: textFieldWidth,
                          height: textFieldHeight,
                          cursorHeight: 22,
                          labelText: 'Work Email',
                          labelStyle: TextStyle(),
                          controller: _workemailController,
                          focusNode: FocusNode(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
                        ),
                      ],
                    ),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          width: textFieldWidth,
                          height: textFieldHeight,
                          cursorHeight: 22,
                          labelText: 'First Name',
                          labelStyle: TextStyle(),
                          controller: _addressController,
                          focusNode: FocusNode(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
                        ),
                        CustomTextField(
                          width: textFieldWidth,
                          height: textFieldHeight,
                          cursorHeight: 22,
                          labelText: 'Personal Phone Number',
                          labelStyle: TextStyle(),
                          controller: _firstnameController,
                          focusNode: FocusNode(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
                        ),
                        CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            labelText: 'Address',
                            labelStyle: TextStyle(),
                            controller: _personalnoController,
                            focusNode: FocusNode(),
                            labelFontSize:
                                MediaQuery.of(context).size.width / 120),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextField(
                          width: textFieldWidth,
                          height: textFieldHeight,
                          cursorHeight: 22,
                          labelText: 'Last Name',
                          labelStyle: TextStyle(),
                          controller: _dateofbirthController,
                          focusNode: FocusNode(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
                        ),
                        CustomDropdownTextField(
                          labelText: 'Reporting Office',
                          labelStyle: TextStyle(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
                          items: ['A', 'B', 'C', 'D'],
                        ),
                        CustomTextField(
                          width: textFieldWidth,
                          height: textFieldHeight,
                          cursorHeight: 22,
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(),
                          controller: _personalemailController,
                          focusNode: FocusNode(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdownTextField(
                          labelText: 'Reporting Office',
                          labelStyle: TextStyle(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
                          items: ['A', 'B', 'C', 'D'],
                        ),
                        CustomTextField(
                          width: textFieldWidth,
                          height: textFieldHeight,
                          cursorHeight: 22,
                          labelText: 'Personal email',
                          labelStyle: TextStyle(),
                          controller: _lastnameController,
                          focusNode: FocusNode(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
                        ),
                        CustomTextField(
                          width: textFieldWidth,
                          height: textFieldHeight,
                          cursorHeight: 22,
                          labelText: 'Emergency Contact Number',
                          labelStyle: TextStyle(),
                          controller: _worknoController,
                          focusNode: FocusNode(),
                          labelFontSize:
                              MediaQuery.of(context).size.width / 120,
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
      SizedBox(height: 10),

      /// second Container
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
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
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      ///button
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
    ]);
  }
}