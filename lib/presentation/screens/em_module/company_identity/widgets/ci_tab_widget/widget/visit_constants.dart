import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

class AddVisitPopup extends StatefulWidget {
  final TextEditingController nameOfDocumentController;
  final TextEditingController idOfDocumentController;
  final Future<void> Function() onSavePressed;
  final Widget child;
  final Widget child1;
  final String title;

  const AddVisitPopup({
    super.key,
    required this.nameOfDocumentController,
    required this.idOfDocumentController,
    required this.onSavePressed,
    required this.child,
    required this.child1,
    required this.title,
  });

  @override
  State<AddVisitPopup> createState() => _AddVisitPopupState();
}

class _AddVisitPopupState extends State<AddVisitPopup> {
  bool isLoading = false;
  bool _isNameOfDocumentValid = true;

  void _validateInputs() {
    setState(() {
      _isNameOfDocumentValid = widget.nameOfDocumentController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s350,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                      fontSize: 13,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SMTextFConst(
                      controller: widget.nameOfDocumentController,
                      keyboardType: TextInputType.text,
                      text: 'Type of Visit',
                    ),
                    if (!_isNameOfDocumentValid)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Please enter some text',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    SizedBox(height: AppSize.s20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Eligible Clinician',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.mediumgrey,
                          ),
                        ),
                        SizedBox(height: 5),
                        widget.child,
                        SizedBox(height: 5),
                        widget.child1,
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: isLoading
                    ? CircularProgressIndicator(
                  color: ColorManager.blueprime,
                )
                    : CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.add,
                  onPressed: () async {
                    _validateInputs();
                    if (_isNameOfDocumentValid) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await widget.onSavePressed();
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pop(context);
                        widget.idOfDocumentController.clear();
                        widget.nameOfDocumentController.clear();
                      }
                    }
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
