import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_general_manager.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../taxtfield_constant.dart';
import 'form_educaton_screen.dart';

class generalForm extends StatefulWidget {
  generalForm({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<generalForm> createState() => _generalFormState();
}

class _generalFormState extends State<generalForm> {
  double textFieldWidth = 430;
  double textFieldHeight = 38;

  //TextEditingController firstName = TextEditingController();

  /////
  TextEditingController dobcontroller = TextEditingController();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController ssecuritynumber = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  // TextEditingController  phonenumber= TextEditingController();
  TextEditingController personalemail = TextEditingController();
  TextEditingController driverlicensenumb = TextEditingController();
  TextEditingController address = TextEditingController();

  // Current step in the stepper
  int _currentStep = 0;

  bool isChecked = false;

  bool get isFirstStep => _currentStep == 0;

  bool isCompleted = false;
  String? _selectedCountry;
  String? _selectedClinician;
  String? _selectedSpeciality;
  String? _selectedDegree;
  late bool _passwordVisible = false;
  String? gendertype;

  String? racetype;


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
            child: Row(
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
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1696C8),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed:_pickFiles,
                        // onPressed: () async {
                        //   FilePickerResult? result =
                        //       await FilePicker.platform.pickFiles(
                        //     allowMultiple: false,
                        //   );
                        //   if (result != null) {
                        //     PlatformFile file = result.files.first;
                        //     print('File picked: ${file.name}');
                        //   } else {
                        //     // User canceled the picker
                        //   }
                        // },
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
                                color: const Color(0xff686464)),
                          ),
                        ))
                            .toList(),
                      )
                          : const SizedBox(), // Display file names if picked

                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'Legal First Name',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'Legal Last Name',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'Social Security Number',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'Personal Mobile Number',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'Personal Email',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'Driver’s License Number',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                      Container(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'DOB',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        controller: dobcontroller,
                        hintText: 'dd-mm-yyyy',
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
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              dobcontroller.text =
                                  "${pickedDate.toLocal()}".split(' ')[0];
                            }
                          },
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'Address',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
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
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text(
                        'Type of Clinician',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                      Container(
                        height: 32,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: 'Select Clinician',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff9B9B9B),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          value: _selectedClinician,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Color(0xff9B9B9B)),
                          iconSize: 24,
                          elevation: 16,
                          style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedClinician = newValue;
                            });
                          },
                          items: <String>[
                            'Clinician 1',
                            'Clinicin ',
                            'Clinican',
                            'Cliniian'
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
                        'Speciality',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464)),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                      Container(
                        height: 32,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: 'Select Speciality',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff9B9B9B),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          value: _selectedSpeciality,
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Color(0xff9B9B9B)),
                          iconSize: 24,
                          elevation: 16,
                          style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff686464),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedSpeciality = newValue;
                            });
                          },
                          items: <String>[
                            'Speciality1',
                            'Speciality2',
                            'CSpeciality',
                            'Speciality'
                          ] // List of countries
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1696C8),
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                 onPressed: () async {
                  await postgeneralscreendata(
                      context,
                      'G023',
                      26,
                      firstname.text,
                      lastname.text,
                      1,
                      1,
                      'Expertise',
                      1,
                      1,
                      1,
                      true,
                      false,
                      1,
                      'SSN123',
                      ssecuritynumber.text,
                      phonenumber.text,
                      '1234',
                      '12345',
                      '1245',
                      personalemail.text,
                      address.text,
                      dobcontroller.text,
                      '1245',
                      'Coverage',
                      'Employment',
                      gendertype.toString(),
                      'Active',
                      'Service',
                      'imgurl',
                      'resumeurl',
                      5,
                      'Onboarding',
                      driverlicensenumb.text,
                      '2024-01-01',
                      '2024-01-01',
                      '2024-01-01',
                      'Yes',
                      'Position',
                      '123 Final St',
                      'Type',
                      'Reason',
                      1,
                      '2024-01-01',
                      1,
                      1,
                      'Method',
                      'Material',
                      racetype.toString(),
                      'rating',
                      'SignatureURL'
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("General data saved")),
                  );
                  firstname.clear();
                  lastname.clear();
                  ssecuritynumber.clear();
                  phonenumber.clear();
                  personalemail.clear();
                  driverlicensenumb.clear();
                  address.clear();
                  dobcontroller.clear();

                 },
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
          )
        ],
      ),
    );
  }
}

// TextEditingController _dobcontroller = TextEditingController();
//
// TextEditingController firstname = TextEditingController();
// TextEditingController lastname = TextEditingController();
// TextEditingController ssecuritynumber = TextEditingController();
// TextEditingController phonenumber = TextEditingController();
//
// TextEditingController personalemail = TextEditingController();
// TextEditingController driverlicensenumb = TextEditingController();
// TextEditingController address = TextEditingController();
