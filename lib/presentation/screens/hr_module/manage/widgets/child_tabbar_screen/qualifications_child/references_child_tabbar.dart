import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/references_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/references_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../icon_button_constant.dart';
import '../../row_container_widget_const.dart';
///done by saloni
class ReferencesChildTabbar extends StatefulWidget {
  const ReferencesChildTabbar({super.key});

  @override
  State<ReferencesChildTabbar> createState() => _ReferencesChildTabbarState();
}

class _ReferencesChildTabbarState extends State<ReferencesChildTabbar> {
  final StreamController<List<ReferenceData>> referenceStreamController = StreamController<List<ReferenceData>>();
  @override
  void initState() {
    // TODO: implement initState
    getReferences(context,5).then((data) {
      referenceStreamController.add(data);
    }).catchError((error) {
      // Handle error
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<ReferenceData>>(
      stream: referenceStreamController.stream,
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorManager.blueprime,
            ),
          );
        }
        if (snapshot.data!.isEmpty) {
          return Center(
              child: Text(
                AppString.dataNotFound,
                style: CustomTextStylesCommon.commonStyle(
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s12,
                    color: ColorManager.mediumgrey),
              ));
        }
        if(snapshot.hasData){
          return WrapWidget(
              childern: List.generate(snapshot.data!.length, (index){
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
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                      const Row(
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
                              const SizedBox(height: 10,),
                              Text('Title/ Position',
                                  style: ThemeManager.customTextStyle(context)),
                              const SizedBox(height: 15,),
                              Text('Company/ Organization',
                                  style: ThemeManager.customTextStyle(context)),
                              const SizedBox(height: 10,),
                              Text('Mobile Number',
                                  style: ThemeManager.customTextStyle(context)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index].name,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 10,),
                              Text(snapshot.data![index].title,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 15,),
                              Text(snapshot.data![index].company,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 10,),
                              Text(snapshot.data![index].mobNumber,
                                style: ThemeManagerDark.customTextStyle(context),),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email',
                                  style: ThemeManager.customTextStyle(context)),
                              const SizedBox(height: 10,),
                              Text('How do you know this\nperson ?',
                                  style: ThemeManager.customTextStyle(context)),
                              const SizedBox(height: 5,),
                              Text('Length of Association',
                                  style: ThemeManager.customTextStyle(context)),
                              const SizedBox(height: 5,),
                              Text('Referred By',
                                  style: ThemeManager.customTextStyle(context)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index].email,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 10,),
                              Text('LinkedIn',
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 15,),
                              Text(snapshot.data![index].association,
                                style: ThemeManagerDark.customTextStyle(context),),
                              const SizedBox(height: 10,),
                              Text(snapshot.data![index].references,
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
        }else{
          return const SizedBox();
        }

      }
    );

  }
}
