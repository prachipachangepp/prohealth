
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_employment_manager.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../taxtfield_constant.dart';

class Employment_screen extends StatefulWidget {
  const Employment_screen({
    super.key,
    required this.context,
  });



  final BuildContext context;

  @override
  State<Employment_screen> createState() => _Employment_screenState();
}

class _Employment_screenState extends State<Employment_screen> {




  double textFieldWidth = 430;
  double textFieldHeight = 38;

  TextEditingController firstName = TextEditingController();

  /////
  TextEditingController _controllersod = TextEditingController();
  TextEditingController _controllereod = TextEditingController();


  // Current step in the stepper0[
  int _currentStep = 0;

  bool isChecked = false;

  bool get isFirstStep => _currentStep == 0;


  bool isCompleted = false;


  TextEditingController finalposition = TextEditingController();
  TextEditingController  employer= TextEditingController();
  TextEditingController rforleaving = TextEditingController();
  TextEditingController lSupervisorName = TextEditingController();
  TextEditingController supervisormobnum = TextEditingController();
  TextEditingController city = TextEditingController();


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
            child: Text(
              'Employment',
              style: GoogleFonts.firaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff50B5E5)),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 60),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFFE6F7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Your personal details will be required to proceed through the recruitment process.',
              style: GoogleFonts.firaSans(
                color: Color(0xFF686464),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Padding(
            padding: const EdgeInsets.only(left: 166.0, right: 166),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Upload your resume as a docx or pdf with a maximum size of 2 mb',
                        style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 20),
                    ElevatedButton.icon(
                      onPressed: _pickFiles,
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
                Column(
                  children: [
                    Text(
                      'Employment #1',
                      style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff686464)),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  30),
                          Text(
                            'Final Position Title',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                           controller: finalposition,
                            hintText: 'Enter Text',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  40),
                          Text(
                            'Start Date',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            controller: _controllersod,
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
                                  _controllersod.text =
                                      "${pickedDate.toLocal()}"
                                          .split(' ')[0];
                                }
                              },
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  40),
                          Text(
                            'End Date',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            controller: _controllereod,
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
                                  _controllereod.text =
                                      "${pickedDate.toLocal()}"
                                          .split(' ')[0];
                                }
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Color(0xff50B5E5),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Text(
                                'Currently work here',
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  40),
                          Text(
                            'Employer',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
                            controller: employer,
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
                        width: MediaQuery.of(context).size.width / 20),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 40),
                        Text(
                          'Reason for Leaving',
                          style: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff686464)),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 60),
                        CustomTextFieldRegister(
                          controller: rforleaving,
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
                                MediaQuery.of(context).size.height / 40),
                        Text(
                          'Last Supervisor’s Name',
                          style: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff686464)),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 60),
                        CustomTextFieldRegister(
                          controller: lSupervisorName,
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
                                MediaQuery.of(context).size.height / 40),
                        Text(
                          'Supervisor’s Mobile Number',
                          style: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff686464)),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 60),
                        CustomTextFieldRegister(
                          controller: supervisormobnum,
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
                                MediaQuery.of(context).size.height / 40),
                        Text(
                          'City',
                          style: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff686464)),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 60),
                        CustomTextFieldRegister(
                          controller: city,
                          hintText: 'Enter Text',
                          hintStyle: GoogleFonts.firaSans(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff9B9B9B),
                          ),
                          height: 32,
                        ),
                      ],
                    )),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
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
                        'Add Experience ',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color(0xff1696C8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed:
                    () async {
                 await postemploymentscreen(context, 0, employer.text, city.text,  rforleaving.text, lSupervisorName.text, supervisormobnum.text, finalposition.text, "__", "__");
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