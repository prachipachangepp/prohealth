import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_employment_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../taxtfield_constant.dart';



///
class Employment_screen extends StatefulWidget {
  const Employment_screen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<Employment_screen> createState() => _Employment_screenState();
}

class _Employment_screenState extends State<Employment_screen> {
  double textFieldWidth = 430;
  double textFieldHeight = 38;

  TextEditingController firstName = TextEditingController();

  int _currentStep = 0;

  bool isChecked = false;

  dynamic? filePath;

  var finalPath;

  bool get isFirstStep => _currentStep == 0;

  bool isCompleted = false;

  TextEditingController finalposition = TextEditingController();
  TextEditingController employer = TextEditingController();
  TextEditingController rforleaving = TextEditingController();
  TextEditingController lSupervisorName = TextEditingController();
  TextEditingController supervisormobnum = TextEditingController();
  TextEditingController city = TextEditingController();

  List<GlobalKey<_EmploymentFormState>> employmentFormKeys = [];


  @override
  void initState() {
    super.initState();
    addEmploymentForm();
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

  Future<void> postEmploymentScreenData(
      BuildContext context,
      int id,
      String employer,
      String city,
      String reasonForLeaving,
      String supervisorName,
      String supervisorMobileNumber,
      String finalPosition,
      String startDate,
      String endDate,
      ) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Employment data saved")),
    );
  }
  Future<void> uploadDocuments({
    required BuildContext context,
    required int employeeDocumentMetaId,
    required int employeeDocumentTypeSetupId,
    required int employeeId,
    required dynamic documentFile,
    required String documentName,
  }) async {

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
                  onPressed: addEmploymentForm,
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
                    await postEmploymentScreenData(
                      context,
                      15,
                      state.employerController.text,
                      state.cityController.text,
                      state.reasonForLeavingController.text,
                      state.supervisorNameController.text,
                      state.supervisorMobileNumberController.text,
                      state.finalPositionController.text,
                      state.startDateController.text,
                      state.isChecked ? 'Present' : state.endDateController.text,
                    );
                    if (state.finalPath == null || state.finalPath.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('No file selected. Please select a file to upload.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      try {
                        await uploadDocuments(
                          context: context,
                          employeeDocumentMetaId: 10,
                          employeeDocumentTypeSetupId: 48,
                          employeeId: 2,
                          documentFile: state.finalPath,
                          documentName: 'Legal Document ID',
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
              ///

              // CustomButton(
              //   width: 117,
              //   height: 30,
              //   text: 'Save',
              //   style: TextStyle(
              //     fontFamily: 'FiraSans',
              //     fontSize: 12,
              //     fontWeight: FontWeight.w700,
              //   ),
              //   borderRadius: 12,
              //   onPressed: () async {
              //     // Loop through each form and extract data to post
              //     for (var key in employmentFormKeys) {
              //       final state = key.currentState!;
              //       await postemploymentscreen(
              //           context,
              //           15,
              //           state.employerController.text,
              //           state.cityController.text,
              //           state.reasonForLeavingController.text,
              //           state.supervisorNameController.text,
              //           state.supervisorMobileNumberController.text,
              //           state.finalPositionController.text,
              //           state.startDateController.text,
              //           isChecked ? 'Present' : state.endDateController.text);
              //     }
              //     for (var key in employmentFormKeys) {
              //       final state = key.currentState!;
              //       if (finalPath == null || finalPath.isEmpty) {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text(
              //                 'No file selected. Please select a file to upload.'),
              //             backgroundColor: Colors.red,
              //           ),
              //         );
              //       } else {
              //         try {
              //           await uploadDocuments(
              //               context: context,
              //               employeeDocumentMetaId: 10,
              //               employeeDocumentTypeSetupId: 48,
              //               employeeId: 2,
              //               documentFile: finalPath,
              //               documentName: 'Legal Document ID');
              //
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(
              //               content: Text('Document uploaded successfully!'),
              //               backgroundColor: Colors.green,
              //             ),
              //           );
              //         } catch (e) {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(
              //               content: Text('Failed to upload document: $e'),
              //               backgroundColor: Colors.red,
              //             ),
              //           );
              //         }
              //       }
              //     }
              //
              //     if (finalPath == null || finalPath.isEmpty) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(
              //           content: Text(
              //               'No file selected. Please select a file to upload.'),
              //           backgroundColor: Colors.red,
              //         ),
              //       );
              //     } else {
              //       try {
              //         await uploadDocuments(
              //             context: context,
              //             employeeDocumentMetaId: 10,
              //             employeeDocumentTypeSetupId: 48,
              //             employeeId: 2,
              //             documentFile: finalPath,
              //             documentName: 'Legal Document ID');
              //
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text('Document uploaded successfully!'),
              //             backgroundColor: Colors.green,
              //           ),
              //         );
              //       } catch (e) {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text('Failed to upload document: $e'),
              //             backgroundColor: Colors.red,
              //           ),
              //         );
              //       }
              //     }
              //
              //     //employerController.clear();
              //   },
              //   child: Text(
              //     'Save',
              //     style: GoogleFonts.firaSans(
              //       fontSize: 12.0,
              //       fontWeight: FontWeight.w700,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Emp old
class EmploymentForm extends StatefulWidget {
  final VoidCallback onRemove;
  final int index;
  EmploymentForm({Key? key, required this.onRemove, required this.index})
      : super(key: key);

  @override
  _EmploymentFormState createState() => _EmploymentFormState();
}

class _EmploymentFormState extends State<EmploymentForm> {
  TextEditingController employerController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController reasonForLeavingController = TextEditingController();
  TextEditingController supervisorNameController = TextEditingController();
  TextEditingController supervisorMobileNumberController =
      TextEditingController();
  TextEditingController finalPositionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool isChecked = false;

  List<String> _fileNames = [];
  bool _loading = false;

  // void _pickFiles() async {
  //   setState(() {
  //     _loading = true; // Show loader
  //     _fileNames.clear(); // Clear previous file names if any
  //   });
  //
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: true,
  //   );
  //
  //   if (result != null) {
  //     setState(() {
  //       _fileNames.addAll(result.files.map((file) => file.name!));
  //       _loading = false; // Hide loader
  //     });
  //     print('Files picked: $_fileNames');
  //   } else {
  //     setState(() {
  //       _loading = false; // Hide loader on cancel
  //     });
  //     print('User canceled the picker');
  //   }
  // }
  // Future<XFile> convertBytesToXFile(Uint8List bytes, String fileName) async {
  //   // Create a Blob from the bytes
  //   final blob = html.Blob([bytes]);
  //
  //   // Create an object URL from the Blob
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //
  //   // Create a File from the Blob
  //   final file = html.File([blob], fileName);
  //
  //   print("XFILE ${url}");
  //
  //   // Return the XFile created from the object URL
  //   return XFile(url);
  // }
  //
  // Future<Uint8List> loadFileBytes() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/somefile.txt');
  //   if (await file.exists()) {
  //     return await file.readAsBytes();
  //   } else {
  //     throw Exception('File not found');
  //   }
  // }

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
      padding: const EdgeInsets.only(left: 166.0, right: 166),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: widget.onRemove,
              ),
            ],
          ),
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
              SizedBox(width: MediaQuery.of(context).size.width / 20),
              ElevatedButton.icon(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    try {
                      Uint8List? bytes = result.files.first.bytes;
                      XFile xFile = await convertBytesToXFile(bytes!, result.files.first.name);
                      finalPath = result.files.first.bytes;
                      setState(() {
                        _fileNames.addAll(result.files.map((file) => file.name!));
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


              ///
              // ElevatedButton.icon(
              //   onPressed: () async {
              //     // FilePickerResult? result = await FilePicker.platform.pickFiles(
              //     //   allowMultiple: false,
              //     // );
              //     FilePickerResult? result =
              //         await FilePicker.platform.pickFiles();
              //     if (result != null) {
              //       print("Result::: ${result}");
              //
              //       try {
              //         Uint8List? bytes = result.files.first.bytes;
              //         XFile xlfile = XFile(result.xFiles.first.path);
              //         xfileToFile = File(xlfile.path);
              //
              //         print("::::XFile To File ${xfileToFile.toString()}");
              //         XFile xFile = await convertBytesToXFile(
              //             bytes!, result.xFiles.first.name);
              //         // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
              //         // html.File file = webFile.file;
              //         //  print("XFILE ${xFile.path}");
              //         //  //filePath = xfileToFile as XFile?;
              //         //  print("L::::::${filePath}");
              //         _fileNames.addAll(result.files.map((file) => file.name!));
              //         print('File picked: ${_fileNames}');
              //         //print(String.fromCharCodes(file));
              //         finalPath = result.files.first.bytes;
              //         setState(() {
              //           _fileNames;
              //           _documentUploaded = true;
              //         });
              //       } catch (e) {
              //         print(e);
              //       }
              //     }
              //   },
              //
              //   //_pickFiles,
              //   // onPressed: () async {
              //   //   FilePickerResult? result =
              //   //       await FilePicker.platform.pickFiles(
              //   //     allowMultiple: false,
              //   //   );
              //   //   if (result != null) {
              //   //     PlatformFile file = result.files.first;
              //   //     print('File picked: ${file.name}');
              //   //   } else {
              //   //     // User canceled the picker
              //   //   }
              //   // },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Color(0xff50B5E5),
              //     // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //     ),
              //   ),
              //   icon: Icon(Icons.file_upload_outlined, color: Colors.white),
              //   label: Text(
              //     'Upload Document',
              //     style: GoogleFonts.firaSans(
              //       fontSize: 14.0,
              //       fontWeight: FontWeight.w700,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // _loading
              //     ? SizedBox(
              //         width: 25,
              //         height: 25,
              //         child: CircularProgressIndicator(
              //           color: ColorManager.blueprime, // Loader color
              //           // Loader size
              //         ),
              //       )
              //     : _fileNames.isNotEmpty
              //         ? Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: _fileNames
              //                 .map((fileName) => Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Text(
              //                         'File picked: $fileName',
              //                         style: GoogleFonts.firaSans(
              //                             fontSize: 12.0,
              //                             fontWeight: FontWeight.w400,
              //                             color: Color(0xff686464)),
              //                       ),
              //                     ))
              //                 .toList(),
              //           )
              //         : SizedBox(), // Display file names if picked
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Column(
            children: [
              Text(
                'Employment #${widget.index}',
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
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Text(
                      'Final Position Title',
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: finalPositionController,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 40),
                    Text(
                      'Start Date',
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: startDateController,
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
                            startDateController.text =
                                "${pickedDate.toLocal()}".split(' ')[0];
                          }
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 40),
                    Text(
                      'End Date',
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: endDateController,
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
                          if (pickedDate != null || isChecked == true) {
                            endDateController.text =
                                "${pickedDate?.toLocal()}".split(' ')[0];
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
                              color: Color(0xff686464)),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 40),
                    Text(
                      'Employer',
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: employerController,
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
              SizedBox(width: MediaQuery.of(context).size.width / 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Text(
                    'Reason for Leaving',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: reasonForLeavingController,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff9B9B9B),
                    ),
                    height: 32,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Text(
                    'Last Supervisor’s Name',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: supervisorNameController,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff9B9B9B),
                    ),
                    height: 32,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Text(
                    'Supervisor’s Mobile Number',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: supervisorMobileNumberController,
                    hintText: 'Enter Text',
                    hintStyle: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff9B9B9B),
                    ),
                    height: 32,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Text(
                    'City',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomTextFieldRegister(
                    controller: cityController,
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
          const Divider(
            color: Colors.grey,
            thickness: 2,
          )
        ],
      ),
    );
  }
}




























///oldddd
// Padding(
//   padding: const EdgeInsets.only(left: 100,right: 100),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Employment #${widget.index}',
//             style: GoogleFonts.firaSans(
//               fontSize: 14.0,
//               fontWeight: FontWeight.w700,
//               color: Color(0xff686464),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.remove_circle, color: Colors.red),
//             onPressed: widget.onRemove,
//           ),
//         ],
//       ),
//       SizedBox(height: MediaQuery
//           .of(context)
//           .size
//           .height / 20),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Final Position Title',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 60),
//                 TextField(
//                   controller: finalPositionController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 40),
//                 Text(
//                   'Start Date',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 60),
//                 TextField(
//                   controller: startDateController,
//                   decoration: InputDecoration(
//                     hintText: 'dd-mm-yyyy',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         Icons.calendar_month_outlined,
//                         color: Color(0xff50B5E5),
//                         size: 16,
//                       ),
//                       onPressed: () async {
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2101),
//                         );
//                         if (pickedDate != null) {
//                           startDateController.text =
//                           "${pickedDate.toLocal()}".split(' ')[0];
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 40),
//                 Text(
//                   'End Date',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 60),
//                 TextField(
//                   controller: endDateController,
//                   decoration: InputDecoration(
//                     hintText: 'dd-mm-yyyy',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                     suffixIcon: IconButton(
//                       icon: const Icon(
//                         Icons.calendar_month_outlined,
//                         color: Color(0xff50B5E5),
//                         size: 16,
//                       ),
//                       onPressed: () async {
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2101),
//                         );
//                         if (pickedDate != null) {
//                           endDateController.text =
//                           "${pickedDate.toLocal()}".split(' ')[0];
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: MediaQuery
//               .of(context)
//               .size
//               .width / 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Employer Name',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 60),
//                 TextField(
//                   controller: employerController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 40),
//                 Text(
//                   'City/State',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 60),
//                 TextField(
//                   controller: cityController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 40),
//                 Text(
//                   'Reason for Leaving',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 60),
//                 TextField(
//                   controller: reasonForLeavingController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       SizedBox(height: MediaQuery
//           .of(context)
//           .size
//           .height / 40),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Supervisor Name',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 60),
//                 TextField(
//                   controller: supervisorNameController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: MediaQuery
//               .of(context)
//               .size
//               .width / 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Supervisor Mobile Number',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height / 60),
//                 TextField(
//                   controller: supervisorMobileNumberController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       SizedBox(height: MediaQuery
//           .of(context)
//           .size
//           .height / 40),
//       Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 Checkbox(
//                   value: isChecked,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       isChecked = value ?? false;
//                     });
//                   },
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Please check this box if you do not want us to contact your employer.',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       const Divider(color: Colors.grey,thickness: 2,)
//     ],
//   ),
// );
/////////////////////////////////////
/////////////////////
//////////
///
//   Container(
//   child: Column(
//     children: [
//       Center(
//         child: Text(
//           'Employment',
//           style: GoogleFonts.firaSans(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Color(0xff50B5E5)),
//         ),
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height / 60),
//       Container(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: Color(0xFFE6F7FF),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(
//           'Your personal details will be required to proceed through the recruitment process.',
//           style: GoogleFonts.firaSans(
//             color: Color(0xFF686464),
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height / 20),
//       Padding(
//         padding: const EdgeInsets.only(left: 166.0, right: 166),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Upload your resume as a docx or pdf with a maximum size of 2 mb',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xff686464),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width / 20),
//                 ElevatedButton.icon(
//                   onPressed: _pickFiles,
//                   // onPressed: () async {
//                   //   FilePickerResult? result =
//                   //       await FilePicker.platform.pickFiles(
//                   //     allowMultiple: false,
//                   //   );
//                   //   if (result != null) {
//                   //     PlatformFile file = result.files.first;
//                   //     print('File picked: ${file.name}');
//                   //   } else {
//                   //     // User canceled the picker
//                   //   }
//                   // },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff50B5E5),
//                     // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   icon: Icon(Icons.file_upload_outlined,
//                       color: Colors.white),
//                   label: Text(
//                     'Upload Document',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 _loading
//                     ? SizedBox(width: 25,
//                   height: 25,
//                   child: CircularProgressIndicator(
//                     color: ColorManager.blueprime, // Loader color
//                     // Loader size
//                   ),
//                 )
//                     : _fileNames.isNotEmpty
//                     ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: _fileNames
//                       .map((fileName) => Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'File picked: $fileName',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                   ))
//                       .toList(),
//                 )
//                     : SizedBox(), // Display file names if picked
//
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 30),
//             Column(
//               children: [
//                 Text(
//                   'Employment #1',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xff686464)),
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 20),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               30),
//                       Text(
//                         'Final Position Title',
//                         style: GoogleFonts.firaSans(
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff686464)),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               60),
//                       CustomTextFieldRegister(
//                        controller: finalposition,
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         height: 32,
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               40),
//                       Text(
//                         'Start Date',
//                         style: GoogleFonts.firaSans(
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff686464)),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               60),
//                       CustomTextFieldRegister(
//                         controller: _controllersod,
//                         hintText: 'dd-mm-yyyy',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         height: 32,
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             Icons.calendar_month_outlined,
//                             color: Color(0xff50B5E5),
//                             size: 16,
//                           ),
//                           onPressed: () async {
//                             DateTime? pickedDate =
//                                 await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2101),
//                             );
//                             if (pickedDate != null) {
//                               _controllersod.text =
//                                   "${pickedDate.toLocal()}"
//                                       .split(' ')[0];
//                             }
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               40),
//                       Text(
//                         'End Date',
//                         style: GoogleFonts.firaSans(
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff686464)),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               60),
//                       CustomTextFieldRegister(
//                         controller: _controllereod,
//                         hintText: 'dd-mm-yyyy',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         height: 32,
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             Icons.calendar_month_outlined,
//                             color: Color(0xff50B5E5),
//                             size: 16,
//                           ),
//                           onPressed: () async {
//                             DateTime? pickedDate =
//                                 await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2101),
//                             );
//                             if (pickedDate != null) {
//                               _controllereod.text =
//                                   "${pickedDate.toLocal()}"
//                                       .split(' ')[0];
//                             }
//                           },
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Checkbox(
//                             activeColor: Color(0xff50B5E5),
//                             value: isChecked,
//                             onChanged: (bool? value) {
//                               setState(() {
//                                 isChecked = value!;
//                               });
//                             },
//                           ),
//                           Text(
//                             'Currently work here',
//                             style: GoogleFonts.firaSans(
//                                 fontSize: 10.0,
//                                 fontWeight: FontWeight.w400,
//                                 color: Color(0xff686464)),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               40),
//                       Text(
//                         'Employer',
//                         style: GoogleFonts.firaSans(
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff686464)),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               60),
//                       CustomTextFieldRegister(
//                         controller: employer,
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         height: 32,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                     width: MediaQuery.of(context).size.width / 20),
//                 Expanded(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                         height:
//                             MediaQuery.of(context).size.height / 40),
//                     Text(
//                       'Reason for Leaving',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                             MediaQuery.of(context).size.height / 60),
//                     CustomTextFieldRegister(
//                       controller: rforleaving,
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
//                             MediaQuery.of(context).size.height / 40),
//                     Text(
//                       'Last Supervisor’s Name',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                             MediaQuery.of(context).size.height / 60),
//                     CustomTextFieldRegister(
//                       controller: lSupervisorName,
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
//                             MediaQuery.of(context).size.height / 40),
//                     Text(
//                       'Supervisor’s Mobile Number',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                             MediaQuery.of(context).size.height / 60),
//                     CustomTextFieldRegister(
//                       controller: supervisormobnum,
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
//                             MediaQuery.of(context).size.height / 40),
//                     Text(
//                       'City',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                             MediaQuery.of(context).size.height / 60),
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
//                   ],
//                 )),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Handle add education action
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff50B5E5),
//                     // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   icon: Icon(Icons.add, color: Colors.white),
//                   label: Text(
//                     'Add Experience ',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor:  Color(0xff1696C8),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             onPressed:
//                 () async {
//              await postemploymentscreen(context, 0, employer.text, city.text,  rforleaving.text, lSupervisorName.text, supervisormobnum.text, finalposition.text, "__", "__");
//             },
//             child: Text(
//               'Save',
//               style: GoogleFonts.firaSans(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//
//           ),
//         ],
//       )
//
//     ],
//   ),
// );
//
// class EmploymentForm extends StatefulWidget {
//   final VoidCallback onRemove;
//   final int index;
//   EmploymentForm({Key? key, required this.onRemove, required this.index})
//       : super(key: key);
//
//   @override
//   _EmploymentFormState createState() => _EmploymentFormState();
// }
//
// class _EmploymentFormState extends State<EmploymentForm> {
//   TextEditingController employerController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController reasonForLeavingController = TextEditingController();
//   TextEditingController supervisorNameController = TextEditingController();
//   TextEditingController supervisorMobileNumberController =
//       TextEditingController();
//   TextEditingController finalPositionController = TextEditingController();
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController endDateController = TextEditingController();
//   bool isChecked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Employment #${widget.index}',
//                 style: GoogleFonts.firaSans(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xff686464),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.remove_circle, color: Colors.red),
//                 onPressed: widget.onRemove,
//               ),
//             ],
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height / 20),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Final Position Title',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff686464),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 60),
//                     TextField(
//                       controller: finalPositionController,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         contentPadding: EdgeInsets.all(12.0),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 40),
//                     Text(
//                       'Start Date',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff686464),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 60),
//                     TextField(
//                       controller: startDateController,
//                       decoration: InputDecoration(
//                         hintText: 'dd-mm-yyyy',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         contentPadding: EdgeInsets.all(12.0),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             Icons.calendar_month_outlined,
//                             color: Color(0xff50B5E5),
//                             size: 16,
//                           ),
//                           onPressed: () async {
//                             DateTime? pickedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2101),
//                             );
//                             if (pickedDate != null) {
//                               startDateController.text =
//                                   "${pickedDate.toLocal()}".split(' ')[0];
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 40),
//                     Text(
//                       'End Date',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff686464),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 60),
//                     TextField(
//                       controller: endDateController,
//                       decoration: InputDecoration(
//                         hintText: 'dd-mm-yyyy',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         contentPadding: EdgeInsets.all(12.0),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             Icons.calendar_month_outlined,
//                             color: Color(0xff50B5E5),
//                             size: 16,
//                           ),
//                           onPressed: () async {
//                             DateTime? pickedDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2101),
//                             );
//                             if (pickedDate != null) {
//                               endDateController.text =
//                                   "${pickedDate.toLocal()}".split(' ')[0];
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width / 20),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Employer Name',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff686464),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 60),
//                     TextField(
//                       controller: employerController,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         contentPadding: EdgeInsets.all(12.0),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 40),
//                     Text(
//                       'City/State',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff686464),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 60),
//                     TextField(
//                       controller: cityController,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         contentPadding: EdgeInsets.all(12.0),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 40),
//                     Text(
//                       'Reason for Leaving',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff686464),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 60),
//                     TextField(
//                       controller: reasonForLeavingController,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         contentPadding: EdgeInsets.all(12.0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height / 40),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Supervisor Name',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff686464),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 60),
//                     TextField(
//                       controller: supervisorNameController,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         contentPadding: EdgeInsets.all(12.0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: MediaQuery.of(context).size.width / 20),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Supervisor Mobile Number',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff686464),
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height / 60),
//                     TextField(
//                       controller: supervisorMobileNumberController,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         contentPadding: EdgeInsets.all(12.0),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height / 40),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Row(
//                   children: [
//                     Checkbox(
//                       value: isChecked,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           isChecked = value ?? false;
//                         });
//                       },
//                     ),
//                     Expanded(
//                       child: Text(
//                         'Please check this box if you do not want us to contact your employer.',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );

