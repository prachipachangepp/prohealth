import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_education_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import '../../../../../../../data/api_data/api_data.dart';
import '../../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../../../../data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_education_data.dart';
import '../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

class EducationScreen extends StatefulWidget {
  final int employeeID;
  const EducationScreen({
    super.key,
    required this.context,
    required this.employeeID,
  });

  final BuildContext context;

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  //late Future<List<EducationDataForm>> futureEducationData;
  List<GlobalKey<_EducationFormState>> educationFormKeys = [];
  bool isVisible = false;
  double textFieldWidth = 430;
  double textFieldHeight = 38;

  // Current step in the stepper
  int _currentStep = 0;


  //List<GlobalKey<_EducationFormState>> educationFormKeys = [];
  // List<EducationDataForm> educationFormList = [];

  @override
  void initState() {
    super.initState();
    _loadEducationData();
  }

  Future<void> _loadEducationData() async {
    try {
      List<EducationDataForm> prefilledData = await getEmployeeEducationForm(context, widget.employeeID);
      setState(() {
        educationFormKeys = List.generate(
          prefilledData.length,
              (index) => GlobalKey<_EducationFormState>(),
        );
      });
    } catch (e) {
      print('Error loading Education data: $e');
    }
  }

  void addEducationForm() {
    setState(() {
      educationFormKeys.add(GlobalKey<_EducationFormState>());
    });
  }

