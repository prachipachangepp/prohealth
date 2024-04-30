import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/resources/color.dart';
import 'package:prohealth/resources/const_string.dart';
import 'package:prohealth/resources/theme_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/profile_bar/profile_bar.dart';
import 'package:prohealth/resources/value_manager.dart';

///saloni
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterController _controller = Get.put(RegisterController());
    return Column(
      children: [
        ProfileBar(),
        SizedBox(
          height: AppSize.s10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: AppSize.s100,
              margin: EdgeInsets.only(right: AppMargin.m30),
              child: CustomIconButtonConst(
                  text: AppString.enroll,
                  onPressed: () {
                    _controller.openDialog(context);
                  }),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s20,
        ),
        Container(
          height: AppSize.s30,
          margin: EdgeInsets.symmetric(horizontal: AppMargin.m35),
          decoration: BoxDecoration(
            color: ColorManager.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                        AppString.srNo,
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: SizedBox(width: AppSize.s16,
              )),
              Expanded(
                  child: Center(
                      child: Text(
                        AppString.name,
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                        AppString.code,
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                        AppString.phone,
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                        AppString.email,
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                        AppString.link,
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                        AppString.status,
                style: RegisterTableHead.customTextStyle(context),
              ))),
            ],
          ),
        ),
        SizedBox(
          height: AppSize.s10,
        ), // Adjust spacing as needed
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: AppSize.s5),
                  Container(
                    padding: EdgeInsets.only(bottom: AppPadding.p5),
                    margin: EdgeInsets.symmetric(horizontal: AppMargin.m50),
                    decoration: BoxDecoration(
                      color:ColorManager.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: AppSize.s56,
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                              child: Text(
                            '1',style: ThemeManagerDark.customTextStyle(context),
                            textAlign: TextAlign.start,
                          )),
                        ),
                        Expanded(
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: ColorManager.blueprime,
                            child: Image.asset('images/profile.png'),
                          ),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            AppString.amogh,
                            textAlign: TextAlign.start,
                            style: ThemeManagerDark.customTextStyle(context),
                          )),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            AppString.pincode,
                            style: ThemeManagerDark.customTextStyle(context),
                          )),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            AppString.mobile,
                            style: ThemeManagerDark.customTextStyle(context),
                          )),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            AppString.mail,
                            style: ThemeManagerDark.customTextStyle(context),
                          )),
                        ),
                        Center(
                            child: Text(
                          AppString.path +'$index',
                          style: ThemeManagerDark.customTextStyle(context),
                        )),
                        Expanded(
                          child: Center(
                              child: Text(
                            AppString.open,
                            style: ThemeManagerDark.customTextStyle(context),
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
