import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import '../../../../../../../app/constants/app_config.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/progress_form_manager/form_health_record_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_health_record_data.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';

class AcknowledgementsScreen extends StatefulWidget {
  final int employeeID;
  final Function onSave;
  final Function onBack;
  final Function onNext;
  const AcknowledgementsScreen({
    super.key,
    required this.context,
    required this.employeeID, required this.onSave, required this.onBack, required this.onNext,
  });

  final BuildContext context;

  @override
  State<AcknowledgementsScreen> createState() => _AcknowledgementsScreenState();
}

class _AcknowledgementsScreenState extends State<AcknowledgementsScreen> {


  final StreamController<List<HREmployeeDocumentModal>> acknowledgements = StreamController<List<HREmployeeDocumentModal>>();

  bool isLoading = false;

  bool fileAbove20Mb = false;
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


  // bool _isButtonPressed = false;
  //
  // void _handleButtonPress() {
  //   setState(() {
  //     _isButtonPressed = true;
  //   });
  //
  //   Future.delayed(Duration(seconds: 3), () {
  //     if (mounted) {
  //       // Check if the widget is still mounted
  //       setState(() {
  //         _isButtonPressed = true; // Update the state to show the icon
  //       });
  //     }
  //   });
  // }

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
  //
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

  ////////////////////////////////////

  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic? filePath;
  File? xfileToFile;
  List<int> docSetupId = [];


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
              style:FormHeading.customTextStyle(context)
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
                textAlign: TextAlign.center,
                style:ZoneDataStyle.customTextStyle(context),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'List Of Documents',
                  style: HeadingFormStyle.customTextStyle(context),
                ),

              ],
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
                        // Assign or retrieve the docSetupId dynamically here
                        int setupId = document.employeeDocTypesetupId; // Assuming 'setupId' is a property of the document
                        print("Document");

                        // If you need to create your own logic, you could do something like:
                        // int setupId = index + 1; // Just an example: setupId starts at 1 for the first item

                        if (docSetupId.length <= index) {
                          docSetupId.add(setupId);
                          print('Document ${docSetupId}');
                        } else {
                          docSetupId[index] = setupId;
                        }

                        return Column(
                          children: [
                            SizedBox(
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      document.docName,
                                      style: DefineWorkWeekStyle.customTextStyle(context),
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                    type: FileType.custom,
                                                    allowedExtensions: ['pdf']
                                                );
                                                final fileSize = result?.files.first.size; // File size in bytes
                                                final isAbove20MB = fileSize! > (20 * 1024 * 1024);
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
                                                        fileAbove20Mb = !isAbove20MB;
                                                      });
                                                    }
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xff50B5E5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                              ),
                                              child: Text(
                                                'Upload File',
                                                style: BlueButtonTextConst.customTextStyle(context),
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
                                                style:onlyFormDataStyle.customTextStyle(context),
                                              ),
                                            )
                                                : SizedBox(),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
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
                  : CustomButton(
                width: 117,
                height: 30,
                text: 'Save',
                style:BlueButtonTextConst.customTextStyle(context),
                borderRadius: 12,
                onPressed: () async {


    if (finalPaths == null || finalPaths.isEmpty) {
    // if (finalPath == null || finalPath.isEmpty) {
    await showDialog(
    context: context,
    builder: (BuildContext context) {
    return VendorSelectNoti(
    message: 'Please Select File',
    );
    },
    );

    //    ScaffoldMessenger.of(context).showSnackBar(
    //      const SnackBar(
    //        content: Text(
    //            'No file selected. Please select a file to upload.'),
    //        backgroundColor: Colors.red,
    //      ),
    //    );
    } else {
    if (fileAbove20Mb) {
    try {

    // Loop through each form and extract data to post

    setState(() {
    isLoading = true; // Start loading
    });

    for (int i = 0; i < finalPaths.length; i++) {
    if (finalPaths[i] != null) {
    await uploadDocuments(
    context: context,
    employeeDocumentMetaId: AppConfig.employeeDocumentTypeMetaDataId,
    employeeDocumentTypeSetupId: docSetupId[i],
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

    await showDialog(context: context,
    builder: (BuildContext context) {
    return const AddSuccessPopup(
    message: 'Document Uploaded Successfully',
    );
    },
    );
    await widget.onSave();
    } catch (e) {

    await showDialog(
    context: context,
    builder: (BuildContext context) {
    return const AddFailePopup(
    message: 'Failed To Upoad Document',
    );
    },
    );

    }

    }  else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddErrorPopup(
            message: 'File is too large!',
          );
        },
      );
    }
    setState(() {
    isLoading = false; // End loading
    });

}
    },

                child:  Text(
                  'Save',
                  style: BlueButtonTextConst.customTextStyle(context),
                ),

              ),
              const SizedBox(
                width: AppSize.s30,
              ),
              Container(
                //color: Colors.white,
                width: 117,
                height: 30,
                child: ElevatedButton(
                  onPressed: (){
                    widget.onNext();
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
                  child: Text('Next',
                    style: TransparentButtonTextConst.customTextStyle(context),
                  ),),
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

































// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
// import 'package:xfile/xfile.dart'; // For XFile
// import 'dart:html' as html;

// Ensure WebFile and other required imports are available

// class DocumentUploader extends StatefulWidget {
//   final String employeeID;
//
//   DocumentUploader({required this.employeeID});
//
//   @override
//   _DocumentUploaderState createState() => _DocumentUploaderState();
// }
//
// class _DocumentUploaderState extends State<DocumentUploader> {
//   List<String> _fileNames = [];
//   List<Uint8List?> _fileBytes = [];
//   bool _loading = false;
//
//   Future<void> _pickFile(int index) async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles();
//       if (result != null) {
//         Uint8List? bytes = result.files.first.bytes;
//         if (bytes != null) {
//           setState(() {
//             if (_fileNames.length <= index) {
//               _fileNames.add(result.files.first.name!);
//             } else {
//               _fileNames[index] = result.files.first.name!;
//             }
//
//             if (_fileBytes.length <= index) {
//               _fileBytes.add(bytes);
//             } else {
//               _fileBytes[index] = bytes;
//             }
//           });
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> _saveFiles() async {
//     if (_fileBytes.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No file selected. Please select a file to upload.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     setState(() {
//       _loading = true;
//     });
//
//     try {
//       for (int i = 0; i < _fileBytes.length; i++) {
//         if (_fileBytes[i] != null) {
//           await uploadDocuments(
//             context: context,
//             employeeDocumentMetaId: 10,
//             employeeDocumentTypeSetupId: 48,
//             employeeId: widget.employeeID,
//             documentFile: _fileBytes[i]!,
//             documentName: _fileNames[i],
//           );
//         }
//       }
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Documents uploaded successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to upload documents: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         children: [
//           Center(
//             child: Text(
//               'Acknowledgements',
//               style: GoogleFonts.firaSans(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xff50B5E5),
//               ),
//             ),
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height / 60),
//           Container(
//             height: 50,
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             decoration: BoxDecoration(
//               color: Color(0xFFE6F7FF),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Center(
//               child: Text(
//                 'Please sign the list of documents required for the recruitment process',
//                 style: GoogleFonts.firaSans(
//                   color: Color(0xFF686464),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height / 20),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               'List Of Documents',
//               style: GoogleFonts.firaSans(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xff686464),
//               ),
//             ),
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height / 10),
//           Expanded(
//             child: StreamBuilder<List<HREmployeeDocumentModal>>(
//               stream: acknowledgements.stream,
//               builder: (BuildContext context,
//                   AsyncSnapshot<List<HREmployeeDocumentModal>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text("Error: ${snapshot.error}"));
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(child: Text("No documents found"));
//                 } else {
//                   List<HREmployeeDocumentModal> documents = snapshot.data!;
//
//                   if (_fileNames.length < documents.length) {
//                     _fileNames.addAll(
//                       List.generate(
//                         documents.length - _fileNames.length,
//                             (_) => '',
//                       ),
//                     );
//                   }
//
//                   if (_fileBytes.length < documents.length) {
//                     _fileBytes.addAll(
//                       List.generate(
//                         documents.length - _fileBytes.length,
//                             (_) => null,
//                       ),
//                     );
//                   }
//
//                   return ListView.builder(
//                     itemCount: documents.length,
//                     itemBuilder: (context, index) {
//                       final document = documents[index];
//                       final fileName =
//                       index < _fileNames.length ? _fileNames[index] : '';
//
//                       return Column(
//                         children: [
//                           SizedBox(
//                             height: 50,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   document.docName,
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 14.0,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xff686464),
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     ElevatedButton(
//                                       onPressed: () => _pickFile(index),
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Color(0xff50B5E5),
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
//                                         color: ColorManager.blueprime,
//                                       ),
//                                     )
//                                         : fileName.isNotEmpty
//                                         ? Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         'File picked: $fileName',
//                                         style: GoogleFonts.firaSans(
//                                           fontSize: 12.0,
//                                           fontWeight: FontWeight.w400,
//                                           color: Color(0xff686464),
//                                         ),
//                                       ),
//                                     )
//                                         : SizedBox(),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Divider(
//                             height: 1,
//                             color: Color(0xFFD1D1D1),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: _saveFiles,
//                 style: ElevatedButton.styleFrom(
//                   primary: Color(0xff50B5E5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   'Save',
//                   style: TextStyle(
//                     fontFamily: 'FiraSans',
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Future<void> uploadDocuments({
//   required BuildContext context,
//   required int employeeDocumentMetaId,
//   required int employeeDocumentTypeSetupId,
//   required String employeeId,
//   required Uint8List documentFile,
//   required String documentName,
// }) async {
//   // Implement your document upload logic here
// }



























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
