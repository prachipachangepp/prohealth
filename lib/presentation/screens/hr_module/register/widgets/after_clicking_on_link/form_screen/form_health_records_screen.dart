import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/progress_form_manager/form_health_record_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_health_record_data.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_health_record_data.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_health_record_data.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../widgets/container_constant.dart';

class HealthRecordsScreen extends StatefulWidget {
  final int employeeID;

  const HealthRecordsScreen({
    super.key,
    required this.context,
    required this.employeeID,
  });

  final BuildContext context;

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {

  final StreamController<List<HREmployeeDocumentModal>> healthrecord = StreamController<List<HREmployeeDocumentModal>>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHREmployeeDoc(
      context,
      AppConfig.empdocumentTypeMetaDataId,
      1,
      20,
    ).then((data){healthrecord.add(data);}).catchError((error){});
  }




  List<String> _fileNames = [];
  bool _loading = false;
  ////////////////////////////////////

  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic? filePath;
  File? xfileToFile;
  var finalPath;
  // PlatformFile? fileName;

  Future<WebFile> saveFileFromBytes(dynamic bytes, String fileName) async {
    // Get the directory to save the file.
    final blob = html.Blob(bytes);
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create the file.
    //final anchor = html.AnchorElement(href: url)..setAttribute("download", fileName)..click();
    final file = html.File([blob], fileName);
    // Write the bytes to the file.
    print(file.toString());
    return WebFile(file, url);
  }

  Future<XFile> convertBytesToXFile(Uint8List bytes, String fileName) async {
    // Create a Blob from the bytes
    final blob = html.Blob([bytes]);

    // Create an object URL from the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a File from the Blob
    final file = html.File([blob], fileName);

    print("XFILE ${url}");

    // Return the XFile created from the object URL
    return XFile(url);
  }

