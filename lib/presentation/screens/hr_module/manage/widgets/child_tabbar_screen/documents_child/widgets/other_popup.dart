import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/app/resources/color.dart';

import '../../../../../../../../app/resources/theme_manager.dart';

class OtherEditAddPopup extends StatefulWidget {
  final TextEditingController idController;
  final TextEditingController nameController;
  final String labelName;

  const OtherEditAddPopup({
    super.key,
    required this.idController,
    required this.nameController,
    required this.labelName,
  });

  @override
  State<OtherEditAddPopup> createState() => _OtherEditAddPopupState();
}

class _OtherEditAddPopupState extends State<OtherEditAddPopup> {
  String? _expiryType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showExpiryTypeError = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          width: AppSize.s400,
          height: AppSize.s500,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 34,
                  decoration: BoxDecoration(
                    color: Color(0xff50B5E5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.labelName,
                          style: DocumentTypeDataStyle.customTextStyle(context),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p3,
                    horizontal: AppPadding.p20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FormField<String>(
                        builder: (FormFieldState<String> field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SMTextFConst(
                                controller: widget.idController,
                                keyboardType: TextInputType.text,
                                text: 'ID of the Document',
                              ),
                              if (field.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    field.errorText!,
                                    style: TextStyle(color: Colors.red, fontSize: 12),
                                  ),
                                ),
                            ],
                          );
                        },
                        validator: (value) {
                          if (widget.idController.text.isEmpty) {
                            return 'Please Enter ID of The Document';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.s8),
                      FormField<String>(
                        builder: (FormFieldState<String> field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SMTextFConst(
                                controller: widget.nameController,
                                keyboardType: TextInputType.text,
                                text: 'Name of the Document',
                              ),
                              if (field.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    field.errorText!,
                                    style: TextStyle(color: Colors.red, fontSize: 12),
                                  ),
                                ),
                            ],
                          );
                        },
                        validator: (value) {
                          if (widget.nameController.text.isEmpty) {
                            return 'Please Enter Name of The Document';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSize.s8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type',
                           style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                          SizedBox(height: 5),
                          CICCDropdown(
                            width: 354,
                            initialValue: 'Compensation',
                            items: [
                              DropdownMenuItem(value: 'Type 1', child: Text('Type 1')),
                              DropdownMenuItem(value: 'Type 2', child: Text('Type 2')),
                              DropdownMenuItem(value: 'Type 3', child: Text('Type 3')),
                              DropdownMenuItem(value: 'Type 4', child: Text('Type 4')),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s12),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p3,
                    horizontal: AppPadding.p20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expiry Type',
                        style: TextStyle(
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile<String>(
                            title: Text(
                              'Not Applicable',
                              style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.mediumgrey,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            value: 'type1',
                            groupValue: _expiryType,
                            onChanged: (value) {
                              setState(() {
                                _expiryType = value;
                                _showExpiryTypeError = false;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Scheduled',
                              style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.mediumgrey,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            value: 'type2',
                            groupValue: _expiryType,
                            onChanged: (value) {
                              setState(() {
                                _expiryType = value;
                                _showExpiryTypeError = false;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text(
                              'Issuer Expiry',
                              style: TextStyle(
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.mediumgrey,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            value: 'type3',
                            groupValue: _expiryType,
                            onChanged: (value) {
                              setState(() {
                                _expiryType = value;
                                _showExpiryTypeError = false;
                              });
                            },
                          ),
                          if (_showExpiryTypeError)
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'Please select Expiry Type',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p24),
                  child: Center(
                    child: CustomElevatedButton(
                      width: AppSize.s105,
                      height: AppSize.s30,
                      text: AppStringEM.add,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_expiryType == null) {
                            setState(() {
                              _showExpiryTypeError = true;
                            });
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}