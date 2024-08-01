
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../app/resources/color.dart';
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
                    onPressed: _pickFiles,
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
    );
  }
}