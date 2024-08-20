import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_general_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/onlink_general_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/onlink_general/onlink_general_data.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/employeement_manager.dart';
import '../../../../../../../app/services/token/token_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class generalForm extends StatefulWidget {
  final int employeeID;
  //final int userId;
  generalForm({
    super.key,
    required this.context,
    required this.employeeID,
  });

  final BuildContext context;

  @override
  State<generalForm> createState() => _generalFormState();
}

class _generalFormState extends State<generalForm> {
  double textFieldWidth = 430;
  double textFieldHeight = 38;

  TextEditingController dobcontroller = TextEditingController();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController ssecuritynumber = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController personalemail = TextEditingController();
  TextEditingController driverlicensenumb = TextEditingController();
  TextEditingController address = TextEditingController();

  // Current step in the stepper
  int _currentStep = 0;
  bool isChecked = false;
  String? specialityName;
  String? clinicialName;
  bool get isFirstStep => _currentStep == 0;
  bool isCompleted = false;
  String? _selectedCountry;
  String? _selectedClinician;
  String? _selectedSpeciality;
  String? _selectedDegree;
  late bool _passwordVisible = false;
  String? gendertype;
  int? generalId;

  String? racetype;

  List<String> _fileNames = [];
  bool _loading = false;
  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic filePath;
  File? xfileToFile;
  var finalPath;
  String? signatureUrl;
  void initState() {
    super.initState();
    _initializeFormWithPrefilledData();
  }
  var fetchedData;
  Future<void> _initializeFormWithPrefilledData() async {
    try {
      OnlinkGeneralData onlinkGeneralData = await getGeneralIdPrefill(context, widget.employeeID);
     // if (onlinkGeneralData) {
      fetchedData = onlinkGeneralData;
        var data = onlinkGeneralData; // Assuming index matches the data list
        setState(() {
          print("Inside function");
          dobcontroller.text = data.dateOfBirth ?? '';
          firstname.text = data.firstName ?? '';
          lastname.text = data.lastName ?? '';
          ssecuritynumber.text = data.SSNNbr ?? '';
          phonenumber.text = data.primaryPhoneNbr ?? '';
          personalemail.text = data.personalEmail ?? '';
          driverlicensenumb.text = data.driverLicenceNbr ?? '';
          address.text = data.finalAddress ?? '';
          racetype = data.race ?? "";
          //isChecked = data.endDate == null;
          gendertype = data.gender ?? "";
          generalId = data.employeeId ?? 0;
          signatureUrl = data.signatureURL ?? "";
        });
      //}
    } catch (e) {
      print('Failed to load prefilled data: $e');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "General",
                style: GoogleFonts.firaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.blueprime,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSize.s5,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Please fill all your personal information below. Your personal details will be required to proceed through the recruitment process.',
                style: GoogleFonts.firaSans(
                  color: const Color(0xFF686464),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: AppSize.s13,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 140, right: 140, top: 20),
              child:
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: AppSize.s5,
                            ),
                            Text(
                              "Upload Photo",
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff50B5E5),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                // FilePickerResult? result = await FilePicker.platform.pickFiles(
                                //   allowMultiple: false,
                                // );
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  print("Result::: ${result}");

                                  try {
                                    Uint8List? bytes = result.files.first.bytes;
                                    XFile xlfile =
                                        XFile(result.xFiles.first.path);
                                    xfileToFile = File(xlfile.path);

                                    print(
                                        "::::XFile To File ${xfileToFile.toString()}");
                                    XFile xFile = await convertBytesToXFile(
                                        bytes!, result.xFiles.first.name);
                                    // WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                                    // html.File file = webFile.file;
                                    //  print("XFILE ${xFile.path}");
                                    //  //filePath = xfileToFile as XFile?;
                                    //  print("L::::::${filePath}");
                                    _fileNames.addAll(
                                        result.files.map((file) => file.name!));
                                    print('File picked: ${_fileNames}');
                                    //print(String.fromCharCodes(file));
                                    fileName = result.files.first.name;
                                    finalPath = result.files.first.bytes;
                                    setState(() {
                                      _fileNames;
                                      _documentUploaded = true;
                                    });
                                  } catch (e) {
                                    print(e);
                                  }
                                }
                              }, //_pickFiles,

                              label: Text(
                                "Choose File",
                                style: GoogleFonts.firaSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              icon: const Icon(Icons.file_upload_outlined),
                            ),
                            _loading
                                ? SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      color: ColorManager
                                          .blueprime, // Loader color
                                      // Loader size
                                    ),
                                  )
                                : _fileNames.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: _fileNames
                                            .map((fileName) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'File picked: $fileName',
                                                    style: GoogleFonts.firaSans(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xff686464)),
                                                  ),
                                                ))
                                            .toList(),
                                      )
                                    :  SizedBox(height: 40,width: 10,), // Display file names if picked

                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'Legal First Name',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            CustomTextFieldRegister(
                              controller: firstname,
                              hintText: 'Enter Text',
                              hintStyle: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              height: 32,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'Legal Last Name',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            CustomTextFieldRegister(
                              controller: lastname,
                              hintText: 'Enter Text',
                              hintStyle: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              height: 32,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'Social Security Number',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            CustomTextFieldRegister(
                              controller: ssecuritynumber,
                              hintText: 'Enter Text',
                              obscureText: !_passwordVisible,
                              hintStyle: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  color: const Color(0xff50B5E5),
                                  size: 16,
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  //color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              height: 32,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'Personal Mobile Number',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            CustomTextFieldRegister(
                              controller: phonenumber,
                              keyboardType: TextInputType.name,
                              hintText: 'Enter Text',
                              hintStyle: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              height: 32,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'Personal Email',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            CustomTextFieldRegister(
                              controller: personalemail,
                              hintText: 'Enter Text',
                              hintStyle: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              height: 32,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'Driver’s License Number',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            CustomTextFieldRegister(
                              controller: driverlicensenumb,
                              hintText: 'Enter Text',
                              hintStyle: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              height: 32,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            Container(
                              width: 400,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomRadioListTile(
                                    title: 'Male',
                                    value: 'male',
                                    groupValue: gendertype,
                                    onChanged: (value) {
                                      setState(() {
                                        gendertype = value;
                                      });
                                    },
                                  ),
                                  CustomRadioListTile(
                                    title: 'Female',
                                    value: 'Female',
                                    groupValue: gendertype,
                                    onChanged: (value) {
                                      setState(() {
                                        gendertype = value;
                                      });
                                    },
                                  ),
                                  CustomRadioListTile(
                                    title: 'Other',
                                    value: 'Other',
                                    groupValue: gendertype,
                                    onChanged: (value) {
                                      setState(() {
                                        gendertype = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'DOB',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            CustomTextFieldRegister(
                              controller: dobcontroller,
                              hintText: 'yyyy-mm-dd',
                              hintStyle: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                              height: 32,
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Color(0xff50B5E5),
                                  size: 16,
                                ),
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1901),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    dobcontroller.text =
                                        "${pickedDate.toLocal()}".split(' ')[0];
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'Address',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            CustomTextFieldRegister(
                              controller: address,
                              hintText: 'Enter Text',
                              hintStyle: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff9B9B9B),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              height: 32,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),
                            Text(
                              "Race",
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    CustomRadioListTile(
                                      title: 'Asian',
                                      value: 'Asian',
                                      groupValue: racetype,
                                      onChanged: (value) {
                                        setState(() {
                                          racetype = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                // const SizedBox(
                                //   width: 3,
                                // ),

                                Column(
                                  children: [
                                    CustomRadioListTile(
                                      title: 'White',
                                      value: 'White',
                                      groupValue: racetype,
                                      onChanged: (value) {
                                        setState(() {
                                          racetype = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                // const SizedBox(
                                //   width: 5,
                                // ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    CustomRadioListTile(
                                      title: 'Black or African American',
                                      value: 'Black or African American',
                                      groupValue: racetype,
                                      onChanged: (value) {
                                        setState(() {
                                          racetype = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),

                                Column(
                                  children: [
                                    CustomRadioListTile(
                                      title: 'Other',
                                      value: 'Other',
                                      groupValue: racetype,
                                      onChanged: (value) {
                                        setState(() {
                                          racetype = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                // const SizedBox(
                                //   width: 3,
                                // ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomRadioListTile(
                                  title: 'Hispanic or Latino',
                                  value: 'Hispanic or Latino',
                                  groupValue: racetype,
                                  onChanged: (value) {
                                    setState(() {
                                      racetype = value;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'Type of Clinician',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),

                            ///clinician
                            FutureBuilder<List<AEClinicalDiscipline>>(
                              future:
                                  HrAddEmplyClinicalDisciplinApi(context, 1),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: Container(
                                        width: AppSize.s250,
                                        height: AppSize.s32,
                                        decoration: BoxDecoration(
                                            color: ColorManager.white),
                                      ),
                                    );

                                }
                                if (snapshot.hasData) {
                                  List<String> dropDownList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(i.empType!);
                                  }
                                  return SizedBox(
                                    height: 32,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        // hintText: 'Select Clinician',
                                        hintStyle: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff9B9B9B),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                //   //  vertical: 5,
                                                horizontal: 12),
                                      ),
                                      // value: selectedCountry,
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Color(0xff9B9B9B)),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff686464),
                                      ),

                                      onChanged: (newValue) {
                                        for (var a in snapshot.data!) {
                                          if (a.empType == newValue) {
                                            _selectedClinician = a.empType!;
                                            //country = a
                                            // int? docType = a.companyOfficeID;
                                          }
                                        }
                                      },
                                      items: dropDownList.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 12,
                                              color: Color(0xff575757),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                } else {
                                  return const Offstage();
                                }
                              },
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            Text(
                              'Speciality',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff686464)),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 60),

                            FutureBuilder<List<AEClinicalDiscipline>>(
                              future:
                                  HrAddEmplyClinicalDisciplinApi(context, 1),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: Container(
                                        width: AppSize.s250,
                                        height: AppSize.s32,
                                        decoration: BoxDecoration(
                                            color: ColorManager.white),
                                      ),
                                    );

                                }
                                if (snapshot.hasData) {
                                  List<String> dropDownList = [];

                                  for (var i in snapshot.data!) {
                                    dropDownList.add(i.empType!);
                                  }
                                  return SizedBox(
                                    height: 32,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        // hintText: 'Select Clinician',
                                        hintStyle: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff9B9B9B),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: Colors.grey),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                //   //  vertical: 5,
                                                horizontal: 12),
                                      ),
                                      // value: selectedCountry,
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Color(0xff9B9B9B)),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff686464),
                                      ),

                                      onChanged: (newValue) {
                                        for (var a in snapshot.data!) {
                                          if (a.empType == newValue) {
                                            _selectedSpeciality = a.empType!;
                                            //country = a
                                            // int? docType = a.companyOfficeID;
                                          }
                                        }
                                      },
                                      items: dropDownList.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 12,
                                              color: Color(0xff575757),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                } else {
                                  return const Offstage();
                                }
                              },
                            ),

                            // CustomDropdownTextField(
                            //   width: 600,
                            //   height: 32,
                            //  // hintText: 'Select Speciality ',
                            //
                            //   items: [
                            //     'Speciality1',
                            //     'Speciality2',
                            //     'CSpeciality',
                            //     'Speciality'
                            //   ],
                            //   value: _selectedSpeciality,
                            //   // List of countries
                            //   //     .map<DropdownMenuItem<String>>((String value) {
                            //   //   return DropdownMenuItem<String>(
                            //   //     value: value,
                            //   //     child: Text(value),
                            //   //   );
                            //   // }).toList(),
                            //
                            //   labelText: 'Select Speciality',
                            //   labelStyle: GoogleFonts.firaSans(
                            //     fontSize: 10,
                            //     fontWeight: FontWeight.w400,
                            //     color: const Color(0xff9B9B9B),
                            //   ),
                            // ),

                            // Container(
                            //   height: 32,
                            //   child: DropdownButtonFormField<String>(
                            //     // alignment: AlignmentDirectional.centerStart,
                            //     decoration: InputDecoration(
                            //       //hintText:
                            //           //'Select Speciality                                      ',
                            //       hintStyle: GoogleFonts.firaSans(
                            //         fontSize: 10,
                            //         fontWeight: FontWeight.w400,
                            //         color: const Color(0xff9B9B9B),
                            //       ),
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(4.0),
                            //         borderSide: const BorderSide(color: Colors.grey),
                            //       ),
                            //       contentPadding: const EdgeInsets.only(
                            //           bottom: AppPadding.p5, left: 12),
                            //     ),
                            //     value: _selectedSpeciality,
                            //     icon: const Icon(Icons.arrow_drop_down,
                            //         color: Color(0xff9B9B9B)),
                            //     iconSize: 24,
                            //     elevation: 16,
                            //     style: GoogleFonts.firaSans(
                            //       fontSize: 10.0,
                            //       fontWeight: FontWeight.w400,
                            //       color: const Color(0xff686464),
                            //     ),
                            //     onChanged: (String? newValue) {
                            //       setState(() {
                            //         _selectedSpeciality = newValue;
                            //       });
                            //     },
                            //     items: <String>[
                            //       'Speciality1',
                            //       'Speciality2',
                            //       'CSpeciality',
                            //       'Speciality'
                            //     ] // List of countries
                            //         .map<DropdownMenuItem<String>>((String value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),),
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
                  // Get the company and user IDs
                  final companyId = await TokenManager.getCompanyId();
                  final userId = await TokenManager.getUserID();

                  print("Company ID: $companyId");
                  print("User ID: $userId");

                  // Print the data being sent
                  print("Sending data:");
                  print("Employee ID: ${widget.employeeID}");
                  print("Code: EMP-C10-U48");
                  print("User ID: $userId");
                  print("First Name: ${firstname.text}");
                  print("Last Name: ${lastname.text}");
                  print("Speciality: ${_selectedSpeciality.toString()}");
                  print("SSN: ${ssecuritynumber.text}");
                  print("Phone Number: ${phonenumber.text}");
                  print("Personal Email: ${personalemail.text}");
                  print("Address: ${address.text}");
                  print("Date of Birth: ${dobcontroller.text}");
                  print("Gender: ${gendertype.toString()}");
                  print("Driver License Number: ${driverlicensenumb.text}");
                  print("Position: position");
                  print("Clinician: ${_selectedClinician.toString()}");
                  print("Race: ${racetype.toString()}");

                  // Call the update function
                  var response = await updateOnlinkGeneralPatch(
                    context,
                    generalId!,
                    'EMP-C10-U48',
                    userId,
                    firstname.text,
                    lastname.text,
                    1,
                    1,
                    _selectedSpeciality.toString(),
                    1,
                    1,
                    1,
                    1,
                    ssecuritynumber.text,
                    phonenumber.text,
                    '1234',
                    '1234',
                    'Robert Tech Services',
                    personalemail.text,
                    personalemail.text,
                    address.text,
                    dobcontroller.text,
                    '1234',
                    'covreage',
                    'employment',
                    gendertype.toString(),
                    'Partial',
                    'service',
                    'imgurl',
                    'resumeurl',
                    companyId,
                    'Active',
                    driverlicensenumb.text,
                    dobcontroller.text,//'2024-01-01',
                    dobcontroller.text,//'2024-01-01',
                    dobcontroller.text,// '2024-01-01',
                    'rehirable',
                    'position',
                    address.text,
                    _selectedClinician.toString(),
                    'reason',
                    1,
                    dobcontroller.text,//'2024-01-01',
                    1,
                    1,
                    'methods',
                    'materials',
                    racetype.toString(),
                    'rating',
                    signatureUrl!,
                  );


                  print("Response Status Code: ${response.statusCode}");
                  print("Response Body: ${response.data}");

                  if (response.statusCode == 200 || response.statusCode == 201) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("User data updated"),backgroundColor: Colors.green,),
                    );
                    _initializeFormWithPrefilledData();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to update user data")),
                    );
                  }

                  // Clear fields after saving
                  firstname.clear();
                  lastname.clear();
                  ssecuritynumber.clear();
                  phonenumber.clear();
                  personalemail.clear();
                  driverlicensenumb.clear();
                  address.clear();
                  dobcontroller.clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