///
//   Padding(
//   padding: const EdgeInsets.symmetric(vertical: 12.0),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'Employment #${widget.key}',
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
//                   'Final Position Title',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 TextField(
//                   controller: finalPositionController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 40),
//                 Text(
//                   'Start Date',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 TextField(
//                   controller: startDateController,
//                   decoration: InputDecoration(
//                     hintText: 'dd-mm-yyyy',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         Icons.calendar_month_outlined,
//                         color: Color(0xff50B5E5),
//                         size: 16,
//                       ),
//                       onPressed: () async {
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2101),
//                         );
//                         if (pickedDate != null) {
//                           startDateController.text =
//                           "${pickedDate.toLocal()}".split(' ')[0];
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 40),
//                 Text(
//                   'End Date',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 TextField(
//                   controller: endDateController,
//                   decoration: InputDecoration(
//                     hintText: 'dd-mm-yyyy',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         Icons.calendar_month_outlined,
//                         color: Color(0xff50B5E5),
//                         size: 16,
//                       ),
//                       onPressed: () async {
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2101),
//                         );
//                         if (pickedDate != null) {
//                           endDateController.text =
//                           "${pickedDate.toLocal()}".split(' ')[0];
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 40),
//                 Row(
//                   children: [
//                     Checkbox(
//                       checkColor: Colors.white,
//                       activeColor: Color(0xff50B5E5),
//                       value: isChecked,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           isChecked = value!;
//                         });
//                       },
//                     ),
//                     Text(
//                       'Currently Working',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width / 60),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Employer',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 TextField(
//                   controller: employerController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 40),
//                 Text(
//                   'City',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 TextField(
//                   controller: cityController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 40),
//                 Text(
//                   'Reason for Leaving',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 TextField(
//                   controller: reasonForLeavingController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 40),
//                 Text(
//                   'Supervisor’s Name',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 TextField(
//                   controller: supervisorNameController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 40),
//                 Text(
//                   'Supervisor’s Mobile Number',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff686464)),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height / 60),
//                 TextField(
//                   controller: supervisorMobileNumberController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter Text',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: EdgeInsets.all(12.0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       SizedBox(height: MediaQuery.of(context).size.height / 40),
//       Divider(color: Color(0xFFE6E6E6), thickness: 1.0),
//     ],
//   ),
// );

