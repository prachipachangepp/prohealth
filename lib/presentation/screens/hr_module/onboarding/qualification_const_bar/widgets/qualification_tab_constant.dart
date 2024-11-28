import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';

//typedef void CheckBoxCallBack(int id);

class QualificationActionButtons extends StatelessWidget {
  //final CheckBoxCallBack onChanged;
  //final int id;
  final VoidCallback onRejectPressed;
  final VoidCallback onApprovePressed;
  final bool? approve;
  final bool? isBackColor;

  QualificationActionButtons({super.key, required this.onRejectPressed,
    required this.onApprovePressed,this.approve,
    this.isBackColor
    //required this.onChanged, required this.id
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        approve == false
            ? Container(
              width: AppSize.s90,
              child: ElevatedButton(
                        onPressed: onRejectPressed,
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
            )
            : approve == false
            ? Text(
          'Rejected',
          textAlign: TextAlign.center,
          style: CustomTextStylesCommon.commonStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeight.w600,
            color: ColorManager.mediumgrey,
          ),
        )
            : SizedBox(width: AppSize.s90),
        SizedBox(width: MediaQuery.of(context).size.width / 75),
        approve == false
            ? Container(
          width: AppSize.s90,
              child: ElevatedButton(
                        onPressed: onApprovePressed,
                        style: ElevatedButton.styleFrom(
              backgroundColor: isBackColor!?Colors.white:Color(0xff1696C8),
              foregroundColor: isBackColor!?Color(0xff1696C8):Colors.white,
              side: BorderSide(color: isBackColor!? Color(0xff1696C8):Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
                        ),
                        child: Text(
              'Approve',
              style: isBackColor!? TransparentButtonTextConst.customTextStyle(context) : BlueButtonTextConst.customTextStyle(context),
                        ),
                      ),
            )
            : approve == true
            ? Text(
          'Approved',
          textAlign: TextAlign.center,
          style: CustomTextStylesCommon.commonStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeight.w600,
            color: ColorManager.blueprime,
          ),
        )
            : SizedBox(width: AppSize.s90),
      ],
    );
  }
}
