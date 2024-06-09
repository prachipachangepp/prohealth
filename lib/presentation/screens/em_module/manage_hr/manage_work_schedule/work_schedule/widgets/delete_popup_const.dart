import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

class DeletePopup extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onDelete;
  const DeletePopup({super.key, required this.onCancel, required this.onDelete});

  @override
  State<DeletePopup> createState() => _DeletePopupState();
}
//
class _DeletePopupState extends State<DeletePopup> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: AppSize.s100,
                    width: AppSize.s150,
                    child: Text('Do you really want to delete ?',textAlign: TextAlign.center,style:CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.mediumgrey
                    ),),
                  )
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p24),
                  child: Center(
                    child: CustomButtonTransparent(
                      text: AppStringEM.cancel,
                      onPressed: () {
                        widget.onCancel();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Padding(
                padding: const EdgeInsets.only(bottom: AppPadding.p24),
                child: Center(
                  child: CustomElevatedButton(
                    width: AppSize.s105,
                    height: AppSize.s30,
                    text: AppStringEM.delete,
                    onPressed: () {
                      widget.onDelete();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),]
            ),
          ],
        ),
      ),
    );
  }
}
