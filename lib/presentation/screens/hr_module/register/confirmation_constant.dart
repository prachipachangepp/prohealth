import 'package:flutter/material.dart';

import 'package:prohealth/presentation/screens/hr_module/hr_home_screen/home_hr.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../../em_module/widgets/button_constant.dart';
import '../manage/widgets/custom_icon_button_constant.dart';

class ConfirmationPopup extends StatefulWidget {
  final VoidCallback onCancel;
  final Future<void> Function() onConfirm; // Change this to support async
  final bool? loadingDuration;
  final String title;
  final String containerText;
  final bool loading;

  const ConfirmationPopup({
    super.key,
    required this.onCancel,
    required this.onConfirm,
    this.loadingDuration,
    required this.title,
    required this.containerText,
    this.loading = false,
  });

  @override
  State<ConfirmationPopup> createState() => _ConfirmationPopupState();
}

class _ConfirmationPopupState extends State<ConfirmationPopup> {
  bool _isLoading = false; // Local loading state

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s350,
        height: AppSize.s181,
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
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      widget.title,
                      style: PopupBlueBarText.customTextStyle(context),
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
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 15),
              child: Row(
                children: [
                  Text(widget.containerText,
                      textAlign: TextAlign.center,
                      style: ConstTextFieldRegister.customTextStyle(context)),
                ],
              ),
            ),
            Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p24),
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: widget.onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: ColorManager.bluebottom,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text('Cancel',
                        style: TransparentButtonTextConst.customTextStyle(
                            context)),
                  ),
                ),
              ),
              SizedBox(
                width: AppPadding.p20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: AppPadding.p24, right: AppPadding.p10),
                child: Center(
                  child: _isLoading // Use the local loading state
                      ? SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: ColorManager.blueprime,
                    ),
                  )
                      : CustomElevatedButton(
                    width: AppSize.s105,
                    height: AppSize.s30,
                    text: 'Confirm',
                    onPressed: () async {
                      setState(() {
                        _isLoading = true; // Set loading state to true
                      });
                      await widget.onConfirm(); // Await the async confirmation
                      setState(() {
                        _isLoading = false; // Reset loading state
                      });
                    },
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

///success popup
class SuccessPopup extends StatelessWidget {
  const SuccessPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s300,
        height: AppSize.s150,
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
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Success",
                      style: PopupBlueBarText.customTextStyle(context),
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
            Spacer(),
            Center(
              child: Container(
                height: AppSize.s50,
                width: AppSize.s210,
                child: Text('Successfully Enrolled!\nThank You.',
                    textAlign: TextAlign.center,
                    style: ConstTextFieldRegister.customTextStyle(context)),
              ),
            ),
            Spacer(),

            //
          ],
        ),
      ),
    );
  }
}
/////
