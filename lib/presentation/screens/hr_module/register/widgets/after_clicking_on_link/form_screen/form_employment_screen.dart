import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_employment_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/employeement_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_employment_data.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../taxtfield_constant.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_employment_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/progress_form_data/form_employment_data.dart';
import 'dart:convert';

import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class EmploymentScreen extends StatefulWidget {
  final int employeeID;
  final BuildContext context;
  final Function onSave;
  final Function onBack;
  const EmploymentScreen({
    super.key,
    required this.employeeID, required this.context, required this.onSave, required this.onBack,
  });

  @override
  State<EmploymentScreen> createState() => _EmploymentScreenState();
}

class _EmploymentScreenState extends State<EmploymentScreen> {
  List<GlobalKey<_EmploymentFormState>> employmentFormKeys = [];
  bool isVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadEmploymentData();
  }

  Future<void> _loadEmploymentData() async {
    try {
      List<EmploymentDataForm> prefilledData = await getEmployeeHistoryForm(context,widget.employeeID);
      if(prefilledData.isEmpty){
        setState((){
          addEmploymentForm();
        });
      }else{
        setState(() {
          employmentFormKeys = List.generate(
            prefilledData.length,
                (index) => GlobalKey<_EmploymentFormState>(),
          );
        });
      }

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
              style: FormHeading.customTextStyle(context)
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
              textAlign: TextAlign.center,
              style:ZoneDataStyle.customTextStyle(context),
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
                    style:BlueButtonTextConst.customTextStyle(context)
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

              Container(
                //color: Colors.white,
                width: 117,
                height: 30,
                child: ElevatedButton(
                  onPressed: (){
                    widget.onBack();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: ColorManager.bluebottom,
                        width: 1,
                      ),
                    ),),
                  child: Text('Previous',
                    style: TransparentButtonTextConst.customTextStyle(context),
                  ),),
              ),
              const SizedBox(
                width: 30,
              ),

              isLoading
                  ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ),
              )
                  :CustomButton(
                width: 117,
                height: 30,
                text: 'Save', // Show empty text when loading
                style: BlueButtonTextConst.customTextStyle(context),
                borderRadius: 12,
                onPressed: () async {
                  setState(() {
                    isLoading = true; // Start loading
                  });

                  for (var key in employmentFormKeys) {
                    final state = key.currentState!;

                    try {
                      // Post employment screen data
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
                        state.isChecked ? "Currently Working" : state.endDateController.text,
                        "NA",
                        "United States Of America",
                      );

                      // Check if the file name is not null before uploading the resume
                      if (state.fileName != null) {
                        await uploadEmployeeResume(
                          context: context,
                          employeementId: widget.employeeID,
                          documentFile: state.finalPath!,
                          documentName: state.fileName!,
                        );
                      }


                      // Show success message after saving the data
                      await  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddSuccessPopup(
                            message: 'Employment Data Saved',
                          );
                        },
                      );
                    } catch (e) {
                      // Show failure message in case of an error
                      await  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddSuccessPopup(
                            message: 'Failed To Update Employment Data',
                          );
                        },
                      );
                      print(e);
                    }
                  }

                  setState(() {
                    isLoading = false; // End loading
                  });
                  widget.onSave();
                },
                child: Text(
                  'Save',
                  style: BlueButtonTextConst.customTextStyle(context),
                ),
              ),







              ///file upload logic old
//
//               isLoading
//                   ? SizedBox(
//                 height: 25,
//                 width: 25,
//                 child: CircularProgressIndicator(
//                   color: ColorManager.blueprime,
//                 ),
//               )
//                   :CustomButton(
//                 width: 117,
//                 height: 30,
//                 text:'Save', // Show empty text when loading
//                 style: BlueButtonTextConst.customTextStyle(context),
//                 borderRadius: 12,
//                 onPressed: () async {
//
//                   setState(() {
//                     isLoading = true; // Start loading
//                   });
//
//                   for (var key in employmentFormKeys) {
//                     final state = key.currentState!;
//                     if (state.finalPath == null || state.finalPath!.isEmpty) {
//                       print("Loading");
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return const VendorSelectNoti(
//                             message: 'Please Select file',
//                           );
//                         },
//                       );
//
//                     } else {
//                       try {
//                         await postemploymentscreenData(
//                           context,
//                           state.widget.employeeID,
//                           state.employerController.text,
//                           state.cityController.text,
//                           state.reasonForLeavingController.text,
//                           state.supervisorNameController.text,
//                           state.supervisorMobileNumberController.text,
//                           state.finalPositionController.text,
//                           state.startDateController.text,
//                           state.isChecked
//                               ? "Currently Working"
//                               : state.endDateController.text,
//                           "NA",
//                           "United States Of America",
//                         );
//
//                         await uploadEmployeeResume(
//                           context: context,
//                           employeementId: widget.employeeID,
//                           documentFile: state.finalPath!,
//                           documentName: state.fileName ?? '',
//                         );
//
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AddSuccessPopup(
//                               message: 'Employment Data Saved',
//                             );
//                           },
//                         );
//                       } catch (e) {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AddSuccessPopup(
//                               message: 'Failed To Update Employment Data',
//                             );
//                           },
//                         );
//                         print(e);
//                       }
//                     }
//                   }
//
//                   setState(() {
//                     isLoading = false; // End loading
//                   });
//                 },
//                 child:Text(
//                   'Save',
//                   style: BlueButtonTextConst.customTextStyle(context),
//                 ),
//               ),


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
          endDateController.text = data.endDate;
        // isChecked = data.endDate == true;
          employementIndex = data.employmentId ?? 0;

        });
      }
    } catch (e) {
      print('Failed to load prefilled data: $e');
    }
  }

  Future<void> _handleFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']
    );

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
                  style: FileuploadString.customTextStyle(context),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 20),
              isChecked?StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setState) { return Column(
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
                          style: BlueButtonTextConst.customTextStyle(context),
                        ),
                      ),
                      SizedBox(height:8),
                      if (fileName != null)
                        AutoSizeText('Selected file: $fileName',style:onlyFormDataStyle.customTextStyle(context),),
                    ],
                  ); },

                ):SizedBox()
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                employementIndex == null ? 'Employment #${widget.index}' :'Employment #${employementIndex}',
                style:  HeadingFormStyle.customTextStyle(context),
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
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: finalPositionController,
                      hintText: 'Enter Title',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32.0,
                     // width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Employer',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: employerController,
                      hintText: 'Enter Text',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32.0,
                      // width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Start Date',
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: startDateController,
                      hintText: 'yyyy-mm-dd',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
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
                            firstDate: DateTime(1900),
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
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: endDateController,
                      hintText: 'yyyy-mm-dd',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
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
                            firstDate: DateTime(1900),
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
                          style: onlyFormDataStyle.customTextStyle(context),
                        ),
                      ],
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
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: reasonForLeavingController,
                      hintText: 'Enter Leaving Reason',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32.0,
                     // width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Last Supervisor’s Name',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: supervisorNameController,
                      hintText: 'Enter Supervisor’s Name',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32.0,
                      //width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Supervisor’s Mobile Number',
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegisterPhone(
                      controller: supervisorMobileNumberController,
                      hintText: 'Enter Mobile Number',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
                      height: 32.0,
                     // width: MediaQuery.of(context).size.width / 5,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'City',
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: 8),
                    CustomTextFieldRegister(
                      controller: cityController,
                      hintText: 'Enter City',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
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


