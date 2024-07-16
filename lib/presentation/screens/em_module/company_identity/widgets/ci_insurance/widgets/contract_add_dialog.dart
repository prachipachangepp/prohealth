import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class ContractAddDialog extends StatefulWidget {
  final TextEditingController contractNmaeController;
  final TextEditingController contractIdController;
  final VoidCallback onSubmitPressed;
  final String title;

  const ContractAddDialog({Key? key,required this.contractNmaeController, required this.onSubmitPressed, required this.contractIdController, required this.title,}) : super(key: key);

  @override
  State<ContractAddDialog> createState() => _ContractAddDialogState();
}

class _ContractAddDialogState extends State<ContractAddDialog> {
  String? _expiryType;
  TextEditingController birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String selectedOption = '';
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s420,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              width: AppSize.s400,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: 13,
                      fontWeight:
                      FontWeightManager.semiBold,
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,
                      color: ColorManager.white,),
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
                    controller: widget.contractNmaeController,
                    keyboardType: TextInputType.text,
                    text: 'Contract Name',
                  ),
                  SizedBox(height: AppSize.s8),
                  SMTextFConst(
                    controller: widget.contractIdController,
                    keyboardType: TextInputType.text,
                    text: 'Contract ID',
                  ),
                  SizedBox(height: AppSize.s8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expiry Type',
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 5,),
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
                    ],),


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
                    widget.onSubmitPressed();
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
