import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/theme_manager.dart';

import '../../../../../../../../../app/resources/color.dart';
import '../../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../widgets/button_constant.dart';
import '../../../../../../widgets/text_form_field_const.dart';

///edit popup
class ORGPoliciesEditPopup extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final VoidCallback onSavePressed;
  final Widget child;

  const ORGPoliciesEditPopup({
    super.key,
    required this.idDocController,
    required this.nameDocController,
    required this.onSavePressed,
    required this.child,
  });

  @override
  State<ORGPoliciesEditPopup> createState() => _CCScreenEditPopupState();
}

class _CCScreenEditPopupState extends State<ORGPoliciesEditPopup> {
  String? _expiryType;
  TextEditingController birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s550,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
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
                    controller: widget.idDocController,
                    keyboardType: TextInputType.text,
                    text: 'ID of the Document',
                  ), SizedBox(height: AppSize.s8),
                  SMTextFConst(
                    controller: widget.nameDocController,
                    keyboardType: TextInputType.text,
                    text: 'Name of the Document',
                  ),
                  SizedBox(height: AppSize.s8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type of the Document',
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 5),
                      widget.child,
                    ],
                  ),
                ],
              ),
            ),
            ///radio
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
                        title: Text('Not Applicable',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),),
                        value: 'type1',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text('Scheduled',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),),
                        value: 'type2',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title:  Text('Issuer Expiry',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry Date',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> field) {
                      return SizedBox(
                        width: 354,
                        height: 30,
                        child: TextFormField(
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.mediumgrey,
                            //decoration: TextDecoration.none,
                          ),
                          controller: birthdayController,
                          decoration: InputDecoration(
                            hintText: 'dd-mm-yyyy',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.mediumgrey,
                              //decoration: TextDecoration.none,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime),
                            errorText: field.errorText,
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1100),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              birthdayController.text =
                              date.toLocal().toString().split(' ')[0];
                              field.didChange(date.toLocal().toString().split(' ')[0]);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please select birth date';
                            }
                            return null;
                          },
                        ),
                      );
                    },
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
                  text: AppStringEM.save,
                  onPressed: () {
                    widget.onSavePressed();
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
