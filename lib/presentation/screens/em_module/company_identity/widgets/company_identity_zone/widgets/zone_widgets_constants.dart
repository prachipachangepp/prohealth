import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../widgets/button_constant.dart';
import '../../../../widgets/text_form_field_const.dart';

class CIZoneAddPopup extends StatefulWidget {
  final TextEditingController countynameController;
  final TextEditingController zipcodeController;
  final TextEditingController mapController;
  final TextEditingController? landmarkController;
  final VoidCallback onSavePressed;
  final String title1;
  final String title2;
  final String title3;
  final String? title4;

  const CIZoneAddPopup({
    Key? key,
    required this.onSavePressed,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.countynameController,
    required this.zipcodeController,
    required this.mapController,
    this.landmarkController,
    this.title4,
  }) : super(key: key);

  @override
  State<CIZoneAddPopup> createState() => _CIZoneAddPopupState();
}

class _CIZoneAddPopupState extends State<CIZoneAddPopup> {
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.countynameController,
                    keyboardType: TextInputType.text,
                    text: widget.title1,
                  ),
                  SizedBox(height: AppSize.s10),
                  SMTextFConst(
                    controller: widget.zipcodeController,
                    keyboardType: TextInputType.text,
                    text: widget.title2,
                  ),
                  SizedBox(height: AppSize.s10),
                  SMTextFConst(
                    controller: widget.mapController,
                    keyboardType: TextInputType.text,
                    text: widget.title3,
                  ),
                  if (widget.title4 != null && widget.landmarkController != null) ...[
                    SizedBox(height: AppSize.s10),
                    SMTextFConst(
                      controller: widget.landmarkController!,
                      keyboardType: TextInputType.text,
                      text: widget.title4!,
                    ),
                  ],
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

///edit
class CIZoneEditPopup extends StatefulWidget {
  final TextEditingController countynameController;
  final TextEditingController landmarkController;
  final VoidCallback onSavePressed;
  final String title1;
  final String title2;
  const CIZoneEditPopup({super.key, required this.countynameController, required this.landmarkController, required this.onSavePressed, required this.title1, required this.title2});

  @override
  State<CIZoneEditPopup> createState() => _CIZoneEditPopupState();
}

class _CIZoneEditPopupState extends State<CIZoneEditPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s210,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.countynameController,
                    keyboardType: TextInputType.text,
                    text: widget.title1,
                  ),
                  SizedBox(height: AppSize.s10),
                  SMTextFConst(
                    controller: widget.landmarkController,
                    keyboardType: TextInputType.text,
                    text: widget.title2,
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
