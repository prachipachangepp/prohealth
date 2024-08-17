import 'dart:async';

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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart'; // Assuming you use shimmer for loading




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
  late Future<List<EducationDataForm>> futureEducationData;



  TextEditingController collegeuniversity = TextEditingController();
  TextEditingController majorsubject = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();

  List<GlobalKey<_EducationFormState>> educationFormKeys = [];
  List<EducationDataForm> educationFormList = [];

  @override
  void initState() {
    super.initState();
   addEducationForm();
    HrEmplyDegreedropdown(context).then((data) {
      Degreestream.add(data);
    }).catchError((error) {});
  }
  final StreamController<List<EduactionDegree>> Degreestream =
  StreamController<List<EduactionDegree>>();
//////////////////////////////////////////////////





  //////////////////////////////////////////////

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

  List<String> _fileNames = [];
  bool _loading = false;

  String? graduatetype;
  String? selectedDegree;



  Future<XFile> convertBytesToXFile(Uint8List bytes, String fileName) async {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final file = html.File([blob], fileName);
    return XFile(url);
  }

  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic? filePath;
  File? xfileToFile;
  var finalPath;


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






          ///////////////////////////////////////////////////////////////////////////////////////////
          Column(
            children: educationFormKeys.asMap().entries.map((entry) {
              int index = entry.key;
              GlobalKey<_EducationFormState> key = entry.value;
              return EducationForm(
                key: key,
                index: index + 1,
                onRemove: () => removeEduacationForm(key),
                employeeID: widget.employeeID,
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
                  onPressed: addEducationForm,
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
                    await postEducationScreenData(
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

                    if (st.finalPath == null || st.finalPath.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'No file selected. Please select a file to upload.'),
                          backgroundColor: Colors.red,
                        ),
                      );
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
                            content: Text('Document uploaded successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to upload document: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  }
                  collegeuniversity.clear();
                  majorsubject.clear();
                  phone.clear();
                  city.clear();
                  state.clear();
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
          // SizedBox(height: 30,),
          // const Divider(
          //   color: Colors.grey,
          //   thickness: 2,
          // ),


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
  const EducationForm(
      {Key? key,
      required this.onRemove,
      required this.index,
      required this.employeeID})
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

  String? graduatetype;
  String? selectedDegree;

  final StreamController<List<EduactionDegree>> Degreestream =
      StreamController<List<EduactionDegree>>();

  void initState() {
    super.initState();
    HrEmplyDegreedropdown(context).then((data) {
      Degreestream.add(data);
    }).catchError((error) {});
  }

  Future<XFile> convertBytesToXFile(Uint8List bytes, String fileName) async {
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final file = html.File([blob], fileName);
    return XFile(url);
  }

  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic? filePath;
  File? xfileToFile;
  var finalPath;

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
                'Education #${widget.index}',
                style: GoogleFonts.firaSans(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff686464),
                ),
              ),
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
                      // controller:  TextEditingController(
                      //      text: snapshot.data!.college.toString()),
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
                      child: StreamBuilder<List<EduactionDegree>>(
                        stream: Degreestream
                            .stream, // Change this to a stream method
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 7),
                                child: Container(
                                  width: AppSize.s250,
                                  height: AppSize.s40,
                                  decoration: BoxDecoration(
                                    color: ColorManager.faintGrey,
                                  ),
                                ),
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }

                          if (snapshot.hasData) {
                            List<String> dropDownList = [];

                            for (var i in snapshot.data!) {
                              if (i.degree != null) {
                                dropDownList.add(i.degree!);
                              }
                            }

                            return SizedBox(
                              height: 32,
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff9B9B9B),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide:
                                    const BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                ),
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Color(0xff9B9B9B)),
                                iconSize: 24,
                                elevation: 16,
                                style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464),
                                ),
                                onChanged: (newValue) {
                                  for (var a in snapshot.data!) {
                                    if (a.degree == newValue) {
                                      selectedDegree = a.degree!;
                                    }
                                  }
                                },
                                items: dropDownList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.firaSans(
                                        fontSize: 12,
                                        color: Color(0xff575757),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          } else {
                            return const Offstage();
                          }
                        },
                      ),
                    ),


           ///////////////////////////////////////////////////////////////
           //          FutureBuilder<List<EduactionDegree>>(
           //            future: HrEmplyDegreedropdown(context),
           //            builder: (context, snapshot) {
           //              if (snapshot.connectionState ==
           //                  ConnectionState.waiting) {
           //                return Shimmer.fromColors(
           //                  baseColor: Colors.grey[300]!,
           //                  highlightColor: Colors.grey[100]!,
           //                  child: Padding(
           //                    padding:
           //                        const EdgeInsets.symmetric(horizontal: 7),
           //                    child: Container(
           //                      width: AppSize.s250,
           //                      height: AppSize.s40,
           //                      decoration: BoxDecoration(
           //                          color: ColorManager.faintGrey),
           //                    ),
           //                  ),
           //                );
           //              }
           //              if (snapshot.hasData) {
           //                List<String> dropDownList = [];
           //
           //                for (var i in snapshot.data!) {
           //                  if (i.degree != null) {
           //                    dropDownList.add(i.degree!);
           //                    //print("Country: $ctlrCountry");
           //                  }
           //                }
           //                return SizedBox(
           //                  height: 32,
           //                  child: DropdownButtonFormField<String>(
           //                    decoration: InputDecoration(
           //                      // hintText: 'Select Clinician',
           //                      hintStyle: GoogleFonts.firaSans(
           //                        fontSize: 10.0,
           //                        fontWeight: FontWeight.w400,
           //                        color: const Color(0xff9B9B9B),
           //                      ),
           //                      border: OutlineInputBorder(
           //                        borderRadius: BorderRadius.circular(4.0),
           //                        borderSide:
           //                            const BorderSide(color: Colors.grey),
           //                      ),
           //                      contentPadding: const EdgeInsets.symmetric(
           //                          //   //  vertical: 5,
           //                          horizontal: 12),
           //                    ),
           //                    // value: selectedCountry,
           //                    icon: Icon(Icons.arrow_drop_down,
           //                        color: Color(0xff9B9B9B)),
           //                    iconSize: 24,
           //                    elevation: 16,
           //                    style: GoogleFonts.firaSans(
           //                      fontSize: 10.0,
           //                      fontWeight: FontWeight.w400,
           //                      color: const Color(0xff686464),
           //                    ),
           //
           //                    onChanged: (newValue) {
           //                      for (var a in snapshot.data!) {
           //                        if (a.degree == newValue) {
           //                          selectedDegree = a.degree!;
           //                          //country = a
           //                          // int? docType = a.companyOfficeID;
           //                        }
           //                      }
           //                    },
           //                    items: dropDownList.map((String value) {
           //                      return DropdownMenuItem<String>(
           //                        value: value,
           //                        child: Text(
           //                          value,
           //                          style: GoogleFonts.firaSans(
           //                            fontSize: 12,
           //                            color: Color(0xff575757),
           //                            fontWeight: FontWeight.w400,
           //                          ),
           //                        ),
           //                      );
           //                    }).toList(),
           //                  ),
           //                );
           //              } else {
           //                return const Offstage();
           //              }
           //            },
           //          ),
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
              SizedBox(width: MediaQuery.of(context).size.width / 5),
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
              ElevatedButton.icon(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    try {
                      Uint8List? bytes = result.files.first.bytes;
                      XFile xFile = await convertBytesToXFile(
                          bytes!, result.files.first.name);
                      finalPath = result.files.first.bytes;
                      setState(() {
                        _fileNames
                            .addAll(result.files.map((file) => file.name!));
                        _loading = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }
                },
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
              _loading
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime, // Loader color
                        // Loader size
                      ),
                    )
                  : _fileNames.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _fileNames
                              .map((fileName) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'File picked: $fileName',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff686464)),
                                    ),
                                  ))
                              .toList(),
                        )
                      : SizedBox(),
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

