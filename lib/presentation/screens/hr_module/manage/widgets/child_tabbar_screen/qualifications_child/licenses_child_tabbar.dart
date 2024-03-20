import 'package:flutter/material.dart';
import '../../../../../../../app/theme_manager.dart';
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('License #1',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 13,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(height: 15,),
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
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width/22,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(''),
                    SizedBox(height: 15,),
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
                SizedBox(width: MediaQuery.of(context).size.width/12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Issue Date',
                        style: ThemeManager.customTextStyle(context)),
                    SizedBox(height: 10,),
                    Text('End Date',
                        style: ThemeManager.customTextStyle(context)),
                    Text(''),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width/22,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('2023-08-09',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('2024-03-20',
                      style: ThemeManagerDark.customTextStyle(context),),
                    Text(''),

                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('License #1',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 13,
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(height: 15,),
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
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width/22,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(''),
                    SizedBox(height: 15,),
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
                SizedBox(width: MediaQuery.of(context).size.width/12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Issue Date',
                        style: ThemeManager.customTextStyle(context)),
                    SizedBox(height: 10,),
                    Text('End Date',
                        style: ThemeManager.customTextStyle(context)),
                    Text(''),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width/22,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('2023-08-09',
                      style: ThemeManagerDark.customTextStyle(context),),
                    SizedBox(height: 10,),
                    Text('2024-03-20',
                      style: ThemeManagerDark.customTextStyle(context),),
                    Text(''),

                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
