import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/employee_banking_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../custom_icon_button_constant.dart';

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
  Future<void> Function() onPressed;

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
  Map<String, bool> errorStates = {
    'name': false,
    'email': false,
    'titlePosition': false,
    'knowPerson': false,
    'companyName': false,
    'associationLength': false,
    'mobileNumber': false,
    'referredBy': false,
  };

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
          child: Form(
            key: _formKey,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: PopupHeadingStyle.customTextStyle(context),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderWithUpload() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.banckId == 0 ?'Bank':'Bank #${widget.banckId}',
          style: GoogleFonts.firaSans(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            SizedBox(height: 5,),
            pickedFileName == null ? const Offstage():Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text(pickedFileName!,style: GoogleFonts.firaSans(
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
                style: GoogleFonts.firaSans(
                  color: Colors.white,
                  fontSize: 10,
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
      allowMultiple: false,
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
      children: [
        Text(
          'Type',
          style:
              TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'Checking',
                      groupValue: widget.selectedType,
                      onChanged: (value) {
                        setState(() {
                          widget.selectedType = value.toString();
                          _typeFieldKey.currentState
                              ?.didChange(value.toString());
                        });
                      },
                    ),
                    Text(
                      'Checking',
                      style: TextStyle(
                          fontSize: AppSize.s10,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    Radio(
                      value: 'Savings',
                      groupValue: widget.selectedType,
                      onChanged: (value) {
                        setState(() {
                          widget.selectedType = value.toString();
                          _typeFieldKey.currentState
                              ?.didChange(value.toString());
                        });
                      },
                    ),
                    Text(
                      'Savings',
                      style: TextStyle(
                          fontSize: AppSize.s11,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
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
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        _buildTextFormField(
            capitalIsSelect:false,
            widget.routingNumberController, 'Routing Number/ Transit Number'),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Text('Requested Amount for this Account (select one)',
            style: _labelStyle()),
        Row(
          children: [
            Radio(
              value: 'Specific Amount',
              groupValue: 'Specific Amount',
              onChanged: (value) {},
            ),
            Text(
              'Specific Amount:',
              style: TextStyle(
                  fontSize: AppSize.s11,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildTextFormField(capitalIsSelect:false,widget.specificAmountController, '',
                  prefixText: '\$'),
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
        _buildTextFormField(
          capitalIsSelect:false,
          widget.effectiveDateController,
          'Effective Date',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.calendar_month_outlined,
              color: Color(0xff50B5E5),
              size: AppSize.s20,
            ),
            onPressed: _selectDate,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 30),
        _buildTextFormField(capitalIsSelect:false,widget.accountNumberController, 'Account Number'),
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

  Widget _buildThirdColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextFormField(widget.bankNameController, 'Bank Name',capitalIsSelect:true),
        SizedBox(height: MediaQuery.of(context).size.height / 30),
        _buildTextFormField(
            capitalIsSelect:false,
            widget.verifyAccountController, 'Verify Account Number'),
      ],
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
    String labelText, {
    Widget? suffixIcon,
    String? prefixText,
        TextInputType? keyboardType,
        Function(String)? validator,
        required bool capitalIsSelect,
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldRegister(
          phoneNumberField:  false,
          height: AppSize.s30,
          width: MediaQuery.of(context).size.width / 6,
          controller: controller,
          labelText: labelText,
          keyboardType: keyboardType ?? TextInputType.text,
          padding: const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
          capitalIsSelect: capitalIsSelect, // Pass the parameter here
          onChanged: (value) {
            // setState(() {
            //   if (validator != null) {
            //     errorStates[errorKey] = validator(value) != null;
            //   } else {
            //     errorStates[errorKey] = value.isEmpty;
            //   }
            //   // if (errorKey == 'mobileNumber') {
            //   //   errorStates[errorKey] = value.length != 10;
            //   // }
            // });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${labelText.toLowerCase()}';
            }
            return null;
          },
        ),
        // Container(
        //   height: 36,
        //   child: TextFormField(
        //     style: TextStyle(
        //       fontSize: AppSize.s12,
        //     ),
        //     controller: controller,
        //     decoration: InputDecoration(
        //       labelText: labelText,
        //       suffixIcon: suffixIcon,
        //       prefixText: prefixText,
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(8),
        //         borderSide: BorderSide(color: Color(0xffB1B1B1)),
        //       ),
        //       contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        //     ),
        //     inputFormatters: [if (capitalIsSelect) CapitalizeFirstLetterFormatter(),// Apply formatter conditionally
        //     ],
        //     validator: (value) {
        //       if (value == null || value.isEmpty) {
        //         return 'Please enter ${labelText.toLowerCase()}';
        //       }
        //       return null;
        //     },
        //   ),
        // ),
        // SizedBox(height: 5),
      ],
    );
  }

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
        padding: const EdgeInsets.only(bottom: 20),
        child:
            CustomButtonTransparent(
          text: "Cancel",
          onPressed: () {
            widget.effectiveDateController.clear();
            widget.specificAmountController.clear();
            widget.bankNameController.clear();
            widget.routingNumberController.clear();
            widget.accountNumberController.clear();
            widget.verifyAccountController.clear();
            widget.selectedType = null;
            _typeFieldKey.currentState?.reset();
          },
        ),
      ),
      isLoading
          ? SizedBox(
              height: 20,
              width: 25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ))
          : Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 20),
              child:
              CustomElevatedButton(
                width: 100,
                text: "Save",
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await widget.onPressed();
                      await uploadBanckingDocument(context,widget.banckId,pickedFile);
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                      widget.effectiveDateController.clear();
                      widget.specificAmountController.clear();
                      widget.bankNameController.clear();
                      widget.routingNumberController.clear();
                      widget.accountNumberController.clear();
                      widget.verifyAccountController.clear();
                      widget.selectedType = null;
                      // _typeFieldKey.currentState?.reset();
                    }
                  // }
                },
                //         style: ElevatedButton.styleFrom(
                // backgroundColor: Color(0xFF27A3E0),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(12.0),
                // ),
                //         ),
              ),
            ),
    ];
  }
}