// Row(
//   mainAxisAlignment: MainAxisAlignment.end,
//   children: [
//     ElevatedButton(onPressed: (){
//
//
//     },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xff50B5E5),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//         ),
//         child: Text("edit",style: GoogleFonts.firaSans(
//       fontSize: 14.0,
//       fontWeight: FontWeight.w500,
//       color: Colors.white,
//     ),))
//   ],
// ),

//
// class EdycationEmptyForm extends StatefulWidget {
//   final int employeeID;
//   final VoidCallback onRemove;
//   final int index;
//
//   const EdycationEmptyForm({super.key, required this.employeeID, required this.onRemove, required this.index});
//
//   @override
//   State<EdycationEmptyForm> createState() => _EdycationEmptyFormState();
// }
//
// class _EdycationEmptyFormState extends State<EdycationEmptyForm> {
//
//
//   TextEditingController collegeuniversity = TextEditingController();
//   TextEditingController majorsubject = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController city = TextEditingController();
//   TextEditingController state = TextEditingController();
//
//   String? graduatetype;
//   String? selectedDegree;
//   List<String> _fileNames = [];
//   bool _loading = false;
//
//
//
//   final StreamController<List<AEClinicalDiscipline>> Degreestream =
//   StreamController<List<AEClinicalDiscipline>>();
//   void initState() {
//     super.initState();
//     HrAddEmplyClinicalDisciplinApi(context, 1).then((data) {
//       Degreestream.add(data);
//     }).catchError((error) {});
//   }
//
//   Future<XFile> convertBytesToXFile(Uint8List bytes, String fileName) async {
//     final blob = html.Blob([bytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final file = html.File([blob], fileName);
//     return XFile(url);
//   }
//
//   bool _documentUploaded = true;
//   var fileName;
//   var fileName1;
//   dynamic? filePath;
//   File? xfileToFile;
//   var finalPath;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 160, right: 160),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Education #{#${widget.index}',
//                 style: GoogleFonts.firaSans(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xff686464),
//                 ),
//               ),
//               IconButton(
//                 icon:
//                 Icon(Icons.remove_circle, color: Colors.red),
//                 onPressed: widget.onRemove,
//               ),
//             ],
//           ),
//           SizedBox(
//               height: MediaQuery.of(context).size.height / 20),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'College/University',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     CustomTextFieldRegister(
//                       // controller:  TextEditingController(
//                       //      text: snapshot.data!.college.toString()),
//                       controller: collegeuniversity,
//                       hintText: 'Enter Text',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       height: 32,
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             30),
//                     Text(
//                       'Graduate',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: CustomRadioListTile(
//                               title: 'Yes',
//                               value: 'Yes',
//                               groupValue: graduatetype,
//                               onChanged: (value) {
//                                 setState(() {
//                                   graduatetype = value;
//                                 });
//                               },
//                             )),
//                         Expanded(
//                           child: CustomRadioListTile(
//                             title: 'No',
//                             value: 'No',
//                             groupValue: graduatetype,
//                             onChanged: (value) {
//                               setState(() {
//                                 graduatetype = value;
//                               });
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             30),
//                     Text(
//                       'Degree',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     FutureBuilder<List<AEClinicalDiscipline>>(
//                       future: HrAddEmplyClinicalDisciplinApi(context, 1),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Shimmer.fromColors(
//                             baseColor: Colors.grey[300]!,
//                             highlightColor: Colors.grey[100]!,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 7),
//                               child: Container(
//                                 width: AppSize.s250,
//                                 height: AppSize.s40,
//                                 decoration: BoxDecoration(
//                                     color: ColorManager.faintGrey),
//                               ),
//                             ),
//                           );
//                         }
//                         if (snapshot.hasData) {
//                           List<String> dropDownList = [];
//
//                           for (var i in snapshot.data!) {
//                             if (i.empType != null) {
//                               dropDownList.add(i.empType!);
//                               //print("Country: $ctlrCountry");
//                             }
//                           }
//                           return SizedBox(
//                             height: 32,
//                             child: DropdownButtonFormField<String>(
//                               decoration: InputDecoration(
//                                 // hintText: 'Select Clinician',
//                                 hintStyle: GoogleFonts.firaSans(
//                                   fontSize: 10.0,
//                                   fontWeight: FontWeight.w400,
//                                   color: const Color(0xff9B9B9B),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(4.0),
//                                   borderSide:
//                                   const BorderSide(color: Colors.grey),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   //   //  vertical: 5,
//                                     horizontal: 12),
//                               ),
//                               // value: selectedCountry,
//                               icon: Icon(Icons.arrow_drop_down,
//                                   color: Color(0xff9B9B9B)),
//                               iconSize: 24,
//                               elevation: 16,
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 10.0,
//                                 fontWeight: FontWeight.w400,
//                                 color: const Color(0xff686464),
//                               ),
//
//                               onChanged: (newValue) {
//                                 for (var a in snapshot.data!) {
//                                   if (a.empType == newValue) {
//                                     selectedDegree =a.empType!;
//                                     //country = a
//                                     // int? docType = a.companyOfficeID;
//                                   }
//                                 }
//                               },
//                               items: dropDownList.map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(
//                                     value,
//                                     style: GoogleFonts.firaSans(
//                                       fontSize: 12,
//                                       color: Color(0xff575757),
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           );
//                         } else {
//                           return const Offstage();
//                         }
//                       },
//                     ),
//
//
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             30),
//                     Text(
//                       'Major Subject',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     CustomTextFieldRegister(
//                       controller: majorsubject,
//                       hintText: 'Enter Text',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       height: 32,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                   width: MediaQuery.of(context).size.width / 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Phone ',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     CustomTextFieldRegister(
//                       controller: phone,
//                       hintText: 'Enter Text',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       height: 32,
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             30),
//                     Text(
//                       'City',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     CustomTextFieldRegister(
//                       controller: city,
//                       hintText: 'Enter Text',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       height: 32,
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             30),
//                     Text(
//                       'State',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     CustomTextFieldRegister(
//                       controller: state,
//                       hintText: 'Enter Text',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       height: 32,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//               height: MediaQuery.of(context).size.height / 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   'Upload your degree / certifications as a docx or pdf',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                   width: MediaQuery.of(context).size.width / 20),
//               ElevatedButton.icon(
//                 onPressed: () async {
//                   FilePickerResult? result =
//                   await FilePicker.platform.pickFiles();
//                   if (result != null) {
//                     try {
//                       Uint8List? bytes = result.files.first.bytes;
//                       XFile xFile = await convertBytesToXFile(
//                           bytes!, result.files.first.name);
//                       finalPath = result.files.first.bytes;
//                       setState(() {
//                         _fileNames.addAll(result.files
//                             .map((file) => file.name!));
//                         _loading = false;
//                       });
//                     } catch (e) {
//                       print(e);
//                     }
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff50B5E5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                 icon: Icon(Icons.upload, color: Colors.white),
//                 label: Text(
//                   'Upload File',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               _loading
//                   ? SizedBox(
//                 width: 25,
//                 height: 25,
//                 child: CircularProgressIndicator(
//                   color: ColorManager
//                       .blueprime, // Loader color
//                   // Loader size
//                 ),
//               )
//                   : _fileNames.isNotEmpty
//                   ? Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: _fileNames
//                     .map((fileName) => Padding(
//                   padding:
//                   const EdgeInsets.all(8.0),
//                   child: Text(
//                     'File picked: $fileName',
//                     style: GoogleFonts.firaSans(
//                         fontSize: 12.0,
//                         fontWeight:
//                         FontWeight.w400,
//                         color:
//                         Color(0xff686464)),
//                   ),
//                 ))
//                     .toList(),
//               )
//                   : SizedBox(),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 20),
//             ],
//           ),
//
//           const Divider(
//             color: Colors.grey,
//             thickness: 2,
//           )
//
//           ///upload document/ Display file names if picked
//         ],
//       ),
//     );
//   }
// }
//