  Future<Uint8List> loadFileBytes() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/somefile.txt');
    if (await file.exists()) {
      return await file.readAsBytes();
    } else {
      throw Exception('File not found');
    }
  }

  //List<String?> fileNames = List<String?>.generate(20, (index) => null);
  ////////////////////////////
  ///////
  //

  void _pickFiles() async {
    setState(() {
      _loading = true; // Show loader
      _fileNames.clear(); // Clear previous file names if any
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _fileNames.addAll(result.files.map((file) => file.name!));
        _loading = false; // Hide loader
      });
      print('Files picked: $_fileNames');
    } else {
      setState(() {
        _loading = false; // Hide loader on cancel
      });
      print('User canceled the picker');
    }
  }



  List<Uint8List?> finalPaths = [];



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Text(
              'Health Records',
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
                SizedBox(height: MediaQuery.of(context).size.height / 100),
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
          SizedBox(height: MediaQuery.of(context).size.height / 20),

          SingleChildScrollView(
            child: Container(
              height: 500,
              child:
              StreamBuilder<List<HREmployeeDocumentModal>>(
                stream: healthrecord.stream,
                // builder: getHREmployeeDoc(
                //     context, AppConfig.empdocumentTypeMetaDataId, 1, 20),


                builder: (BuildContext context,
                    AsyncSnapshot<List<HREmployeeDocumentModal>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error :${snapshot.error}");
                  } else {
                    List<HREmployeeDocumentModal> documents = snapshot.data!;

                    // Ensure _fileNames is at least as long as documents
                    if (_fileNames.length < documents.length) {
                      _fileNames.addAll(List.generate(
                        documents.length - _fileNames.length,
                        (index) => '', // Or any default value
                      ));
                    }

                    if (finalPaths.length < documents.length) {
                      finalPaths.addAll(
                        List.generate(documents.length - finalPaths.length, (_) => null),
                      );
                    }
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final fileName =
                            _fileNames.isNotEmpty && index < _fileNames.length
                                ? _fileNames[index]
                                : null;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 150, vertical: 10),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          document.docName,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff686464),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Flexible(
                                          child: Text(
                                            'Upload Physical Exam records in pdf, jpg or png format',
                                            style: GoogleFonts.firaSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffB1B1B1)),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            FilePickerResult? result = await FilePicker.platform.pickFiles();
                                            if (result != null) {
                                              try {
                                                Uint8List? bytes = result.files.first.bytes;
                                                if (bytes != null) {
                                                  setState(() {
                                                    if (_fileNames.length <= index) {
                                                      _fileNames.add(result.files.first.name!);
                                                    } else {
                                                      _fileNames[index] = result.files.first.name!;
                                                    }

                                                    if (finalPaths.length <= index) {
                                                      finalPaths.add(bytes);
                                                    } else {
                                                      finalPaths[index] = bytes;
                                                    }
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }
                                            }
                                            // FilePickerResult? result =
                                            //     await FilePicker.platform
                                            //         .pickFiles();
                                            // if (result != null) {
                                            //   try {
                                            //     Uint8List? bytes =
                                            //         result.files.first.bytes;
                                            //     XFile xlfile =
                                            //         XFile(result.xFiles.first.path);
                                            //     File xfileToFile =
                                            //         File(xlfile.path);
                                            //     XFile xFile =
                                            //         await convertBytesToXFile(
                                            //       bytes!,
                                            //       result.xFiles.first.name,
                                            //     );
                                            //     if (_fileNames.length <= index) {
                                            //       _fileNames.add(
                                            //           result.files.first.name!);
                                            //     } else {
                                            //       _fileNames[index] =
                                            //           result.files.first.name!;
                                            //     }
                                            //     finalPath =
                                            //         result.files.first.bytes;
                                            //     // setState(() {
                                            //     //   _documentUploaded = true;
                                            //     // });
                                            //   } catch (e) {
                                            //     print(e);
                                            //   }
                                            // }
                                          },
                                          child: Text(
                                            "Upload file",
                                            style: GoogleFonts.firaSans(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff50B5E5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      _loading
                                          ? SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          color: ColorManager.blueprime,
                                        ),
                                      )
                                          : fileName != null
                                          ? Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                          'File picked: $fileName',
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff686464),
                                          ),
                                        ),
                                      )
                                          : SizedBox(),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).size.height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                width: 117,
                height: 30,
                text: 'Save',
                style: const TextStyle(
                  fontFamily: 'FiraSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                borderRadius: 12,
                onPressed: () async {
                  if (finalPaths == null || finalPaths.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'No file selected. Please select a file to upload.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    try {
                      for (int i = 0; i < finalPaths.length; i++) {
                        if (finalPaths[i] != null) {
                          await uploadDocuments(
                            context: context,
                            employeeDocumentMetaId: 1,
                            employeeDocumentTypeSetupId: 10,
                            employeeId: widget.employeeID,
                            documentFile: finalPaths[i]!,
                            documentName: _fileNames[i],
                          );
                        }
                      }
                      // await uploadDocuments(
                      //     context: context,
                      //     employeeDocumentMetaId: 10,
                      //     employeeDocumentTypeSetupId: 48,
                      //     employeeId: widget.employeeID,
                      //     documentFile: finalPath,
                      //     documentName: 'Legal Document ID');

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
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Expanded(
//   child: FutureBuilder<List<HREmployeeDocumentModal>>(
//     future: getHREmployeeDoc(context, 0, 1, 20),
//     builder: (BuildContext context,
//         AsyncSnapshot<List<HREmployeeDocumentModal>> snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Text("Error :${snapshot.error}");
//       } else {
//         List<HREmployeeDocumentModal> documents = snapshot.data!;
//
//         return ListView.builder(
//           itemCount: documents.length,
//           itemBuilder: (context, index) {
//             final document = documents[index];
//             final fileName =
//                 _fileNames.isNotEmpty ? _fileNames[index] : null;
//
//             return Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 150, vertical: 10),
//               child: Container(
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: ColorManager.white,
//                   borderRadius: BorderRadius.circular(4),
//                   boxShadow: [
//                     BoxShadow(
//                       color: ColorManager.grey.withOpacity(0.5),
//                       spreadRadius: 1,
//                       blurRadius: 4,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               document.docName,
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: const Color(0xff686464),
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'Upload Physical Exam records in pdf, jpg or png format',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color: const Color(0xff686464),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: const Color(0xffB1B1B1)),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             FilePickerResult? result =
//                                 await FilePicker.platform.pickFiles();
//                             if (result != null) {
//                               print("Result::: ${result}");
//                               try {
//                                 Uint8List? bytes =
//                                     result.files.first.bytes;
//                                 XFile xlfile =
//                                     XFile(result.xFiles.first.path);
//                                 File xfileToFile = File(xlfile.path);
//                                 print(
//                                     "::::XFile To File ${xfileToFile.toString()}");
//                                 XFile xFile =
//                                     await convertBytesToXFile(
//                                   bytes!,
//                                   result.xFiles.first.name,
//                                 );
//                                 if (_fileNames.length <= index) {
//                                   _fileNames
//                                       .add(result.files.first.name!);
//                                 } else {
//                                   _fileNames[index] =
//                                       result.files.first.name!;
//                                 }
//                                 print('File picked: ${_fileNames}');
//                                 finalPath = result.files.first.bytes;
//                                 setState(() {
//                                   _documentUploaded = true;
//                                 });
//                               } catch (e) {
//                                 print(e);
//                               }
//                             }
//                           },
//                           child: Text(
//                             "Upload file",
//                             style: GoogleFonts.firaSans(
//                               fontSize: 14.0,
//                               fontWeight: FontWeight.w700,
//                               color: Colors.white,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xff50B5E5),
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(8.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // SizedBox(width: 10),
//                       _loading
//                           ? SizedBox(
//                               width: 25,
//                               height: 25,
//                               child: CircularProgressIndicator(
//                                 color: ColorManager.blueprime,
//                               ),
//                             )
//                           : fileName != null
//                               ? Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'File picked: $fileName',
//                                     style: GoogleFonts.firaSans(
//                                       fontSize: 12.0,
//                                       fontWeight: FontWeight.w400,
//                                       color: Color(0xff686464),
//                                     ),
//                                   ),
//                                 )
//                               : SizedBox(),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }
//     },
//   ),
// ),

// Expanded(
//   child: FutureBuilder<List<HREmployeeDocumentModal>>(
//       future: getHREmployeeDoc(context, 0, 1, 20),
//       builder: (BuildContext context,
//           AsyncSnapshot<List<HREmployeeDocumentModal>> snaphot) {
//         if (snaphot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snaphot.hasError) {
//           return Text("Error :${snaphot.error}");
//         } else {
//           return ListView.builder(
//               itemCount: snaphot.data!.length,
//               itemBuilder: (context, index) {
//                 //final document = snapshot.data![index];
//                 final post = snaphot.data![index];
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 150),
//                   child: Column(
//
//                     children: [
//                       Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: ColorManager.white,
//                           borderRadius: BorderRadius.circular(4),
//                           boxShadow: [
//                             BoxShadow(
//                               color:
//                                   ColorManager.grey.withOpacity(0.5),
//                               spreadRadius: 1,
//                               blurRadius: 4,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Column(
//                               children: [
//                                 Text(
//                                   post.docName,
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(0xff686464),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Upload Physical Exam records in pdf, jpg or png format',
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400,
//                                         color:
//                                             const Color(0xff686464),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                         width: MediaQuery.of(context)
//                                                 .size
//                                                 .width /
//                                             80),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: const Color(
//                                                 0xffB1B1B1)),
//                                         borderRadius:
//                                             BorderRadius.circular(8),
//                                       ),
//                                       child: ElevatedButton(
//                                         onPressed: () async {
//                                           // FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                           //   allowMultiple: false,
//                                           // );
//                                           FilePickerResult? result =
//                                               await FilePicker
//                                                   .platform
//                                                   .pickFiles();
//                                           if (result != null) {
//                                             print(
//                                                 "Result::: ${result}");
//
//                                             try {
//                                               Uint8List? bytes =
//                                                   result.files.first
//                                                       .bytes;
//                                               XFile xlfile = XFile(
//                                                   result.xFiles.first
//                                                       .path);
//                                               xfileToFile =
//                                                   File(xlfile.path);
//
//                                               print(
//                                                   "::::XFile To File ${xfileToFile.toString()}");
//                                               XFile xFile =
//                                                   await convertBytesToXFile(
//                                                       bytes!,
//                                                       result
//                                                           .xFiles
//                                                           .first
//                                                           .name);
//                                               // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//                                               // html.File file = webFile.file;
//                                               //  print("XFILE ${xFile.path}");
//                                               //  //filePath = xfileToFile as XFile?;
//                                               //  print("L::::::${filePath}");
//                                               _fileNames.addAll(result
//                                                   .files
//                                                   .map((file) =>
//                                                       file.name!));
//                                               print(
//                                                   'File picked: ${_fileNames}');
//                                               //print(String.fromCharCodes(file));
//                                               finalPath = result
//                                                   .files.first.bytes;
//                                               setState(() {
//                                                 _fileNames;
//                                                 _documentUploaded =
//                                                     true;
//                                               });
//                                             } catch (e) {
//                                               print(e);
//                                             }
//                                           }
//                                         },
//                                         child: Text(
//                                           "Upload file",
//                                           style: GoogleFonts.firaSans(
//                                             fontSize: 14.0,
//                                             fontWeight:
//                                                 FontWeight.w700,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         style:
//                                             ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               Color(0xff50B5E5),
//                                           shape:
//                                               RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(
//                                                     8.0),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     _loading
//                                         ? SizedBox(
//                                             width: 25,
//                                             height: 25,
//                                             child:
//                                                 CircularProgressIndicator(
//                                               color: ColorManager
//                                                   .blueprime, // Loader color
//                                               // Loader size
//                                             ),
//                                           )
//                                         : _fileNames.isNotEmpty
//                                             ? Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment
//                                                         .start,
//                                                 children: _fileNames
//                                                     .map(
//                                                         (fileName) =>
//                                                             Padding(
//                                                               padding: const EdgeInsets
//                                                                   .all(
//                                                                   8.0),
//                                                               child:
//                                                                   Text(
//                                                                 'File picked: $fileName',
//                                                                 style: GoogleFonts.firaSans(
//                                                                     fontSize: 12.0,
//                                                                     fontWeight: FontWeight.w400,
//                                                                     color: Color(0xff686464)),
//                                                               ),
//                                                             ))
//                                                     .toList(),
//                                               )
//                                             : SizedBox(),
//                                   ],
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 );
//               });
//         }
//       }),
// )

//
//
// Expanded(
//   child: Column(
//     children: [
//       PhysicalExamContainer(),
//       SizedBox(
//           height: 16), // Add some spacing between containers
//       // VaccineContainer(),
//       // SizedBox(height: 16),
//       PhysicalExamContainer(),
//       SizedBox(height: 16),
//       Expanded(
//         child: ListView.builder(
//           itemCount: 5,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: 16),
//               child: VaccineContainer(),
//             );
//           },
//         ),
//       ),
//     ],
//   ),
// )
