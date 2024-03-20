import 'package:flutter/material.dart';
import '../../../../../../../app/theme_manager.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';
///done by saloni
class EducationChildTabbar extends StatelessWidget {
  const EducationChildTabbar({super.key});

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
            const Row(children: [
              Text('Education #1',
                style: TextStyle(
                  fontFamily: 'FiraSans',
                  fontSize: 13,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                ),),
            ],),
            SizedBox(height: MediaQuery.of(context).size.height/50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Degree',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Graduate',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Educational Institute',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Major Subject',
                        style: ThemeManager.customTextStyle(context)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MS',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('True',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('MIT',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('Biology',
                      style: ThemeManagerDark.customTextStyle(context),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Phone',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('City',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('State',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Country',
                        style: ThemeManager.customTextStyle(context)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('+1234687654',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('Hamburg',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('Northen Germany',
                        style: ThemeManagerDark.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Germany',
                        style: ThemeManagerDark.customTextStyle(context)),
                  ],
                ),
              ],
            ),
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
        child2:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Row(children: [
              Text('Education #2',
                style: TextStyle(
                  fontFamily: 'FiraSans',
                  fontSize: 13,
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                ),),
            ],),
            SizedBox(height: MediaQuery.of(context).size.height/50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Degree',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Graduate',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Educational Institute',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Major Subject',
                        style: ThemeManager.customTextStyle(context)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MS',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('True',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('MIT',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('Biology',
                      style: ThemeManagerDark.customTextStyle(context),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Phone',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('City',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('State',
                        style: ThemeManager.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Country',
                        style: ThemeManager.customTextStyle(context)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('+1234687654',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('Hamburg',
                      style: ThemeManagerDark.customTextStyle(context),),
                    const SizedBox(height: 10,),
                    Text('Northen Germany',
                        style: ThemeManagerDark.customTextStyle(context)),
                    const SizedBox(height: 10,),
                    Text('Germany',
                        style: ThemeManagerDark.customTextStyle(context)),
                  ],
                ),
              ],
            ),
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
    );
  }
}