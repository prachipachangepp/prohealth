import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';

class IntakePComplianceScreen extends StatefulWidget {
  const IntakePComplianceScreen({super.key});

  @override
  State<IntakePComplianceScreen> createState() => _IntakePComplianceScreenState();
}

class _IntakePComplianceScreenState extends State<IntakePComplianceScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 32.0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Status: Not Completed',
                  style: GoogleFonts.firaSans(
                      decoration: TextDecoration.none,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffDE0909)
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width/60),
                Container(
                  height: 32,
                  width: 105,
                  child: SchedularIconButtonConst(
                      text: 'Add New',
                      icon: Icons.add,
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ComplianceAddPopUp();
                          },
                        );

                      }
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/30),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            height: 403,
            width: 1219,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 65,
                                width: 1109,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        color: Color(0xff50B5E5),
                                        height: 45,
                                        width: 62,
                                        child: Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 24,),
                                      ),
                                    ),

                                    SizedBox(width: MediaQuery.of(context).size.width/120),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 11.5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ID: 248d1eb1-9020-4d8d-8168-43a3ef90a261',
                                            style: GoogleFonts.firaSans(
                                                decoration: TextDecoration.none,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464)
                                            ),
                                          ),
                                          SizedBox(height: 3.5),
                                          Text(
                                            'Compliance 1',
                                            style: GoogleFonts.firaSans(
                                                decoration: TextDecoration.none,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff686464)
                                            ),
                                          ),

                                          SizedBox(height: 1),
                                          Text(
                                            'Expiry 10 months',
                                            style: GoogleFonts.firaSans(
                                                decoration: TextDecoration.none,
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w300,
                                                color: Color(0xff686464)
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    SizedBox(width: MediaQuery.of(context).size.width/2.7),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.history,
                                            color: Color(0xff686464),
                                          ),
                                          onPressed: () {

                                          },
                                        ),

                                        SizedBox(width: MediaQuery.of(context).size.width/120),
                                        IconButton(
                                          icon: Icon(
                                            Icons.print_outlined,
                                            color: Color(0xff686464),
                                          ),
                                          onPressed: () async {
                                            final pdf = pw.Document();

                                            pdf.addPage(
                                              pw.Page(
                                                build: (pw.Context context) => pw.Center(
                                                  child: pw.Text('Hello, this is a test print!'),
                                                ),
                                              ),
                                            );

                                            await Printing.layoutPdf(
                                              onLayout: (PdfPageFormat format) async => pdf.save(),
                                            );
                                          },
                                        ),

                                        SizedBox(width: MediaQuery.of(context).size.width/120),
                                        IconButton(
                                          icon: Icon(
                                            Icons.file_download_outlined,
                                            color: Color(0xff686464),
                                          ),
                                          onPressed: () {

                                          },
                                        ),

                                        SizedBox(width: MediaQuery.of(context).size.width/120),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete_outline,
                                            color: Color(0xff686464),
                                          ),
                                          onPressed: () {

                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ComplianceAddPopUp extends StatefulWidget {
  const ComplianceAddPopUp({super.key});

  @override
  State<ComplianceAddPopUp> createState() => _ComplianceAddPopUpState();
}

class _ComplianceAddPopUpState extends State<ComplianceAddPopUp> {

  final TextEditingController _typeDocumentController = TextEditingController();
  final TextEditingController _nameDocumentController = TextEditingController();
  final TextEditingController _uploadDocumentController = TextEditingController();
  final List<String> _typeDocumentOptions = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];


  String? _typeDocumentSelectedOption;
  String _selectedExpiryType = '';

  String _fileName = 'Upload';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color(0xff50B5E5),
        ),
        height: 47,
        width: 408,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Add New Compliance Document',
                style: GoogleFonts.firaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          height: 475,
          width: 350,
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height /60),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Type of the Document',
                        style: GoogleFonts.firaSans(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff686464)
                        ),),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 80,
                  ),
                  Container(
                    height: 30,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      cursorHeight: 18,
                      controller: _typeDocumentController,
                      style: GoogleFonts.firaSans(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575757)
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        labelText: 'Compliance Type 1',
                        labelStyle: GoogleFonts.firaSans(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff575757)
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        suffixIcon: PopupMenuButton<String>(
                          icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                          onSelected: (String value) {
                            setState(() {
                              _typeDocumentSelectedOption = value;
                              _typeDocumentController.text = value;
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return _typeDocumentOptions.map<PopupMenuItem<String>>((String value) {
                              return PopupMenuItem(
                                value: value,
                                child: Text(value,
                                  style: GoogleFonts.firaSans(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff575757)
                                  ),),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Name of the Document',
                        style: GoogleFonts.firaSans(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff686464)
                        ),),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 120,
                  ),
                  Container(
                    height: 30,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      cursorHeight: 18,
                      controller: _nameDocumentController,
                      style: GoogleFonts.firaSans(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575757)
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffB1B1B1), width: 1.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expiry Type',
                        style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff686464)
                        ),
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        title: Text(
                          'Not Applicable',
                          style: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400
                          ),),
                        value: 'Not Applicable',
                        groupValue: _selectedExpiryType,
                        onChanged: (value) {
                          setState(() {
                            _selectedExpiryType = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                        title: Text(
                          'Scheduled',
                          style: GoogleFonts.firaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),),
                        value: 'Scheduled',
                        groupValue: _selectedExpiryType,
                        onChanged: (value) {
                          setState(() {
                            _selectedExpiryType = value!;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        title: Text(
                          'Issuer Expiry',
                          style: GoogleFonts.firaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),),
                        value: 'Issuer Expiry',
                        groupValue: _selectedExpiryType,
                        onChanged: (value) {
                          setState(() {
                            _selectedExpiryType = value!;
                          });
                        },
                      ),
                    ],
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height/30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Upload Document',
                        style: GoogleFonts.firaSans(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff686464)
                        ),),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 120,
                  ),
                  Container(
                    height: 30,
                    width: 360,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffB1B1B1),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                _fileName,
                                style: GoogleFonts.firaSans(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff575757),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: _pickFile,
                          icon: Icon(Icons.file_upload_outlined, color: Colors.black),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      backgroundColor: Color(0xff1696C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



