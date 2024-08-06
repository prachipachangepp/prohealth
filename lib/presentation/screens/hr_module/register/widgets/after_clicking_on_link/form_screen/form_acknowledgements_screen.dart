import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import '../../../../../../../app/constants/app_config.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/progress_form_manager/form_health_record_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_health_record_data.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';

class AcknowledgementsScreen extends StatefulWidget {
  final int employeeID;
  const AcknowledgementsScreen({
    super.key,
    required this.context,
    required this.employeeID,
  });

  final BuildContext context;

  @override
  State<AcknowledgementsScreen> createState() => _AcknowledgementsScreenState();
}

class _AcknowledgementsScreenState extends State<AcknowledgementsScreen> {


  final StreamController<List<HREmployeeDocumentModal>> acknowledgements = StreamController<List<HREmployeeDocumentModal>>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHREmployeeDoc(
      context,
      AppConfig.employeeDocumentTypeMetaDataId,
      1,
      20,
    ).then((data){acknowledgements.add(data);}).catchError((error){});
  }


  bool _isButtonPressed = false;

  void _handleButtonPress() {
    setState(() {
      _isButtonPressed = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still mounted
        setState(() {
          _isButtonPressed = true; // Update the state to show the icon
        });
      }
    });
  }

  List<String> _fileNames = [];
  List<String> onCAll = [];
  List<String> hIPPA = [];
  List<String> rDparty = [];
  List<String> prop = [];
  List<String> rocp = [];
  List<String> soConduct = [];
  List<String> harassment = [];

  List<Uint8List?> soConductFiles = [];
  List<Uint8List?> harassmentFiles = [];
  List<Uint8List?> onCAllFiles = [];
  List<Uint8List?> hIPPAFiles = [];
  List<Uint8List?> rDpartyFiles = [];
  List<Uint8List?> propFiles = [];

  bool _loading = false;

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

  ////////////////////////////////////

  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic? filePath;
  File? xfileToFile;


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

  // List<String> _fileNames = [];
  List<Uint8List?> finalPaths = [];
  List<Uint8List?> finalPath = [];
  //var finalPath;

  ////////////////////////////
  ///////
  //



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 166),
      child: Column(
        children: [
          Center(
            child: Text(
              'Acknowledgements',
              style: GoogleFonts.firaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xff50B5E5),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 60),
          Container(
            height: 50,
            width: 940,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'List Of Documents',
              style: GoogleFonts.firaSans(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff686464),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 10),
          SingleChildScrollView(
            child: Container(
              height: 300,
              child: StreamBuilder<List<HREmployeeDocumentModal>>(

                stream:acknowledgements.stream ,
                builder: (BuildContext context,
                    AsyncSnapshot<List<HREmployeeDocumentModal>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No documents found"));
                  } else {
                    List<HREmployeeDocumentModal> documents = snapshot.data!;

                    // Ensure _fileNames is at least as long as documents
                    if (_fileNames.length < documents.length) {
                      _fileNames.addAll(
                        List.generate(
                            documents.length - _fileNames.length, (_) => ''),
                      );
                    }

                    if (finalPath.length < documents.length) {
                      finalPath.addAll(
                        List.generate(documents.length - finalPath.length, (_) => null),
                      );
                    }
                    // if (finalPaths.length < documents.length) {
                    //   finalPaths.addAll(
                    //     List.generate(documents.length - finalPaths.length, (_) => null),
                    //   );
                    // }


                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final fileName =
                            index < _fileNames.length ? _fileNames[index] : '';
                        // final document = documents[index];
                        // final fileName = index < _fileNames.length ? _fileNames[index] : '';
                        // final pickedFile = index < _pickedFiles.length
                        //     ? _pickedFiles[index]
                        //     : PlatformFile(
                        //         name: '',
                        //         bytes: null,
                        //         size: 15,
                        //       );

                        return Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    document.docName,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
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





                                          ///no setstate
                                          // FilePickerResult? result =
                                          //     await FilePicker.platform
                                          //         .pickFiles();
                                          // if (result != null) {
                                          //   try {
                                          //     Uint8List? bytes =
                                          //         result.files.first.bytes;
                                          //     XFile xlfile = XFile(
                                          //         result.xFiles.first.path);
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
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff50B5E5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff686464),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              color: Color(0xFFD1D1D1),
                            ),
                          ],
                        );
                        //  SizedBox(height: MediaQuery.of(context).size.height / 100),
                        //  Divider(
                        //    height: 1,
                        //    color: Color(0xFFD1D1D1),
                        // ),
                      },
                    );
                  }
                },
              ),
            ),
          ),
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
                 // if (finalPath == null || finalPath.isEmpty) {
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
                            employeeDocumentMetaId: 10,
                            employeeDocumentTypeSetupId: 48,
                            employeeId: widget.employeeID,
                            documentFile: finalPaths[i]!,
                            documentName: _fileNames[i],
                          );
                        }
                      }


                      ////
                      // for (int i = 0; i < finalPath.length; i++) {
                      //   if (finalPath[i] != null) {
                      //     await uploadDocuments(
                      //       context: context,
                      //       employeeDocumentMetaId: 10,
                      //       employeeDocumentTypeSetupId: 48,
                      //       employeeId: widget.employeeID,
                      //       documentFile: finalPath[i]!,
                      //       documentName: _fileNames[i],
                      //     );
                      //   }
                      // }



                      ///api
                      // await uploadDocuments(
                      //     context: context,
                      //     employeeDocumentMetaId: 10,
                      //     employeeDocumentTypeSetupId: 48,
                      //     employeeId: widget.employeeID,
                      //     documentFile: finalPath,
                      //     documentName: 'Legal Document ID');

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
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
                  ;
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}








