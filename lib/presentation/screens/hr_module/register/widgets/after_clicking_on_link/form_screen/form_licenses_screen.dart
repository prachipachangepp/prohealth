
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_licenses_manager.dart';

import '../../../taxtfield_constant.dart';

class LicensesScreen extends StatefulWidget {
  const LicensesScreen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<LicensesScreen> createState() => _LicensesScreenState();
}

class _LicensesScreenState extends State<LicensesScreen> {


  double textFieldWidth = 430;
  double textFieldHeight = 38;

  TextEditingController firstName = TextEditingController();

  /////
  TextEditingController _controller = TextEditingController();
  TextEditingController licensure = TextEditingController();
  TextEditingController org = TextEditingController();
  TextEditingController licensurenumber = TextEditingController();
  TextEditingController _controllerIssueDate = TextEditingController();
  TextEditingController _controllerExpirationDate = TextEditingController();

  // Current step in the stepper
  int _currentStep = 0;

  bool isChecked = false;

  bool get isFirstStep => _currentStep == 0;


  bool isCompleted = false;
  String? _selectedCountry;








  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                'Licenses',
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
                          'Please fill all the current and relevant licensure / certification below. If you are applying for a clinical or attorney position which is lists licensure in the requirements, your information will be required to proceed through the requirements process.',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF686464),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 100),
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
                          'Please note, MSW and Chaplains do not need a License. Rather , they need academic credentials.',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF686464),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 100),
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
                          'Clinical Staff MUST fill this section out. ',
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
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 166.0, right: 166),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Licensure / Certification #1',
                      style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Licensure / Certification',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          60),
                              CustomTextFieldRegister(
                                controller: licensure,
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          40),
                              Text(
                                'Issuing Organization',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          60),
                              CustomTextFieldRegister(
                                controller: org,
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          30),
                              Text(
                                'Country',
                                style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff686464),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          60),
                              Container(
                                height: 32,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    hintText: 'Select Country',
                                    hintStyle: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9B9B9B),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                  ),
                                  value: _selectedCountry,
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: Color(0xff9B9B9B)),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedCountry = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Country1',
                                    'Country2',
                                    'Country3',
                                    'Country4'
                                  ] // List of countries
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          30),
                              Text(
                                'Number / ID',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          60),
                              CustomTextFieldRegister(
                                controller: licensurenumber,
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
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.width / 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Issue Date',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          100),
                              CustomTextFieldRegister(
                                controller: _controllerIssueDate,
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
                                    DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedDate);
                                      _controllerIssueDate.text =
                                          formattedDate;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          200),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'If the licensure / certification will be recieved in future, enter the expected issuing date',
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff686464)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          100),
                              Text(
                                'Expiration Date',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          100),
                              CustomTextFieldRegister(
                                controller: _controllerExpirationDate,
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
                                    DateTime? pickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedDate);
                                      _controllerExpirationDate.text =
                                          formattedDate;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 20),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Upload your degree / certifications as a docx or pdf',
                            style: GoogleFonts.firaSans(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff686464)),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 5),
                        ElevatedButton.icon(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                            );
                            if (result != null) {
                              PlatformFile file = result.files.first;
                              print('File picked: ${file.name}');
                            } else {
                              // User canceled the picker
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          icon: const Icon(Icons.file_upload_outlined,
                              color: Colors.white),
                          label: Text(
                            'Upload Document',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Handle add education action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text(
                            'Add Licensure / Certification',
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff1696C8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    await postlicensesscreen(context, "--", 0, "__", licensure.text, licensurenumber.text, org.text, "__");                 },
                  child: Text(
                    'Save',
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}