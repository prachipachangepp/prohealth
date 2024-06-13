import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';

class HealthRecordsHeadTabbar extends StatelessWidget {
  const HealthRecordsHeadTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomIconButton(text: AppStringHr.edit, onPressed: (){

          },icon: Icons.edit_outlined,),
        ),
        Container(
          height: mediaQuery.height / 3,
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 80,
                      vertical: MediaQuery.of(context).size.height / 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Container(
                              height: mediaQuery.height / 9,
                              width: mediaQuery.width / 2.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: ColorManager.faintGrey)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorManager.faintGrey)),
                                      child: Image.asset('images/file-document-green.png')
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Physical Exam',style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeightManager.semiBold
                                        ),),
                                        SizedBox(height: 10,),
                                        Text('2023-08-17',style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeightManager.lightbold
                                        ),),
                                      ],
                                    ),
                                    Spacer(),
                                    IconButtonWidget(iconData1: Icons.print_outlined, buttonText: 'Print', onPressed:(){},),
                                    SizedBox(width: 5,),
                                    IconButtonWidget(iconData1: Icons.file_copy_rounded, buttonText: 'Download', onPressed:(){},),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Container(
                              height: mediaQuery.height / 9,
                              width: mediaQuery.width / 2.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: ColorManager.faintGrey)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorManager.faintGrey)),
                                      child: Image.asset('images/file-document-black.png')
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Chest X-ray',style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeightManager.semiBold
                                        ),),
                                        SizedBox(height: 10,),
                                        Text('2023-08-17',style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeightManager.lightbold
                                        ),),
                                      ],
                                    ),
                                    Spacer(),
                                    IconButtonWidget(iconData1: Icons.print_outlined, buttonText: 'Print', onPressed:(){},),
                                    SizedBox(width: 5,),
                                    IconButtonWidget(iconData1: Icons.file_copy_rounded, buttonText: 'Download', onPressed:(){},),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
