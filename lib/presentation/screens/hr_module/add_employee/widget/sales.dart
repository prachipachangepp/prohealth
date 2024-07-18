import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../manage/widgets/custom_icon_button_constant.dart';
import 'mcq_widget_add-employee.dart';

///prachi
class SalesTab extends StatefulWidget {
  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> {
  final TextEditingController _sale1Controller = TextEditingController();
  final TextEditingController _workemailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _personalnoController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _worknoController = TextEditingController();
  final TextEditingController _dateofbirthController = TextEditingController();
  final TextEditingController _personalemailController =
      TextEditingController();

  int? _selectedItemIndex;

  String? _fileName;

  @override
  Widget build(BuildContext context) {
    double containerHeight1 = MediaQuery.of(context).size.height * 0.32;
    // double containerHeight2 = 100;
    // MediaQuery.of(context).size.height * 0.2;
    double textFieldWidth = 200;
    double textFieldHeight = 38;
    FocusNode _focusNode = FocusNode();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child:
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     ElevatedButton.icon(
            //       onPressed: () async {
            //         FilePickerResult? result = await FilePicker.platform.pickFiles(
            //           type: FileType.image,
            //           allowMultiple: false,
            //         );
            //
            //         if (result != null) {
            //           PlatformFile file = result.files.first;
            //           print('File path: ${file.path}');
            //         } else {
            //
            //         }
            //       },
            //       icon: Icon(
            //         Icons.file_upload_outlined,
            //         color: Colors.white,
            //       ),
            //       label: Text(
            //         'Upload Photo',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //           fontFamily: 'FiraSans',
            //           fontSize: 12,
            //           fontWeight: FontWeight.w700,
            //           color: Colors.white,
            //         ),
            //       ),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Color(0xff1696C8),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //       ),
            //     )
            //   ],
            // ),


            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_fileName != null)
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      _fileName!,
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      allowMultiple: false,
                    );

                    if (result != null) {
                      PlatformFile file = result.files.first;
                      setState(() {
                        _fileName = file.name;
                      });
                      print('File path: ${file.path}');
                    }
                  },
                  icon: Icon(
                    Icons.file_upload_outlined,
                    color: Colors.white,
                  ),
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
                ),
              ],
            ),
          ),

          /// first container
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height / 70,
                      vertical: 20
                  ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomDropdownTextField(
                                  labelText: 'Position',
                                  labelStyle: TextStyle(),
                                  labelFontSize:
                                      MediaQuery.of(context).size.width / 99,
                                  items: ['A', 'B', 'C', 'D'],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  width: textFieldWidth,
                                  height: textFieldHeight,
                                  cursorHeight: 22,
                                  labelText: 'First Name',
                                  labelStyle: TextStyle(),
                                  controller: _addressController,
                                  focusNode: FocusNode(),
                                  labelFontSize:
                                      MediaQuery.of(context).size.width / 99,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  width: textFieldWidth,
                                  height: textFieldHeight,
                                  cursorHeight: 22,
                                  labelText: 'Last Name',
                                  labelStyle: TextStyle(),
                                  controller: _dateofbirthController,
                                  focusNode: FocusNode(),
                                  labelFontSize:
                                      MediaQuery.of(context).size.width / 99,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomDropdownTextField(
                                  labelText: 'Home Office',
                                  labelStyle: TextStyle(),
                                  labelFontSize:
                                      MediaQuery.of(context).size.width / 99,
                                  items: ['A', 'B', 'C', 'D'],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  width: textFieldWidth,
                                  height: textFieldHeight,
                                  cursorHeight: 22,
                                  labelText: 'Social Security Number',
                                  labelStyle: TextStyle(),
                                  suffixIcon: Icon(
                                    Icons.remove_red_eye_sharp,
                                    color: Color(0xff50B5E5),
                                    size:
                                        MediaQuery.of(context).size.width / 99,
                                  ),
                                  controller: _sale1Controller,
                                  focusNode: FocusNode(),
                                  labelFontSize:
                                      MediaQuery.of(context).size.width / 99,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  width: textFieldWidth,
                                  height: textFieldHeight,
                                  cursorHeight: 22,
                                  labelText: 'Personal Phone Number',
                                  labelStyle: TextStyle(),
                                  controller: _firstnameController,
                                  focusNode: FocusNode(),
                                  labelFontSize:
                                      MediaQuery.of(context).size.width / 99,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomDropdownTextField(
                                  labelText: 'Work Phone No.',
                                  labelStyle: TextStyle(),
                                  labelFontSize:
                                      MediaQuery.of(context).size.width / 99,
                                  items: ['A', 'B', 'C', 'D'],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  width: textFieldWidth,
                                  height: textFieldHeight,
                                  cursorHeight: 22,
                                  labelText: 'Personal Email',
                                  labelStyle: TextStyle(),
                                  controller: _lastnameController,
                                  focusNode: FocusNode(),
                                  labelFontSize:
                                      MediaQuery.of(context).size.width / 99,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomTextField(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 22,
                                labelText: 'Work Email',
                                labelStyle: TextStyle(),
                                controller: _workemailController,
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
                                  controller: _personalnoController,
                                  focusNode: FocusNode(),
                                  labelFontSize:
                                      MediaQuery.of(context).size.width / 99),
                              CustomTextField(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 22,
                                labelText: 'Date of Birth',
                                labelStyle: TextStyle(),
                                controller: _personalemailController,
                                focusNode: FocusNode(),
                                labelFontSize:
                                    MediaQuery.of(context).size.width / 99,
                              ),
                              CustomTextField(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 22,
                                labelText: 'Emergency Contact No.',
                                labelStyle: TextStyle(),
                                controller: _worknoController,
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
          SizedBox(height: 10),
          /// second Container
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      height: 100,
                      // containerHeight2,
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
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: McqWidget(
                              title: 'Status',
                              items: ['Active', 'Trainee', 'Inactive'],
                              onChanged: (int) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                    width: 125,
                    height: 33,
                    text: 'Add Employee',
                    style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                    borderRadius: 12,
                    onPressed: () {})
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