// Container(
//   child: StreamBuilder<List<AEClinicalDiscipline>>(
//     stream: Degreestream
//         .stream, // Change this to a stream method
//     builder: (context, snapshot) {
//       if (snapshot.connectionState ==
//           ConnectionState.waiting) {
//         return Shimmer.fromColors(
//           baseColor: Colors.grey[300]!,
//           highlightColor: Colors.grey[100]!,
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 7),
//             child: Container(
//               width: AppSize.s250,
//               height: AppSize.s40,
//               decoration: BoxDecoration(
//                 color: ColorManager.faintGrey,
//               ),
//             ),
//           ),
//         );
//       }
//
//       if (snapshot.hasError) {
//         return Center(
//             child: Text('Error: ${snapshot.error}'));
//       }
//
//       if (snapshot.hasData) {
//         List<String> dropDownList = [];
//
//         for (var i in snapshot.data!) {
//           if (i.empType != null) {
//             dropDownList.add(i.empType!);
//           }
//         }
//
//         return SizedBox(
//           height: 32,
//           child: DropdownButtonFormField<String>(
//             decoration: InputDecoration(
//               hintStyle: GoogleFonts.firaSans(
//                 fontSize: 10.0,
//                 fontWeight: FontWeight.w400,
//                 color: const Color(0xff9B9B9B),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4.0),
//                 borderSide:
//                     const BorderSide(color: Colors.grey),
//               ),
//               contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 12),
//             ),
//             icon: Icon(Icons.arrow_drop_down,
//                 color: Color(0xff9B9B9B)),
//             iconSize: 24,
//             elevation: 16,
//             style: GoogleFonts.firaSans(
//               fontSize: 10.0,
//               fontWeight: FontWeight.w400,
//               color: const Color(0xff686464),
//             ),
//             onChanged: (newValue) {
//               for (var a in snapshot.data!) {
//                 if (a.empType == newValue) {
//                   selectedDegree = a.empType!;
//                 }
//               }
//             },
//             items: dropDownList.map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(
//                   value,
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     color: Color(0xff575757),
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         );
//       } else {
//         return const Offstage();
//       }
//     },
//   ),
// ),

