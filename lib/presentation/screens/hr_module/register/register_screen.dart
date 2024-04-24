import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/theme_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/controller/controller.dart';
import 'package:prohealth/presentation/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/profile_bar/profile_bar.dart';

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
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 100,
              margin: EdgeInsets.only(right: 30),
              child: CustomIconButtonConst(
                  text: 'Enroll',
                  onPressed: () {
                    _controller.openDialog(context);
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 30,
          margin: EdgeInsets.symmetric(horizontal: 35),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Center(
                      child: Text(
                'Sr. No',
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: SizedBox(
                width: 15,
              )),
              Expanded(
                  child: Center(
                      child: Text(
                'Name',
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                'Code',
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                'Phone No',
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                'Email',
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                'Link',
                style: RegisterTableHead.customTextStyle(context),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                'Status',
                style: RegisterTableHead.customTextStyle(context),
              ))),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ), // Adjust spacing as needed
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: 56,
                    
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
                            backgroundColor: Colors.blue, // Example color
                            child: Image.asset('images/profile.png'),
                          ),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            'Amogh Joshi',
                            textAlign: TextAlign.start,
                            style: ThemeManagerDark.customTextStyle(context),
                          )),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            '351631',
                            style: ThemeManagerDark.customTextStyle(context),
                          )),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            '+1 1234567890',
                            style: ThemeManagerDark.customTextStyle(context),
                          )),
                        ),
                        Expanded(
                          child: Center(
                              child: Text(
                            'amogh@gmail.com',
                            style: ThemeManagerDark.customTextStyle(context),
                          )),
                        ),
                        Center(
                            child: Text(
                          'https://prohealth.symmetry.care/register $index',
                          style: ThemeManagerDark.customTextStyle(context),
                        )),
                        Expanded(
                          child: Center(
                              child: Text(
                            'Opened',
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
