import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../em_module/widgets/dialogue_template.dart';

class RejectDialog extends StatelessWidget {
  final VoidCallback onYesPressed; // Callback for "Yes" button action

  const RejectDialog({required this.onYesPressed});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: 450,
      height: 200,
      title: AppString.reject,
      body: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Do you really want to reject this?",
                textAlign: TextAlign.center,
                style: PopupTextConst.customTextStyle(context),
              ),
            ],
          ),
        ),
      ],
      bottomButtons: Padding(
        padding: const EdgeInsets.only(bottom: AppPadding.p5, right: AppPadding.p25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog on "Cancel"
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.white,
                foregroundColor: Color(0xff1696C8),
                side: BorderSide(color: Color(0xff1696C8)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Cancel',
                style: TransparentButtonTextConst.customTextStyle(context),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width / 75),
            Container(
              width: AppSize.s80,
              child: ElevatedButton(
                onPressed: onYesPressed, // Customizable action for "Yes"
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1696C8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Yes',
                  style: BlueButtonTextConst.customTextStyle(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
class ApproveDialog extends StatelessWidget {
  final VoidCallback onYesPressed;

  const ApproveDialog({required this.onYesPressed});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: 450,
      height: 200,
      title: AppString.approve,
      body: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Do you really want to approve this?",
                textAlign: TextAlign.center,
                style: PopupTextConst.customTextStyle(context),
              ),
            ],
          ),
        ),
      ],
      bottomButtons: Padding(
        padding: const EdgeInsets.only(bottom: AppPadding.p5, right: AppPadding.p25),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog on "Cancel"
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xff1696C8),
                  side: BorderSide(color: Color(0xff1696C8)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TransparentButtonTextConst.customTextStyle(context),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 75),
              Container(
                width: AppSize.s80,
                child: ElevatedButton(
                  onPressed: onYesPressed, // Customizable action for "Yes"
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff1696C8),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Yes',
                    style: BlueButtonTextConst.customTextStyle(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
