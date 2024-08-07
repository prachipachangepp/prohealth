import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_licenses_manager.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class LicensesScreen extends StatefulWidget {
  final int employeeID;
  const LicensesScreen({
    super.key,
    required this.context, required this.employeeID,
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

  // Current step in the stepper
  int _currentStep = 0;

  bool isChecked = false;

  bool get isFirstStep => _currentStep == 0;

  bool isCompleted = false;
  String? selectedCountry;

  List<GlobalKey<_licensesFormState>> licensesFormKeys = [];

  @override
  void initState() {
    super.initState();
    addEducationForm();
  }

  void addEducationForm() {
    setState(() {
      licensesFormKeys.add(GlobalKey<_licensesFormState>());
    });
  }

  void removeEduacationForm(GlobalKey<_licensesFormState> key) {
    setState(() {
      licensesFormKeys.remove(key);
    });
  }

  Future<void> postlicensesscreendata(
      BuildContext context,
      String country,
      int employeeId,
      String licenseUrl,
      String licensure,
      String licenseNumber,
      String org,
      String documentType) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Licenses data saved")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Column(
          children: licensesFormKeys.asMap().entries.map((entry) {
            int index = entry.key;
            GlobalKey<_licensesFormState> key = entry.value;
            return licensesForm(
              key: key,
              index: index + 1,
              onRemove: () => removeEduacationForm(key),employeeID:widget.employeeID,
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
                onPressed: addEducationForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff50B5E5),
                  // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Add Licenses',
                  style: GoogleFonts.firaSans(
                    fontSize: 14.0,
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
              style: const TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              borderRadius: 12,
              onPressed: () async {
                for (var key in licensesFormKeys) {
                  final st = key.currentState!;
                  await postlicensesscreen(
                      context,
                      selectedCountry.toString(),
                      widget.employeeID,
                      "__",
                      st.licensure.text,
                      st.licensurenumber.text,
                      st.org.text,
                      "__");


                  if (st.finalPath == null || st.finalPath.isEmpty) {
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
                        employeeId: widget.employeeID,
                        documentFile: st.finalPath,
                        documentName: 'education data',
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
                //licensure.clear();
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
          ],
        ),
      ],
    );
  }
}

class licensesForm extends StatefulWidget {
  final int employeeID;
  final VoidCallback onRemove;
  final int index;
  const licensesForm({Key? key, required this.onRemove, required this.index, required this.employeeID})
      : super(key: key);

  @override
  _licensesFormState createState() => _licensesFormState();
}

class _licensesFormState extends State<licensesForm> {
  TextEditingController firstName = TextEditingController();

  /////

  TextEditingController licensure = TextEditingController();
  TextEditingController org = TextEditingController();
  TextEditingController licensurenumber = TextEditingController();
  TextEditingController _controllerIssueDate = TextEditingController();
  TextEditingController _controllerExpirationDate = TextEditingController();

  String? selectedCountry;

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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Licensure / Certification #${widget.index}',
              style: GoogleFonts.firaSans(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff686464)),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red),
              onPressed: widget.onRemove,
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  Text(
                    'Issuing Organization',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Text(
                    'Country',
                    style: GoogleFonts.firaSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff686464),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  Container(
                    height: 32,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        //hintText: 'Select Country',
                        hintStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9B9B9B),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      value: selectedCountry,
                      icon:
                          Icon(Icons.arrow_drop_down, color: Color(0xff9B9B9B)),
                      iconSize: 24,
                      elevation: 16,
                      style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountry = newValue;
                        });
                      },
                      items: <String>[
                        'Country1',
                        'Country2',
                        'Country3',
                        'Country4'
                      ] // List of countries
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Text(
                    'Number / ID',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
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
            SizedBox(width: MediaQuery.of(context).size.width / 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text(
                    'Issue Date',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
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
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          _controllerIssueDate.text = formattedDate;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Text(
                    'Expiration Date',
                    style: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686464)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
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
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          _controllerExpirationDate.text = formattedDate;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 150)
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
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
            SizedBox(width: MediaQuery.of(context).size.width / 5),
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
            _loading
                ? SizedBox(
              width: 25,
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
                : SizedBox(),
          ],
        ),

        const Divider(color: Colors.grey,thickness: 2,),
      ],),
    );
  }
}

//
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xff1696C8),
// foregroundColor: Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// onPressed: () async {
// await postlicensesscreen(context, "--", 0, "__",
// licensure.text, licensurenumber.text, org.text, "__");
// },
// child: Text(
// 'Save',
// style: GoogleFonts.firaSans(
// fontSize: 14.0,
// fontWeight: FontWeight.w700,
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
