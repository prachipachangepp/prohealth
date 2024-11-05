import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../../../../app/constants/app_config.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/const_string.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/services/api/managers/establishment_manager/manage_insurance_manager/insurance_vendor_contract_manager.dart';
import '../../../../manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../widgets/dialogue_template.dart';
import '../../../../widgets/header_content_const.dart';
import '../../whitelabelling/success_popup.dart';

class ContractAddDialog extends StatefulWidget {
  final String title;
  final int selectedVendorId;
  final String officeid;

  ContractAddDialog({
    Key? key,
    required this.title,
    required this.selectedVendorId,
    required this.officeid,
  }) : super(key: key);

  @override
  State<ContractAddDialog> createState() => _ContractAddDialogState();
}

class _ContractAddDialogState extends State<ContractAddDialog> {
  TextEditingController birthdayController = TextEditingController();

  TextEditingController contractNmaeController = TextEditingController();
  TextEditingController contractIdController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController daysController = TextEditingController(text: "1");

  bool loading = false;
  bool _isFormValid = true;
  String selectedExpiryType = "";

  // Error messages for each text field
  String? _idDocError;
  String? _nameDocError;
  String? selectedYear = AppConfig.year;
  bool showExpiryDateField = false;

  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }

  DateTime? datePicked;
  void _validateForm() {
    setState(() {
      _isFormValid = true;
      _idDocError =
          _validateTextField(contractIdController.text, 'ID of the Contract');
      _nameDocError = _validateTextField(
          contractNmaeController.text, 'Name of the Contract');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s420,
      height: AppSize.s500,
      body: [
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             FirstSMTextFConst(
               controller: contractNmaeController,
               keyboardType: TextInputType.text,
               text: 'Contract Name',
             ),
             if (_nameDocError != null) // Display error if any
               Text(
                 _nameDocError!,
                 style: CommonErrorMsg.customTextStyle(context),
               ),

             SizedBox(height: AppSize.s8),
             SMTextFConst(
               controller: contractIdController,
               keyboardType: TextInputType.text,
               text: 'Contract ID',
             ),
             if (_idDocError != null)
               Padding(
                 padding: const EdgeInsets.only(top: 2.0),
                 child: Text(
                   _idDocError!,
                   style: CommonErrorMsg.customTextStyle(context),
                 ),
               ),

             SizedBox(height: AppSize.s8),
             Row(
               children: [
                 HeaderContentConst(
                   heading: AppString.expiry_type,
                   content: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       CustomRadioListTile(
                         value: AppConfig.scheduled,
                         groupValue: selectedExpiryType,
                         onChanged: (value) {
                           setState(() {
                             selectedExpiryType = value!;
                           });
                         },
                         title: AppConfig.scheduled,
                       ),

                       CustomRadioListTile(
                         value: AppConfig.issuer,
                         groupValue: selectedExpiryType,
                         onChanged: (value) {
                           setState(() {
                             selectedExpiryType = value!;
                           });
                         },
                         title: AppConfig.issuer,
                       ),
                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(
                       left: AppPadding.p20,
                       right: AppPadding.p20,
                       bottom: AppPadding.p15
                   ),
                   child: Visibility(
                     visible: selectedExpiryType == AppConfig.scheduled,
                     child: Row(
                       children: [
                         Container(
                           height: 30,
                           width: 50,
                           //color: ColorManager.red,
                           child: TextFormField(
                             textAlign: TextAlign.center,
                             controller: daysController, // Use the controller initialized with "1"
                             cursorColor: ColorManager.black,
                             cursorWidth: 1,
                             style:  DocumentTypeDataStyle.customTextStyle(context),
                             decoration: InputDecoration(
                               enabledBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                     color: ColorManager.fmediumgrey,
                                     width: 2),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                     color: ColorManager.fmediumgrey,
                                     width: 2),
                                 borderRadius: BorderRadius.circular(8),
                               ),
                               contentPadding:
                               EdgeInsets.symmetric(horizontal: 10),
                             ),
                             keyboardType: TextInputType.number,
                             inputFormatters: [
                               FilteringTextInputFormatter
                                   .digitsOnly, // This ensures only digits are accepted
                             ],
                           ),
                         ),
                         SizedBox(width: 10),
                         Container(
                           height: 30,
                           width: 80,
                           padding: EdgeInsets.symmetric(horizontal: 5),
                           decoration: BoxDecoration(
                             border: Border.all(
                                 color: ColorManager.fmediumgrey),
                             borderRadius: BorderRadius.circular(8),
                           ),
                           child: DropdownButtonFormField<String>(
                             value:
                             selectedYear, // Initial value (you should define this variable)
                             items: [
                               DropdownMenuItem(
                                 value: AppConfig.year,
                                 child: Text(
                                   AppConfig.year,
                                   style:  DocumentTypeDataStyle.customTextStyle(context),
                                 ),
                               ),
                               DropdownMenuItem(
                                 value: AppConfig.month,
                                 child: Text(
                                   AppConfig.month,
                                   style:  DocumentTypeDataStyle.customTextStyle(context),
                                 ),
                               ),
                             ],
                             onChanged: (value) {
                               setState(() {
                                 selectedYear =
                                     value; // Update the selected option (Year/Month)
                               });
                             },
                             decoration: InputDecoration(
                               enabledBorder: InputBorder.none,
                               focusedBorder: InputBorder.none,
                               hintText: AppConfig.year,
                               hintStyle:   DocumentTypeDataStyle.customTextStyle(context),
                               contentPadding: EdgeInsets.only(bottom: 20),
                             ),
                             icon: Icon(
                               Icons.arrow_drop_down,
                               color: ColorManager.black,
                               size: 16,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               ],
             ),
             Visibility(
               visible: selectedExpiryType == AppConfig.issuer,

               /// Conditionally display expiry date field
               child: HeaderContentConst(
                 heading: AppString.expiry_date,
                 content: FormField<String>(
                   builder: (FormFieldState<String> field) {
                     return SizedBox(
                       width: 354,
                       height: 30,
                       child: TextFormField(
                         controller: expiryDateController,
                         cursorColor: ColorManager.black,
                         style:  DocumentTypeDataStyle.customTextStyle(context),
                         decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                                 color: ColorManager.fmediumgrey, width: 1),
                             borderRadius: BorderRadius.circular(6),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(
                                 color: ColorManager.fmediumgrey, width: 1),
                             borderRadius: BorderRadius.circular(6),
                           ),
                           hintText: 'yyyy-mm-dd',
                           hintStyle:  DocumentTypeDataStyle.customTextStyle(context),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(6),
                             borderSide: BorderSide(
                                 width: 1, color: ColorManager.fmediumgrey),
                           ),
                           contentPadding:
                           EdgeInsets.symmetric(horizontal: 16),
                           suffixIcon: Icon(Icons.calendar_month_outlined,
                               color: ColorManager.blueprime),
                           errorText: field.errorText,
                         ),
                         onTap: () async {
                           DateTime? pickedDate = await showDatePicker(
                             context: context,
                             initialDate: datePicked,
                             firstDate: DateTime(1901),
                             lastDate: DateTime(3101),
                           );
                           if (pickedDate != null) {
                             datePicked = pickedDate;
                             expiryDateController.text =
                                 DateFormat('MM-dd-yyyy').format(pickedDate);
                           }
                         },
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'please select date';
                           }
                           return null;
                         },
                       ),
                     );
                   },
                 ),
               ),
             ),
           ],
         ),
       )
      ],
      bottomButtons: loading == true
          ? SizedBox(
              height: AppSize.s25,
              width: AppSize.s25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
          : CustomElevatedButton(
              width: AppSize.s105,
              height: AppSize.s30,
              text: AppStringEM.submit,
              onPressed: () async {
                _validateForm(); // Validate the form on button press
                if (_isFormValid) {
                  setState(() {
                    loading = true;
                  });
                  int threshold = 0;
                  if (selectedExpiryType == AppConfig.scheduled &&
                      daysController.text.isNotEmpty) {
                    int enteredValue = int.parse(daysController.text);
                    if (selectedYear == AppConfig.year) {
                      threshold = enteredValue * 365;
                    } else if (selectedYear == AppConfig.month) {
                      threshold = enteredValue * 30;
                    }
                  }
                  try {
                    String? expiryDate;
                    expiryDate = expiryDateController == AppConfig.issuer
                        ? datePicked!.toIso8601String() + "Z"
                        : null;
                    await addVendorContract(
                        context,
                        widget.selectedVendorId,
                        contractNmaeController.text,
                        selectedExpiryType!.toString(),
                        threshold,
                        widget.officeid,
                        contractIdController.text,
                        expiryDateController.text);
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CountySuccessPopup(
                          message: 'Save Successfully',
                        );
                      },
                    );
                  } finally {
                    setState(() {
                      loading = false;
                    });
                  }
                }
              }),
      title: widget.title,
    );
  }
}





