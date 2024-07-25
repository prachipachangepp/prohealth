import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_banking_manager.dart';

import '../../../../../../../app/resources/color.dart';
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
  /////

  List<GlobalKey<_BankingFormState>> bankingFormKeys = [];

  @override
  void initState() {
    super.initState();
    addEducationForm();
  }

  void addEducationForm() {
    setState(() {
      bankingFormKeys.add(GlobalKey<_BankingFormState>());
    });
  }

  void removeEduacationForm(GlobalKey<_BankingFormState> key) {
    setState(() {
      bankingFormKeys.remove(key);
    });
  }

  Future<void> postbankingscreen(
      BuildContext context,
      int employeeId,
      String accountNumber,
      String bankName,
      int amountRequested,
      String checkUrl,
      String routingNumber,
      String type,
      String requestedPercentage) async {}

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Column(
          children: bankingFormKeys.asMap().entries.map((entry) {
            int index = entry.key;
            GlobalKey<_BankingFormState> key = entry.value;
            return BankingForm(
              key: key,
              index: index + 1,
              onRemove: () => removeEduacationForm(key),
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
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
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
                // Loop through each form and extract data to post
                for (var key in bankingFormKeys) {
                  final st = key.currentState!;
                  await postbankingscreen(
                    context,
                    0,
                    st.accountnumber.text,
                    st.bankname.text,
                    int.parse(st.requestammount.text),
                    "checkUrl",
                    st.routingnumber.text,
                    st.selectedtype.toString(),
                    "requestedPercentage",
                  );
                }
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

class BankingForm extends StatefulWidget {
  final VoidCallback onRemove;
  final int index;
  const BankingForm({super.key, required this.onRemove, required this.index});

  @override
  _BankingFormState createState() => _BankingFormState();
}

class _BankingFormState extends State<BankingForm> {
  TextEditingController controller = TextEditingController();
  TextEditingController requestammount = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController routingnumber = TextEditingController();
  TextEditingController bankname = TextEditingController();

  String? selectedtype;

  String? selectedacc;

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
    return Padding(
      padding: const EdgeInsets.only(left: 166.0, right: 166),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bank Details #${widget.index}',
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
                          groupValue: selectedtype,
                          onChanged: (value) {
                            setState(() {
                              selectedtype = value;
                            });
                          },
                        )),
                        Expanded(
                          child: CustomRadioListTile(
                            title: 'Savings',
                            value: 'Savings',
                            groupValue: selectedtype,
                            onChanged: (value) {
                              setState(() {
                                selectedtype = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 40),
                    Text(
                      'Effective Date',
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: controller,
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
                            controller.text =
                                "${pickedDate.toLocal()}".split(' ')[0];
                          }
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Text(
                      'Bank Name',
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: bankname,
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
                      'Routing/Transit Number ( 9 Digits )',
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: routingnumber,
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
                  children: [
                    Text(
                      'Account Number ',
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
                      controller: accountnumber,
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
                      'Verify Account Number',
                      style: GoogleFonts.firaSans(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    CustomTextFieldRegister(
// controller: ,
                      hintText: 'Enter Text',
                      hintStyle: GoogleFonts.firaSans(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9B9B9B),
                      ),
                      height: 32,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 25),
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
                      groupValue: selectedacc,
                      onChanged: (value) {
                        setState(() {
                          selectedacc = value;
                        });
                      },
                    ),
                    CustomTextFieldRegister(
                      controller: requestammount,
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
              SizedBox(width: MediaQuery.of(context).size.width / 5),
              ElevatedButton.icon(
                onPressed: _pickFiles,
// onPressed: () async {
//   FilePickerResult? result =
//   await FilePicker.platform.pickFiles(
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
                icon: Icon(Icons.file_upload_outlined, color: Colors.white),
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
              SizedBox(height: MediaQuery.of(context).size.height / 20),// Display file names if picked
            ],

          ),
         const Divider(color: Colors.grey,thickness: 2,)
        ],
      ),
    );
  }
}
