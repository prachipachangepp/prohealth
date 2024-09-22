import 'package:flutter/material.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Color(0xff1696C8),
            side: BorderSide(color: Color(0xff1696C8)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Reject',
            style: TransparentButtonTextConst.customTextStyle(context)
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width/75),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff1696C8),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Approve',
            style: BlueButtonTextConst.customTextStyle(context),
          ),
        ),
      ],
    );
  }
}
