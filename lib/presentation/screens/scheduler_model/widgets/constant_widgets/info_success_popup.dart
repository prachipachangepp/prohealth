import 'package:flutter/material.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../sm_Intake/widgets/intake_profile_bar.dart';

class SchedularInfoSuccessPopup extends StatefulWidget {
  const SchedularInfoSuccessPopup({super.key,});

  @override
  State<SchedularInfoSuccessPopup> createState() => _SchedularInfoSuccessPopupState();
}

class _SchedularInfoSuccessPopupState extends State<SchedularInfoSuccessPopup> {

  bool showProfileBar = false;
  void toggleProfileBar() {
    setState(() {
      showProfileBar = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s503,
        height: AppSize.s383,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SizedBox(height: AppSize.s40),
            Icon(
              Icons.check_circle_outline,
              size: 125,
              color: ColorManager.blueprime,
            ),
             SizedBox(height: 20),
            Center(
              child: Container(
                height: AppSize.s50,
                width: AppSize.s210,
                child: Text(
                  'Successfully Saved!',
                  textAlign: TextAlign.center,
                  style: CustomTextStylesCommon.commonStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: FontSize.s22,
                    color: ColorManager.mediumgrey,
                  ),
                ),
              ),
            ),
           SizedBox(height: AppSize.s40),
            Container(
              height: AppSize.s46,
              width: AppSize.s282,
              child: ElevatedButton(
                onPressed: () {
                  // toggleProfileBar();
                  Navigator.pop(context);
                },
                child: Text(
                  'Continue',
                  style:TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  backgroundColor: ColorManager.blueprime,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
