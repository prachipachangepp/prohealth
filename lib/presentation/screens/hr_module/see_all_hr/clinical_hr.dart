import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/drop_down.dart';
import 'package:prohealth/presentation/screens/hr_module/see_all_hr/widgets/see_all_container_constant.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../register/taxtfield_constant.dart';

class ClinicalHrScreen extends StatefulWidget {
  const ClinicalHrScreen({super.key});

  @override
  State<ClinicalHrScreen> createState() => _ClinicalHrScreenState();
}

class _ClinicalHrScreenState extends State<ClinicalHrScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(''),
                Text(AppStringEM.srno,
                    style: AllHRTableHeading.customTextStyle(context)),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(AppStringEM.type,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Text(AppStringEM.name,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(AppStringEM.location,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(AppStringEM.specialization,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(AppStringEM.edit,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 60,
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                // int serialNumber =
                //     index + 1 + (currentPage - 1) * itemsPerPage;
                // String formattedSerialNumber =
                // serialNumber.toString().padLeft(2, '0');

                return SeeAllContainerConstant();
              }),
        )
      ],
    );
  }
}

class EditPopUp extends StatefulWidget {
  const EditPopUp({super.key});

  @override
  State<EditPopUp> createState() => _EditPopUpState();
}

class _EditPopUpState extends State<EditPopUp> {
  String? dropdownValue;
  String? dropdownValueRating;
  String? dropdownValueSpeciality;
  String? dropdownValueOffice;
  String? dropdownValueZone;
  String? dropdownValueCity;
  String? dropdownValueCountry;
  String? dropdownValueSSN;
  String? dropdownValueStatus;

  TextEditingController _controller = TextEditingController();
  String? _selectedType;
  String? _selectedType1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          color: Color(0xff50B5E5),
        ),
        height: 32,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Edit',
                style: GoogleFonts.firaSans(
                  fontSize: 16,
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
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        PlatformFile file = result.files.first;
                        print('File selected: ${file.name}');
                        // Handle the selected file
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Upload Resume',
                          style: GoogleFonts.firaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.file_upload_outlined, color: Colors.white),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      backgroundColor: Color(0xff50B5E5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 100),
                  ElevatedButton(
                    onPressed: ()async {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                      if (result != null) {
                        PlatformFile file = result.files.first;
                        print('File selected: ${file.name}');
                        // Handle the selected file
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          'Upload Photo',
                          style: GoogleFonts.firaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.file_upload_outlined, color: Colors.white),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      backgroundColor: Color(0xff50B5E5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldRegister(
                      height: 36,
                      labelText: 'First Name',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomTextFieldRegister(
                      height: 36,
                      labelText: 'Last Name',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomDropdown(
                      labelText: 'Type of Clinician',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValue,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      labelText: 'Rating',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValueRating,
                      onChanged: (value) {
                        setState(() {
                          dropdownValueRating = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomDropdown(
                      labelText: 'Speciality',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValueSpeciality,
                      onChanged: (value) {
                        setState(() {
                          dropdownValueSpeciality = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomDropdown(
                      labelText: 'Reporting Office',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValueOffice,
                      onChanged: (value) {
                        setState(() {
                          dropdownValueOffice = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      hintText: 'Select a Zone',
                      hintStyle: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575757)),
                      labelText: 'Zone',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValueZone,
                      onChanged: (value) {
                        setState(() {
                          dropdownValueZone = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomDropdown(
                      hintText: 'Select a City',
                      hintStyle: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575757)),
                      labelText: 'City',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValueCity,
                      onChanged: (value) {
                        setState(() {
                          dropdownValueCity = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomDropdown(
                      hintText: 'Select a Country',
                      hintStyle: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff575757)),
                      labelText: 'Country',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValueCountry,
                      onChanged: (value) {
                        setState(() {
                          dropdownValueCountry = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      labelText: 'SSN',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValueSSN,
                      onChanged: (value) {
                        setState(() {
                          dropdownValueSSN = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomTextFieldRegister(
                      height: 36,
                      labelText: 'Personal Phone Number',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomTextFieldRegister(
                      height: 36,
                      labelText: 'Work Phone Number',
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldRegister(
                      height: 36,
                      labelText: 'Personal email',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomTextFieldRegister(
                      height: 36,
                      labelText: 'Work email',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomTextFieldRegister(
                      height: 36,
                      controller: _controller,
                      labelText: 'dd-mm-yyyy',
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
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            _controller.text =
                                "${pickedDate.toLocal()}".split(' ')[0];
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 60),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldRegister(
                      height: 36,
                      labelText: 'Personal email',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomDropdown(
                      labelText: 'Status',
                      items: [
                        'option 1',
                        'option 2',
                        'option 3',
                        'option 4',
                      ],
                      value: dropdownValueStatus,
                      onChanged: (value) {
                        setState(() {
                          dropdownValueStatus = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 120,
                  ),
                  Expanded(
                    child: CustomTextFieldRegister(
                      height: 36,
                      labelText: 'Driver’s License',
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 200),
              Divider(
                // height: 50,
                thickness: 3,
                color: Color(0xffD9D9D9),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Row(
                children: [
                  Container(
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 18.0, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gender',
                              style: GoogleFonts.firaSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Wrap(
                          children: [
                            CustomRadioListTile(
                              value: 'Male',
                              groupValue: _selectedType,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = value;
                                });
                              },
                              title: 'Male',
                            ),
                            CustomRadioListTile(
                              value: 'Female',
                              groupValue: _selectedType,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = value;
                                });
                              },
                              title: 'Female',
                            ),
                            CustomRadioListTile(
                              value: 'Other',
                              groupValue: _selectedType,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType = value;
                                });
                              },
                              title: 'Other',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/120,
                  ),
                  Container(
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 2.0, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Race',
                              style: GoogleFonts.firaSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Wrap(
                          children: [
                            CustomRadioListTile(
                              value: 'Asian',
                              groupValue: _selectedType1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType1 = value;
                                });
                              },
                              title: 'Asian',
                            ),
                            CustomRadioListTile(
                              value: 'Black or African American',
                              groupValue: _selectedType1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType1 = value;
                                });
                              },
                              title: 'Black or African American',
                            ),
                            CustomRadioListTile(
                              value: 'White',
                              groupValue: _selectedType1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType1 = value;
                                });
                              },
                              title: 'White',
                            ),
                            CustomRadioListTile(
                              value: 'Hispanic or Latino',
                              groupValue: _selectedType1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType1 = value;
                                });
                              },
                              title: 'Hispanic or Latino',
                            ),
                            CustomRadioListTile(
                              value: 'Other',
                              groupValue: _selectedType1,
                              onChanged: (value) {
                                setState(() {
                                  _selectedType1 = value;
                                });
                              },
                              title: 'Other',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontFamily: 'FiraSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff50B5E5)),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Color(0xff50B5E5)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 60,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          fontFamily: 'FiraSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      backgroundColor: Color(0xff50B5E5),
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
