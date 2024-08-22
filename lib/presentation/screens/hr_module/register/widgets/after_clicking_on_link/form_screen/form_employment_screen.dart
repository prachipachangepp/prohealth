import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_employment_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/employeement_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_employment_data.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../taxtfield_constant.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_employment_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/progress_form_data/form_employment_data.dart';
import 'dart:convert';

import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Employment_screen extends StatefulWidget {
  final int employeeID;
  final BuildContext context;
  const Employment_screen({
    super.key,
    required this.employeeID, required this.context,
  });

  @override
  State<Employment_screen> createState() => _Employment_screenState();
}

class _Employment_screenState extends State<Employment_screen> {
  List<GlobalKey<_EmploymentFormState>> employmentFormKeys = [];
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _loadEmploymentData();
  }

  Future<void> _loadEmploymentData() async {
    try {
      List<EmploymentDataForm> prefilledData = await getEmployeeHistoryForm(context,widget.employeeID);
      setState(() {
        employmentFormKeys = List.generate(
          prefilledData.length,
              (index) => GlobalKey<_EmploymentFormState>(),
        );
      });
    } catch (e) {
      print('Error loading employment data: $e');
    }
  }

  void addEmploymentForm() {
    setState(() {
      employmentFormKeys.add(GlobalKey<_EmploymentFormState>());
    });
  }

  void removeEmploymentForm(GlobalKey<_EmploymentFormState> key) {
    setState(() {
      employmentFormKeys.remove(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: Text(
              'Employment',
              style: GoogleFonts.firaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xff50B5E5),
              ),
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
          Column(
            children: employmentFormKeys.asMap().entries.map((entry) {
              int index = entry.key;
              GlobalKey<_EmploymentFormState> key = entry.value;
              return EmploymentForm(
                key: key,
                index: index + 1,
                onRemove: () => removeEmploymentForm(key),
                employeeID: widget.employeeID,
                isVisible: isVisible,
              );
            }).toList(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Padding(
            padding: const EdgeInsets.only(left: 150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff50B5E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'Add Experience',
                    style: GoogleFonts.firaSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isVisible = true;
                      addEmploymentForm();
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                width: 117,
                height: 30,
                text: 'Save',
                style: TextStyle(
                  fontFamily: 'FiraSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                borderRadius: 12,
                onPressed: () async {
                  for (var key in employmentFormKeys) {
                    final state = key.currentState!;
                    if (state.finalPath == null || state.finalPath!.isEmpty) {
                      print("Loading");
                    } else {
                      try {
                        await postemploymentscreenData(
                            context,
                            state.widget.employeeID,
                            state.employerController.text,
                            state.cityController.text,
                            state.reasonForLeavingController.text,
                            state.supervisorNameController.text,
                            state.supervisorMobileNumberController.text,
                            state.finalPositionController.text,
                            state.startDateController.text,
                            state.isChecked
                                ? '0000-00-00'
                                : state.endDateController.text,
                            "NA",
                            "USA");
                        await uploadEmployeeResume(
                          context: context,
                          employeementId: widget.employeeID,
                          documentFile: state.finalPath!,
                          documentName: state.fileName ?? '',
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Document uploaded successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    }
                  }
                },
                child: Text(
                  'Save',
                  style: GoogleFonts.firaSans(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class EmploymentForm extends StatefulWidget {
  final int employeeID;
  final VoidCallback onRemove;
  final int index;
  final bool isVisible;

  EmploymentForm({
    Key? key,
    required this.onRemove,
    required this.index,
    required this.employeeID,
    required this.isVisible,
  }) : super(key: key);

  @override
  _EmploymentFormState createState() => _EmploymentFormState();
}

class _EmploymentFormState extends State<EmploymentForm> {
  TextEditingController employerController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController reasonForLeavingController = TextEditingController();
  TextEditingController supervisorNameController = TextEditingController();
  TextEditingController supervisorMobileNumberController = TextEditingController();
  TextEditingController finalPositionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool isChecked = false;

  List<String> _fileNames = [];
  bool _loading = false;
  Uint8List? finalPath;
  String? fileName;
  int? employementIndex;

  @override
  void initState() {
    super.initState();
    _initializeFormWithPrefilledData();
  }

  Future<void> _initializeFormWithPrefilledData() async {
    try {
      List<EmploymentDataForm> prefilledData = await getEmployeeHistoryForm(context, widget.employeeID);
      if (prefilledData.isNotEmpty) {
        var data = prefilledData[widget.index - 1]; // Assuming index matches the data list
        setState(() {
          employerController.text = data.employer ?? '';
          cityController.text = data.city ?? '';
          reasonForLeavingController.text = data.reason ?? '';
          supervisorNameController.text = data.supervisor ?? '';
          supervisorMobileNumberController.text = data.supMobile ?? '';
          finalPositionController.text = data.title ?? '';
          startDateController.text = data.dateOfJoining ?? '';
          endDateController.text = data.endDate ?? '';
          isChecked = data.endDate == null;
          employementIndex = data.employmentId ?? 0;

        });
      }
    } catch (e) {
      print('Failed to load prefilled data: $e');
    }
  }

  Future<void> _handleFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = result.files.first;
      setState(() {
        fileName = file.name;
        finalPath = file.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120),
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
                    fontWeight: FontWeight.w600,
                    color: ColorManager.mediumgrey,
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _handleFileUpload,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff50B5E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      icon: Icon(Icons.upload, color: Colors.white),
                      label: Text(
                        'Upload File',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height:8),
                    if (fileName != null)
                      AutoSizeText('Selected file: $fileName',style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.mediumgrey,
                      )),
                  ],
                ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                employementIndex == null ? 'Employment ${widget.index}' :'Employment ${employementIndex}',
                style: GoogleFonts.firaSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff686464),
                ),
              ),
              if (widget.index > 1)
                IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: widget.onRemove,
                ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Final Position Title',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: finalPositionController,
                      hintText: 'Enter Title',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32.0,
                     // width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Start Date',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: startDateController,
                      hintText: 'dd-mm-yyyy',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32.0,
                      //width: MediaQuery.of(context).size.width / 5,
                      suffixIcon: IconButton(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
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
                            startDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'End Date',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: endDateController,
                      hintText: 'dd-mm-yyyy',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32.0,
                      //width: MediaQuery.of(context).size.width / 5,
                      suffixIcon: IconButton(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
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
                          if (pickedDate != null || isChecked) {
                            endDateController.text = "${pickedDate?.toLocal()}".split(' ')[0];
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Color(0xff50B5E5),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                              if (isChecked) {
                                endDateController.clear();
                              }
                            });
                          },
                        ),
                        Text(
                          'Currently work here',
                          style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686464),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Employer',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: employerController,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32.0,
                      // width: MediaQuery.of(context).size.width / 5,
                    ),

                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason for Leaving',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: reasonForLeavingController,
                      hintText: 'Enter Leaving Reason',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32.0,
                     // width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Last Supervisor’s Name',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: supervisorNameController,
                      hintText: 'Enter Supervisor’s Name',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32.0,
                      //width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Supervisor’s Mobile Number',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: supervisorMobileNumberController,
                      hintText: 'Enter Mobile Number',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32.0,
                     // width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'City',
                      style: GoogleFonts.firaSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: cityController,
                      hintText: 'Enter City',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32.0,
                     // width: MediaQuery.of(context).size.width / 5,
                    ),
                  ],
                ),
              ),

            ],
          ),
          // SizedBox(height: 16),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),

        ],
      ),
    );
  }
}


