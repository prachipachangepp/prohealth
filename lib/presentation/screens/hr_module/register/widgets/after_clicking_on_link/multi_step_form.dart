///////////////////////

import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/widgets/container_constant.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../add_employee/widget/mcq_widget_add-employee.dart';
import '../../../manage/widgets/bottom_row.dart';
import '../../../manage/widgets/top_row.dart';
import '../../taxtfield_constant.dart';
import '../dropdown_const.dart';
import 'constant_in_all.dart';

class MultiStepForm extends StatefulWidget {
  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  double textFieldWidth = 430;
  double textFieldHeight = 38;

  TextEditingController firstName = TextEditingController();
  /////
  TextEditingController _controller = TextEditingController();

  // Current step in the stepper
  int _currentStep = 0;

  bool isChecked = false;
  bool get isFirstStep => _currentStep == 0;
  bool get isLastStep => _currentStep == steps().length - 1;
  bool isCompleted = false;
  String? _selectedCountry;

  String? _selectedType;
  String? _selectedType1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Details",
                  style: GoogleFonts.firaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.blueprime,
                    decoration: TextDecoration.none,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: AppSize.s5,
            ),
            Expanded(
              child: Container(
                // height: MediaQuery.of(context).size.height / 4,
                // width: MediaQuery.of(context).size.width / 1.1,
                // color: Colors.yellow,
                child: Flexible(
                  child: Stepper(
                      type: StepperType.horizontal,
                      steps: steps(),
                      currentStep: _currentStep,
                      onStepContinue: () {
                        if (isLastStep) {
                          setState(() => isCompleted = true);
                        } else {
                          setState(() => _currentStep += 1);
                        }
                      },
                      onStepCancel: isFirstStep
                          ? null
                          : () => setState(() => _currentStep -= 1),
                      controlsBuilder: (context, details) => Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1696C8),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: details.onStepContinue,
                                  label:
                                      Text(isLastStep ? 'Conform' : 'Continue'),
                                  icon: const Icon(Icons.arrow_forward),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                if (!isFirstStep) ...[
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xff1696C8),
                                      side: const BorderSide(
                                          color: Color(0xff1696C8)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: details.onStepCancel,
                                    label: const Text("Back"),
                                    icon: const Icon(Icons.arrow_back),
                                  )
                                ]
                              ],
                            ),
                          )),
                ),
              ),
            ),
            const Row(
              children: [BottomBarRow()],
            )
          ],
        ),
      ),
    );
  }

  List<Step> steps() => [
        Step(
            state: _currentStep <= 0 ? StepState.editing : StepState.complete,
            isActive: _currentStep >= 0,
            title: Text(
              'General',
              style: GoogleFonts.firaSans(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorManager.grey,
                decoration: TextDecoration.none,
              ),
            ),
            content: Container(
              //color: Colors.grey,
              // height: MediaQuery.of(context).size.height / 1,
              // width: 100,
              child: Column(
                children: [
                  Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "General",
                        style: GoogleFonts.firaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.blueprime,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s5,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F7FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Please fill all your personal information below. Your personal details will be required to proceed through the recruitment process.',
                        style: GoogleFonts.firaSans(
                          color: const Color(0xFF686464),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: AppSize.s13,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 140, right: 140, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: AppSize.s5,
                              ),
                              Text(
                                "Upload Photo",
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1696C8),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                  );
                                  if (result != null) {
                                    PlatformFile file = result.files.first;
                                    print('File picked: ${file.name}');
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                label: const Text("Choose File"),
                                icon: const Icon(Icons.file_upload_outlined),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30),
                              Text(
                                'Legal First Name',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30),
                              Text(
                                'Legal Last Name',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30),
                              Text(
                                'Social Security Number',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30),
                              Text(
                                'Personal Mobile Number',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30),
                              Text(
                                'Personal Email',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30),
                              Text(
                                'Driver’s License Number',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                height: 32,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gender",
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              Container(
                                width: 400,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: CustomRadioListTile(
                                      title: 'Male',
                                      value: 'male',
                                      groupValue: _selectedType,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedType = value;
                                        });
                                      },
                                    )),
                                    Expanded(
                                        child: CustomRadioListTile(
                                      title: 'Female',
                                      value: 'Female',
                                      groupValue: _selectedType,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedType = value;
                                        });
                                      },
                                    )),
                                    Expanded(
                                        child: CustomRadioListTile(
                                      title: 'Other',
                                      value: 'Other',
                                      groupValue: _selectedType,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedType = value;
                                        });
                                      },
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30),
                              Text(
                                'DOB',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                controller: _controller,
                                hintText: 'dd-mm-yyyy',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: Color(0xff50B5E5),
                                    size: 16,
                                  ),
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      _controller.text =
                                          "${pickedDate.toLocal()}"
                                              .split(' ')[0];
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 30),
                              Text(
                                'Address',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),

                              Text(
                                "Race",
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),

                              Container(
                                //width: 550,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CustomRadioListTile(
                                        title: 'Asian',
                                        value: 'Asian',
                                        groupValue: _selectedType,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedType = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomRadioListTile(
                                        title: 'White',
                                        value: 'White',
                                        groupValue: _selectedType,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedType = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomRadioListTile(
                                        title: 'Hispanic or Latino',
                                        value: 'Hispanic or Latino',
                                        groupValue: _selectedType,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedType = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomRadioListTile(
                                      title: 'Black or African American',
                                      value: 'Black or African American',
                                      groupValue: _selectedType,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedType = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomRadioListTile(
                                      title: 'Other',
                                      value: 'Other',
                                      groupValue: _selectedType,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedType = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              // Container(
                              //   color: Colors.redAccent,
                              //   height: 100,
                              //   width: MediaQuery.of(context).size.width / 4,
                              //   child: Row(
                              //     children: [
                              //       Flexible(
                              //         flex: 2,
                              //         child: McqWidget(
                              //           title: 'Race',
                              //           items: const [
                              //             'Asian',
                              //             'Black or African American',
                              //             'White',
                              //             'Hispanic or Latino',
                              //             'Other'
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              // Container(
                              //   color: Colors.redAccent,
                              //   height: 100,
                              //   width: MediaQuery.of(context).size.width / 4,
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.stretch,
                              //     children: [
                              //       Expanded(
                              //         flex: 2,
                              //         child: McqWidget(
                              //           title: 'Race',
                              //           items: const [
                              //             'Asian',
                              //             'Black or African American',
                              //             'White',
                              //             'Hispanic or Latino',
                              //             'Other'
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              // Container(
                              //   color: Colors.redAccent,
                              //   height: 100,
                              //   width:  MediaQuery.of(context).size.width/4,
                              //   child: Expanded(
                              //     flex: 2,
                              //     child: McqWidget(
                              //       title: 'Race',
                              //       items: const [
                              //         'Asian',
                              //         'Black or African American',
                              //         'White',
                              //         'Hispanic or Latino',
                              //       'Other'
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: AppSize.s10,
                              ),
                              Text(
                                'Type of Clinician',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              const SizedBox(
                                height: AppSize.s5,
                              ),

                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                height: textFieldHeight,
                                //alignment: Alignment.center,
                                //color: Colors.cyan,

                                child: MyDropdownTextField(
                                  hint: 'Select',

                                  //width: MediaQuery.of(context).size.width/7,
                                  // height: AppSize.s25,
                                  items: [
                                    'Item 1',
                                    'Item 2',
                                    'Item 3',
                                    'Item 4'
                                  ],
                                  onChanged: (String? newValue) {
                                    print('Selected item: $newValue');
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: AppSize.s10,
                              ),
                              Text(
                                'Speciality',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              const SizedBox(
                                height: AppSize.s5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                height: textFieldHeight,
                                //alignment: Alignment.center,
                                //color: Colors.cyan,

                                child: MyDropdownTextField(
                                  hint: 'select',

                                  //width: MediaQuery.of(context).size.width/7,
                                  // height: AppSize.s25,
                                  items: [
                                    'Item 1',
                                    'Item 2',
                                    'Item 3',
                                    'Item 4'
                                  ],
                                  onChanged: (String? newValue) {
                                    print('Selected item: $newValue');
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        /////////////////////////////////////////////////////////////////////////////////////////////
        Step(
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 1,
          title: Text(
            'Employment',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Employment',
                    style: GoogleFonts.firaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff50B5E5)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 60),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F7FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Your personal details will be required to proceed through the recruitment process.',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFF686464),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Padding(
                  padding: const EdgeInsets.only(left: 166.0, right: 166),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Upload your resume as a docx or pdf with a maximum size of 2 mb',
                              style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff686464),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 20),
                          ElevatedButton.icon(
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                              );
                              if (result != null) {
                                PlatformFile file = result.files.first;
                                print('File picked: ${file.name}');
                              } else {
                                // User canceled the picker
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff50B5E5),
                              // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            icon: Icon(Icons.file_upload_outlined,
                                color: Colors.white),
                            label: Text(
                              'Upload Document',
                              style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Column(
                        children: [
                          Text(
                            'Employment #1',
                            style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff686464)),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  'Final Position Title',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        40),
                                Text(
                                  'Start Date',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  controller: _controller,
                                  hintText: 'dd-mm-yyyy',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Color(0xff50B5E5),
                                      size: 16,
                                    ),
                                    onPressed: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        _controller.text =
                                            "${pickedDate.toLocal()}"
                                                .split(' ')[0];
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        40),
                                Text(
                                  'End Date',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  controller: _controller,
                                  hintText: 'dd-mm-yyyy',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Color(0xff50B5E5),
                                      size: 16,
                                    ),
                                    onPressed: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        _controller.text =
                                            "${pickedDate.toLocal()}"
                                                .split(' ')[0];
                                      }
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: Color(0xff50B5E5),
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Currently work here',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff686464)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        40),
                                Text(
                                  'Employer',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 20),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 40),
                              Text(
                                'Reason for Leaving',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 40),
                              Text(
                                'Last Supervisor’s Name',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 40),
                              Text(
                                'Supervisor’s Mobile Number',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 40),
                              Text(
                                'City',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                            ],
                          )),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle add education action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff50B5E5),
                              // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            icon: Icon(Icons.add, color: Colors.white),
                            label: Text(
                              'Add Experience ',
                              style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Step(
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 2,
          title: Text(
            'Education',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Education',
                    style: GoogleFonts.firaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff50B5E5)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 60),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F7FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Your personal details will be required to proceed through the recruitment process.',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFF686464),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Padding(
                  padding: const EdgeInsets.only(left: 166.0, right: 166),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Education # 1',
                        style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'College/University',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  'Graduate',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomRadioListTile(
                                      title: 'Yes',
                                      value: 'Yes',
                                      groupValue: _selectedType,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedType = value;
                                        });
                                      },
                                    )),
                                    Expanded(
                                      child: CustomRadioListTile(
                                        title: 'No',
                                        value: 'No',
                                        groupValue: _selectedType,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedType = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  'Degree',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  'Major Subject',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone ',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  'City',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  'State',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Upload your degree / certifications as a docx or pdf',
                              style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff686464),
                              ),
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 20),
                          ElevatedButton.icon(
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                              );
                              if (result != null) {
                                PlatformFile file = result.files.first;
                                print('File picked: ${file.name}');
                              } else {
                                // User canceled the picker
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff50B5E5),
                              // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            icon: Icon(Icons.file_upload_outlined,
                                color: Colors.white),
                            label: Text(
                              'Upload Document',
                              style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle add education action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff50B5E5),
                              // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            icon: Icon(Icons.add, color: Colors.white),
                            label: Text(
                              'Add Education',
                              style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Step(
      state: _currentStep <= 3 ? StepState.editing : StepState.complete,
      isActive: _currentStep == 3,
      title: Text(
        'References',
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorManager.grey,
          decoration: TextDecoration.none,
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                child: Text(AppString.references,
                  style: GoogleFonts.firaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff50B5E5)),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Container(
                width: 952,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFE6F7FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please provide the names and contact information of three professional references who can speak to your work experience and qualifications. For each\n reference, Kindly include the following information:',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF686464),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 166.0, right: 166),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'References # 1',
                        style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppString.name,
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        40),
                                Text(
                                  AppString.title_position,
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  AppString.company_organization,
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  AppString.mobile_number,
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width:
                              MediaQuery.of(context).size.width / 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppString.email,
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60),
                                Text(
                                  AppString.how_do_you_know_this_person,
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60),
                                Text(
                                  AppString.length_of_association,
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Text(
                        'Please ensure that the references you provide are professional contacts who can provide insight into \n your skills, work ethic, and character ',
                        style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle add education action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff50B5E5),
                              // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8.0),
                              ),
                            ),
                            icon: Icon(Icons.add, color: Colors.white),
                            label: Text(AppString.add_education,
                              style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Step(
          state: _currentStep <= 4 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 4,
          title: Text(
            'Licenses',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Licenses',
                      style: GoogleFonts.firaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff50B5E5)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  Container(
                    width: 952,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFE6F7FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFF686464),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Please fill all the current and relevant licensure / certification below. If you are applying for a clinical or attorney position which is lists licensure in the requirements, your information will be required to proceed through the requirements process.',
                                style: GoogleFonts.firaSans(
                                  color: Color(0xFF686464),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 100),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFF686464),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Please note, MSW and Chaplains do not need a License. Rather , they need academic credentials.',
                                style: GoogleFonts.firaSans(
                                  color: Color(0xFF686464),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 100),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFF686464),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Clinical Staff MUST fill this section out. ',
                                style: GoogleFonts.firaSans(
                                  color: Color(0xFF686464),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 166.0, right: 166),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Licensure / Certification #1',
                            style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Licensure / Certification',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff686464)),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                60),
                                    CustomTextFieldRegister(
                                      hintText: 'Enter Text',
                                      hintStyle: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9B9B9B),
                                      ),
                                      height: 32,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                40),
                                    Text(
                                      'Issuing Organization',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff686464)),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                60),
                                    CustomTextFieldRegister(
                                      hintText: 'Enter Text',
                                      hintStyle: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9B9B9B),
                                      ),
                                      height: 32,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                30),
                                    Text(
                                      'Country',
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff686464),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                60),
                                    Container(
                                      height: 32,
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          hintText: 'Select Country',
                                          hintStyle: GoogleFonts.firaSans(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff9B9B9B),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                        ),
                                        value: _selectedCountry,
                                        icon: Icon(Icons.arrow_drop_down,
                                            color: Color(0xff9B9B9B)),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff686464),
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            _selectedCountry = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Country1',
                                          'Country2',
                                          'Country3',
                                          'Country4'
                                        ] // List of countries
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                30),
                                    Text(
                                      'Number / ID',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff686464)),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                60),
                                    CustomTextFieldRegister(
                                      hintText: 'Enter Text',
                                      hintStyle: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9B9B9B),
                                      ),
                                      height: 32,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Issue Date',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff686464)),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                100),
                                    CustomTextFieldRegister(
                                      controller: _controller,
                                      hintText: 'dd-mm-yyyy',
                                      hintStyle: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9B9B9B),
                                      ),
                                      height: 32,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: Color(0xff50B5E5),
                                          size: 16,
                                        ),
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          if (pickedDate != null) {
                                            _controller.text =
                                                "${pickedDate.toLocal()}"
                                                    .split(' ')[0];
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                200),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'If the licensure / certification will be recieved in future, enter the expected issuing date',
                                            style: GoogleFonts.firaSans(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff686464)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                100),
                                    Text(
                                      'Issue Date',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff686464)),
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                100),
                                    CustomTextFieldRegister(
                                      controller: _controller,
                                      hintText: 'dd-mm-yyyy',
                                      hintStyle: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9B9B9B),
                                      ),
                                      height: 32,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: Color(0xff50B5E5),
                                          size: 16,
                                        ),
                                        onPressed: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                          );
                                          if (pickedDate != null) {
                                            _controller.text =
                                                "${pickedDate.toLocal()}"
                                                    .split(' ')[0];
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 20),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Upload your degree / certifications as a docx or pdf',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464)),
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 5),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                  );
                                  if (result != null) {
                                    PlatformFile file = result.files.first;
                                    print('File picked: ${file.name}');
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff50B5E5),
                                  // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                icon: const Icon(Icons.file_upload_outlined,
                                    color: Colors.white),
                                label: Text(
                                  'Upload Document',
                                  style: GoogleFonts.firaSans(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Handle add education action
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff50B5E5),
                                  // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                icon: Icon(Icons.add, color: Colors.white),
                                label: Text(
                                  'Add Licensure / Certification',
                                  style: GoogleFonts.firaSans(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Step(
        //   state: _currentStep <= 4 ? StepState.editing : StepState.complete,
        //   isActive: _currentStep >= 4,
        //   title: Text(
        //     'Licenses',
        //     style: GoogleFonts.firaSans(
        //       fontSize: 12,
        //       fontWeight: FontWeight.w400,
        //       color: ColorManager.grey,
        //       decoration: TextDecoration.none,
        //     ),
        //   ),
        //   content: Container(
        //     height: 100,
        //     color: Colors.orange,
        //   ),
        // ),
        ///////////////////////////////////////////////////////////////////////////
        Step(
          state: _currentStep <= 5 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 5,
          title: Text(
            'Banking',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Banking',
                    style: GoogleFonts.firaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff50B5E5)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 60),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F7FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Your personal details will be required to proceed through the recruitment process.',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFF686464),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Padding(
                  padding: const EdgeInsets.only(left: 166.0, right: 166),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bank Details #1',
                        style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Type',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomRadioListTile(
                                      title: 'Checking',
                                      value: 'Checking',
                                      groupValue: _selectedType,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedType = value;
                                        });
                                      },
                                    )),
                                    Expanded(
                                      child: CustomRadioListTile(
                                        title: 'Savings',
                                        value: 'Savings',
                                        groupValue: _selectedType,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedType = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        40),
                                Text(
                                  'Effective Date',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  controller: _controller,
                                  hintText: 'dd-mm-yyyy',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Color(0xff50B5E5),
                                      size: 16,
                                    ),
                                    onPressed: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null) {
                                        _controller.text =
                                            "${pickedDate.toLocal()}"
                                                .split(' ')[0];
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  'Bank Name',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  'Routing/Transit Number ( 9 Digits )',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account Number ',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        30),
                                Text(
                                  'Verify Account Number',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        60),
                                CustomTextFieldRegister(
                                  hintText: 'Enter Text',
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        25),
                                Text(
                                  'Requested amount for this account (select one)',
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff686464)),
                                ),
                                CustomRadioListTile(
                                  title: 'Specific Amount',
                                  value: 'Specific Amount',
                                  groupValue: _selectedType1,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedType1 = value;
                                    });
                                  },
                                ),
                                CustomTextFieldRegister(
                                  prefixText: '\$',
                                  prefixStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B9B9B),
                                  ),
                                  height: 32,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Upload your Void Check',
                                style: GoogleFonts.firaSans(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff686464)),
                              ),
                            ],
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 5),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                  );
                                  if (result != null) {
                                    PlatformFile file = result.files.first;
                                    print('File picked: ${file.name}');
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff50B5E5),
                                  // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                icon: Icon(Icons.file_upload_outlined,
                                    color: Colors.white),
                                label: Text(
                                  'Upload Document',
                                  style: GoogleFonts.firaSans(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Handle add education action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff50B5E5),
                              // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            icon: Icon(Icons.add, color: Colors.white),
                            label: Text(
                              'Add Education',
                              style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

    Step(
      state: _currentStep <= 6 ? StepState.editing : StepState.complete,
      isActive: _currentStep == 6,
      title:  Text('Health \nRecords',style: GoogleFonts.firaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ColorManager.grey,
        decoration: TextDecoration.none,
      ),),
      content: Container(
        height: 1500,
        width: 1200,
        child: Column(
          children: [
            Center(
              child: Text(
                'Health Records',
                style: GoogleFonts.firaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff50B5E5)
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/60),
            Container(
              width: 952,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFE6F7FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF686464),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Instructions: This section is designed to capture and document your health and immunization records as part of your onboarding process. Please enter the required information accurately.',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF686464),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/100),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• ',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF686464),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Please ensure that all uploaded immunization records are clear and legible. Accepted file formats for iuploads include PDF, JPG or PNG. In case of declination, please upload a signed copy of the declination form.',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF686464),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height/20),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return PhysicalExamContainer();
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return VaccineContainer();
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return PhysicalExamContainer();
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return VaccineContainer();
                },
              ),
            ),

          ],
        ),
      ),
    ),
    ////////////////////////////////////
        Step(
          state: _currentStep <= 7 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 7,
          title: Text(
            'Acknowledgements',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 166, right: 166),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Acknowledgements',
                        style: GoogleFonts.firaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff50B5E5)),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    Container(
                      height: 50,
                      width: 940,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6F7FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Please sign the list of documents required for the recruitment process',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF686464),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Row(
                      children: [
                        Text(
                          'List Of Documents',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Canditate Release Form (Background Check)',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 24.0,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'On - call',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // fill info action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Sign',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Confidentiality Statement HIPAA',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // fill info action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Sign',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Policy Concerning 3 RD Party',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // fill info action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Sign',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Standards Of Conduct',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // fill info action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Sign',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'California Sexual Harassment Training',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // fill info action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Sign',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prop65',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // fill info action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Sign',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Return Of Company Policy',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 24.0,
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Step(
        //   state: _currentStep <= 7 ? StepState.editing : StepState.complete,
        //   isActive: _currentStep == 7,
        //   title: Text(
        //     'Acknowledgements',
        //     style: GoogleFonts.firaSans(
        //       fontSize: 12,
        //       fontWeight: FontWeight.w400,
        //       color: ColorManager.grey,
        //       decoration: TextDecoration.none,
        //     ),
        //   ),
        //   content: Container(
        //     height: 100,
        //     color: Colors.brown,
        //   ),
        // ),

        Step(
          state: _currentStep <= 8 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 8,
          title: Text(
            'Legal \nDocuments',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 166, right: 166),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Legal Documents',
                        style: GoogleFonts.firaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff50B5E5)),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    Container(
                      //color: Colors.redAccent,
                      height: 50,
                      width: 940,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6F7FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Please add information about your legal documents',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF686464),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Upload one of your government ids ( e.g. drivers license )',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff686464),
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 10),
                        ElevatedButton.icon(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                            );
                            if (result != null) {
                              PlatformFile file = result.files.first;
                              print('File picked: ${file.name}');
                            } else {
                              // User canceled the picker
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          icon: Icon(Icons.file_upload_outlined,
                              color: Colors.white),
                          label: Text(
                            'Upload Document',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Row(
                      children: [
                        Text(
                          'List Of Documents',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'i - 9 Paper Version',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // fill info action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Fill Info',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'W4 2023',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // fill info action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Fill Info',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 100),
                    Divider(
                      height: 1,
                      color: Color(0xFFD1D1D1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Step(
        //   state: _currentStep <= 8 ? StepState.editing : StepState.complete,
        //   isActive: _currentStep == 8,
        //   title: Text(
        //     'Legal \nDocuments',
        //     style: GoogleFonts.firaSans(
        //       fontSize: 12,
        //       fontWeight: FontWeight.w400,
        //       color: ColorManager.grey,
        //       decoration: TextDecoration.none,
        //     ),
        //   ),
        //   content: Container(
        //     height: 100,
        //     color: Colors.green,
        //   ),
        // ),
      ];
}

//
//
// Form(
// key: _formKey,
// child: Stepper(
// type: StepperType.horizontal,
// currentStep: _currentStep,
// onStepContinue: () {
// if(_currentStep== 8){
// setState(() => isCompleted =true);
// }else{
//
// }
//
// setState(() {
// if (_currentStep < 8) {
// _currentStep += 1;
// } else {
// // Validate the form fields before proceeding
// if (_formKey.currentState!.validate()) {
// // All validations pass
// // Submit your form or save data here
// // For demonstration, let's just show a snackbar
// ScaffoldMessenger.of(context).showSnackBar(
// const SnackBar(
// content: Text('Form Submitted!'),
// ),
// );
// }
// }
// });
// },
// onStepCancel: () {
// setState(() {
// if (_currentStep > 0) {
// _currentStep -= 1;
// } else {
// _currentStep = 0;
// }
// });
// },
// steps: [
// Step(
// state:
// _currentStep <= 0 ? StepState.editing : StepState.complete,
//
// // isActive: true,
// title: const Text('General'),
// content: Container(
// height: 700,
// width: 100,
// child: Column(
// children: [
// Center(
// child: Align(
// alignment: Alignment.topCenter,
// child: Text("Details"),
// ),
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
// padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// decoration: BoxDecoration(
// color: Color(0xFFE6F7FF),
// borderRadius: BorderRadius.circular(12),
// ),
// child: Text(
// 'Please fill all your personal information below. Your personal details will be required to proceed through the recruitment process.',
// style: GoogleFonts.firaSans(
// color: Color(0xFF686464),
// fontSize: 12,
// fontWeight: FontWeight.w500,
// ),
// ),
// ),
//
// ]
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text("Upload Photo")
// ],
// ),
// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Text("Gender")
// ],
// ),
// ],
// )
// ],
// ),
// color: Colors.black26)),
// Step(
// state: _currentStep <= 1 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 1,
// title: const Text('Employment'),
// content: TextFormField(
// //controller: _employmentController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Employment details';
// }
// return null;
// }),
// ),
//
// // Add more steps for other form fields as needed
// // Example:
// Step(
// state: _currentStep <= 2 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 2,
// title: const Text('Education'),
// content: TextFormField(
// // controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter education details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 3 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 3,
// title: const Text('References'),
// content: TextFormField(
// //controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter References details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 4 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 4,
// title: const Text('Licenses'),
// content: TextFormField(
// //controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Licenses details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 5 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 5,
// title: const Text('Banking'),
// content: TextFormField(
// //controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Banking details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 6 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 6,
// title: const Text('Health Records'),
// content: TextFormField(
// //controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Health Records details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 7 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 7,
// title: const Text('Acknowledgements'),
// content: TextFormField(
// // controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Acknowledgements details';
// }
// return null;
// },
// ),
// ),
// Step(
// state: _currentStep <= 8 ? StepState.editing : StepState.complete,
// isActive: _currentStep == 8,
// title: const Text('Legal Documents'),
// content: TextFormField(
// // controller: _educationController,
// validator: (value) {
// if (value!.isEmpty) {
// return 'Please enter Legal Documents details';
// }
// return null;
// },
// ),
// ),
// ],
//
// ),
// ),

// ////rohit

//
// import 'package:flutter/material.dart';
//
// class ProgressBar extends StatelessWidget {
//   final List<String> steps = [
//     "General",
//     "Employment",
//     "Education",
//     "References",
//     "Licenses",
//     "Banking",
//     "Health Records",
//     "Acknowledgements",
//     "Legal Documents"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Details',
//             style: TextStyle(fontSize: 20, color: Colors.blue),
//           ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(steps.length, (index) {
//               return Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 12,
//                     backgroundColor: index == 0 ? Colors.blue : Colors.grey,
//                     child: CircleAvatar(
//                       radius: 10,
//                       backgroundColor: Colors.white,
//                       child: CircleAvatar(
//                         radius: 6,
//                         backgroundColor: index == 0 ? Colors.blue : Colors.grey,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     steps[index],
//                     style: TextStyle(
//                       color: index == 0 ? Colors.blue : Colors.grey,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               );
//
//             }),
//           ),
//
//           Expanded(
//             child: Container(
//               color: Colors.indigoAccent,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//import 'package:flutter/material.dart';

///////////////////////////////////
//
// class StepProgressBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               buildStep(context, isActive: true),
//               buildConnector(context),
//               buildStep(context, isActive: false),
//               buildConnector(context),
//               buildStep(context, isActive: false),
//               buildConnector(context),
//               buildStep(context, isActive: false),
//               buildConnector(context),
//               buildStep(context, isActive: false),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text('Step 1'),
//               SizedBox(width: 50),
//               Text('Step 2'),
//               SizedBox(width: 50),
//               Text('Step 3'),
//               SizedBox(width: 50),
//               Text('Step 4'),
//               SizedBox(width: 50),
//               Text('Step 5'),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget buildStep(BuildContext context, {bool isActive = false}) {
//     return CircleAvatar(
//       radius: 15,
//       backgroundColor: isActive ? Colors.blue : Colors.grey,
//       child: isActive ? Icon(Icons.check, color: Colors.white, size: 20) : null,
//     );
//   }
//
//   Widget buildConnector(BuildContext context) {
//     return Expanded(
//       child: Container(
//         height: 5,
//         color: Colors.grey,
//       ),
//     );
//   }
// }

// //////new///////
//
// import 'package:flutter/material.dart';
//
// class ProgressBar extends StatefulWidget {
//   @override
//   _ProgressBarState createState() => _ProgressBarState();
// }
//
// class _ProgressBarState extends State<ProgressBar> {
//   int _currentStep = 0;
//
//   final List<String> steps = [
//     "General",
//     "Employment",
//     "Education",
//     "References",
//     "Licenses",
//     "Banking",
//     "Health Records",
//     "Acknowledgements",
//     "Legal Documents"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Details',
//             style: TextStyle(fontSize: 20, color: Colors.blue),
//           ),
//           SizedBox(height: 10),
//           SizedBox(
//             height: 100,
//             //width: I,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(steps.length, (index) {
//                 bool isActive = index <= _currentStep;
//                 bool isLast = index == steps.length - 1;
//
//                 return Column(
//                   children: [
//                     Container(
//                       width: 24,
//                       height: 24,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: isActive ? Colors.blue : Colors.grey,
//                       ),
//                       child: Center(
//                         child: Text(
//                           (index + 1).toString(),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       steps[index],
//                       style: TextStyle(
//                         color: isActive ? Colors.blue : Colors.grey,
//                         fontSize: 12,
//                       ),
//                     ),
//                     if (!isLast)
//                       Expanded(
//                         child: Container(
//                           height: 2,
//                           color: isActive ? Colors.blue : Colors.grey,
//                         ),
//                       ),
//                   ],
//                 );
//               }),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               //height: ,
//               color: Colors.indigoAccent, // Replace with your main content
//               child:
//                 // PageView(
//                 //   children: [
//                 //     PageView.custom(childrenDelegate:)
//                 //   ],
//
//                 //)
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       if (_currentStep < steps.length - 1) {
//                         _currentStep++;
//                       }
//                     });
//                   },
//                   child: Text(_currentStep == steps.length - 1 ? 'Finish' : 'Next'),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

/////////////

/////dummy////
//
// import 'package:flutter/material.dart';
//
// import '../../../../../../app/resources/const_string.dart';
//
// class MyStepperForm extends StatefulWidget {
//   @override
//   _MyStepperFormState createState() => _MyStepperFormState();
// }
//
// class _MyStepperFormState extends State<MyStepperForm> {
//   int _currentStep = 0;
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//
//   final List<Step> _steps = [
//     Step(
//       title: Center(child: Text('Name')),
//       content: TextFormField(
//
//         decoration: InputDecoration(labelText: 'Enter your name'),
//       ),
//       isActive: true,
//     ),
//     Step(
//       title: Text('Email'),
//       content: TextFormField(
//         decoration: InputDecoration(labelText: 'Enter your email'),
//       ),
//       isActive: true,
//     ),
//     Step(
//       title: Column(
//         children: [
//           Text('Password'),
//         ],
//       ),
//       content: TextFormField(
//
//         decoration: InputDecoration(labelText: 'Enter your password'),
//         obscureText: true,
//         onChanged: (value) {},
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return AppString.enterText;
//           }
//           return null;
//         },
//       ),
//       isActive: true,
//     ),
//   ];
//
//   void _submitForm() {
//     // Handle form submission here
//     String name = _nameController.text;
//     String email = _emailController.text;
//     String password = _passwordController.text;
//
//     // Process the data
//     print('Name: $name, Email: $email, Password: $password');
//
//     // Navigate to next screen or perform further actions
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Horizontal Stepper Form'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Stepper(
//               steps: _steps,
//               currentStep: _currentStep,
//               type: StepperType.horizontal, // Set horizontal type
//               onStepContinue: () {
//                 setState(() {
//                   if (_currentStep < _steps.length - 1) {
//                     _currentStep++;
//                   } else {
//                     _submitForm();
//                     // You can navigate to another screen here
//                   }
//                 });
//               },
//               onStepCancel: () {
//                 setState(() {
//                   if (_currentStep > 0) {
//                     _currentStep--;
//                   } else {
//                     _currentStep = 0;
//                   }
//                 });
//               },
//               onStepTapped: (step) {
//                 setState(() {
//                   _currentStep = step;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