// Container(
//   height: 32,
//   child: DropdownButtonFormField<String>(
//     decoration: InputDecoration(
//       // hintText: 'Select Degree',
//       hintStyle: GoogleFonts.firaSans(
//         fontSize: 10.0,
//         fontWeight: FontWeight.w400,
//         color: Color(0xff9B9B9B),
//       ),
//       border: OutlineInputBorder(
//         borderRadius:
//             BorderRadius.circular(4.0),
//         borderSide:
//             BorderSide(color: Colors.grey),
//       ),
//       contentPadding: EdgeInsets.symmetric(
//           vertical: 10, horizontal: 10),
//     ),
//     value: selectedDegree,
//     icon: Icon(Icons.arrow_drop_down,
//         color: Color(0xff9B9B9B)),
//     iconSize: 24,
//     elevation: 16,
//     style: GoogleFonts.firaSans(
//       fontSize: 10.0,
//       fontWeight: FontWeight.w400,
//       color: Color(0xff686464),
//     ),
//     onChanged: (String? newValue) {
//       setState(() {
//         selectedDegree = newValue;
//       });
//     },
//     items: <String>[
//       'Degee',
//       'Deree',
//       'Dgree',
//       'Degre'
//     ] // List of countries
//         .map<DropdownMenuItem<String>>(
//             (String value) {
//       return DropdownMenuItem<String>(
//         value: value,
//         child: Text(value),
//       );
//     }).toList(),
//   ),
// ),

// save

