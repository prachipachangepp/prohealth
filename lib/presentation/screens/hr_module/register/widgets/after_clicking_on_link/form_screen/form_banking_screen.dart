
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../taxtfield_constant.dart';

class BankingScreen extends StatefulWidget {
  const BankingScreen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<BankingScreen> createState() => _BankingScreenState();
}

class _BankingScreenState extends State<BankingScreen> {


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
            child: Text(
              'Banking',
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
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bank Details #1',
                  style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff686464)),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomRadioListTile(
                                title: 'Checking',
                                value: 'Checking',
                                groupValue: _selectedType,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedType = value;
                                  });
                                },
                              )),
                              Expanded(
                                child: CustomRadioListTile(
                                  title: 'Savings',
                                  value: 'Savings',
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
                              height: MediaQuery.of(context).size.height /
                                  40),
                          Text(
                            'Effective Date',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
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
                                DateTime? pickedDate =
                                    await showDatePicker(
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
                              height: MediaQuery.of(context).size.height /
                                  30),
                          Text(
                            'Bank Name',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
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
                              height: MediaQuery.of(context).size.height /
                                  30),
                          Text(
                            'Routing/Transit Number ( 9 Digits )',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
                          CustomTextFieldRegister(
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
                        width: MediaQuery.of(context).size.width / 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Number ',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
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
                              height: MediaQuery.of(context).size.height /
                                  30),
                          Text(
                            'Verify Account Number',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  60),
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
                              height: MediaQuery.of(context).size.height /
                                  25),
                          Text(
                            'Requested amount for this account (select one)',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff686464)),
                          ),
                          CustomRadioListTile(
                            title: 'Specific Amount',
                            value: 'Specific Amount',
                            groupValue: _selectedType1,
                            onChanged: (value) {
                              setState(() {
                                _selectedType1 = value;
                              });
                            },
                          ),
                          CustomTextFieldRegister(
                            prefixText: '\$',
                            prefixStyle: GoogleFonts.firaSans(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff9B9B9B),
                            ),
                            height: 32,
                            keyboardType: TextInputType.number,
                          ),
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
                        'Upload your Void Check',
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
                        'Add Education',
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
        ],
      ),
    );
  }
}