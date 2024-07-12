import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../../../taxtfield_constant.dart';

class PhysicalExamContainer extends StatefulWidget {
  @override
  _PhysicalExamContainerState createState() => _PhysicalExamContainerState();
}

class _PhysicalExamContainerState extends State<PhysicalExamContainer> {
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  String? _selectedFileName;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateController.text = _dateFormat.format(pickedDate);
      });
    }
  }

  Future<void> _openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _selectedFileName = result.files.single.name;
        });
      } else {
        // User canceled the file picking
        print('User canceled file picking.');
      }
    } on PlatformException catch (e) {
      print('Error while picking the file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 182.0, right: 182.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Physical Exam',
                    style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  Text(
                    'Valid within 1 year of test',
                    style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  Text(
                    'Date Administrated',
                    style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff575757)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 110),
                  Container(
                    height: 30,
                    width: 242,
                    child: CustomTextFieldRegister(
                      controller: _dateController,
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
                          _selectDate(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 80),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Immunization records in pdf, jpg or png format',
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffB1B1B1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: _openFileExplorer,
                              child: Text(
                                'Choose File',
                                style: GoogleFonts.firaSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.3,
                                    color: Color(0xff686464)),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffD9D9D9),
                                // foregroundColor: Colors.black,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              _selectedFileName ?? 'No file chosen',
                              style: GoogleFonts.roboto(
                                  fontSize: 11.3,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff575757)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////

class VaccineContainer extends StatefulWidget {
  @override
  _VaccineContainerState createState() => _VaccineContainerState();
}

class _VaccineContainerState extends State<VaccineContainer> {
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  String? _selectedFileName;
  int? _selectedRadio;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateController.text = _dateFormat.format(pickedDate);
      });
    }
  }

  Future<void> _openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _selectedFileName = result.files.single.name;
        });
      } else {
        // User canceled the file picking
        print('User canceled file picking.');
      }
    } on PlatformException catch (e) {
      print('Error while picking the file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 182.0, right: 182.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio<int>(
                                value: 0,
                                groupValue: _selectedRadio,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    _selectedRadio =
                                        (_selectedRadio == newValue)
                                            ? null
                                            : newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TB',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff686464),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Valid within 1 year of test',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff686464),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 100),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio<int>(
                                value: 1,
                                groupValue: _selectedRadio,
                                onChanged: (int? newValue) {
                                  setState(() {
                                    _selectedRadio =
                                        (_selectedRadio == newValue)
                                            ? null
                                            : newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chest X-Ray',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff686464),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Valid within 1 year of test',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff686464),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Text(
                    'Date Administered',
                    style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff575757)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 110),
                  Container(
                    height: 30,
                    width: 242,
                    child: TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        hintText: 'dd-mm-yyyy',
                        hintStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9B9B9B),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xff50B5E5),
                            size: 16,
                          ),
                          onPressed: () async {
                            _selectDate(context);
                          },
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 80),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Vaccination Records in pdf, jpg or png format',
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffB1B1B1)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: _openFileExplorer,
                              child: Text(
                                'Choose File',
                                style: GoogleFonts.firaSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.3,
                                    color: Color(0xff686464)),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffD9D9D9),
                                // foregroundColor: Colors.black,
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              _selectedFileName ?? 'No file chosen',
                              style: GoogleFonts.roboto(
                                  fontSize: 11.3,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff575757)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
