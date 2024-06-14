import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';

import '../../../../../../em_module/widgets/text_form_field_const.dart';

class HealthRecordEditAddPopup extends StatefulWidget {
  final TextEditingController idController;
  final TextEditingController nameController;
  final String labelName;
  const HealthRecordEditAddPopup({super.key, required this.idController, required this.nameController, required this.labelName});

  @override
  State<HealthRecordEditAddPopup> createState() => _HealthRecordEditAddPopupState();
}

class _HealthRecordEditAddPopupState extends State<HealthRecordEditAddPopup> {
  @override
  Widget build(BuildContext context) {
    String? _expiryType;
    return  Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s460,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.labelName,style:GoogleFonts.firaSans(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.blueprime,
                    //decoration: TextDecoration.none,
                  ),),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.idController,
                    keyboardType: TextInputType.text,
                    text: 'ID of the Document',
                  ),
                  SizedBox(height: AppSize.s8),
                  SMTextFConst(
                    controller: widget.nameController,
                    keyboardType: TextInputType.text,
                    text: 'Name of the Document',
                  ),
                  SizedBox(height: AppSize.s8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type',
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 5),
                      CICCDropdown(
                        initialValue: 'Compentation',
                        items: [
                          DropdownMenuItem(
                              value: 'Type 1',
                              child: Text('Physical')),
                          DropdownMenuItem(
                              value: 'Type 2',
                              child: Text('TB Test')),
                          DropdownMenuItem(
                              value: 'Type 3',
                              child: Text('MMR')),
                          DropdownMenuItem(
                              value: 'Type 4',
                              child: Text('Compensation')),
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
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
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
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        value: 'type1',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(
                          'Scheduled',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        value: 'type2',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(
                          'Issuer Expiry',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        value: 'type3',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
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
                  text: AppStringEM.submit,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
