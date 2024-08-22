import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class PayRatesPopup extends StatefulWidget {
  final Widget child1;
  final Widget child2;
  final String title;
  final Future<void> Function() onPressed;
  final TextEditingController payRatesController;
  final TextEditingController perMilesController;

  PayRatesPopup({
    super.key,
    required this.child1,
    required this.child2,
    required this.payRatesController,
    required this.onPressed,
    required this.title,
    required this.perMilesController,
  });

  @override
  State<PayRatesPopup> createState() => _PayRatesPopupState();
}

class _PayRatesPopupState extends State<PayRatesPopup> {
  bool isLoading = false;

  // Error messages
  String? payRatesError;
  String? perMilesError;

  void _validateAndSubmit() {
    setState(() {
      payRatesError = widget.payRatesController.text.isEmpty ? 'Please enter a rate' : null;
      perMilesError = widget.perMilesController.text.isEmpty ? 'Please enter a per mile rate' : null;
    });

    if (payRatesError == null && perMilesError == null) {
      // If no errors, proceed with the onPressed action
      widget.onPressed().whenComplete(() {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
        widget.payRatesController.clear();
        widget.perMilesController.clear();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
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
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: ColorManager.white,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.child1,
                      SizedBox(height: 10,),
                      Text(
                        'Zone',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                      SizedBox(height: 2,),
                      widget.child2,
                      SizedBox(height: 10,),
                      SMTextFConst(
                        prefixWidget: Text("\$ "),
                        controller: widget.payRatesController,
                        keyboardType: TextInputType.number,
                        text: 'Rate',
                      ),
                      if (payRatesError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            payRatesError!,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: 10,),
                      SMTextFConst(
                        controller: widget.perMilesController,
                        keyboardType: TextInputType.number,
                        text: 'Permile',
                      ),
                      if (perMilesError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            perMilesError!,
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
              padding: const EdgeInsets.only(bottom: AppPadding.p10),
              child: Center(
                child: isLoading
                    ? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: ColorManager.blueprime,)
                )
                    : CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.submit,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    _validateAndSubmit();
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
