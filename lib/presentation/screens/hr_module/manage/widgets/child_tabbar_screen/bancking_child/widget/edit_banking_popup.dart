import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/employee_banking_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../custom_icon_button_constant.dart';



class AddBankingPopup extends StatefulWidget {
  final int employeeID;
  final int banckId;
  const AddBankingPopup({super.key, required this.employeeID, required this.banckId});

  @override
  State<AddBankingPopup> createState() => _AddBankingPopupState();
}

class _AddBankingPopupState extends State<AddBankingPopup> {


  String? pickedFileName;
  String? selectedtype;
  dynamic pickedFile;
  bool isLoading = false;
  TextEditingController effectivecontroller = TextEditingController();
  TextEditingController requestammount = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController routingnumber = TextEditingController();
  TextEditingController bankname = TextEditingController();
  TextEditingController verifyaccountnumber = TextEditingController();

  Future<void> _handleFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        pickedFileName = result.files.first.name;
        pickedFile = result.files.first.bytes;
      });
      // PlatformFile file = result.files.first;
      print('File picked: ${pickedFileName}');
    } else {
      // User canceled the picker
    }
  }

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
  void initState() {
    super.initState();
    // Add listeners to controllers
    accountnumber.addListener(validateAccounts);
    verifyaccountnumber.addListener(validateAccounts);
   // _initializeFormWithPrefilledData();
  }

  @override
  void dispose() {
    // Dispose controllers when widget is removed
    accountnumber.dispose();
    verifyaccountnumber.dispose();
    super.dispose();
  }


  String? _PositionError;
  String? _dateError;
  String? _amountError;
  String? _numberError;
  String? _banknameError;
  String? _acError;

  bool _isFormValid = true;


  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "$fieldName";
    }
    return null;
  }

  void _validateFields() {
    setState(() {
      _isFormValid = true;
      _dateError = _validateTextField(effectivecontroller.text, 'Please Enter Date');
      _amountError = _validateTextField(requestammount.text, 'Please Enter Amount');
      _acError = _validateTextField(accountnumber.text, 'Please Enter Account Number');
      _numberError = _validateTextField(routingnumber.text, 'Please Enter Number');
      _banknameError = _validateTextField(bankname.text, 'Please Enter Bank Name');
     // _emailError = _validateTextField(widget.email.text, 'Please Enter Email');
      //_ZoneError = _validateTextField(selectedZone!, 'Please Select Zone');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 444,
        width: 800,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                height:AppSize.s50,
                decoration: BoxDecoration(
                  color: ColorManager.blueprime,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                          "Add Banking",
                          style: PopupHeadingStyle.customTextStyle(context)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);

                        },
                        icon: Icon(
                            Icons.close,
                            color: IconColorManager.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(

                  children: [
                    SizedBox(height: AppSize.s20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                        Text(
                          widget.banckId == 0 ?'Bank':'Bank #${widget.banckId}',
                          style:TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.blackfaint,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(height: 5,),
                            pickedFileName == null ? const Offstage():Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 60),
                                child: Text(pickedFileName!,style:TextStyle(
                                    fontSize: FontSize.s10,
                                    color: ColorManager.mediumgrey
                                ),),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: _handleFileUpload,
                              icon: Icon(Icons.file_upload_outlined, color: Colors.white),
                              label: Text(
                                'Upload',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF27A3E0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s20),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Type',
                                    style: AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),

                                  Row(
                                    children: [
                                      CustomRadioListTile(
                                        title: 'Checking',
                                        value: 'Checking',
                                        groupValue: selectedtype,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedtype = value;
                                          });
                                        },
                                      ),
                                      CustomRadioListTile(
                                        title: 'Savings',
                                        value: 'Savings',
                                        groupValue: selectedtype,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedtype = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'Routing/Transit Number',
                                    style:AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  CustomTextFieldSSn(
                                    width: 240,
                                    maxLength: 9,
                                    controller: routingnumber,
                                    hintText: 'Enter Number',
                                    hintStyle:onlyFormDataStyle.customTextStyle(context),
                                    height: 30,
                                  ),
                                  if (_numberError != null) // Display error if any
                                    Text(
                                      _numberError!,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: FontSize.s10,
                                      ),
                                    ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Specific Amount',
                                    style: AllPopupHeadings.customTextStyle(context),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),

                                  Row(
                                    children: [
                                      CustomTextFieldRegister(
                                        width: 150,
                                        controller: requestammount,
                                        prefixText: '\$',
                                        prefixStyle: onlyFormDataStyle.customTextStyle(context),
                                        height: 30,
                                        keyboardType: TextInputType.number,
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          requestammount.clear();
                                        },
                                        child: Text(
                                          'Reset',
                                          style: TextStyle(
                                            fontSize: AppSize.s12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF27A3E0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_amountError != null) // Display error if any
                                    Text(
                                      _amountError!,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: FontSize.s10,
                                      ),
                                    ),

                                ],
                              ),
                            ),

                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Effective Date',
                                  style: AllPopupHeadings.customTextStyle(context),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                CustomTextFieldRegister(
                                  width: 240,
                                  controller: effectivecontroller,
                                  hintText: 'yyyy-mm-dd',
                                  hintStyle: onlyFormDataStyle.customTextStyle(context),
                                  height: 30,
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
                                if (_dateError != null) // Display error if any
                                  Text(
                                    _dateError!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Account Number ',
                                  style: AllPopupHeadings.customTextStyle(context),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                CustomTextFieldRegister(
                                  width: 240,
                                  controller: accountnumber,
                                  hintText: 'Enter AC Number',
                                  hintStyle: onlyFormDataStyle.customTextStyle(context),
                                  height: 30,
                                ),
                                if (_acError != null) // Display error if any
                                  Text(
                                    _acError!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                SizedBox(
                                  height: 40,
                                )
                              ],
                            )),

                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bank Name',
                                  style:AllPopupHeadings.customTextStyle(context),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                CustomTextFieldRegister(
                                  width: 240,
                                  controller: bankname,
                                  hintText: 'Enter Bank Name',
                                  hintStyle:onlyFormDataStyle.customTextStyle(context),
                                  height: 30,
                                ),
                                if (_banknameError != null) // Display error if any
                                  Text(
                                    _banknameError!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Verify Account Number',
                                  style: AllPopupHeadings.customTextStyle(context),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                CustomTextFieldRegister(
                                  width: 240,
                                  controller: verifyaccountnumber,
                                  // controller: ,
                                  hintText: 'Enter AC Number',
                                  hintStyle: onlyFormDataStyle.customTextStyle(context),
                                  height: 30,
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
                                  height: 40,
                                )
                              ],
                            )),

                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButtonTransparent(
                          text: "Cancel",
                          onPressed: () {
                            // widget.effectiveDateController.clear();
                            // widget.specificAmountController.clear();
                            // widget.bankNameController.clear();
                            // widget.routingNumberController.clear();
                            // widget.accountNumberController.clear();
                            // widget.verifyAccountController.clear();
                            // widget.selectedType = null;
                            // _typeFieldKey.currentState?.reset();
                          },
                        ),
                        SizedBox(width: AppSize.s13),
                        isLoading
                            ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime,
                            ))
                            : CustomElevatedButton(
                              width: 100,
                              text: "Save",
                              onPressed: ()async {
                                _validateFields();
                                if (_isFormValid) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var response = await addNewEmployeeBanking(
                                      context: context,
                                      employeeId: widget.employeeID,
                                      accountNumber: accountnumber.text,
                                      bankName: bankname.text,
                                      amountRequested: int.parse(requestammount.text),
                                      checkUrl: '--',
                                      effectiveDate: effectivecontroller.text,
                                      routingNumber: routingnumber.text,
                                      percentage: '',
                                      type: selectedtype.toString()
                                  );
                                  var responseBank = await approveBankPatch(context,response.banckingId!);
                                  await uploadBanckingDocument(
                                      context, response.banckingId!, pickedFile);
                                  Navigator.pop(context);
                                  if (responseBank.statusCode == 200 ||
                                      responseBank.statusCode == 201) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AddSuccessPopup(
                                          message: 'Banking Added Successfully',
                                        );
                                      },
                                    );
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            ),

                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}



























