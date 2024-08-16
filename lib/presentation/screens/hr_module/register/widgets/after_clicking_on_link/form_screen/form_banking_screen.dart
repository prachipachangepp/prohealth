import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_banking_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_banking_data.dart';
import '../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class BankingScreen extends StatefulWidget {
  final int employeeID;

  const BankingScreen({
    super.key,
    required this.context,
    required this.employeeID,
  });

  final BuildContext context;

  @override
  State<BankingScreen> createState() => _BankingScreenState();
}

class _BankingScreenState extends State<BankingScreen> {
  /////

  List<GlobalKey<_BankingFormState>> bankingFormKeys = [];

  var validateAccounts;

  var errorMessage;

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

  Future<void> perfFormBanckingData({
    required BuildContext context,
    required int employeeId,
    required String accountNumber,
    required String bankName,
    required int amountRequested,
    required String checkUrl,
    required String effectiveDate,
    required String routingNumber,
    required String type,
    required String requestedPercentage,
    //required String documentType,
    //required String employeeId,
    required dynamic documentFile,
    required String documentName,
  }) async {
    ApiDataRegister result = await postbankingscreen(
        context,
        employeeId,
        accountNumber,
        bankName,
        amountRequested,
        checkUrl,
        effectiveDate,
        routingNumber,
        type,
        requestedPercentage);

    // setState(() {
    //   _isLoading = false;
    // });
    print('BanckingId :: ${result.banckingId!}');
    await uploadcheck(
        context: context,
        employeeid: employeeId,
        empBankingId: result.banckingId!,
        documentFile: documentFile,
        documentName: documentName);

    if (result.success) {
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${result.message}')),
      );
    }
  }

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
              employeeID: widget.employeeID,
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
                  'Add Banking',
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
              style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              borderRadius: 12,
              onPressed: () async {
                for (var key in bankingFormKeys) {
                  final st = key.currentState!;
                  await perfFormBanckingData(
                    context: context,
                    employeeId: widget.employeeID,
                    accountNumber: st.accountnumber.text,
                    bankName: st.bankname.text,
                    amountRequested: int.parse(st.requestammount.text),
                    checkUrl: "",
                    effectiveDate: st.effectivecontroller.text,
                    routingNumber: st.routingnumber.text,
                    type: st.selectedtype.toString(),
                    requestedPercentage: "",
                    documentFile: st.finalPath,
                    documentName: st.fileName,
                  );
                  validateAccounts;
                }
              },
              // accountnumber.clear();

              child: Text(
                'Save',
                style: GoogleFonts.firaSans(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class BankingForm extends StatefulWidget {
  final int employeeID;
  final VoidCallback onRemove;
  final int index;
  const BankingForm(
      {super.key,
      required this.onRemove,
      required this.index,
      required this.employeeID});

  @override
  _BankingFormState createState() => _BankingFormState();
}

class _BankingFormState extends State<BankingForm> {
  @override
  void initState() {
    super.initState();
    // Add listeners to controllers
    accountnumber.addListener(validateAccounts);
    verifyaccountnumber.addListener(validateAccounts);
  }

  @override
  void dispose() {
    // Dispose controllers when widget is removed
    accountnumber.dispose();
    verifyaccountnumber.dispose();
    super.dispose();
  }

  TextEditingController effectivecontroller = TextEditingController();
  TextEditingController requestammount = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController routingnumber = TextEditingController();
  TextEditingController bankname = TextEditingController();
  TextEditingController verifyaccountnumber = TextEditingController();

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
        _fileNames.addAll(result.files.map((file) => file.name));
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
  dynamic filePath;
  File? xfileToFile;
  var finalPath;

  String? errorMessage;

  void validateAccounts() {
    setState(() {
      if (accountnumber.text != verifyaccountnumber.text) {
        errorMessage = 'Account numbers do not match';
      } else {
        errorMessage = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BankingDataForm>>(
        future: getBankingForm(context, widget.employeeID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 150),
                child: CircularProgressIndicator(
                  color: Color(0xff50B5E5),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            List<BankingDataForm>? data = snapshot.data;
            //print{::::::::=> "$snapshot.data"};
            print(":::::: :=>${snapshot.data!}");
            //final data = snapshot.data;
            // Update controllers with API data

            return Container(
              height: MediaQuery.of(context).size.height / 1,
              width: MediaQuery.of(context).size.width / 1,

              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  effectivecontroller = TextEditingController(
                      text: snapshot.data![index].effectiveDate);
                  requestammount = TextEditingController(
                      text: snapshot.data![index].amountRequested.toString());
                  // requestammount = snapshot.data![index].requestammount  ;
                  accountnumber = TextEditingController(
                      text: snapshot.data![index].accountNumber);
                  routingnumber = TextEditingController(
                      text: snapshot.data![index].routingNumber);
                  bankname = TextEditingController(
                      text: snapshot.data![index].bankName);
                  selectedtype=snapshot.data![index].type;
                  // verifyaccountnumber = TextEditingController(text:snapshot.data![index].);
               return  Padding(
                    padding: EdgeInsets.only(left: 166.0, right: 166),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bank Details #${snapshot.data![index].empBankingId}',
                              style: GoogleFonts.firaSans(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff686464)),
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: widget.onRemove,
                            ),
                          ],
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
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              40),
                                  Text(
                                    'Effective Date',
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
                                    controller: effectivecontroller,
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
                                          effectivecontroller.text =
                                              "${pickedDate.toLocal()}"
                                                  .split(' ')[0];
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30),
                                  Text(
                                    'Bank Name',
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
                                    controller: bankname,
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
                                    'Routing/Transit Number ( 9 Digits )',
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
                                      height:
                                          MediaQuery.of(context).size.height /
                                              60),
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
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30),
                                  Text(
                                    'Verify Account Number',
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
                                    controller: verifyaccountnumber,
                                    // controller: ,
                                    hintText: 'Enter Text',
                                    hintStyle: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9B9B9B),
                                    ),
                                    height: 32,
                                  ),
                                  if (errorMessage != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        errorMessage!,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 10),
                                      ),
                                    ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 20),
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
                                    await FilePicker.platform.pickFiles();
                                if (result != null) {
                                  try {
                                    Uint8List? bytes = result.files.first.bytes;
                                    XFile xFile = await convertBytesToXFile(
                                        bytes!, result.files.first.name);
                                    finalPath = result.files.first.bytes;
                                    fileName = result.files.first.name;
                                    setState(() {
                                      _fileNames.addAll(result.files
                                          .map((file) => file.name));
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
                                                        color:
                                                            Color(0xff686464)),
                                                  ),
                                                ))
                                            .toList(),
                                      )
                                    : SizedBox(),
                            SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    20), // Display file names if picked
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 2,
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return SizedBox();
        });
  }
}
