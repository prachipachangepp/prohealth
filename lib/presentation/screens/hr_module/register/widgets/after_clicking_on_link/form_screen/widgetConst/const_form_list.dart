import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';

class DefineFormList extends StatefulWidget {
  final String formName;
  final VoidCallback onPressed;
  final VoidCallback onPressedView;
  const DefineFormList({super.key, required this.formName, required this.onPressed, required this.onPressedView});

  @override
  State<DefineFormList> createState() => _DefineFormListState();
}

class _DefineFormListState extends State<DefineFormList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.formName,
          style: DefineWorkWeekStyle.customTextStyle(context),
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff1696C8)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButtonWidget(
                width: AppSize.s110,
                iconData1: Icons.remove_red_eye_outlined,
                buttonText: AppStringHr.voidcheck,
                onPressed: widget.onPressedView,
              ),
            ),
            SizedBox(width:AppSize.s20),
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: widget.onPressed,
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             FormNineScreen(employeeID: widget.employeeID,)));
                  // Timer(Duration(seconds: 2), () {
                  //   print("Timer call");
                  //   setState(() {
                  //     isSelected = true;
                  //   });
                  // });


                style: ElevatedButton.styleFrom(
                  backgroundColor:Color(0xff50B5E5) ,
                  // backgroundColor: isSelected == false ? Color(0xff50B5E5) : ColorManager.green,
                  // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                    "Sign",
                    style:BlueButtonTextConst.customTextStyle(context)
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