class EditBankingPopUp extends StatefulWidget {
  final int banckId;
  String? selectedType;
  final String title;
  final TextEditingController effectiveDateController;
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController verifyAccountController;
  final TextEditingController routingNumberController;
  final TextEditingController specificAmountController;
  Future<void> Function(String) onPressed;

  EditBankingPopUp({
    super.key,
    required this.title,
    required this.onPressed,
    this.selectedType,
    required this.effectiveDateController,
    required this.bankNameController,
    required this.accountNumberController,
    required this.verifyAccountController,
    required this.routingNumberController,
    required this.specificAmountController,  required this.banckId,
  });

  @override
  State<EditBankingPopUp> createState() => _EditBankingPopUpState();
}

class _EditBankingPopUpState extends State<EditBankingPopUp> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _typeFieldKey = GlobalKey<FormFieldState<String>>();
  String? pickedFileName;
  dynamic pickedFile;
 // Map<String, bool> errorStates = {
 //    'name': false,
 //    'email': false,
 bool   rnumber = false;
      bool eDate = false;
    bool bankname = false;
  bool sac= false;
   bool ac= false;
    bool vac= false;
 // };

  String?  errorKey;
  String gropvalue ='';

@override
  void initState() {
    // TODO: implement initState
  gropvalue =widget.selectedType!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        titlePadding: EdgeInsets.zero,
        title: _buildDialogTitle(context),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          width: MediaQuery.of(context).size.width * 0.6, //0.8
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderWithUpload(),
                SizedBox(height: MediaQuery.of(context).size.height / 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildFirstColumn()),
                    SizedBox(width: 20),
                    Expanded(child: _buildSecondColumn()),
                    SizedBox(width: 20),
                    Expanded(child: _buildThirdColumn()),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: _buildDialogActions(context),
      ),
    );
  }

  Widget _buildDialogTitle(BuildContext context) {
    return Container(
      height: AppSize.s50,
      decoration: BoxDecoration(
          color: ColorManager.blueprime,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0))),
      padding: EdgeInsets.only(left: 25.0),
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: PopupHeadingStyle.customTextStyle(context),
            ),
            IconButton(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderWithUpload() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.banckId == 0 ?'Bank':'Bank #${widget.banckId}',
          style:TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: ColorManager.blackfaint,
          ),
        ),
        Row(
          children: [
            SizedBox(height: 5,),
            pickedFileName == null ? const Offstage():Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text(pickedFileName!,style:TextStyle(
                    fontSize: FontSize.s10,
                    color: ColorManager.mediumgrey
                ),),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _handleFileUpload,
              icon: Icon(Icons.file_upload_outlined, color: Colors.white),
              label: Text(
                'Upload',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF27A3E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _handleFileUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        pickedFileName = result.files.first.name;
        pickedFile = result.files.first.bytes;
      });
      // PlatformFile file = result.files.first;
      print('File picked: ${pickedFileName}');
    } else {


      // User canceled the picker
    }
  }

  Widget _buildFirstColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Type',
          style: AllPopupHeadings.customTextStyle(context),
        ),


        FormField<String>(
          key: _typeFieldKey,
          initialValue: widget.selectedType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select an account type';
            }
            return null;
          },
          builder: (state) {
            print("IIII:::::${ gropvalue}");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Checking',
                      groupValue: gropvalue,
                      onChanged: (value) {
                        setState(() {
                          gropvalue = value.toString();
                          _typeFieldKey.currentState
                              ?.didChange(value.toString());
                        });
                      },
                    ),
                    Text(
                      'Checking',
                      style: TextStyle(
                          fontSize: AppSize.s12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    SizedBox(width: 5,),
                    Radio(
                      value: 'Savings',
                      groupValue: gropvalue,
                      onChanged: (value) {
                        setState(() {
                          gropvalue = value.toString();
                          _typeFieldKey.currentState
                              ?.didChange(value.toString());
                        });
                      },
                    ),

                    Text(
                      'Savings',
                      style: TextStyle(
                          fontSize: AppSize.s12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     CustomRadioListTile(
                //       title: 'Checking',
                //       value: 'Checking',
                //       groupValue: widget.selectedType,
                //       onChanged: (value) {
                //         setState(() {
                //           widget.selectedType = value;
                //         });
                //       },
                //     ),
                //     CustomRadioListTile(
                //       title: 'Savings',
                //       value: 'Savings',
                //       groupValue: widget.selectedType,
                //       onChanged: (value) {
                //         setState(() {
                //           widget.selectedType = value;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top:1),
                    child: Text(
                      state.errorText!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
         SizedBox(height: MediaQuery.of(context).size.height / 20),
        _buildTextField(
            capitalIsSelect:false,
          controller:widget.routingNumberController,
          labelText: 'Routing Number/ Transit Number',
          errorText: rnumber?"Please Enter Routing Number" : null, ),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
        // Text('Requested Amount for this Account (select one)',
        //     style: _labelStyle()),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _buildTextField(
                capitalIsSelect:false,
                  prefixText: '\$', controller: widget.specificAmountController, labelText: 'Specific Amount',
                errorText: sac?"Please Enter Specific Amount" : null,
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                widget.specificAmountController.clear();
              },
              child: Text(
                'Reset',
                style: TextStyle(
                  fontSize: AppSize.s12,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF27A3E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          capitalIsSelect:false,
          errorText: eDate?"Please Enter Effective Date" : null,
          suffixIcon: IconButton(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              Icons.calendar_month_outlined,
              color: Color(0xff50B5E5),
              size: AppSize.s16,
            ),
            onPressed: _selectDate,
          ), controller:  widget.effectiveDateController, labelText: 'Effective Date',
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 22),
        _buildTextField(capitalIsSelect:false, controller:widget.accountNumberController, labelText: 'Account Number' , errorText: ac?"Please Enter Account Number" : null,),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      widget.effectiveDateController.text =
          "${pickedDate.toLocal()}".split(' ')[0];
    }
  }


  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? errorText,
    Widget? suffixIcon,
    String? prefixText,
    required bool capitalIsSelect,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,style: AllPopupHeadings.customTextStyle(context),),
        SizedBox(height: 4,),
        CustomTextFieldRegister(
          capitalIsSelect: capitalIsSelect,
          phoneNumberField:false, // Specify if this is the phone field
          height: AppSize.s30,
          controller: controller,

          keyboardType: labelText == "Phone" ? TextInputType.phone : TextInputType.text,
          padding: EdgeInsets.only(bottom: AppPadding.p1, left: 2),
          suffixIcon: suffixIcon,
          onTap: onTap,
          onChanged: (value) {
            setState(() {
              // Update error state based on the field
              if (labelText == "Specific Amount") sac = value.isEmpty;
              if (labelText == "Routing Number/ Transit Number") rnumber = value.isEmpty;
              if (labelText == "Account Number") ac = value.isEmpty;
              //if (labelText == "Phone") sac = !_isPhoneValid(value); // Use custom phone validation
              if (labelText == "Effective Date") eDate = value.isEmpty;
              if (labelText == "Bank Name") bankname = value.isEmpty;
              if (labelText == "Verify Account Number") vac = value.isEmpty;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppString.enterText;
            }
            return null;
          },
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 1),
            child: Text(
              errorText,
              style: CommonErrorMsg.customTextStyle(context),
            ),
          ),
      ],
    );
  }

 String? errorVerifyAccountMessage = "Account Number does not match";
  void _handleSave() async {
    setState(() {
      isLoading = true;
      eDate = widget.effectiveDateController.text.isEmpty;
      bankname = widget.bankNameController.text.isEmpty;
      vac = widget.verifyAccountController.text.isEmpty;
      rnumber = widget.routingNumberController.text.isEmpty;
      sac = widget.specificAmountController.text.isEmpty;
      ac = widget.accountNumberController.text.isEmpty;

      // Add this check to see if the account numbers match
      if (widget.accountNumberController.text != widget.verifyAccountController.text ) {
        vac = true; // Set error for Verify Account Number
        errorVerifyAccountMessage;
      } else {
        errorVerifyAccountMessage = null;
      }

    });

    if (!rnumber &&
        !eDate &&
        !bankname &&
        !sac &&
        !ac &&
        !vac && // Ensure this is only true when both account numbers match
        errorVerifyAccountMessage == null && _typeFieldKey.currentState!.validate()) {
      try {
        await widget.onPressed(gropvalue);
        if(pickedFile != null){
          await uploadBanckingDocument(context, widget.banckId, pickedFile);



        }


      } finally {

        _clearControllers();
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildThirdColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          controller: widget.bankNameController,
          labelText: 'Bank Name',
          capitalIsSelect: true,
          errorText: bankname ? "Please Enter Bank Name" : null,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 22),
        _buildTextField(
          capitalIsSelect: false,
          controller: widget.verifyAccountController,
          labelText: 'Verify Account Number',
          errorText: vac ? errorVerifyAccountMessage ?? "Please Enter Verify Account Number" : null, // Display the custom error if account numbers don't match
        ),
      ],
    );
  }



  void _clearControllers() {
    widget.effectiveDateController.clear();
    widget.specificAmountController.clear();
    widget.bankNameController.clear();
    widget.routingNumberController.clear();
    widget.accountNumberController.clear();
    widget.verifyAccountController.clear();
  }




  // Widget _buildTextFormField(
  //   TextEditingController controller,
  //   String labelText, {
  //   Widget? suffixIcon,
  //   String? prefixText,
  //       TextInputType? keyboardType,
  //       Function(String)? validator,
  //       required bool capitalIsSelect,
  // }){
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       CustomTextFieldRegister(
  //         phoneNumberField:  false,
  //         height: AppSize.s30,
  //         width: MediaQuery.of(context).size.width / 6,
  //         controller: controller,
  //         labelText: labelText,
  //         keyboardType: keyboardType ?? TextInputType.text,
  //         padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
  //         capitalIsSelect: capitalIsSelect, // Pass the parameter here
  //         onChanged: (value) {
  //           setState(() {
  //             if (validator != null) {
  //               errorStates[errorKey!] = validator(value) != null;
  //             } else {
  //               errorStates[errorKey!] = value.isEmpty;
  //             }
  //             if (errorKey == 'mobileNumber') {
  //               errorStates[errorKey!] = value.length != 10;
  //             }
  //           });
  //         },
  //         validator: (value) {
  //           if (value == null || value.isEmpty) {
  //             return 'Please enter ${labelText.toLowerCase()}';
  //           }
  //           return null;
  //         },
  //       ),
  //       // Container(
  //       //   height: 36,
  //       //   child: TextFormField(
  //       //     style: TextStyle(
  //       //       fontSize: AppSize.s12,
  //       //     ),
  //       //     controller: controller,
  //       //     decoration: InputDecoration(
  //       //       labelText: labelText,
  //       //       suffixIcon: suffixIcon,
  //       //       prefixText: prefixText,
  //       //       border: OutlineInputBorder(
  //       //         borderRadius: BorderRadius.circular(8),
  //       //         borderSide: BorderSide(color: Color(0xffB1B1B1)),
  //       //       ),
  //       //       contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  //       //     ),
  //       //     inputFormatters: [if (capitalIsSelect) CapitalizeFirstLetterFormatter(),// Apply formatter conditionally
  //       //     ],
  //       //     validator: (value) {
  //       //       if (value == null || value.isEmpty) {
  //       //         return 'Please enter ${labelText.toLowerCase()}';
  //       //       }
  //       //       return null;
  //       //     },
  //       //   ),
  //       // ),
  //       // SizedBox(height: 5),
  //     ],
  //   );
  // }

  TextStyle _labelStyle() {
    return TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: Color(0xff575757),
    );
  }

  List<Widget> _buildDialogActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 13,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonTransparent(
              text: "Cancel",
              onPressed: () {
                // widget.effectiveDateController.clear();
                // widget.specificAmountController.clear();
                // widget.bankNameController.clear();
                // widget.routingNumberController.clear();
                // widget.accountNumberController.clear();
                // widget.verifyAccountController.clear();
                // widget.selectedType = null;
                // _typeFieldKey.currentState?.reset();
              },
            ),
            SizedBox(width: AppSize.s13),
            isLoading
                ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ))
                : CustomElevatedButton(
              width: 100,
              text: "Save",
              onPressed: _handleSave,
              //  onPressed: () async {
              // // if (_formKey.currentState!.validate()) {
              //      setState(() {
              //        isLoading = true;
              //      });
              //      try {
              //        await widget.onPressed();
              //
              //        await uploadBanckingDocument(context,widget.banckId,pickedFile);
              //      } finally {
              //        setState(() {
              //          isLoading = false;
              //        });
              //        widget.effectiveDateController.clear();
              //        widget.specificAmountController.clear();
              //        widget.bankNameController.clear();
              //        widget.routingNumberController.clear();
              //        widget.accountNumberController.clear();
              //        widget.verifyAccountController.clear();
              //        widget.selectedType = null;
              //        _typeFieldKey.currentState?.reset();
              //      }
              //    // }
              //  },
              //         style: ElevatedButton.styleFrom(
              // backgroundColor: Color(0xFF27A3E0),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(12.0),
              // ),
              //         ),
            ),
          ],
        ),
      ),

    ];
  }
}