//
// FutureBuilder<List<HREmployeeDocumentModal>>(
// future: getHREmployeeDoc(
// context,
// AppConfig.employeeDocumentTypeMetaDataId,
// 1,
// 20,
// ),

















//
//
//   if (finalPath.isEmpty || finalPath.every((file) => file == null)) {
//   ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//   content: Text('No file selected. Please select files to upload.'),
//   backgroundColor: Colors.red,
//   ),
//   );
//   return;
//   }
//
//   try {
//   setState(() {
//   _loading = true;
//   });
//
//   for (int i = 0; i < finalPath.length; i++) {
//   if (finalPath[i] != null) {
//   await uploadDocuments(
//   context: context,
//   employeeDocumentMetaId: 10,
//   employeeDocumentTypeSetupId: 48,
//   employeeId: widget.employeeID,
//   documentFile: finalPath[i]!,
//   documentName: _fileNames[i],
//   );
//   }
//   }
//
//   ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//   content: Text('Documents uploaded successfully!'),
//   backgroundColor: Colors.green,
//   ),
//   );
//   } catch (e) {
//   ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//   content: Text('Failed to upload documents: $e'),
//   backgroundColor: Colors.red,
//   ),
//   );
//   } finally {
//   setState(() {
//   _loading = false;
//   });
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: EdgeInsets.only(left: 166, right: 166),
//         child: Column(
//           children: [
//             Center(
//               child: Text(
//                 'Acknowledgements',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xff50B5E5)),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 60),
//             Container(
//               height: 50,
//               width: 940,
//               padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//               decoration: BoxDecoration(
//                 color: Color(0xFFE6F7FF),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Text(
//                   'Please sign the list of documents required for the recruitment process',
//                   style: GoogleFonts.firaSans(
//                     color: Color(0xFF686464),
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 20),
//             Row(
//               children: [
//                 Text(
//                   'List Of Documents',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height / 10),
//             Expanded(
//               child: FutureBuilder(
//                 future: getHREmployeeDoc(context,
//                     AppConfig.employeeDocumentTypeMetaDataId, 1, 20),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<List<HREmployeeDocumentModal>> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text("Error :${snapshot.error}");
//                   } else {
//                     List<HREmployeeDocumentModal> documents =
//                         snapshot.data!;
//
//                     // Ensure _fileNames is at least as long as documents
//                     if (_fileNames.length < documents.length) {
//                       _fileNames.addAll(List.generate(
//                         documents.length - _fileNames.length,
//                         (index) => '', // Or any default value
//                       ));
//                     }
//
//                     return ListView.builder(
//                       itemCount: documents.length,
//                       itemBuilder: (context, index) {
//                         final document = documents[index];
//                         final fileName = _fileNames.isNotEmpty &&
//                                 index < _fileNames.length
//                             ? _fileNames[index]
//                             : null;
//
//
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               children: [
//                                 Text(
//                                   document.docName,
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 14.0,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     ElevatedButton(
//
//                                       onPressed: () async {
//                                         FilePickerResult? result =
//                                         await FilePicker.platform.pickFiles();
//                                         if (result != null) {
//                                           try {
//                                             onCAllFiles.clear();
//                                             onCAllFiles.addAll(
//                                                 result.files.map((file) => file.bytes));
//                                             onCAll.addAll(
//                                                 result.files.map((file) => file.name!));
//                                             setState(() {
//                                               _documentUploaded = true;
//                                             });
//                                           } catch (e) {
//                                             print(e);
//                                           }
//                                         }
//                                       },
//
//
//                                       // onPressed:()async {
//                                       //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                       //   //   allowMultiple: false,
//                                       //   // );
//                                       //   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                                       //   if (result != null) {
//                                       //     print("Result::: ${result}");
//                                       //
//                                       //     try{
//                                       //       Uint8List? bytes = result.files.first.bytes;
//                                       //       XFile xlfile = XFile(result.xFiles.first.path);
//                                       //       xfileToFile = File(xlfile.path);
//                                       //
//                                       //       print("::::XFile To File ${xfileToFile.toString()}");
//                                       //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
//                                       //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//                                       //       // html.File file = webFile.file;
//                                       //       //  print("XFILE ${xFile.path}");
//                                       //       //  //filePath = xfileToFile as XFile?;
//                                       //       //  print("L::::::${filePath}");
//                                       //       onCAll.addAll(result.files.map((file) => file.name!));
//                                       //       print('File picked: ${onCAll}');
//                                       //       //print(String.fromCharCodes(file));
//                                       //       finalPath = result.files.first.bytes;
//                                       //       setState(() {
//                                       //         onCAll;
//                                       //         _documentUploaded = true;
//                                       //       });
//                                       //     }catch(e){
//                                       //       print(e);
//                                       //     }
//                                       //   }
//                                       // },
//
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Color(0xff50B5E5),
//                                         // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(8.0),
//                                         ),
//                                       ),
//                                       child: Text(
//                                         'Sign',
//                                         style: GoogleFonts.firaSans(
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                     _loading
//                                         ? SizedBox(
//                                       width: 25,
//                                       height: 25,
//                                       child: CircularProgressIndicator(
//                                         color:
//                                         ColorManager.blueprime, // Loader color
//                                         // Loader size
//                                       ),
//                                     )
//                                         : onCAll.isNotEmpty
//                                         ? Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: onCAll
//                                           .map((fileName) => Padding(
//                                         padding:
//                                         const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           'File picked: $fileName',
//                                           style: GoogleFonts.firaSans(
//                                               fontSize: 12.0,
//                                               fontWeight:
//                                               FontWeight.w400,
//                                               color: Color(0xff686464)),
//                                         ),
//                                       ))
//                                           .toList(),
//                                     )
//                                         : SizedBox(),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Canditate Release Form (Background Check)',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xff686464),
//                     ),
//                   ),
//                   Icon(
//                     Icons.check,
//                     color: Colors.green,
//                     size: 24.0,
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Divider(
//                 height: 1,
//                 color: Color(0xFFD1D1D1),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         'On - call',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff686464),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           ElevatedButton(
//
//                             onPressed: () async {
//                               FilePickerResult? result =
//                               await FilePicker.platform.pickFiles();
//                               if (result != null) {
//                                 try {
//                                   onCAllFiles.clear();
//                                   onCAllFiles.addAll(
//                                       result.files.map((file) => file.bytes));
//                                   onCAll.addAll(
//                                       result.files.map((file) => file.name!));
//                                   setState(() {
//                                     _documentUploaded = true;
//                                   });
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                               }
//                             },
//
//
//                             // onPressed:()async {
//                             //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
//                             //   //   allowMultiple: false,
//                             //   // );
//                             //   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                             //   if (result != null) {
//                             //     print("Result::: ${result}");
//                             //
//                             //     try{
//                             //       Uint8List? bytes = result.files.first.bytes;
//                             //       XFile xlfile = XFile(result.xFiles.first.path);
//                             //       xfileToFile = File(xlfile.path);
//                             //
//                             //       print("::::XFile To File ${xfileToFile.toString()}");
//                             //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
//                             //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//                             //       // html.File file = webFile.file;
//                             //       //  print("XFILE ${xFile.path}");
//                             //       //  //filePath = xfileToFile as XFile?;
//                             //       //  print("L::::::${filePath}");
//                             //       onCAll.addAll(result.files.map((file) => file.name!));
//                             //       print('File picked: ${onCAll}');
//                             //       //print(String.fromCharCodes(file));
//                             //       finalPath = result.files.first.bytes;
//                             //       setState(() {
//                             //         onCAll;
//                             //         _documentUploaded = true;
//                             //       });
//                             //     }catch(e){
//                             //       print(e);
//                             //     }
//                             //   }
//                             // },
//
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xff50B5E5),
//                               // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             child: Text(
//                               'Sign',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           _loading
//                               ? SizedBox(
//                                   width: 25,
//                                   height: 25,
//                                   child: CircularProgressIndicator(
//                                     color:
//                                         ColorManager.blueprime, // Loader color
//                                     // Loader size
//                                   ),
//                                 )
//                               : onCAll.isNotEmpty
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: onCAll
//                                           .map((fileName) => Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Text(
//                                                   'File picked: $fileName',
//                                                   style: GoogleFonts.firaSans(
//                                                       fontSize: 12.0,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: Color(0xff686464)),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                     )
//                                   : SizedBox(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Text(
//               //       'On - call',
//               //       style: GoogleFonts.firaSans(
//               //         fontSize: 14.0,
//               //         fontWeight: FontWeight.w500,
//               //         color: Color(0xff686464),
//               //       ),
//               //     ),
//               //     _isButtonPressed
//               //         ? Icon(
//               //       Icons.check,
//               //       color: Colors.green,
//               //       size: 24.0,
//               //     )
//               //         : ElevatedButton(
//               //
//               //       onPressed: ()
//               //       async {
//               //         // FilePickerResult? result = await FilePicker.platform.pickFiles(
//               //         //   allowMultiple: false,
//               //         // );
//               //         FilePickerResult? result = await FilePicker.platform.pickFiles();
//               //         if (result != null) {
//               //           print("Result::: ${result}");
//               //
//               //           try{
//               //             Uint8List? bytes = result.files.first.bytes;
//               //             XFile xlfile = XFile(result.xFiles.first.path);
//               //             xfileToFile = File(xlfile.path);
//               //
//               //             print("::::XFile To File ${xfileToFile.toString()}");
//               //             XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
//               //             // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//               //             // html.File file = webFile.file;
//               //             //  print("XFILE ${xFile.path}");
//               //             //  //filePath = xfileToFile as XFile?;
//               //             //  print("L::::::${filePath}");
//               //             fileName = result.files.first.name;
//               //             print('File picked: ${fileName}');
//               //             //print(String.fromCharCodes(file));
//               //             finalPath = result.files.first.bytes;
//               //             setState(() {
//               //               fileName;
//               //               _documentUploaded = true;
//               //               _handleButtonPress;
//               //             });
//               //           }catch(e){
//               //             print(e);
//               //           }
//               //         }
//               //
//               //
//               //       },
//               //       style: ElevatedButton.styleFrom(
//               //         backgroundColor: Color(0xff50B5E5),
//               //         shape: RoundedRectangleBorder(
//               //           borderRadius: BorderRadius.circular(8.0),
//               //         ),
//               //       ),
//               //       child: Text(
//               //         'Sign',
//               //         style: GoogleFonts.firaSans(
//               //           fontSize: 14.0,
//               //           fontWeight: FontWeight.w700,
//               //           color: Colors.white,
//               //         ),
//               //       ),
//               //     ),
//               //     _loading
//               //         ? SizedBox(width: 25,
//               //       height: 25,
//               //       child: CircularProgressIndicator(
//               //         color: ColorManager.blueprime, // Loader color
//               //         // Loader size
//               //       ),
//               //     )
//               //         : _fileNames.isNotEmpty
//               //         ? Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: _fileNames
//               //           .map((fileName) => Padding(
//               //         padding: const EdgeInsets.all(8.0),
//               //         child: Text(
//               //           'File picked: $fileName',
//               //           style: GoogleFonts.firaSans(
//               //               fontSize: 12.0,
//               //               fontWeight: FontWeight.w400,
//               //               color: Color(0xff686464)),
//               //         ),
//               //       ))
//               //           .toList(),
//               //     )
//               //         : SizedBox(),
//               //   ],
//               // ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Divider(
//                 height: 1,
//                 color: Color(0xFFD1D1D1),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         'Confidentiality Statement HIPAA',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff686464),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () async {
//                               FilePickerResult? result =
//                                   await FilePicker.platform.pickFiles();
//                               if (result != null) {
//                                 try {
//                                   hIPPAFiles.clear();
//                                   hIPPAFiles.addAll(
//                                       result.files.map((file) => file.bytes));
//                                   hIPPA.addAll(
//                                       result.files.map((file) => file.name!));
//                                   setState(() {
//                                     _documentUploaded = true;
//                                   });
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                               }
//                             },
//
//                             // onPressed:()async {
//                             //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
//                             //   //   allowMultiple: false,
//                             //   // );
//                             //   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                             //   if (result != null) {
//                             //     print("Result::: ${result}");
//                             //
//                             //     try{
//                             //       Uint8List? bytes = result.files.first.bytes;
//                             //       XFile xlfile = XFile(result.xFiles.first.path);
//                             //       xfileToFile = File(xlfile.path);
//                             //
//                             //       print("::::XFile To File ${xfileToFile.toString()}");
//                             //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
//                             //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//                             //       // html.File file = webFile.file;
//                             //       //  print("XFILE ${xFile.path}");
//                             //       //  //filePath = xfileToFile as XFile?;
//                             //       //  print("L::::::${filePath}");
//                             //       hIPPA.addAll(result.files.map((file) => file.name!));
//                             //       print('File picked: ${hIPPA}');
//                             //       //print(String.fromCharCodes(file));
//                             //       finalPath = result.files.first.bytes;
//                             //       setState(() {
//                             //         hIPPA;
//                             //         _documentUploaded = true;
//                             //       });
//                             //     }catch(e){
//                             //       print(e);
//                             //     }
//                             //   }
//                             // },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xff50B5E5),
//                               // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             child: Text(
//                               'Sign',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           _loading
//                               ? SizedBox(
//                                   width: 25,
//                                   height: 25,
//                                   child: CircularProgressIndicator(
//                                     color:
//                                         ColorManager.blueprime, // Loader color
//                                     // Loader size
//                                   ),
//                                 )
//                               : hIPPA.isNotEmpty
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: hIPPA
//                                           .map((fileName) => Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Text(
//                                                   'File picked: $fileName',
//                                                   style: GoogleFonts.firaSans(
//                                                       fontSize: 12.0,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: Color(0xff686464)),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                     )
//                                   : SizedBox(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Divider(
//                 height: 1,
//                 color: Color(0xFFD1D1D1),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         'Policy Concerning 3 RD Party',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff686464),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () async {
//                               FilePickerResult? result =
//                                   await FilePicker.platform.pickFiles();
//                               if (result != null) {
//                                 try {
//                                   rDpartyFiles.clear();
//                                   rDpartyFiles.addAll(
//                                       result.files.map((file) => file.bytes));
//                                   rDparty.addAll(
//                                       result.files.map((file) => file.name!));
//                                   setState(() {
//                                     _documentUploaded = true;
//                                   });
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                               }
//                             },
//
//                             // onPressed:()async {
//                             //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
//                             //   //   allowMultiple: false,
//                             //   // );
//                             //   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                             //   if (result != null) {
//                             //     print("Result::: ${result}");
//                             //
//                             //     try{
//                             //       Uint8List? bytes = result.files.first.bytes;
//                             //       XFile xlfile = XFile(result.xFiles.first.path);
//                             //       xfileToFile = File(xlfile.path);
//                             //
//                             //       print("::::XFile To File ${xfileToFile.toString()}");
//                             //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
//                             //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//                             //       // html.File file = webFile.file;
//                             //       //  print("XFILE ${xFile.path}");
//                             //       //  //filePath = xfileToFile as XFile?;
//                             //       //  print("L::::::${filePath}");
//                             //       rDparty.addAll(result.files.map((file) => file.name!));
//                             //       print('File picked: ${rDparty}');
//                             //       //print(String.fromCharCodes(file));
//                             //       finalPath = result.files.first.bytes;
//                             //       setState(() {
//                             //         rDparty;
//                             //         _documentUploaded = true;
//                             //       });
//                             //     }catch(e){
//                             //       print(e);
//                             //     }
//                             //   }
//                             // },
//                             // onPressed: () async {
//                             //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
//                             //   //   allowMultiple: false,
//                             //   // );
//                             //   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                             //   if (result != null) {
//                             //     print("Result::: ${result}");
//                             //
//                             //     try{
//                             //       Uint8List? bytes = result.files.first.bytes;
//                             //       XFile xlfile = XFile(result.xFiles.first.path);
//                             //       xfileToFile = File(xlfile.path);
//                             //
//                             //       print("::::XFile To File ${xfileToFile.toString()}");
//                             //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
//                             //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//                             //       // html.File file = webFile.file;
//                             //       //  print("XFILE ${xFile.path}");
//                             //       //  //filePath = xfileToFile as XFile?;
//                             //       //  print("L::::::${filePath}");
//                             //       fileName = result.files.first.name;
//                             //       print('File picked: ${fileName}');
//                             //       //print(String.fromCharCodes(file));
//                             //       finalPath = result.files.first.bytes;
//                             //       setState(() {
//                             //         fileName;
//                             //         _documentUploaded = true;
//                             //       });
//                             //     }catch(e){
//                             //       print(e);
//                             //     }
//                             //   }
//                             // },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xff50B5E5),
//                               // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             child: Text(
//                               'Sign',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           _loading
//                               ? SizedBox(
//                                   width: 25,
//                                   height: 25,
//                                   child: CircularProgressIndicator(
//                                     color:
//                                         ColorManager.blueprime, // Loader color
//                                     // Loader size
//                                   ),
//                                 )
//                               : rDparty.isNotEmpty
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: rDparty
//                                           .map((fileName) => Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Text(
//                                                   'File picked: $fileName',
//                                                   style: GoogleFonts.firaSans(
//                                                       fontSize: 12.0,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: Color(0xff686464)),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                     )
//                                   : SizedBox(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Divider(
//                 height: 1,
//                 color: Color(0xFFD1D1D1),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         'Standards Of Conduct',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff686464),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () async {
//                               FilePickerResult? result =
//                                   await FilePicker.platform.pickFiles();
//                               if (result != null) {
//                                 try {
//                                   soConductFiles.clear();
//                                   soConductFiles.addAll(
//                                       result.files.map((file) => file.bytes));
//                                   soConduct.addAll(
//                                       result.files.map((file) => file.name!));
//                                   setState(() {
//                                     _documentUploaded = true;
//                                   });
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                               }
//                             },
//                             // onPressed:()async {
//                             //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
//                             //   //   allowMultiple: false,
//                             //   // );
//                             //   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                             //   if (result != null) {
//                             //     print("Result::: ${result}");
//                             //
//                             //     try{
//                             //       Uint8List? bytes = result.files.first.bytes;
//                             //       XFile xlfile = XFile(result.xFiles.first.path);
//                             //       xfileToFile = File(xlfile.path);
//                             //
//                             //       print("::::XFile To File ${xfileToFile.toString()}");
//                             //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
//                             //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//                             //       // html.File file = webFile.file;
//                             //       //  print("XFILE ${xFile.path}");
//                             //       //  //filePath = xfileToFile as XFile?;
//                             //       //  print("L::::::${filePath}");
//                             //       soConduct.addAll(result.files.map((file) => file.name!));
//                             //       print('File picked: ${soConduct}');
//                             //       //print(String.fromCharCodes(file));
//                             //       finalPath = result.files.first.bytes;
//                             //       setState(() {
//                             //         soConduct;
//                             //         _documentUploaded = true;
//                             //       });
//                             //     }catch(e){
//                             //       print(e);
//                             //     }
//                             //   }
//                             // },
//
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xff50B5E5),
//                               // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             child: Text(
//                               'Sign',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           _loading
//                               ? SizedBox(
//                                   width: 25,
//                                   height: 25,
//                                   child: CircularProgressIndicator(
//                                     color:
//                                         ColorManager.blueprime, // Loader color
//                                     // Loader size
//                                   ),
//                                 )
//                               : soConduct.isNotEmpty
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: soConduct
//                                           .map((fileName) => Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Text(
//                                                   'File picked: $fileName',
//                                                   style: GoogleFonts.firaSans(
//                                                       fontSize: 12.0,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: Color(0xff686464)),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                     )
//                                   : SizedBox(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Divider(
//                 height: 1,
//                 color: Color(0xFFD1D1D1),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         'California Sexual Harassment Training',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff686464),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () async {
//                               FilePickerResult? result =
//                                   await FilePicker.platform.pickFiles();
//                               if (result != null) {
//                                 try {
//                                   harassmentFiles.clear();
//                                   harassmentFiles.addAll(
//                                       result.files.map((file) => file.bytes));
//                                   harassment.addAll(
//                                       result.files.map((file) => file.name!));
//                                   setState(() {
//                                     _documentUploaded = true;
//                                   });
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                               }
//                             },
//
//                             // onPressed:()async {
//                             //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
//                             //   //   allowMultiple: false,
//                             //   // );
//                             //   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                             //   if (result != null) {
//                             //     print("Result::: ${result}");
//                             //
//                             //     try{
//                             //       Uint8List? bytes = result.files.first.bytes;
//                             //       XFile xlfile = XFile(result.xFiles.first.path);
//                             //       xfileToFile = File(xlfile.path);
//                             //
//                             //       print("::::XFile To File ${xfileToFile.toString()}");
//                             //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
//                             //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//                             //       // html.File file = webFile.file;
//                             //       //  print("XFILE ${xFile.path}");
//                             //       //  //filePath = xfileToFile as XFile?;
//                             //       //  print("L::::::${filePath}");
//                             //       harassment.addAll(result.files.map((file) => file.name!));
//                             //       print('File picked: ${harassment}');
//                             //       //print(String.fromCharCodes(file));
//                             //       finalPath = result.files.first.bytes;
//                             //       setState(() {
//                             //         harassment;
//                             //         _documentUploaded = true;
//                             //       });
//                             //     }catch(e){
//                             //       print(e);
//                             //     }
//                             //   }
//                             // },
//
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xff50B5E5),
//                               // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             child: Text(
//                               'Sign',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           _loading
//                               ? SizedBox(
//                                   width: 25,
//                                   height: 25,
//                                   child: CircularProgressIndicator(
//                                     color:
//                                         ColorManager.blueprime, // Loader color
//                                     // Loader size
//                                   ),
//                                 )
//                               : harassment.isNotEmpty
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: harassment
//                                           .map((fileName) => Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Text(
//                                                   'File picked: $fileName',
//                                                   style: GoogleFonts.firaSans(
//                                                       fontSize: 12.0,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: Color(0xff686464)),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                     )
//                                   : SizedBox(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Divider(
//                 height: 1,
//                 color: Color(0xFFD1D1D1),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Prop65',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xff686464),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () async {
//                               FilePickerResult? result =
//                                   await FilePicker.platform.pickFiles();
//                               if (result != null) {
//                                 try {
//                                   propFiles.clear();
//                                   propFiles.addAll(
//                                       result.files.map((file) => file.bytes));
//                                   prop.addAll(
//                                       result.files.map((file) => file.name!));
//                                   setState(() {
//                                     _documentUploaded = true;
//                                   });
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                               }
//                             },
//
//                             //
//                             // onPressed:()async {
//                             //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
//                             //   //   allowMultiple: false,
//                             //   // );
//                             //   FilePickerResult? result = await FilePicker.platform.pickFiles();
//                             //   if (result != null) {
//                             //     print("Result::: ${result}");
//                             //
//                             //     try{
//                             //       Uint8List? bytes = result.files.first.bytes;
//                             //       XFile xlfile = XFile(result.xFiles.first.path);
//                             //       xfileToFile = File(xlfile.path);
//                             //
//                             //       print("::::XFile To File ${xfileToFile.toString()}");
//                             //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
//                             //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
//                             //       // html.File file = webFile.file;
//                             //       //  print("XFILE ${xFile.path}");
//                             //       //  //filePath = xfileToFile as XFile?;
//                             //       //  print("L::::::${filePath}");
//                             //       prop.addAll(result.files.map((file) => file.name!));
//                             //       print('File picked: ${prop}');
//                             //       //print(String.fromCharCodes(file));
//                             //       finalPath = result.files.first.bytes;
//                             //       setState(() {
//                             //         prop;
//                             //         _documentUploaded = true;
//                             //       });
//                             //     }catch(e){
//                             //       print(e);
//                             //     }
//                             //   }
//                             // },
//
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xff50B5E5),
//                               // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             child: Text(
//                               'Sign',
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           _loading
//                               ? SizedBox(
//                                   width: 25,
//                                   height: 25,
//                                   child: CircularProgressIndicator(
//                                     color:
//                                         ColorManager.blueprime, // Loader color
//                                     // Loader size
//                                   ),
//                                 )
//                               : prop.isNotEmpty
//                                   ? Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: prop
//                                           .map((fileName) => Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Text(
//                                                   'File picked: $fileName',
//                                                   style: GoogleFonts.firaSans(
//                                                       fontSize: 12.0,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: Color(0xff686464)),
//                                                 ),
//                                               ))
//                                           .toList(),
//                                     )
//                                   : SizedBox(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Divider(
//                 height: 1,
//                 color: Color(0xFFD1D1D1),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Return Of Company Policy',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xff686464),
//                     ),
//                   ),
//                   Icon(
//                     Icons.check,
//                     color: Colors.green,
//                     size: 24.0,
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 100),
//               Divider(
//                 height: 1,
//                 color: Color(0xFFD1D1D1),
//               ),
//
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
// //                   ElevatedButton(
// //                     onPressed: () async {
// //                       if (onCAllFiles.isEmpty&& hIPPAFiles.isEmpty && rDpartyFiles.isEmpty&&  soConductFiles.isEmpty && harassmentFiles.isEmpty &&propFiles.isEmpty) {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(
// //                             content: Text(
// //                                 'No files selected. Please select files to upload.'),
// //                             backgroundColor: Colors.red,
// //                           ),
// //                         );
// //                         return;
// //                       }
// //
// //                       try {
// //
// //                         for (var file in onCAllFiles) {
// //                           await uploadDocuments(
// //                               context: context,
// //                               employeeDocumentMetaId: 10,
// //                               employeeDocumentTypeSetupId: 48,
// //                               employeeId: 2,
// //                               documentFile: file,
// //                               documentName: 'on call');
// //                         }
// //                         for (var file in hIPPAFiles) {
// //                           await uploadDocuments(
// //                               context: context,
// //                               employeeDocumentMetaId: 10,
// //                               employeeDocumentTypeSetupId: 48,
// //                               employeeId: 2,
// //                               documentFile: file,
// //                               documentName: 'Hippa');
// //                         }
// //                         for (var file in rDpartyFiles) {
// //                           await uploadDocuments(
// //                               context: context,
// //                               employeeDocumentMetaId: 10,
// //                               employeeDocumentTypeSetupId: 48,
// //                               employeeId: 2,
// //                               documentFile: file,
// //                               documentName: 'R D party');
// //                         }
// //
// //
// //
// //
// // // Upload "Standards Of Conduct" documents
// //                         for (var file in soConductFiles) {
// //                           await uploadDocuments(
// //                               context: context,
// //                               employeeDocumentMetaId: 10,
// //                               employeeDocumentTypeSetupId: 48,
// //                               employeeId: 2,
// //                               documentFile: file,
// //                               documentName: 'Standards Of Conduct');
// //                         }
// //
// // // Upload "California Sexual Harassment Training" documents
// //                         for (var file in harassmentFiles) {
// //                           await uploadDocuments(
// //                               context: context,
// //                               employeeDocumentMetaId: 10,
// //                               employeeDocumentTypeSetupId: 48,
// //                               employeeId: 2,
// //                               documentFile: file,
// //                               documentName:
// //                                   'California Sexual Harassment Training');
// //                         }
// //                         for (var file in propFiles) {
// //                           await uploadDocuments(
// //                               context: context,
// //                               employeeDocumentMetaId: 10,
// //                               employeeDocumentTypeSetupId: 48,
// //                               employeeId: 2,
// //                               documentFile: file,
// //                               documentName:
// //                               'Prop65');
// //                         }
// //
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(
// //                             content: Text('Documents uploaded successfully!'),
// //                             backgroundColor: Colors.green,
// //                           ),
// //                         );
// //                       } catch (e) {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(
// //                             content: Text('Failed to upload documents: $e'),
// //                             backgroundColor: Colors.red,
// //                           ),
// //                         );
// //                       }
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Color(0xff50B5E5),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8.0),
// //                       ),
// //                     ),
// //                     child: Text(
// //                       'Save',
// //                       style: GoogleFonts.firaSans(
// //                         fontSize: 14.0,
// //                         fontWeight: FontWeight.w700,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                   ),
//
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
//                     onPressed: () async {
//                       if (onCAllFiles.isEmpty&& hIPPAFiles.isEmpty && rDpartyFiles.isEmpty&&  soConductFiles.isEmpty && harassmentFiles.isEmpty &&propFiles.isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                                 'No files selected. Please select files to upload.'),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                         return;
//                       }
//
//                       try {
//
//                         for (var file in onCAllFiles) {
//                           await uploadDocuments(
//                               context: context,
//                               employeeDocumentMetaId: 10,
//                               employeeDocumentTypeSetupId: 48,
//                               employeeId: 2,
//                               documentFile: file,
//                               documentName: 'on call');
//                         }
//                         for (var file in hIPPAFiles) {
//                           await uploadDocuments(
//                               context: context,
//                               employeeDocumentMetaId: 10,
//                               employeeDocumentTypeSetupId: 48,
//                               employeeId: 2,
//                               documentFile: file,
//                               documentName: 'Hippa');
//                         }
//                         for (var file in rDpartyFiles) {
//                           await uploadDocuments(
//                               context: context,
//                               employeeDocumentMetaId: 10,
//                               employeeDocumentTypeSetupId: 48,
//                               employeeId: 2,
//                               documentFile: file,
//                               documentName: 'R D party');
//                         }
//
//
//
//
// // Upload "Standards Of Conduct" documents
//                         for (var file in soConductFiles) {
//                           await uploadDocuments(
//                               context: context,
//                               employeeDocumentMetaId: 10,
//                               employeeDocumentTypeSetupId: 48,
//                               employeeId: 2,
//                               documentFile: file,
//                               documentName: 'Standards Of Conduct');
//                         }
//
// // Upload "California Sexual Harassment Training" documents
//                         for (var file in harassmentFiles) {
//                           await uploadDocuments(
//                               context: context,
//                               employeeDocumentMetaId: 10,
//                               employeeDocumentTypeSetupId: 48,
//                               employeeId: 2,
//                               documentFile: file,
//                               documentName:
//                               'California Sexual Harassment Training');
//                         }
//                         for (var file in propFiles) {
//                           await uploadDocuments(
//                               context: context,
//                               employeeDocumentMetaId: 10,
//                               employeeDocumentTypeSetupId: 48,
//                               employeeId: 2,
//                               documentFile: file,
//                               documentName:
//                               'Prop65');
//                         }
//
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Documents uploaded successfully!'),
//                             backgroundColor: Colors.green,
//                           ),
//                         );
//                       } catch (e) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Failed to upload documents: $e'),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       }
//                     },
//
//
//
//                     //
//                     // onPressed: () async {
//                     //   if (finalPath == null || finalPath.isEmpty) {
//                     //
//                     //     ScaffoldMessenger.of(context).showSnackBar(
//                     //       SnackBar(
//                     //         content: Text('No file selected. Please select a file to upload.'),
//                     //         backgroundColor: Colors.red,
//                     //       ),
//                     //     );
//                     //   } else {
//                     //
//                     //     try {
//                     //       await uploadDocuments(
//                     //           context: context,
//                     //           employeeDocumentMetaId: 10,
//                     //           employeeDocumentTypeSetupId: 48,
//                     //           employeeId: 2,
//                     //           documentFile: finalPath,
//                     //           documentName: 'Legal Document ID'
//                     //       );
//                     //
//                     //
//                     //       ScaffoldMessenger.of(context).showSnackBar(
//                     //         SnackBar(
//                     //           content: Text('Document uploaded successfully!'),
//                     //           backgroundColor: Colors.green,
//                     //         ),
//                     //       );
//                     //     } catch (e) {
//                     //
//                     //       ScaffoldMessenger.of(context).showSnackBar(
//                     //         SnackBar(
//                     //           content: Text('Failed to upload document: $e'),
//                     //           backgroundColor: Colors.red,
//                     //         ),
//                     //       );
//                     //     }
//                     //   }
//                     // },
//
//                     // },
//
//                   ),
//                 ],
//               )
