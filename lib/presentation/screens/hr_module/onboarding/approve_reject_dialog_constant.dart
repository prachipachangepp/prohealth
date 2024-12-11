import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import '../../../../app/resources/color.dart';
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/value_manager.dart';

class RejectConfirmPopup extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onReject;

  RejectConfirmPopup({super.key, required this.onCancel, required this.onReject});

  @override
  State<RejectConfirmPopup> createState() => _RejectConfirmPopupState();
}

class _RejectConfirmPopupState extends State<RejectConfirmPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: AppSize.s181,
        width: AppSize.s500,
        child: Column(
          children: <Widget>[
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
                    child: Text(AppString.reject,
                      style:PopupBlueBarText.customTextStyle(context)
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,
                        color: ColorManager.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p20,
                horizontal: AppPadding.p20,
              ),
              child: Row(
                children: [
                  Text(
                    "Do you really want to reject the selected files?",
                    style: PopupTextConst.customTextStyle(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p20, right: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: AppSize.s100,
                    child: ElevatedButton(
                      onPressed: widget.onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.white,
                        foregroundColor: ColorManager.bluebottom,
                        side: BorderSide(color: ColorManager.bluebottom),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(AppString.cancel,
                        style: TransparentButtonTextConst.customTextStyle(context)
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 75),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: widget.onReject,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.bluebottom,
                        foregroundColor: ColorManager.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(AppString.yes,
                        style: BlueButtonTextConst.customTextStyle(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


///approve Popup
class ApproveConfirmPopup extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onApprove;

  ApproveConfirmPopup({super.key, required this.onCancel, required this.onApprove});

  @override
  State<ApproveConfirmPopup> createState() => _ApproveConfirmPopupState();
}

class _ApproveConfirmPopupState extends State<ApproveConfirmPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: AppSize.s181,
        width: AppSize.s500,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: AppSize.s35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Approve',
                      style: PopupBlueBarText.customTextStyle(context)
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p20,
                horizontal: AppPadding.p20,
              ),
              child: Row(
                children: [
                  Text(
                    "Do you really want to approve this?",
                    style:PopupTextConst.customTextStyle(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p20, right: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: AppSize.s100,
                    child: ElevatedButton(
                      onPressed: widget.onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.white,
                        foregroundColor: ColorManager.bluebottom,
                        side: BorderSide(color: ColorManager.bluebottom),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(AppString.cancel,
                        style: TransparentButtonTextConst.customTextStyle(context)
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 75),
                  SizedBox(
                    width: AppSize.s100,
                    child: ElevatedButton(
                      onPressed: widget.onApprove,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.bluebottom,
                        foregroundColor: ColorManager.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(AppString.yes,
                        style: BlueButtonTextConst.customTextStyle(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