//
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// ElevatedButton(
// onPressed: () {
// setState(() {
// _isEditing = !_isEditing; // Toggle edit mode
// });
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xff50B5E5),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8.0),
// ),
// ),
// child: Text(
// _isEditing ? "Save" : "Edit",
// style: GoogleFonts.firaSans(
// fontSize: 14.0,
// fontWeight: FontWeight.w500,
// color: Colors.white,
// ),
// ),
// )
// ],
// ),

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
// class EducationScreen extends StatefulWidget {
//   final int employeeID;
//
//   EducationScreen({super.key, required this.employeeID, required this.context});
//   final BuildContext context;
//
//   @override
//   EducationScreenState createState() => EducationScreenState();
// }
//
// class EducationScreenState extends State<EducationScreen> {
//   Future<List<EducationDataForm>>? educationDataFuture;
//   List<List<TextEditingController>> _controllers = [];
//   List<String> selectedDegrees = [];
//   List<String> _graduateTypes = [];
//   final List<List<String>> _fileNames = []; // List of file names per index
//   final List<bool> _loadingStates = []; //
//
//   List<List<TextEditingController>> _newControllers = []; // Track new forms
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     educationDataFuture = getEmployeeEducationForm(context, widget.employeeID);
//     // Initialize with one empty form
//     _addNewForm();
//
//   }
//
//   @override
//   void dispose() {
//     // Dispose of all controllers
//     for (var formControllers in _controllers) {
//       for (var controller in formControllers) {
//         controller.dispose();
//       }
//     }
//     for (var formControllers in _newControllers) {
//       for (var controller in formControllers) {
//         controller.dispose();
//       }
//     }
//
//     super.dispose();
//   }
//
//   void _addNewForm() {
//     setState(() {
//       _controllers.add([
//         TextEditingController(),
//         TextEditingController(),
//         TextEditingController(),
//         TextEditingController(),
//         TextEditingController(),
//       ]);
//       selectedDegrees.add('');
//       _graduateTypes.add('');
//
//       // Add a new empty form to track new data
//       _newControllers.add([
//         TextEditingController(),
//         TextEditingController(),
//         TextEditingController(),
//         TextEditingController(),
//         TextEditingController(),
//       ]);
//     });
//   }
//
//   void _removeForm(int index) {
//     setState(() {
//       // Dispose controllers
//       for (var controller in _controllers[index]) {
//         controller.dispose();
//       }
//       _controllers.removeAt(index);
//       selectedDegrees.removeAt(index);
//       _graduateTypes.removeAt(index);
//     });
//   }
//
//   Future<XFile> convertBytesToXFile(Uint8List bytes, String fileName) async {
//     final blob = html.Blob([bytes]);
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final file = html.File([blob], fileName);
//     return XFile(url);
//   }
//
//   bool _documentUploaded = true;
//   var fileName;
//   var fileName1;
//   dynamic? filePath;
//   File? xfileToFile;
//   var finalPath;
//
//   //List<String> _fileNames = [];
//   bool _loading = false;
//
//   Future<void> _saveNewForms() async {
//     // Prepare a list to collect futures for saving education data
//     List<Future<void>> saveFutures = [];
//
//     for (int i = 0; i < _newControllers.length; i++) {
//       var controllers = _newControllers[i];
//       String graduateType = _graduateTypes[i];
//       String selectedDegree = selectedDegrees[i];
//
//       // Extract data from controllers
//       String majorSubject = controllers[1].text;
//       String city = controllers[2].text;
//       String collegeUniversity = controllers[3].text;
//       String phone = controllers[4].text;
//       String state = controllers[5].text;
//
//       // Print extracted values for debugging
//       print('Saving education data for form $i:');
//       print('Major Subject: $majorSubject');
//       print('City: $city');
//       print('College/University: $collegeUniversity');
//       print('Phone: $phone');
//       //print('State: $state');
//
//
//
//     //  // Call API and add future to list
//           try {
//             saveFutures.add(postEducationScreenForm(
//               context,
//               widget.employeeID,
//               graduateType,
//               selectedDegree,
//               majorSubject,
//               city,
//               collegeUniversity,
//               phone,
//               state,
//               "USA",
//               "2024-08-09",
//             ));
//           } catch (e) {
//             print('Error adding future for form $i: $e');
//           }
//         }
//
//
//     // Wait for all education data save futures to complete
//     try {
//       await Future.wait(saveFutures);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('All new education data saved successfully')),
//       );
//
//       // Check if a document is selected
//       if (finalPath == null || finalPath.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('No file selected. Please select a file to upload.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       } else {
//         // Upload the document
//         await uploadDocuments(
//           context: context,
//           employeeDocumentMetaId: 10,
//           employeeDocumentTypeSetupId: 48,
//           employeeId: widget.employeeID,
//           documentFile: finalPath,
//           documentName: 'education data',
//         );
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Document uploaded successfully!'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     } catch (error) {
//       print('Error in saving new education data or uploading document: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error saving new education data: $error')),
//       );
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<EducationDataForm>>(
//       future: educationDataFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 150),
//               child: CircularProgressIndicator(
//                 color: Color(0xff50B5E5),
//               ),
//             ),
//           );
//         }
//
//         if (snapshot.hasError) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 150),
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//           );
//         }
//
//         if (snapshot.hasData) {
//           List<EducationDataForm>? data = snapshot.data;
//
//           // Update the existing controllers with data
//           for (int i = 0; i < data!.length; i++) {
//             if (i < _controllers.length) {
//               _controllers[i][0].text = data[i].college!;
//               _controllers[i][1].text = data[i].major!;
//               _controllers[i][2].text = data[i].phone!;
//               _controllers[i][3].text = data[i].city!;
//               _controllers[i][4].text = data[i].state!;
//               selectedDegrees[i] = data[i].degree!.toString();
//               _graduateTypes[i] = data[i].graduate!.toString();
//             }
//           }
//
//           return Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height / 1,
//                 width: MediaQuery.of(context).size.width / 1,
//                 child: ListView.builder(
//                   itemCount: _controllers.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 160, right: 160),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Education #${index + 1}',
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.w700,
//                                   color: Color(0xff686464),
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.remove_circle,
//                                     color: Colors.red),
//                                 onPressed: () {
//                                   if (_controllers.length > 1) {
//                                     _removeForm(index);
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                               height: MediaQuery.of(context).size.height / 20),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'College/University',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff686464),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 60),
//                                     CustomTextFieldRegister(
//                                       controller: _controllers[index][0],
//                                       hintText: 'Enter Text',
//                                       hintStyle: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff9B9B9B),
//                                       ),
//                                       height: 32,
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 30),
//                                     Text(
//                                       'Graduate',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff686464),
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: CustomRadioListTile(
//                                             title: 'Yes',
//                                             value: 'Yes',
//                                             groupValue: _graduateTypes[index],
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 _graduateTypes[index] = value!;
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: CustomRadioListTile(
//                                             title: 'No',
//                                             value: 'No',
//                                             groupValue: _graduateTypes[index],
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 _graduateTypes[index] = value!;
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 30),
//                                     Text(
//                                       'Degree',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff686464),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 60),
//
//                                     // Dropdown for Degree
//                                     Container(
//                                       child: FutureBuilder<List<EduactionDegree>>(
//                                         future:  HrEmplyDegreedropdown(context),// Change this to a stream method
//                                         builder: (context, snapshot) {
//                                           if (snapshot.connectionState ==
//                                               ConnectionState.waiting) {
//                                             return Shimmer.fromColors(
//                                               baseColor: Colors.grey[300]!,
//                                               highlightColor: Colors.grey[100]!,
//                                               child: Padding(
//                                                 padding:
//                                                 const EdgeInsets.symmetric(horizontal: 7),
//                                                 child: Container(
//                                                   width: AppSize.s250,
//                                                   height: AppSize.s40,
//                                                   decoration: BoxDecoration(
//                                                     color: ColorManager.faintGrey,
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           }
//
//                                           if (snapshot.hasError) {
//                                             return Center(
//                                                 child: Text('Error: ${snapshot.error}'));
//                                           }
//
//                                           if (snapshot.hasData) {
//                                             List<String> dropDownList = [];
//
//                                             for (var i in snapshot.data!) {
//                                               if (i.degree != null) {
//                                                 dropDownList.add(i.degree!);
//                                               }
//                                             }
//
//                                             return SizedBox(
//                                               height: 32,
//                                               child: DropdownButtonFormField<String>(
//                                                 decoration: InputDecoration(
//                                                   hintStyle: GoogleFonts.firaSans(
//                                                     fontSize: 10.0,
//                                                     fontWeight: FontWeight.w400,
//                                                     color: const Color(0xff9B9B9B),
//                                                   ),
//                                                   border: OutlineInputBorder(
//                                                     borderRadius: BorderRadius.circular(4.0),
//                                                     borderSide:
//                                                     const BorderSide(color: Colors.grey),
//                                                   ),
//                                                   contentPadding: const EdgeInsets.symmetric(
//                                                       horizontal: 12),
//                                                 ),
//                                                 icon: Icon(Icons.arrow_drop_down,
//                                                     color: Color(0xff9B9B9B)),
//                                                 iconSize: 24,
//                                                 elevation: 16,
//                                                 style: GoogleFonts.firaSans(
//                                                   fontSize: 10.0,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: const Color(0xff686464),
//                                                 ),
//                                                 onChanged: (newValue) {
//                                                   for (var a in snapshot.data!) {
//                                                     if (a.degree == newValue) {
//                                                       selectedDegrees.add(a.degree!);
//                                                     }
//                                                   }
//                                                 },
//                                                 items: dropDownList.map((String value) {
//                                                   return DropdownMenuItem<String>(
//                                                     value: value,
//                                                     child: Text(
//                                                       value,
//                                                       style: GoogleFonts.firaSans(
//                                                         fontSize: 12,
//                                                         color: Color(0xff575757),
//                                                         fontWeight: FontWeight.w400,
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }).toList(),
//                                               ),
//                                             );
//                                           } else {
//                                             return const Offstage();
//                                           }
//                                         },
//                                       ),
//                                     ),
//
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 30),
//                                     Text(
//                                       'Major Subject',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff686464),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 60),
//                                     CustomTextFieldRegister(
//                                       controller: _controllers[index][1],
//                                       hintText: 'Enter Text',
//                                       hintStyle: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff9B9B9B),
//                                       ),
//                                       height: 32,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width / 15),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Phone',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff686464),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 60),
//                                     CustomTextFieldRegister(
//                                       controller: _controllers[index][2],
//                                       hintText: 'Enter Text',
//                                       hintStyle: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff9B9B9B),
//                                       ),
//                                       height: 32,
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 30),
//                                     Text(
//                                       'City',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff686464),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 60),
//                                     CustomTextFieldRegister(
//                                       controller: _controllers[index][3],
//                                       hintText: 'Enter Text',
//                                       hintStyle: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff9B9B9B),
//                                       ),
//                                       height: 32,
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 30),
//                                     Text(
//                                       'State',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff686464),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height /
//                                                 60),
//                                     CustomTextFieldRegister(
//                                       controller: _controllers[index][4],
//                                       hintText: 'Enter Text',
//                                       hintStyle: GoogleFonts.firaSans(
//                                         fontSize: 10.0,
//                                         fontWeight: FontWeight.w400,
//                                         color: Color(0xff9B9B9B),
//                                       ),
//                                       height: 32,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                               height: MediaQuery.of(context).size.height / 30),
//                           SizedBox(
//                               height: MediaQuery.of(context).size.height / 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   'Upload your degree / certifications as a docx or pdf',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 14.0,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width / 20),
//                               ElevatedButton.icon(
//                                 onPressed: () async {
//                                   setState(() {
//                                     _loadingStates[index] = true;
//                                   });
//                                   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                                   if (result != null) {
//                                     try {
//                                       Uint8List? bytes = result.files.first.bytes;
//                                       XFile xFile = await convertBytesToXFile(bytes!, result.files.first.name);
//                                       setState(() {
//                                         _fileNames[index].add(result.files.first.name!);
//                                         _loadingStates[index] = false;
//                                       });
//                                     } catch (e) {
//                                       print(e);
//                                       setState(() {
//                                         _loadingStates[index] = false;
//                                       });
//                                     }
//                                   } else {
//                                     setState(() {
//                                       _loadingStates[index] = false;
//                                     });
//                                   }
//
//                                   //
//                                   // FilePickerResult? result =
//                                   //     await FilePicker.platform.pickFiles();
//                                   // if (result != null) {
//                                   //   try {
//                                   //     Uint8List? bytes =
//                                   //         result.files.first.bytes;
//                                   //     XFile xFile = await convertBytesToXFile(
//                                   //         bytes!, result.files.first.name);
//                                   //     finalPath = result.files.first.bytes;
//                                   //     setState(() {
//                                   //       _fileNames.addAll(result.files
//                                   //           .map((file) => file.name!));
//                                   //       _loading = false;
//                                   //     });
//                                   //   } catch (e) {
//                                   //     print(e);
//                                   //   }
//                                   // }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Color(0xff50B5E5),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8.0),
//                                   ),
//                                 ),
//                                 icon: Icon(Icons.upload, color: Colors.white),
//                                 label: Text(
//                                   'Upload File',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 14.0,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               _loading
//                                   ? SizedBox(
//                                       width: 25,
//                                       height: 25,
//                                       child: CircularProgressIndicator(
//                                         color: ColorManager
//                                             .blueprime, // Loader color
//                                         // Loader size
//                                       ),
//                                     )
//                                   : _fileNames.isNotEmpty
//                                       ? Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: _fileNames
//                                               .map((fileName) => Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Text(
//                                                       'File picked: $fileName',
//                                                       style:
//                                                           GoogleFonts.firaSans(
//                                                               fontSize: 12.0,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               color: Color(
//                                                                   0xff686464)),
//                                                     ),
//                                                   ))
//                                               .toList(),
//                                         )
//                                       : SizedBox(),
//                               SizedBox(
//                                   height:
//                                       MediaQuery.of(context).size.height / 20),
//                             ],
//                           ),
//                           const Divider(
//                             color: Colors.grey,
//                             thickness: 2,
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.only(left: 150),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     ElevatedButton.icon(
//                       onPressed: _addNewForm,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xff50B5E5),
//                         // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       icon: Icon(Icons.add, color: Colors.white),
//                       label: Text(
//                         'Add Education',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CustomButton(
//                     width: 117,
//                     height: 30,
//                     text: 'Save',
//                     style: TextStyle(
//                       fontFamily: 'FiraSans',
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     borderRadius: 12,
//                     onPressed: _saveNewForms,
//
//                     child: Text(
//                       'Save',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12.0,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               // ElevatedButton(
//               //   onPressed: _addNewForm,
//               //   child: Text('Add New Education'),
//               // ),
//               // ElevatedButton(
//               //   onPressed: _saveNewForms,
//               //   child: Text('Save New Education'),
//               // ),
//             ],
//           );
//         } else {
//           return Center(child: Text('No data available'));
//         }
//       },
//     );
//   }
// }
//
// // Mock function to save new education forms, replace with actual implementation
// Future<void> saveNewEducationForms(List<EducationDataForm> newForms) async {
//   // Implement the logic to save the new education forms
//   // This is a placeholder for demonstration
//   await Future.delayed(Duration(seconds: 1));
// }



//
// class EducationScreen extends StatefulWidget {
//   final int employeeID;
//
//
//
//
//
//   EducationScreen({super.key, required this.context,required this.employeeID,});
//   final BuildContext context;
//
//   @override
//   EducationScreenState createState() => EducationScreenState();
// }

// class EducationScreenState extends State<EducationScreen> {
//   late Future<List<EducationDataForm>> _educationDataFuture;
//   List<TextEditingController> _collegeUniversityControllers = [];
//   List<TextEditingController> _majorSubjectControllers = [];
//   List<TextEditingController> _phoneControllers = [];
//   List<TextEditingController> _cityControllers = [];
//   List<TextEditingController> _stateControllers = [];
//   List<String> _selectedDegrees = [];
//   List<String> _graduateTypes = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _educationDataFuture = getEmployeeEducationForm(context, widget.employeeID);
//   }
//
//   @override
//   void dispose() {
//     // Dispose of all controllers
//     for (var controller in _collegeUniversityControllers) controller.dispose();
//     for (var controller in _majorSubjectControllers) controller.dispose();
//     for (var controller in _phoneControllers) controller.dispose();
//     for (var controller in _cityControllers) controller.dispose();
//     for (var controller in _stateControllers) controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<EducationDataForm>>(
//       future: _educationDataFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 150),
//               child: CircularProgressIndicator(
//                 color: Color(0xff50B5E5),
//               ),
//             ),
//           );
//         }
//
//         if (snapshot.hasError) {
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 150),
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//           );
//         }
//
//         if (snapshot.hasData) {
//           List<EducationDataForm>? data = snapshot.data;
//
//           // Create controllers for each form field based on fetched data
//           _collegeUniversityControllers = data!.map((education) => TextEditingController(text: education.college)).toList();
//           _majorSubjectControllers = data.map((education) => TextEditingController(text: education.major)).toList();
//           _phoneControllers = data.map((education) => TextEditingController(text: education.phone)).toList();
//           _cityControllers = data.map((education) => TextEditingController(text: education.city)).toList();
//           _stateControllers = data.map((education) => TextEditingController(text: education.state)).toList();
//           _selectedDegrees = data.map((education) => education.degree.toString()).toList();
//           _graduateTypes = data.map((education) => education.graduate.toString()).toList();
//
//           return Container(
//             height: MediaQuery.of(context).size.height/1,
//             width: MediaQuery.of(context).size.width/1,
//             child: ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 160, right: 160),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Education #${index + 1}',
//                             style: GoogleFonts.firaSans(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xff686464),
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.edit, color: Colors.blue),
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height / 20),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'College/University',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                                 CustomTextFieldRegister(
//                                   controller: _collegeUniversityControllers[index],
//                                   hintText: 'Enter Text',
//                                   hintStyle: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff9B9B9B),
//                                   ),
//                                   height: 32,
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 30),
//                                 Text(
//                                   'Graduate',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: CustomRadioListTile(
//                                         title: 'Yes',
//                                         value: 'Yes',
//                                         groupValue: _graduateTypes[index],
//                                         onChanged: (value) {
//                                           setState(() {
//                                             _graduateTypes[index] = value!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: CustomRadioListTile(
//                                         title: 'No',
//                                         value: 'No',
//                                         groupValue: _graduateTypes[index],
//                                         onChanged: (value) {
//                                           setState(() {
//                                             _graduateTypes[index] = value!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 30),
//                                 Text(
//                                   'Degree',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                                 FutureBuilder<List<EduactionDegree>>(
//                                   future: HrEmplyDegreedropdown(context),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState == ConnectionState.waiting) {
//                                       return Shimmer.fromColors(
//                                         baseColor: Colors.grey[300]!,
//                                         highlightColor: Colors.grey[100]!,
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 7),
//                                           child: Container(
//                                             width: AppSize.s250,
//                                             height: AppSize.s40,
//                                             decoration: BoxDecoration(
//                                               color: ColorManager.faintGrey,
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     }
//
//                                     if (snapshot.hasError) {
//                                       return Center(child: Text('Error: ${snapshot.error}'));
//                                     }
//
//                                     if (snapshot.hasData) {
//                                       List<String> dropDownList = snapshot.data!
//                                           .map((e) => e.degree ?? '')
//                                           .toList();
//
//                                       return SizedBox(
//                                         height: 32,
//                                         child: DropdownButtonFormField<String>(
//                                           decoration: InputDecoration(
//                                             hintStyle: GoogleFonts.firaSans(
//                                               fontSize: 10.0,
//                                               fontWeight: FontWeight.w400,
//                                               color: const Color(0xff9B9B9B),
//                                             ),
//                                             border: OutlineInputBorder(
//                                               borderRadius: BorderRadius.circular(4.0),
//                                               borderSide: const BorderSide(color: Colors.grey),
//                                             ),
//                                             contentPadding: const EdgeInsets.symmetric(horizontal: 12),
//                                           ),
//                                           icon: Icon(Icons.arrow_drop_down, color: Color(0xff9B9B9B)),
//                                           iconSize: 24,
//                                           elevation: 16,
//                                           style: GoogleFonts.firaSans(
//                                             fontSize: 10.0,
//                                             fontWeight: FontWeight.w400,
//                                             color: const Color(0xff686464),
//                                           ),
//                                           onChanged: (newValue) {
//                                             setState(() {
//                                               _selectedDegrees[index] = newValue ?? '';
//                                             });
//                                           },
//                                           items: dropDownList.map((String value) {
//                                             return DropdownMenuItem<String>(
//                                               value: value,
//                                               child: Text(
//                                                 value,
//                                                 style: GoogleFonts.firaSans(
//                                                   fontSize: 12,
//                                                   color: Color(0xff575757),
//                                                   fontWeight: FontWeight.w400,
//                                                 ),
//                                               ),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       );
//                                     } else {
//                                       return const Offstage();
//                                     }
//                                   },
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 30),
//                                 Text(
//                                   'Major Subject',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                                 CustomTextFieldRegister(
//                                   controller: _majorSubjectControllers[index],
//                                   hintText: 'Enter Text',
//                                   hintStyle: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff9B9B9B),
//                                   ),
//                                   height: 32,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: MediaQuery.of(context).size.width / 15),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Phone',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                                 CustomTextFieldRegister(
//                                   controller: _phoneControllers[index],
//                                   hintText: 'Enter Text',
//                                   hintStyle: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff9B9B9B),
//                                   ),
//                                   height: 32,
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 30),
//                                 Text(
//                                   'City',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                                 CustomTextFieldRegister(
//                                   controller: _cityControllers[index],
//                                   hintText: 'Enter Text',
//                                   hintStyle: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff9B9B9B),
//                                   ),
//                                   height: 32,
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 30),
//                                 Text(
//                                   'State',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                                 CustomTextFieldRegister(
//                                   controller: _stateControllers[index],
//                                   hintText: 'Enter Text',
//                                   hintStyle: GoogleFonts.firaSans(
//                                     fontSize: 10.0,
//                                     fontWeight: FontWeight.w400,
//                                     color: Color(0xff9B9B9B),
//                                   ),
//                                   height: 32,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height / 30),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         } else {
//           return Center(child: Text('No data available'));
//         }
//       },
//     );
//   }
// }