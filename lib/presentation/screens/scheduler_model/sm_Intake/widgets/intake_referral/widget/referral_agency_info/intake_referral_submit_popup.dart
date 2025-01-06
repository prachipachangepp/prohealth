import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/schedular_success_popup.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';

class ReferralSubmitPopup extends StatefulWidget {
  const ReferralSubmitPopup({super.key});

  @override
  State<ReferralSubmitPopup> createState() => _ReferralSubmitPopupState();
}

class _ReferralSubmitPopupState extends State<ReferralSubmitPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s500,
        height: AppSize.s150,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 27.0),
              child: Text(
                'Are you sure you want to submit this intake information for John Scott ?',
                style: CustomTextStylesCommon.commonStyle(
                    fontSize: AppSize.s12,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.granitegray
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20.0,bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(AppString.no,
                        style: CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeight.w700,
                            fontSize: AppSize.s12,
                            color: ColorManager.granitegray)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: AppSize.s20),
                  SizedBox(
                    height: AppSize.s26,
                    width: AppSize.s103,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        child: Text(AppString.yes,
                          style: CustomTextStylesCommon.commonStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppSize.s12,
                            color: ColorManager.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.blueprime,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SchedularSuccessPopup(title: 'Success');
                            },
                          );
                        },
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
