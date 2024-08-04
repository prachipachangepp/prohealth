
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';

class AcknowledgementsScreen extends StatefulWidget {
  const AcknowledgementsScreen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<AcknowledgementsScreen> createState() => _AcknowledgementsScreenState();
}

class _AcknowledgementsScreenState extends State<AcknowledgementsScreen> {


  bool _isButtonPressed = false;

  void _handleButtonPress() {
    setState(() {
      _isButtonPressed = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      if (mounted) { // Check if the widget is still mounted
        setState(() {
          _isButtonPressed = true; // Update the state to show the icon
        });
      }
    });
  }


   List<String> _fileNames = [];
  List<String>onCAll =[];
  List<String>hIPPA =[];
  List<String>rDparty =[];
  List<String>soConduct =[];
  List<String>harassment =[];
  List<String>prop =[];
  List<String>rocp =[];


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
  var finalPath;
  // PlatformFile? fileName;

  Future<WebFile> saveFileFromBytes(dynamic bytes, String fileName) async {
    // Get the directory to save the file.
    final blob = html.Blob(bytes);
    final url = html.Url.createObjectUrlFromBlob(blob);


    // Create the file.
    //final anchor = html.AnchorElement(href: url)..setAttribute("download", fileName)..click();
    final file = html.File([blob],fileName);
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



  ////////////////////////////
  ///////
  //


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  Column(
                    children: [
                      Text(
                        'On - call',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed:()async {
                              // FilePickerResult? result = await FilePicker.platform.pickFiles(
                              //   allowMultiple: false,
                              // );
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                print("Result::: ${result}");

                                try{
                                  Uint8List? bytes = result.files.first.bytes;
                                  XFile xlfile = XFile(result.xFiles.first.path);
                                  xfileToFile = File(xlfile.path);

                                  print("::::XFile To File ${xfileToFile.toString()}");
                                  XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                                  // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                                  // html.File file = webFile.file;
                                  //  print("XFILE ${xFile.path}");
                                  //  //filePath = xfileToFile as XFile?;
                                  //  print("L::::::${filePath}");
                                  onCAll.addAll(result.files.map((file) => file.name!));
                                  print('File picked: ${onCAll}');
                                  //print(String.fromCharCodes(file));
                                  finalPath = result.files.first.bytes;
                                  setState(() {
                                    onCAll;
                                    _documentUploaded = true;
                                  });
                                }catch(e){
                                  print(e);
                                }
                              }
                            },
                            // onPressed: () async {
                            //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
                            //   //   allowMultiple: false,
                            //   // );
                            //   FilePickerResult? result = await FilePicker.platform.pickFiles();
                            //   if (result != null) {
                            //     print("Result::: ${result}");
                            //
                            //     try{
                            //       Uint8List? bytes = result.files.first.bytes;
                            //       XFile xlfile = XFile(result.xFiles.first.path);
                            //       xfileToFile = File(xlfile.path);
                            //
                            //       print("::::XFile To File ${xfileToFile.toString()}");
                            //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                            //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                            //       // html.File file = webFile.file;
                            //       //  print("XFILE ${xFile.path}");
                            //       //  //filePath = xfileToFile as XFile?;
                            //       //  print("L::::::${filePath}");
                            //       fileName = result.files.first.name;
                            //       print('File picked: ${fileName}');
                            //       //print(String.fromCharCodes(file));
                            //       finalPath = result.files.first.bytes;
                            //       setState(() {
                            //         fileName;
                            //         _documentUploaded = true;
                            //       });
                            //     }catch(e){
                            //       print(e);
                            //     }
                            //   }
                            // },
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
                          _loading
                              ? SizedBox(width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime, // Loader color
                              // Loader size
                            ),
                          )
                              : onCAll.isNotEmpty
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: onCAll
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
                        ],
                      ),

                    ],
                  ),

                ],
              ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'On - call',
          //       style: GoogleFonts.firaSans(
          //         fontSize: 14.0,
          //         fontWeight: FontWeight.w500,
          //         color: Color(0xff686464),
          //       ),
          //     ),
          //     _isButtonPressed
          //         ? Icon(
          //       Icons.check,
          //       color: Colors.green,
          //       size: 24.0,
          //     )
          //         : ElevatedButton(
          //
          //       onPressed: ()
          //       async {
          //         // FilePickerResult? result = await FilePicker.platform.pickFiles(
          //         //   allowMultiple: false,
          //         // );
          //         FilePickerResult? result = await FilePicker.platform.pickFiles();
          //         if (result != null) {
          //           print("Result::: ${result}");
          //
          //           try{
          //             Uint8List? bytes = result.files.first.bytes;
          //             XFile xlfile = XFile(result.xFiles.first.path);
          //             xfileToFile = File(xlfile.path);
          //
          //             print("::::XFile To File ${xfileToFile.toString()}");
          //             XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
          //             // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
          //             // html.File file = webFile.file;
          //             //  print("XFILE ${xFile.path}");
          //             //  //filePath = xfileToFile as XFile?;
          //             //  print("L::::::${filePath}");
          //             fileName = result.files.first.name;
          //             print('File picked: ${fileName}');
          //             //print(String.fromCharCodes(file));
          //             finalPath = result.files.first.bytes;
          //             setState(() {
          //               fileName;
          //               _documentUploaded = true;
          //               _handleButtonPress;
          //             });
          //           }catch(e){
          //             print(e);
          //           }
          //         }
          //
          //
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: Color(0xff50B5E5),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8.0),
          //         ),
          //       ),
          //       child: Text(
          //         'Sign',
          //         style: GoogleFonts.firaSans(
          //           fontSize: 14.0,
          //           fontWeight: FontWeight.w700,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //     _loading
          //         ? SizedBox(width: 25,
          //       height: 25,
          //       child: CircularProgressIndicator(
          //         color: ColorManager.blueprime, // Loader color
          //         // Loader size
          //       ),
          //     )
          //         : _fileNames.isNotEmpty
          //         ? Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: _fileNames
          //           .map((fileName) => Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text(
          //           'File picked: $fileName',
          //           style: GoogleFonts.firaSans(
          //               fontSize: 12.0,
          //               fontWeight: FontWeight.w400,
          //               color: Color(0xff686464)),
          //         ),
          //       ))
          //           .toList(),
          //     )
          //         : SizedBox(),
              //   ],
          // ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Divider(
                height: 1,
                color: Color(0xFFD1D1D1),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Confidentiality Statement HIPAA',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed:()async {
                              // FilePickerResult? result = await FilePicker.platform.pickFiles(
                              //   allowMultiple: false,
                              // );
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                print("Result::: ${result}");

                                try{
                                  Uint8List? bytes = result.files.first.bytes;
                                  XFile xlfile = XFile(result.xFiles.first.path);
                                  xfileToFile = File(xlfile.path);

                                  print("::::XFile To File ${xfileToFile.toString()}");
                                  XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                                  // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                                  // html.File file = webFile.file;
                                  //  print("XFILE ${xFile.path}");
                                  //  //filePath = xfileToFile as XFile?;
                                  //  print("L::::::${filePath}");
                                  hIPPA.addAll(result.files.map((file) => file.name!));
                                  print('File picked: ${hIPPA}');
                                  //print(String.fromCharCodes(file));
                                  finalPath = result.files.first.bytes;
                                  setState(() {
                                    hIPPA;
                                    _documentUploaded = true;
                                  });
                                }catch(e){
                                  print(e);
                                }
                              }
                            },
                            // onPressed: () async {
                            //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
                            //   //   allowMultiple: false,
                            //   // );
                            //   FilePickerResult? result = await FilePicker.platform.pickFiles();
                            //   if (result != null) {
                            //     print("Result::: ${result}");
                            //
                            //     try{
                            //       Uint8List? bytes = result.files.first.bytes;
                            //       XFile xlfile = XFile(result.xFiles.first.path);
                            //       xfileToFile = File(xlfile.path);
                            //
                            //       print("::::XFile To File ${xfileToFile.toString()}");
                            //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                            //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                            //       // html.File file = webFile.file;
                            //       //  print("XFILE ${xFile.path}");
                            //       //  //filePath = xfileToFile as XFile?;
                            //       //  print("L::::::${filePath}");
                            //       fileName = result.files.first.name;
                            //       print('File picked: ${fileName}');
                            //       //print(String.fromCharCodes(file));
                            //       finalPath = result.files.first.bytes;
                            //       setState(() {
                            //         fileName;
                            //         _documentUploaded = true;
                            //       });
                            //     }catch(e){
                            //       print(e);
                            //     }
                            //   }
                            // },
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
                          _loading
                              ? SizedBox(width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime, // Loader color
                              // Loader size
                            ),
                          )
                              : hIPPA.isNotEmpty
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: hIPPA
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
                        ],
                      ),

                    ],
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
                  Column(
                    children: [
                      Text(
                        'Policy Concerning 3 RD Party',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed:()async {
                              // FilePickerResult? result = await FilePicker.platform.pickFiles(
                              //   allowMultiple: false,
                              // );
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                print("Result::: ${result}");

                                try{
                                  Uint8List? bytes = result.files.first.bytes;
                                  XFile xlfile = XFile(result.xFiles.first.path);
                                  xfileToFile = File(xlfile.path);

                                  print("::::XFile To File ${xfileToFile.toString()}");
                                  XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                                  // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                                  // html.File file = webFile.file;
                                  //  print("XFILE ${xFile.path}");
                                  //  //filePath = xfileToFile as XFile?;
                                  //  print("L::::::${filePath}");
                                  rDparty.addAll(result.files.map((file) => file.name!));
                                  print('File picked: ${rDparty}');
                                  //print(String.fromCharCodes(file));
                                  finalPath = result.files.first.bytes;
                                  setState(() {
                                    rDparty;
                                    _documentUploaded = true;
                                  });
                                }catch(e){
                                  print(e);
                                }
                              }
                            },
                            // onPressed: () async {
                            //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
                            //   //   allowMultiple: false,
                            //   // );
                            //   FilePickerResult? result = await FilePicker.platform.pickFiles();
                            //   if (result != null) {
                            //     print("Result::: ${result}");
                            //
                            //     try{
                            //       Uint8List? bytes = result.files.first.bytes;
                            //       XFile xlfile = XFile(result.xFiles.first.path);
                            //       xfileToFile = File(xlfile.path);
                            //
                            //       print("::::XFile To File ${xfileToFile.toString()}");
                            //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                            //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                            //       // html.File file = webFile.file;
                            //       //  print("XFILE ${xFile.path}");
                            //       //  //filePath = xfileToFile as XFile?;
                            //       //  print("L::::::${filePath}");
                            //       fileName = result.files.first.name;
                            //       print('File picked: ${fileName}');
                            //       //print(String.fromCharCodes(file));
                            //       finalPath = result.files.first.bytes;
                            //       setState(() {
                            //         fileName;
                            //         _documentUploaded = true;
                            //       });
                            //     }catch(e){
                            //       print(e);
                            //     }
                            //   }
                            // },
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
                          _loading
                              ? SizedBox(width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime, // Loader color
                              // Loader size
                            ),
                          )
                              : rDparty.isNotEmpty
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: rDparty
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
                        ],
                      ),

                    ],
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
                  Column(
                    children: [
                      Text(
                        'Standards Of Conduct',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed:()async {
                              // FilePickerResult? result = await FilePicker.platform.pickFiles(
                              //   allowMultiple: false,
                              // );
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                print("Result::: ${result}");

                                try{
                                  Uint8List? bytes = result.files.first.bytes;
                                  XFile xlfile = XFile(result.xFiles.first.path);
                                  xfileToFile = File(xlfile.path);

                                  print("::::XFile To File ${xfileToFile.toString()}");
                                  XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                                  // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                                  // html.File file = webFile.file;
                                  //  print("XFILE ${xFile.path}");
                                  //  //filePath = xfileToFile as XFile?;
                                  //  print("L::::::${filePath}");
                                  soConduct.addAll(result.files.map((file) => file.name!));
                                  print('File picked: ${soConduct}');
                                  //print(String.fromCharCodes(file));
                                  finalPath = result.files.first.bytes;
                                  setState(() {
                                    soConduct;
                                    _documentUploaded = true;
                                  });
                                }catch(e){
                                  print(e);
                                }
                              }
                            },
                            // onPressed: () async {
                            //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
                            //   //   allowMultiple: false,
                            //   // );
                            //   FilePickerResult? result = await FilePicker.platform.pickFiles();
                            //   if (result != null) {
                            //     print("Result::: ${result}");
                            //
                            //     try{
                            //       Uint8List? bytes = result.files.first.bytes;
                            //       XFile xlfile = XFile(result.xFiles.first.path);
                            //       xfileToFile = File(xlfile.path);
                            //
                            //       print("::::XFile To File ${xfileToFile.toString()}");
                            //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                            //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                            //       // html.File file = webFile.file;
                            //       //  print("XFILE ${xFile.path}");
                            //       //  //filePath = xfileToFile as XFile?;
                            //       //  print("L::::::${filePath}");
                            //       fileName = result.files.first.name;
                            //       print('File picked: ${fileName}');
                            //       //print(String.fromCharCodes(file));
                            //       finalPath = result.files.first.bytes;
                            //       setState(() {
                            //         fileName;
                            //         _documentUploaded = true;
                            //       });
                            //     }catch(e){
                            //       print(e);
                            //     }
                            //   }
                            // },
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
                          _loading
                              ? SizedBox(width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime, // Loader color
                              // Loader size
                            ),
                          )
                              : soConduct.isNotEmpty
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: soConduct
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
                        ],
                      ),

                    ],
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
                  Column(
                    children: [
                      Text(
                        'California Sexual Harassment Training',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed:()async {
                              // FilePickerResult? result = await FilePicker.platform.pickFiles(
                              //   allowMultiple: false,
                              // );
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                print("Result::: ${result}");

                                try{
                                  Uint8List? bytes = result.files.first.bytes;
                                  XFile xlfile = XFile(result.xFiles.first.path);
                                  xfileToFile = File(xlfile.path);

                                  print("::::XFile To File ${xfileToFile.toString()}");
                                  XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                                  // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                                  // html.File file = webFile.file;
                                  //  print("XFILE ${xFile.path}");
                                  //  //filePath = xfileToFile as XFile?;
                                  //  print("L::::::${filePath}");
                                  harassment.addAll(result.files.map((file) => file.name!));
                                  print('File picked: ${harassment}');
                                  //print(String.fromCharCodes(file));
                                  finalPath = result.files.first.bytes;
                                  setState(() {
                                    harassment;
                                    _documentUploaded = true;
                                  });
                                }catch(e){
                                  print(e);
                                }
                              }
                            },
                            // onPressed: () async {
                            //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
                            //   //   allowMultiple: false,
                            //   // );
                            //   FilePickerResult? result = await FilePicker.platform.pickFiles();
                            //   if (result != null) {
                            //     print("Result::: ${result}");
                            //
                            //     try{
                            //       Uint8List? bytes = result.files.first.bytes;
                            //       XFile xlfile = XFile(result.xFiles.first.path);
                            //       xfileToFile = File(xlfile.path);
                            //
                            //       print("::::XFile To File ${xfileToFile.toString()}");
                            //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                            //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                            //       // html.File file = webFile.file;
                            //       //  print("XFILE ${xFile.path}");
                            //       //  //filePath = xfileToFile as XFile?;
                            //       //  print("L::::::${filePath}");
                            //       fileName = result.files.first.name;
                            //       print('File picked: ${fileName}');
                            //       //print(String.fromCharCodes(file));
                            //       finalPath = result.files.first.bytes;
                            //       setState(() {
                            //         fileName;
                            //         _documentUploaded = true;
                            //       });
                            //     }catch(e){
                            //       print(e);
                            //     }
                            //   }
                            // },
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
                          _loading
                              ? SizedBox(width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime, // Loader color
                              // Loader size
                            ),
                          )
                              : harassment.isNotEmpty
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: harassment
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
                        ],
                      ),

                    ],
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
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed:()async {
                              // FilePickerResult? result = await FilePicker.platform.pickFiles(
                              //   allowMultiple: false,
                              // );
                              FilePickerResult? result = await FilePicker.platform.pickFiles();
                              if (result != null) {
                                print("Result::: ${result}");

                                try{
                                  Uint8List? bytes = result.files.first.bytes;
                                  XFile xlfile = XFile(result.xFiles.first.path);
                                  xfileToFile = File(xlfile.path);

                                  print("::::XFile To File ${xfileToFile.toString()}");
                                  XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                                  // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                                  // html.File file = webFile.file;
                                  //  print("XFILE ${xFile.path}");
                                  //  //filePath = xfileToFile as XFile?;
                                  //  print("L::::::${filePath}");
                                  prop.addAll(result.files.map((file) => file.name!));
                                  print('File picked: ${prop}');
                                  //print(String.fromCharCodes(file));
                                  finalPath = result.files.first.bytes;
                                  setState(() {
                                    prop;
                                    _documentUploaded = true;
                                  });
                                }catch(e){
                                  print(e);
                                }
                              }
                            },
                            // onPressed: () async {
                            //   // FilePickerResult? result = await FilePicker.platform.pickFiles(
                            //   //   allowMultiple: false,
                            //   // );
                            //   FilePickerResult? result = await FilePicker.platform.pickFiles();
                            //   if (result != null) {
                            //     print("Result::: ${result}");
                            //
                            //     try{
                            //       Uint8List? bytes = result.files.first.bytes;
                            //       XFile xlfile = XFile(result.xFiles.first.path);
                            //       xfileToFile = File(xlfile.path);
                            //
                            //       print("::::XFile To File ${xfileToFile.toString()}");
                            //       XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                            //       // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                            //       // html.File file = webFile.file;
                            //       //  print("XFILE ${xFile.path}");
                            //       //  //filePath = xfileToFile as XFile?;
                            //       //  print("L::::::${filePath}");
                            //       fileName = result.files.first.name;
                            //       print('File picked: ${fileName}');
                            //       //print(String.fromCharCodes(file));
                            //       finalPath = result.files.first.bytes;
                            //       setState(() {
                            //         fileName;
                            //         _documentUploaded = true;
                            //       });
                            //     }catch(e){
                            //       print(e);
                            //     }
                            //   }
                            // },
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
                          _loading
                              ? SizedBox(width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime, // Loader color
                              // Loader size
                            ),
                          )
                              : prop.isNotEmpty
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: prop
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
                        ],
                      ),

                    ],
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

              SizedBox(height: 20,),
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
                      if (finalPath == null || finalPath.isEmpty) {

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
                              documentFile: finalPath,
                              documentName: 'Legal Document ID'
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
                    },
                    // onPressed: () async{
                    //   try{
                    //     //File filePath = File(finalPath!);
                    //     await uploadDocuments(context: context, employeeDocumentMetaId: 10, employeeDocumentTypeSetupId: 48,
                    //         employeeId: 2, documentName:fileName,
                    //         documentFile: finalPath, //documentName: 'Acknowledgment ID'
                    //
                    //     );
                    //   }catch(e){
                    //     print(e);
                    //   }
                    //
                    // },

                  ),


                ],
              )
            ],
          ),
        ),

      ),
    );
  }
}