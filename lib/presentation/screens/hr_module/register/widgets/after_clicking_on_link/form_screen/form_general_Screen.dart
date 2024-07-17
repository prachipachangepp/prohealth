import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../taxtfield_constant.dart';

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

  TextEditingController firstName = TextEditingController();

  /////
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerIssueDate = TextEditingController();
  TextEditingController _controllerExpirationDate = TextEditingController();

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
  String? _selectedType;
  String? _selectedType1;


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
              padding: const EdgeInsets.symmetric(
                  vertical: 12, horizontal: 16),
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
            padding:
            const EdgeInsets.only(left: 140, right: 140, top: 20),
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
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1696C8),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
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
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 30),
                      Text(
                        'Legal First Name',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        hintText: 'Enter Text',
                        hintStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9B9B9B),
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
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        hintText: 'Enter Text',
                        hintStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9B9B9B),
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
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        hintText: 'Enter Text',
                        obscureText: !_passwordVisible,
                        hintStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9B9B9B),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            color: Color(0xff50B5E5),
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
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        hintText: 'Enter Text',
                        hintStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9B9B9B),
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
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        hintText: 'Enter Text',
                        hintStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9B9B9B),
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
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        hintText: 'Enter Text',
                        hintStyle: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9B9B9B),
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
                            color: Color(0xff686464)),
                      ),
                      Container(
                        width: 400,
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomRadioListTile(
                                  title: 'Male',
                                  value: 'male',
                                  groupValue: _selectedType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedType = value;
                                    });
                                  },
                                )),
                            Expanded(
                                child: CustomRadioListTile(
                                  title: 'Female',
                                  value: 'Female',
                                  groupValue: _selectedType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedType = value;
                                    });
                                  },
                                )),
                            Expanded(
                                child: CustomRadioListTile(
                                  title: 'Other',
                                  value: 'Other',
                                  groupValue: _selectedType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedType = value;
                                    });
                                  },
                                )),
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
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
                        controller: _controller,
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
                              _controller.text =
                              "${pickedDate.toLocal()}"
                                  .split(' ')[0];
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
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      CustomTextFieldRegister(
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
                          MediaQuery.of(context).size.height / 60),
                      Text(
                        "Race",
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686464)),
                      ),
                      Container(
                        //width: 550,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomRadioListTile(
                                title: 'Asian',
                                value: 'Asian',
                                groupValue: _selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedType = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomRadioListTile(
                                title: 'White',
                                value: 'White',
                                groupValue: _selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedType = value;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomRadioListTile(
                                title: 'Hispanic or Latino',
                                value: 'Hispanic or Latino',
                                groupValue: _selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedType = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomRadioListTile(
                              title: 'Black or African American',
                              value: 'Black or African American',
                              groupValue: _selectedType,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: CustomRadioListTile(
                              title: 'Other',
                              value: 'Other',
                              groupValue: _selectedType,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = value;
                                });
                              },
                            ),
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
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      Container(
                        height: 32,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: 'Select Clinician',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide:
                              BorderSide(color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          value: _selectedClinician,
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
                              _selectedClinician = newValue;
                            });
                          },
                          items: <String>[
                            'Clinician 1',
                            'Clinicin ',
                            'Clinican',
                            'Cliniian'
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
                          MediaQuery.of(context).size.height / 30),
                      Text(
                        'Speciality',
                        style: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686464)),
                      ),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height / 60),
                      Container(
                        height: 32,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: 'Select Speciality',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              borderSide:
                              BorderSide(color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          value: _selectedSpeciality,
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
                              _selectedSpeciality = newValue;
                            });
                          },
                          items: <String>[
                            'Speciality1',
                            'Speciality2',
                            'CSpeciality',
                            'Speciality'
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
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}