  void removeEduacationForm(GlobalKey<_EducationFormState> key) {
    setState(() {
      educationFormKeys.remove(key);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Column(
                    children: educationFormKeys.asMap().entries.map((entry) {
                      int index = entry.key;
                      GlobalKey<_EducationFormState> key = entry.value;
                      return EducationForm(
                        key: key,
                        index: index + 1,
                        onRemove: () => removeEduacationForm(key),
                        employeeID: widget.employeeID, isVisible: isVisible,
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
                          onPressed: () {
                            setState(() {
                              isVisible = true;
                              addEducationForm();
                            });
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
                  ),
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
                          // Loop through each form and extract data to post
                          for (var key in educationFormKeys) {
                            final st = key.currentState!;
                            if (st.finalPath == null || st.finalPath!.isEmpty) {
                                print("Loading");
                            } else {
                              try {
                                await uploadDocuments(
                                  context: context,
                                  employeeDocumentMetaId: 10,
                                  employeeDocumentTypeSetupId: 48,
                                  employeeId: widget.employeeID,
                                  documentFile: st.finalPath,
                                  documentName: 'education data',
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Document uploaded successfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                await FormEducationManager().posteducationscreen(
                                    context,
                                    st.widget.employeeID,
                                    st.graduatetype.toString(),
                                    st.selectedDegree.toString(),
                                    st.majorsubject.text,
                                    st.city.text,
                                    st.collegeuniversity.text,
                                    st.phone.text,
                                    st.state.text,
                                    "USA",
                                    "2024-08-09");
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Failed to upload document: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
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
        //   }
        //
        //   return SizedBox();
        // });
  }
}

class EducationForm extends StatefulWidget {
  final int employeeID;
  final VoidCallback onRemove;
  final int index;
  final bool isVisible;
  const EducationForm(
      {Key? key,
      required this.onRemove,
      required this.index,
      required this.employeeID, required this.isVisible})
      : super(key: key);

  @override
  _EducationFormState createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  TextEditingController collegeuniversity = TextEditingController();
  TextEditingController majorsubject = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();

  List<String> _fileNames = [];
  bool _loading = false;
  Uint8List? finalPath;
  String? fileName;
  int? educationIndex;

  String? graduatetype;
  String? selectedDegree;

  final StreamController<List<AEClinicalDiscipline>> Degreestream =
      StreamController<List<AEClinicalDiscipline>>();
  void initState() {
    super.initState();
    HrAddEmplyClinicalDisciplinApi(context, 1).then((data) {
      Degreestream.add(data);
    }).catchError((error) {});
    _initializeFormWithPrefilledData();
  }

  Future<void> _initializeFormWithPrefilledData() async {
    try {
      List<EducationDataForm> prefilledData = await getEmployeeEducationForm(context, widget.employeeID);
      if (prefilledData.isNotEmpty) {
        var data = prefilledData[widget.index - 1]; // Assuming index matches the data list
        setState(() {
          collegeuniversity.text = data.college ?? '';
          majorsubject.text = data.major ?? '';
          phone.text = data.phone ?? '';
          city.text = data.city ?? '';
          state.text = data.state ?? '';
          graduatetype = data.graduate ?? '';
          selectedDegree = data.degree ?? '';
          educationIndex = data.educationID ?? 0;

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
            padding: const EdgeInsets.only(left: 160, right: 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      educationIndex == null ? 'Education #${widget.index}' :  'Education #${educationIndex}',
                      style: GoogleFonts.firaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
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
                          SizedBox(height: MediaQuery.of(context).size.height / 60),
                          CustomTextFieldRegister(
                            controller: collegeuniversity,
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 30),
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
                                    groupValue: graduatetype,
                                    onChanged: (value) {
                                      setState(() {
                                        graduatetype = value;
                                      });
                                    },
                                  )),
                              Expanded(
                                child: CustomRadioListTile(
                                  title: 'No',
                                  value: 'No',
                                  groupValue: graduatetype,
                                  onChanged: (value) {
                                    setState(() {
                                      graduatetype = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 30),
                          Text(
                            'Degree',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 60),
                          Container(
                            height: 32,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                // hintText: 'Select Degree',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              value: selectedDegree,
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
                                  selectedDegree = newValue;
                                });
                              },
                              items: <String>[
                                'Degee',
                                'Deree',
                                'Dgree',
                                'Degre'
                              ] // List of countries
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 30),
                          Text(
                            'Major Subject',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 60),
                          CustomTextFieldRegister(
                            controller: majorsubject,
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
                    SizedBox(width: MediaQuery.of(context).size.width / 15),
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
                          SizedBox(height: MediaQuery.of(context).size.height / 60),
                          CustomTextFieldRegister(
                            controller: phone,
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 30),
                          Text(
                            'City',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 60),
                          CustomTextFieldRegister(
                            controller: city,
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 30),
                          Text(
                            'State',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 60),
                          CustomTextFieldRegister(
                            controller: state,
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
                        if (fileName != null)
                          AutoSizeText(
                            'File picked: $fileName',
                            style: GoogleFonts.firaSans(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                      ],
                    ),


                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 2,
                )
      
                ///upload document/ Display file names if picked
              ],
            ),
          );
  }
}


























//
// Container(
// height: 700,
// //color:Colors.cyanAccent,
// child: Padding(
// padding: const EdgeInsets.only(left: 160,right: 160),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Education # 1',
// style: GoogleFonts.firaSans(
// fontSize: 14.0,
// fontWeight: FontWeight.w700,
// color: Color(0xff686464),
// ),
// ),
// SizedBox(height: MediaQuery.of(context).size.height / 20),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Expanded(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'College/University',
// style: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464)),
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 60),
// CustomTextFieldRegister(
// controller: collegeuniversity,
// hintText: 'Enter Text',
// hintStyle: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff9B9B9B),
// ),
// height: 32,
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 30),
// Text(
// 'Graduate',
// style: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464)),
// ),
// Row(
// children: [
// Expanded(
// child: CustomRadioListTile(
// title: 'Yes',
// value: 'Yes',
// groupValue: graduatetype,
// onChanged: (value) {
// setState(() {
// graduatetype = value;
// });
// },
// )),
// Expanded(
// child: CustomRadioListTile(
// title: 'No',
// value: 'No',
// groupValue: graduatetype,
// onChanged: (value) {
// setState(() {
// graduatetype = value;
// });
// },
// ),
// ),
// ],
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 30),
// Text(
// 'Degree',
// style: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464)),
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 60),
// Container(
// height: 32,
// child: DropdownButtonFormField<String>(
// decoration: InputDecoration(
// hintText: 'Select Degree',
// hintStyle: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff9B9B9B),
// ),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(4.0),
// borderSide: BorderSide(color: Colors.grey),
// ),
// contentPadding: EdgeInsets.symmetric(
// vertical: 10, horizontal: 10),
// ),
// value: _selectedDegree,
// icon: Icon(Icons.arrow_drop_down,
// color: Color(0xff9B9B9B)),
// iconSize: 24,
// elevation: 16,
// style: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464),
// ),
// onChanged: (String? newValue) {
// setState(() {
// _selectedDegree = newValue;
// });
// },
// items: <String>[
// 'Degee',
// 'Deree',
// 'Dgree',
// 'Degre'
// ] // List of countries
//     .map<DropdownMenuItem<String>>(
// (String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// ),
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 30),
// Text(
// 'Major Subject',
// style: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464)),
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 60),
// CustomTextFieldRegister(
// controller: majorsubject,
// hintText: 'Enter Text',
// hintStyle: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff9B9B9B),
// ),
// height: 32,
// ),
// ],
// ),
// ),
// SizedBox(width: MediaQuery.of(context).size.width / 15),
// Expanded(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Phone ',
// style: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464)),
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 60),
// CustomTextFieldRegister(
// controller: phone,
// hintText: 'Enter Text',
// hintStyle: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff9B9B9B),
// ),
// height: 32,
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 30),
// Text(
// 'City',
// style: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464)),
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 60),
// CustomTextFieldRegister(
// controller: city,
// hintText: 'Enter Text',
// hintStyle: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff9B9B9B),
// ),
// height: 32,
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 30),
// Text(
// 'State',
// style: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464)),
// ),
// SizedBox(
// height:
// MediaQuery.of(context).size.height / 60),
// CustomTextFieldRegister(
// controller: state,
// hintText: 'Enter Text',
// hintStyle: GoogleFonts.firaSans(
// fontSize: 10.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff9B9B9B),
// ),
// height: 32,
// ),
// ],
// ),
// ),
// ],
// ),
// SizedBox(height: MediaQuery.of(context).size.height / 20),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: Text(
// 'Upload your degree / certifications as a docx or pdf',
// style: GoogleFonts.firaSans(
// fontSize: 14.0,
// fontWeight: FontWeight.w500,
// color: Color(0xff686464),
// ),
// ),
// ),
// SizedBox(width: MediaQuery.of(context).size.width / 20),
// ElevatedButton.icon(
// onPressed: _pickFiles,
// // onPressed: () async {
// //   FilePickerResult? result =
// //       await FilePicker.platform.pickFiles(
// //     allowMultiple: true,
// //   );
// //   if (result != null) {
// //     PlatformFile file = result.files.first;
// //     print('File picked: ${file.name}');
// //
// //   } else {
// //     // User canceled the picker
// //   }
// //
// // },
// style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xff50B5E5),
// // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8.0),
// ),
// ),
// icon: Icon(Icons.file_upload_outlined,
// color: Colors.white),
// label: Text(
// 'Upload Document',
// style: GoogleFonts.firaSans(
// fontSize: 14.0,
// fontWeight: FontWeight.w700,
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
// SizedBox(height: 5.0),
//
// ///upload document
// _loading
// ? SizedBox(width: 25,
// height: 25,
// child: CircularProgressIndicator(
// color: ColorManager.blueprime, // Loader color
// // Loader size
// ),
// )
//     : _fileNames.isNotEmpty
// ? Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: _fileNames
//     .map((fileName) => Padding(
// padding: const EdgeInsets.all(8.0),
// child: Text(
// 'File picked: $fileName',
// style: GoogleFonts.firaSans(
// fontSize: 12.0,
// fontWeight: FontWeight.w400,
// color: Color(0xff686464)),
// ),
// ))
//     .toList(),
// )
//     : SizedBox(), // Display file names if picked
//
// // SizedBox(height: MediaQuery.of(context).size.height / 20),
// // Divider(
// //   thickness: 2,
// //   color: Color(0xff686464),
// // )
// ],
// ),
// )),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xff1696C8),
// foregroundColor: Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// onPressed: () async {
// await posteducationscreen(
// context,
// 0,
// graduatetype.toString(),
// "__",
// majorsubject.text,
// city.text,
// collegeuniversity.text,
// phone.text,
// state.text,
// "__");
// },
// child: Text(
// 'Save',
// style: GoogleFonts.firaSans(
// fontSize: 14.0,
// fontWeight: FontWeight.w700,
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
// ]),
// );

// class EducationEntry {
//   String collegeUniversity;
//   String graduateType;
//   String degree;
//   String majorSubject;
//   String phone;
//   String city;
//   String state;
//
//   EducationEntry({
//     required this.collegeUniversity,
//     required this.graduateType,
//     required this.degree,
//     required this.majorSubject,
//     required this.phone,
//     required this.city,
//     required this.state,
//   });
// }
//
// List<EducationEntry> educationEntries = [
//   EducationEntry(
//     collegeUniversity: '',
//     graduateType: '',
//     degree: '',
//     majorSubject: '',
//     phone: '',
//     city: '',
//     state: '',
//   ),
// ];
//
// Row(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     ElevatedButton.icon(
//       onPressed: () {
//         setState(() {
//           educationEntries.add(EducationEntry(
//             collegeUniversity: '',
//             graduateType: '',
//             degree: '',
//             majorSubject: '',
//             phone: '',
//             city: '',
//             state: '',
//           ));
//         });
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Color(0xff50B5E5),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       icon: Icon(Icons.add, color: Colors.white),
//       label: Text(
//         'Add Education',
//         style: GoogleFonts.firaSans(
//           fontSize: 14.0,
//           fontWeight: FontWeight.w700,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   ],
// ),

// Padding(
//   padding: const EdgeInsets.only(left: 166.0, right: 166),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'Education # 1',
//         style: GoogleFonts.firaSans(
//             fontSize: 14.0,
//             fontWeight: FontWeight.w700,
//             color: Color(0xff686464)),
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height / 20),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'College/University',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 60),
//                 CustomTextFieldRegister(
//                   controller: collegeuniversity,
//                   hintText: 'Enter Text',
//                   hintStyle: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff9B9B9B),
//                   ),
//                   height: 32,
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 30),
//                 Text(
//                   'Graduate',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                         child: CustomRadioListTile(
//                       title: 'Yes',
//                       value: 'Yes',
//                       groupValue: graduatetype,
//                       onChanged: (value) {
//                         setState(() {
//                           graduatetype = value;
//                         });
//                       },
//                     )),
//                     Expanded(
//                       child: CustomRadioListTile(
//                         title: 'No',
//                         value: 'No',
//                         groupValue: graduatetype,
//                         onChanged: (value) {
//                           setState(() {
//                             graduatetype = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 30),
//                 Text(
//                   'Degree',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 60),
//                 Container(
//                   height: 32,
//                   child: DropdownButtonFormField<String>(
//                     decoration: InputDecoration(
//                       hintText: 'Select Degree',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(4.0),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 10),
//                     ),
//                     value: _selectedDegree,
//                     icon: Icon(Icons.arrow_drop_down,
//                         color: Color(0xff9B9B9B)),
//                     iconSize: 24,
//                     elevation: 16,
//                     style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464),
//                     ),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedDegree = newValue;
//                       });
//                     },
//                     items: <String>[
//                       'Degee',
//                       'Deree',
//                       'Dgree',
//                       'Degre'
//                     ] // List of countries
//                         .map<DropdownMenuItem<String>>(
//                             (String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 30),
//                 Text(
//                   'Major Subject',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 60),
//                 CustomTextFieldRegister(
//                   controller: majorsubject,
//                   hintText: 'Enter Text',
//                   hintStyle: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff9B9B9B),
//                   ),
//                   height: 32,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width / 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Phone ',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 60),
//                 CustomTextFieldRegister(
//                   controller: phone,
//                   hintText: 'Enter Text',
//                   hintStyle: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff9B9B9B),
//                   ),
//                   height: 32,
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 30),
//                 Text(
//                   'City',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 60),
//                 CustomTextFieldRegister(
//                   controller: city,
//                   hintText: 'Enter Text',
//                   hintStyle: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff9B9B9B),
//                   ),
//                   height: 32,
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 30),
//                 Text(
//                   'State',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(
//                     height: MediaQuery.of(context).size.height / 60),
//                 CustomTextFieldRegister(
//                   controller: state,
//                   hintText: 'Enter Text',
//                   hintStyle: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff9B9B9B),
//                   ),
//                   height: 32,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height / 20),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               'Upload your degree / certifications as a docx or pdf',
//               style: GoogleFonts.firaSans(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xff686464),
//               ),
//             ),
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width / 20),
//           ElevatedButton.icon(
//             onPressed: () async {
//               FilePickerResult? result =
//                   await FilePicker.platform.pickFiles(
//                 allowMultiple: false,
//               );
//               if (result != null) {
//                 PlatformFile file = result.files.first;
//                 print('File picked: ${file.name}');
//               } else {
//                 // User canceled the picker
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xff50B5E5),
//               // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             icon:
//                 Icon(Icons.file_upload_outlined, color: Colors.white),
//             label: Text(
//               'Upload Document',
//               style: GoogleFonts.firaSans(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height / 20),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           ElevatedButton.icon(
//             onPressed: () {
//               // Handle add education action
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xff50B5E5),
//               // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             icon: Icon(Icons.add, color: Colors.white),
//             label: Text(
//               'Add Education',
//               style: GoogleFonts.firaSans(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
// ),
