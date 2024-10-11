import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_education_manager.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/onboarding_manager/qualification_bar_manager.dart';
import '../../../../../../../data/api_data/api_data.dart';
import '../../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../../../../data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_education_data.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
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

  bool isLoading = false;


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
                style:FormHeading.customTextStyle(context)
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
              style: DefineWorkWeekStyle.customTextStyle(context),
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
                      style: BlueButtonTextConst.customTextStyle(context)
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
                text: isLoading ? 'Wait..' : 'Save',
                style:  BlueButtonTextConst.customTextStyle(context),
                borderRadius: 12,
                onPressed: () async {

                  if (isLoading)
                    return;
                  // Loop through each form and extract data to post

                  setState(() {
                    isLoading = true; // Start loading
                  });
                  for (var key in educationFormKeys) {
                    final st = key.currentState!;
                    if (st.finalPath == null || st.finalPath!.isEmpty) {
                      print("Loading");
                    } else {
                      try {
                        ApiDataRegister result =  await FormEducationManager().posteducationscreen(
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
                        await uploadEducationDocument(
                            context,
                            result.educationId!,
                            st.finalPath,
                            st.fileName!
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddSuccessPopup(
                              message: 'Education Data Saved',
                            );
                          },
                        );

                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddSuccessPopup(
                              message: 'Failed To Update Education Data',
                            );
                          },
                        );
                      }
                    }
                  }
                  setState(() {
                    isLoading = false; // End loading
                  });
                },

                child: isLoading
                    ? SizedBox(
                  height: AppSize.s25,
                  width: AppSize.s25,
                  child: CircularProgressIndicator(
                      color: Colors.white
                  ),
                )
                    : Text(
                  'Save',
                  style: BlueButtonTextConst.customTextStyle(context),
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
  int selectedDegreeId = 0;

  String? graduatetype;
  String? selectedDegree;
  String? docName;

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
          // selectedDegree = data.degree ?? '';
          educationIndex = data.educationID ?? 0;
          docName = data.docName ?? "--";

        });
      }
    } catch (e) {
      print('Failed to load prefilled data: $e');
    }
  }

  // Future<void> _handleFileUpload() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  //   if (result != null) {
  //     final file = result.files.first;
  //     setState(() {
  //       fileName = file.name;
  //       finalPath = file.bytes;
  //     });
  //   }
  // }
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
                style: HeadingFormStyle.customTextStyle(context),
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
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: collegeuniversity,
                      hintText: 'Enter College/University Name',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Text(
                      'Graduate',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) {
                        return Row(
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
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Text(
                      'Degree',
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) { return Container(
                        height: 32,
                        child: buildDropdownButton(context),
                      );  },

                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Text(
                      'Major Subject',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: majorsubject,
                      hintText: 'Enter Subject',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
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
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegisterPhone(
                      controller: phone,
                      hintText: 'Enter Phone Number',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Text(
                      'City',
                      style: AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: city,
                      hintText: 'Enter City',
                      hintStyle:onlyFormDataStyle.customTextStyle(context),
                      height: 32,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 45),
                    Text(
                      'State',
                      style:AllPopupHeadings.customTextStyle(context),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: state,
                      hintText: 'Enter State',
                      hintStyle: onlyFormDataStyle.customTextStyle(context),
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
                  style: FileuploadString.customTextStyle(context),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 20),
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) { return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                        onPressed: ()async {
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
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff50B5E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),

                        ),
                        icon: docName == "--" ? Icon(Icons.upload, color: Colors.white):null,
                        label:docName == null ?Text(
                          'Upload File',
                          style: BlueButtonTextConst.customTextStyle(context),
                        ):Text(
                          'Uploaded',
                          style: BlueButtonTextConst.customTextStyle(context),
                        )
                    ),
                    SizedBox(height: 8,),
                    docName != null ? AutoSizeText(
                        'Uploaded File: $docName',
                        style:onlyFormDataStyle.customTextStyle(context)
                    ):
                    fileName != null ?
                    AutoSizeText(
                        'File picked: $fileName',
                        style: onlyFormDataStyle.customTextStyle(context)
                    ) : SizedBox(),
                  ],
                );  },

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
  Widget buildDropdownButton(BuildContext context) {
    return FutureBuilder<List<EduactionDegree>>(
      future: getDegreeDropDown(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 7),
            child: Container(
              height: 31,
              width: 250,
              decoration: BoxDecoration(
                  color: ColorManager.white),
            ),
          );

        } else if (snapshot.hasError) {
          return  CustomDropdownTextField(
            //width: MediaQuery.of(context).size.width / 5,
            items: ['Error'], headText: 'Degree',
          );
        } else if (snapshot.hasData) {
          List<DropdownMenuItem<String>> dropDownList = [];
          int degreeID = 0;
          for(var i in snapshot.data!){
            dropDownList.add(DropdownMenuItem<String>(
              child: Text(i.degree),
              value: i.degree,
            ));
          }
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Container(
                height: 32,
                // margin: EdgeInsets.symmetric(horizontal: 20),
                padding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: const Color(0xff686464).withOpacity(0.5),
                      width: 1), // Black border
                  borderRadius:
                  BorderRadius.circular(6), // Rounded corners
                ),
                child: DropdownButtonFormField<String>(
                    focusColor: Colors.transparent,
                    icon: const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Color(0xff686464),
                    ),
                    decoration: const InputDecoration.collapsed(hintText: ''),
                    items: dropDownList,
                    onChanged: (newValue) {
                      for(var a in snapshot.data!){
                        if(a.degree == newValue){
                          selectedDegree = a.degree;
                          degreeID = a.degreeId;
                          selectedDegreeId = degreeID;
                          print("Degree :: ${selectedDegree}");
                          //empTypeId = docType;
                        }
                      }
                    },
                    value: dropDownList[0].value,
                    style: onlyFormDataStyle.customTextStyle(context)
                ),
              );
            },
          );
        } else {
          return CustomDropdownTextField(
            // width: MediaQuery.of(context).size.width / 5,
            headText: 'Zone',
            items: ['No Data'],
          );
        }
      },
    );
  }
}

