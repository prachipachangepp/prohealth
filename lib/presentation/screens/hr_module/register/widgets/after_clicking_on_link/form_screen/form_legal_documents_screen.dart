import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../form_nine_screen.dart';

class LegalDocumentsScreen extends StatefulWidget {
  const LegalDocumentsScreen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<LegalDocumentsScreen> createState() => _LegalDocumentsScreenState();
}

class _LegalDocumentsScreenState extends State<LegalDocumentsScreen> {


  List<String> _fileNames = [];
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
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 166, right: 166),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Legal Documents',
                      style: GoogleFonts.firaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff50B5E5)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  Container(
                    //color: Colors.redAccent,
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
                        'Please add information about your legal documents',
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
                      Expanded(
                        child: Text(
                          'Upload one of your government ids ( e.g. drivers license )',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff686464),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 10),
                      ElevatedButton.icon(
                        onPressed:


                         ()async {
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
                            fileName = result.files.first.name;
                            print('File picked: ${fileName}');
                            //print(String.fromCharCodes(file));
                            finalPath = result.files.first.bytes;
                            setState(() {
                              fileName;
                              _documentUploaded = true;
                            });
                          }catch(e){
                            print(e);
                          }
                        }
                      },
                        // onPressed: () async {
                        //   FilePickerResult? result =
                        //   await FilePicker.platform.pickFiles(
                        //     allowMultiple: false,
                        //   );
                        //   if (result != null) {
                        //     PlatformFile file = result.files.first;
                        //     print('File picked: ${file.name}');
                        //   } else {
                        //     // User canceled the picker
                        //   }
                        // },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff50B5E5),
                          // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        icon: Icon(Icons.file_upload_outlined,
                            color: Colors.white),
                        label: Text(
                          'Upload Document',
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
                          : SizedBox(), // Display file names if picked

                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
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
                        'i - 9 Paper Version',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FormNineScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff50B5E5),
                          // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Fill Info',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
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
                        'W4 2023',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // fill info action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff50B5E5),
                          // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Fill Info',
                          style: GoogleFonts.firaSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                ],
              ),
            ),
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
                  onPressed: () async{
                    try{
                      //File filePath = File(finalPath!);
                      await uploadDocuments(context: context, employeeDocumentMetaId: 10, employeeDocumentTypeSetupId: 48,
                      employeeId: 2, //documentName: widget.AcknowledgementnameController.text,
                      documentFile: finalPath, documentName: 'Legal Document ID');
                    }catch(e){
                      print(e);
                    }

                  },),


            ],
          )
        ],
      ),

    );
  }
}