//
//
// ElevatedButton(
// onPressed: () async {
// if (soConductFiles.isEmpty && harassmentFiles.isEmpty) {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('No files selected. Please select files to upload.'),
// backgroundColor: Colors.red,
// ),
// );
// return;
// }
//
// try {
// // Upload "Standards Of Conduct" documents
// for (var file in soConductFiles) {
// await uploadDocuments(
// context: context,
// employeeDocumentMetaId: 10,
// employeeDocumentTypeSetupId: 48,
// employeeId: 2,
// documentFile: file,
// documentName: 'Standards Of Conduct'
// );
// }
//
// // Upload "California Sexual Harassment Training" documents
// for (var file in harassmentFiles) {
// await uploadDocuments(
// context: context,
// employeeDocumentMetaId: 10,
// employeeDocumentTypeSetupId: 48,
// employeeId: 2,
// documentFile: file,
// documentName: 'California Sexual Harassment Training'
// );
// }
//
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('Documents uploaded successfully!'),
// backgroundColor: Colors.green,
// ),
// );
// } catch (e) {
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(
// content: Text('Failed to upload documents: $e'),
// backgroundColor: Colors.red,
// ),
// );
// }
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xff50B5E5),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8.0),
// ),
// ),
// child: Text(
// 'Upload All',
// style: GoogleFonts.firaSans(
// fontSize: 14.0,
// fontWeight: FontWeight.w700,
// color: Colors.white,
// ),
// ),
//),
