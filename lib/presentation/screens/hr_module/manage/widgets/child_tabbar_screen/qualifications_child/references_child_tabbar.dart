import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';
///done by saloni
class ReferencesChildTabbar extends StatelessWidget {
  const ReferencesChildTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return WrapWidget(childern: List.generate(3, (index){
      return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: Container(
        width: MediaQuery.of(context).size.width/2.5,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        height: 200,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 80,
            vertical: MediaQuery.of(context).size.height / 120,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('References #1',
                    style: TextStyle(
                      fontFamily: 'FiraSans',
                      fontSize: 13,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name',
                          style: ThemeManager.customTextStyle(context)),
                      SizedBox(height: 10,),
                      Text('Title/ Position',
                          style: ThemeManager.customTextStyle(context)),
                      SizedBox(height: 15,),
                      Text('Company/ Organization',
                          style: ThemeManager.customTextStyle(context)),
                      SizedBox(height: 10,),
                      Text('Mobile Number',
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('John Smith',
                        style: ThemeManagerDark.customTextStyle(context),),
                      SizedBox(height: 10,),
                      Text('Developer',
                        style: ThemeManagerDark.customTextStyle(context),),
                      SizedBox(height: 15,),
                      Text('Google',
                        style: ThemeManagerDark.customTextStyle(context),),
                      SizedBox(height: 10,),
                      Text('+11234567891',
                        style: ThemeManagerDark.customTextStyle(context),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email',
                          style: ThemeManager.customTextStyle(context)),
                      SizedBox(height: 10,),
                      Text('How do you know this\nperson ?',
                          style: ThemeManager.customTextStyle(context)),
                      SizedBox(height: 5,),
                      Text('Length of Association',
                          style: ThemeManager.customTextStyle(context)),
                      SizedBox(height: 5,),
                      Text('Referred By',
                          style: ThemeManager.customTextStyle(context)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('john@gmail.com',
                        style: ThemeManagerDark.customTextStyle(context),),
                      SizedBox(height: 10,),
                      Text('Linked In',
                        style: ThemeManagerDark.customTextStyle(context),),
                      SizedBox(height: 15,),
                      Text('1',
                        style: ThemeManagerDark.customTextStyle(context),),
                      SizedBox(height: 10,),
                      Text('John',
                        style: ThemeManagerDark.customTextStyle(context),),
                    ],
                  ),
                ],),
              SizedBox(height: MediaQuery.of(context).size.height/40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButtonWidget(iconData: Icons.edit_outlined,
                      buttonText: 'Edit', onPressed: (){})
                ],
              )
            ],
          ),
        ),
      ),
      );
    }));

  }
}
