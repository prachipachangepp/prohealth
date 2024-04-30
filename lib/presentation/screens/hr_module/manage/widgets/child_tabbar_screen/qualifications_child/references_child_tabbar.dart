import 'package:flutter/material.dart';
import '../../../../../../../resources/theme_manager.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';
///done by saloni
class ReferencesChildTabbar extends StatelessWidget {
  const ReferencesChildTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width/80,
          vertical: MediaQuery.of(context).size.height/100),
      child: TwoContainersRow(
        child1: Column(
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
        child2: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('References #2',
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
        ),),
    );
  }
}
