import 'package:flutter/material.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../custom_icon_button_constant.dart';
import '../../row_container_widget_const.dart';
///done by saloni
class LicensesChildTabbar extends StatelessWidget {
  const LicensesChildTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width/80,
          vertical: MediaQuery.of(context).size.height/100),
      child: TwoContainersRow(
        child1: Column(
          children: [
            Row(
              children: [
                Text('License #1',
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
                  Text('Licensure/Certification',
                      style: ThemeManager.customTextStyle(context)),
                  SizedBox(height: 10,),
                  Text('Issuing Organization',
                      style: ThemeManager.customTextStyle(context)),
                  SizedBox(height: 10,),
                  Text('Country',
                      style: ThemeManager.customTextStyle(context)),
                  SizedBox(height: 10,),
                  Text('Number/ID',
                      style: ThemeManager.customTextStyle(context)),
                ],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Driving',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('Health Ministry',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('USA',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('123345555',
                      style: ThemeManagerDark.customTextStyle(context),),
                  ],
                ),
                Column(
                  children: [
                    Text('Issue Date',
                        style: ThemeManager.customTextStyle(context)),
                    SizedBox(height: 10,),
                    Text('End Date',
                        style: ThemeManager.customTextStyle(context)),
                    SizedBox(height: 50,)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('2023-08-09',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('2024-03-20',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 50,)

                  ],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height/40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButtonTransparent(text: 'Edit', onPressed: (){}),
                SizedBox(width: 5,),
                CustomButtonTransparent(text: 'Reject', onPressed: (){}),
                SizedBox(width: 5,),
                CustomIconButton(
                    text: 'Approve', onPressed: (){}),
              ],
            )
          ],
        ),
        child2: Column(
          children: [
            Row(
              children: [
                Text('License #2',
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
                    Text('Licensure/Certification',
                        style: ThemeManager.customTextStyle(context)),
                    SizedBox(height: 10,),
                    Text('Issuing Organization',
                        style: ThemeManager.customTextStyle(context)),
                    SizedBox(height: 10,),
                    Text('Country',
                        style: ThemeManager.customTextStyle(context)),
                    SizedBox(height: 10,),
                    Text('Number/ID',
                        style: ThemeManager.customTextStyle(context)),
                  ],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Driving',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('Health Ministry',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('USA',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('123345555',
                      style: ThemeManagerDark.customTextStyle(context),),
                  ],
                ),
                Column(
                  children: [
                    Text('Issue Date',
                        style: ThemeManager.customTextStyle(context)),
                    SizedBox(height: 10,),
                    Text('End Date',
                        style: ThemeManager.customTextStyle(context)),
                    SizedBox(height: 50,)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('2023-08-09',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('2024-03-20',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 50,)

                  ],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height/40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButtonTransparent(text: 'Edit', onPressed: (){}),
                SizedBox(width: 5,),
                CustomButtonTransparent(text: 'Reject', onPressed: (){}),
                SizedBox(width: 5,),
                CustomIconButton(
                    text: 'Approve', onPressed: (){}),
              ],
            )
          ],
        ),),
    );
  }
}