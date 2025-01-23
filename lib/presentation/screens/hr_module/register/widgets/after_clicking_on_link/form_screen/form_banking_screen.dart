import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:image_picker/image_picker.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_banking_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_banking_data.dart';
import '../../../../../../widgets/error_popups/four_not_four_popup.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../../../taxtfield_constant.dart';

class BankingScreen extends StatefulWidget {
  final int employeeID;
  final Function onSave;
  final Function onBack;
  final Function onNext;

  const BankingScreen({
    super.key,
    required this.context,
    required this.employeeID, required this.onSave, required this.onBack, required this.onNext,
  });

  final BuildContext context;

  @override
  State<BankingScreen> createState() => _BankingScreenState();
}

class _BankingScreenState extends State<BankingScreen> {
  List<GlobalKey<_BankingFormState>> bankingFormKeys = [];
  bool isVisible = false;
  var validateAccounts;



 bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBankingData();
  }

  Future<void> _loadBankingData() async {
    try {
      List<BankingDataForm> prefilledData = await getBankingForm(context, widget.employeeID);
      if(prefilledData.isEmpty){
        addBankingForm();
      }
      else{
        setState(() {
          bankingFormKeys = List.generate(
            prefilledData.length,
                (index) => GlobalKey<_BankingFormState>(),
          );
        });

      }

    } catch (e) {
      print('Error loading Banking data: $e');
    }
  }

  void addBankingForm() {
    setState(() {
      bankingFormKeys.add(GlobalKey<_BankingFormState>());
    });
  }

  void removeBankingForm(GlobalKey<_BankingFormState> key) {
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
    required dynamic documentFile,
    required String documentName,
  }) async {
        try {
          ApiDataRegister response = await postbankingscreenData(
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


          await uploadcheck(
              context: context,
              employeeid: employeeId,
              empBankingId: response.banckingId!,
              documentFile: documentFile,
              documentName: documentName);
          print('BanckingId :::::: ${response.banckingId!}');

          if(response.statusCode == 200 || response.statusCode == 201){
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddSuccessPopup(
                  message: 'Banking Document Saved',
                );
              },
            );

            await  _loadBankingData();
          }
          else{
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddFailePopup(
                  message: 'Failed To Save Banking Document',
                );
              },
            );
          }
        } catch (e) {
          await showDialog(
            context: context,
            builder: (BuildContext context) => const FourNotFourPopup(),
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
            style:  FormHeading.customTextStyle(context)
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
            textAlign: TextAlign.center,
            style:ZoneDataStyle.customTextStyle(context),
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
              onRemove: () => removeBankingForm(key),
              employeeID: widget.employeeID, isVisible: isVisible,
            );
          }).toList(),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Padding(
          padding: const EdgeInsets.only(left: 160),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: addBankingForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff50B5E5),
                  // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Add Bank Details',
                  style:BlueButtonTextConst.customTextStyle(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //color: Colors.white,
              width: 117,
              height: 30,
              child: ElevatedButton(
                onPressed: ()async{
                  await widget.onBack();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: ColorManager.bluebottom,
                      width: 1,
                    ),
                  ),),
                child: Text('Previous',
                  style: TransparentButtonTextConst.customTextStyle(context),
                ),),
            ),
            const SizedBox(
              width: 30,
            ),

            isLoading
                ? SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
                :CustomButton(
              width: 117,
              height: 30,
              text: 'Save',
              style: BlueButtonTextConst.customTextStyle(context),
              borderRadius: 12,
              onPressed: () async {
                // Start loading state


                // Flag to check if a document is selected

                // Loop through bankingFormKeys
                try{
                  setState(() {
                    isLoading = true;
                  });
                  for (var key in bankingFormKeys) {
                    try {
                      final st = key.currentState!;
                      if (st.isPrefill == false) {
                        // Check if documentFile is selected
                        if (st.finalPath == null || st.finalPath.isEmpty) {
                          // If no document is selected, show a message and stop further execution
                          await  showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return VendorSelectNoti(
                                message: 'Please Select A File',
                              );
                            },
                          );

                          return;  // Exit the loop and method early
                        }

                        if(st.fileAbove20Mb){

                          // Print values before calling perfFormBanckingData
                          print(':::::::Saving Banking Data:::::::::::::');
                          print('Employee ID: ${widget.employeeID}');
                          print('Account Number: ${st.accountnumber.text}');
                          print('Bank Name: ${st.bankname.text}');
                          print('Amount Requested: ${int.parse(st.requestammount.text)}');
                          print('Effective Date: ${st.effectivecontroller.text}');
                          print('Routing Number: ${st.routingnumber.text}');
                          print('Type: ${st.selectedtype.toString()}');
                          print('Requested Percentage: '); // If you have this value, print it
                          print('Document File: ${st.finalPath}');
                          print('Document Name:>>>> ${st.fileName}');

                          // Call the function to submit the data
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
                            requestedPercentage: '', // If you have this value, pass it
                            documentFile: st.finalPath,
                            documentName: st.fileName,
                          );


                        }
                        else{
                          await  showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddErrorPopup(
                                message: 'File is too large!',
                              );
                            },
                          );
                        }
                      }
                    } catch (e) {
                      print('Error: $e');
                    }
                  }
                }finally{
                  setState(() {
                    isLoading = false; // Stop loading
                  });
                  widget.onSave();
                }


                // If a document is selected and everything goes fine, complete the process


                // You can also call any post-save actions here
               // widget.onSave();
              },
              child: Text(
                'Save',
                style: BlueButtonTextConst.customTextStyle(context),
              ),
            ),
            const SizedBox(
              width: AppSize.s30,
            ),
            Container(
              //color: Colors.white,
              width: 117,
              height: 30,
              child: ElevatedButton(
                onPressed: ()async{
                  await widget.onNext();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: ColorManager.bluebottom,
                      width: 1,
                    ),
                  ),),
                child: Text('Next',
                  style: TransparentButtonTextConst.customTextStyle(context),
                ),),
            ),


            //     : CustomButton(
            //   width: 117,
            //   height: 30,
            //   text: 'Save',
            //   style: BlueButtonTextConst.customTextStyle(context),
            //   borderRadius: 12,
            //   onPressed: () async {
            //     // Start loading state
            //     setState(() {
            //       isLoading = true;
            //     });
            //
            //     // Loop through bankingFormKeys
            //     for (var key in bankingFormKeys) {
            //       try {
            //         final st = key.currentState!;
            //         if (st.isPrefill ==false) {
            //           // Print values before calling perfFormBanckingData
            //           print(':::::::Saving Banking Data:::::::::::::');
            //           print('Employee ID: ${widget.employeeID}');
            //           print('Account Number: ${st.accountnumber.text}');
            //           print('Bank Name: ${st.bankname.text}');
            //           print('Amount Requested: ${int.parse(st.requestammount.text)}');
            //           print('Effective Date: ${st.effectivecontroller.text}');
            //           print('Routing Number: ${st.routingnumber.text}');
            //           print('Type: ${st.selectedtype.toString()}');
            //           print('Requested Percentage: '); // If you have this value, print it
            //           print('Document File: ${st.finalPath}');
            //           print('Document Name:>>>> ${st.fileName}');
            //
            //           // Call the function
            //           await perfFormBanckingData(
            //             context: context,
            //             employeeId: widget.employeeID,
            //             accountNumber: st.accountnumber.text,
            //             bankName: st.bankname.text,
            //             amountRequested: int.parse(st.requestammount.text),
            //             checkUrl: "",
            //             effectiveDate: st.effectivecontroller.text,
            //             routingNumber: st.routingnumber.text,
            //             type: st.selectedtype.toString(),
            //             requestedPercentage: '', // If you have this value, pass it
            //             documentFile: st.finalPath ,
            //             documentName: st.fileName ,
            //           );
            //         }
            //       } catch (e) {
            //
            //         print('Error: $e');
            //       }
            //     }
            //
            //     // End loading state
            //     setState(() {
            //       isLoading = false;
            //     });
            //
            //
            //   },
            //   child: Text(
            //     'Save',
            //     style: BlueButtonTextConst.customTextStyle(context),
            //   ),
            // ),


            // if (errorMessage != null)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 16.0),
            //     child: Text(
            //       errorMessage!,
            //       style: TextStyle(color: Colors.red),
            //     ),
            //   ),
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
  final bool isVisible;
  const BankingForm(
      {super.key,
      required this.onRemove,
      required this.index,
      required this.employeeID, required this.isVisible});

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
    _initializeFormWithPrefilledData();
  }

  @override
  void dispose() {
    // Dispose controllers when widget is removed
    accountnumber.dispose();
    verifyaccountnumber.dispose();
    super.dispose();
  }
  bool isPrefill= true;

  TextEditingController effectivecontroller = TextEditingController();
  TextEditingController requestammount = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController routingnumber = TextEditingController();
  TextEditingController bankname = TextEditingController();
  TextEditingController verifyaccountnumber = TextEditingController();

  String? selectedtype ='Checking';

  String? selectedacc;
  int? bankingId;
  String? checkUrl;

  List<String> _fileNames = [];
  bool _loading = false;

  bool fileAbove20Mb = false;
  Future<void> _initializeFormWithPrefilledData() async {
    try {
      List<BankingDataForm> prefilledData = await getBankingForm(context, widget.employeeID);
      if (prefilledData.isNotEmpty) {
        var data = prefilledData[widget.index - 1]; // Assuming index matches the data list
        setState(() {
          effectivecontroller.text = data.effectiveDate ?? '';
          requestammount.text = data.amountRequested.toString() ?? "";
          accountnumber.text = data.accountNumber ?? '';
          routingnumber.text = data.routingNumber ?? '';
          bankname.text = data.bankName ?? '';
          verifyaccountnumber.text = data.accountNumber ?? '';
          selectedtype = data.type ?? '';
          //selectedacc = data. ?? "";
          checkUrl = data.checkUrl.split('/').last;
          bankingId = data.empBankingId ?? 0;

        });
      }
    } catch (e) {
      print('Failed to load prefilled data: $e');
    }
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
    return  Padding(
                    padding: EdgeInsets.only(left: 166.0, right: 166),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bankingId == null ? 'Bank Details #${widget.index}' :  'Bank Details #${bankingId}',
                              style:  HeadingFormStyle.customTextStyle(context),
                            ),
                            if (widget.index > 1)
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
                                    'Effective Date',
                                    style: AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              60),
                                  CustomTextFieldRegister(
                                    controller: effectivecontroller,
                                    hintText: 'yyyy-mm-dd',
                                    hintStyle: onlyFormDataStyle.customTextStyle(context),
                                    height: 32,
                                    onChanged: (value){
                                      if(value.isNotEmpty){
                                        isPrefill= false;
                                      }
                                    },
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
                                    style:AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              60),
                                  CustomTextFieldRegister(
                                    controller: bankname,
                                    hintText: 'Enter Bank Name',
                                    hintStyle:onlyFormDataStyle.customTextStyle(context),
                                    height: 32,
                                    onChanged: (value){
                                      if(value.isNotEmpty){
                                        isPrefill= false;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25),
                                  Text(
                                    'Routing/Transit Number ( 9 Digits )',
                                    style:AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              60),
                                  CustomTextFieldSSn(
                                    maxLength: 9,
                                    controller: routingnumber,
                                    hintText: 'Enter Number',
                                    hintStyle:onlyFormDataStyle.customTextStyle(context),
                                    height: 32,
                                    onChanged: (value){
                                      if(value.isNotEmpty){
                                        isPrefill= false;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          30),


                                  Text(
                                    'Type',
                                    style: AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          30),
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
                                                isPrefill= false;
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
                                              isPrefill= false;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ).paddingOnly(right: 170),
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
                                    style: AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              60),
                                  CustomTextFieldRegister(
                                    controller: accountnumber,
                                    hintText: 'Enter AC Number',
                                    hintStyle: onlyFormDataStyle.customTextStyle(context),
                                    height: 32,
                                    onChanged: (value){
                                      if(value.isNotEmpty){
                                        isPrefill= false;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30),
                                  Text(
                                    'Verify Account Number',
                                    style: AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              60),
                                  CustomTextFieldRegister(
                                    controller: verifyaccountnumber,
                                    // controller: ,
                                    hintText: 'Enter AC Number',
                                    hintStyle: onlyFormDataStyle.customTextStyle(context),
                                    height: 32,
                                    onChanged: (value){
                                      if(value.isNotEmpty){
                                        isPrefill= false;
                                      }
                                    },
                                  ),
                                  errorMessage != null ?
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        errorMessage!,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 10),
                                      ),
                                    ) : SizedBox(height:18),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              25),
                                  Text(
                                    'Requested amount for this account (select one)',
                                    style: AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          60),
                                  // CustomRadioListTile(
                                  //   title: 'Specific Amount',
                                  //   value: 'Specific Amount',
                                  //   groupValue: selectedacc,
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       selectedacc = value;
                                  //     });
                                  //   },
                                  // ),
                                  CustomTextFieldRegister(
                                    hintText: 'Enter Requested amount',
                                    controller: requestammount,
                                    prefixText: '\$',
                                    prefixStyle: onlyFormDataStyle.customTextStyle(context),
                                    height: 32,
                                    onChanged: (value){
                                      if(value.isNotEmpty){
                                        isPrefill= false;
                                      }
                                    },
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
                                style:  FileuploadString.customTextStyle(context),
                              ),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                    onPressed: ()async{
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['pdf']
                                      );
                                      final fileSize = result?.files.first.size; // File size in bytes
                                      final isAbove20MB = fileSize! > (20 * 1024 * 1024);

                                      if (result != null) {
                                        final file = result.files.first;
                                        setState(() {
                                          fileName = file.name;
                                          finalPath = file.bytes;
                                          fileAbove20Mb = !isAbove20MB;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff50B5E5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),

                                    ),
                                    icon: checkUrl == "--" ? Icon(Icons.upload, color: Colors.white):null,
                                    label:checkUrl == null ?Text(
                                      'Upload File',
                                      style:BlueButtonTextConst.customTextStyle(context),
                                    ):Text(
                                      'Uploaded',
                                      style: BlueButtonTextConst.customTextStyle(context),
                                    )
                                ),
                                SizedBox(height: 8,),
                                checkUrl != null ? AutoSizeText(
                                  'Uploaded File: $checkUrl',
                                  style:onlyFormDataStyle.customTextStyle(context),
                                ):
                                fileName != null ?
                                AutoSizeText(
                                  'File picked: $fileName',
                                  style: onlyFormDataStyle.customTextStyle(context),
                                ) : SizedBox(),
                              ],
                            ),
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
  }
}
